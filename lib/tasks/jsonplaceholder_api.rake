namespace :jsonplaceholder_api do
  desc "Fetch user, album, and photo data from JSONPlaceholder API"
  task fetch_data: :environment do
    require 'net/http'
    require 'json'

    def fetch_json_data(url)
      uri = URI(url)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri)
        http.request(request)
      end
      JSON.parse(response.body)
    rescue StandardError => e
      puts "Failed to fetch data from #{url}: #{e.message}"
      []
    end

    user_url = 'https://jsonplaceholder.typicode.com/users'
    album_url = 'https://jsonplaceholder.typicode.com/albums'
    photo_url = 'https://jsonplaceholder.typicode.com/photos'

    users = fetch_json_data(user_url)
    albums = fetch_json_data(album_url)
    photos = fetch_json_data(photo_url)

    if users.empty? || albums.empty? || photos.empty?
      puts "Data fetching failed, task aborted."
      next
    end

    begin
      ActiveRecord::Base.transaction do

        users.each do |user_data|
          user = User.find_or_initialize_by(id: user_data['id'])
          user.update!(
            name: user_data['name'],
            username: user_data['username'],
            email: user_data['email'],
            street: user_data.dig('address', 'street'),
            suite: user_data.dig('address', 'suite'),
            city: user_data.dig('address', 'city'),
            zipcode: user_data.dig('address', 'zipcode'),
            phone: user_data['phone'],
            website: user_data['website'],
            company: user_data.dig('company', 'name')
          )
          puts "User #{user.id} - #{user.name} updated/created."
        end

        albums.each do |album_data|
          album = Album.find_or_initialize_by(id: album_data['id'])
          album.update!(
            user_id: album_data['userId'],
            title: album_data['title']
          )
          puts "Album #{album.id} - #{album.title} updated/created."
        end

        photos.each do |photo_data|
          photo = Photo.find_or_initialize_by(id: photo_data['id'])
          photo.update!(
            album_id: photo_data['albumId'],
            title: photo_data['title'],
            url: photo_data['url'],
            thumbnail_url: photo_data['thumbnailUrl']
          )
          puts "Photo #{photo.id} - #{photo.title} updated/created."
        end

      end
    rescue ActiveRecord::RecordInvalid => e
      puts "Database update failed: #{e.message}"
      raise ActiveRecord::Rollback
    end

    puts "Data fetch and update task completed successfully."
  end
end
