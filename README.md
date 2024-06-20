# Albumist

This repo is my graduation project for the "Ruby on Rails Bootcamp" program launched in collaboration with <a href="https://www.iwallet.com.tr/" target="_blank">iWallet</a> & <a href="https://www.patika.dev/" target="_blank">Patika.dev</a>

## Introduction

Albumist is a simple "User Album Tracker" application. Initially, user, album and album details data are fetched from <a href="https://jsonplaceholder.typicode.com" target="_blank">https://jsonplaceholder.typicode.com</a> via http requests from the routes `/users`, `/albums` and `/photos` with the help of a **rake task** and saved in the database.  Albumist basically has 2 pages. (*Homepage and Profile*) `Homepage` lists all users. `Profile` includes detailed information of the users.

- Then, these data can be updated or new ones created.
- With search input supported by Stimulus and Turbo, recorded users can be searched by `username` and results can be dynamically listed on the `Homepage`.
- This application styled with Scss has a responsive layout.
- Flash messages that can be closed 3 seconds after being shown (or immediately if you prefer).
- Album details are displayed with a pop-up.

<br>

## Getting Started

```sh
https://github.com/sametpolat7/albumist.git
```

Clone the repo to your local. Make your database settings.
<br><br>
*config/database.yml*
```
username: <%= ENV["DATABASE_USERNAME"] %>
password: <%= ENV["DATABASE_PASSWORD"] %>
```

```
cd albumist
rails db:create
rails db:migrate
```

<br>

```
rails s
```
When you start the server, you should see "User not found." on the `Homepage`.

<br>

Now let's pull the data from the jsonplaceholder API and record it in the database. You need to start the `rake` task.

```
rake jsonplaceholder_api:fetch_data
```

<br>

Data fetching will start.

```
Data fetch and update task completed successfully.
```

<br>

## Possible Problems

If you see an SSL error like this:

```
Failed to fetch data from https://jsonplaceholder.typicode.com/users: SSL_connect returned=1 errno=0 peeraddr=104.21.59.19:443 state=error: certificate verify failed
(unable to get local issuer certificate)
```

This error occurs because the SSL certificate used by the server (jsonplaceholder.typicode.com) could not be verified. This can happen if the certificate chain cannot be traced back to a trusted root certificate authority (CA) on your system.

<br>

### Solution

### Step 1: Download the `cacert.pem` File
1. Go to [https://curl.se/ca/cacert.pem](https://curl.se/ca/cacert.pem).
2. Download the `cacert.pem` file and save it to a known location on your system, for example, `C:\Certificates\cacert.pem`.

<br>

### Step 2: Configure Ruby (or your environment) to Use the Certificate

#### Setting the Environment Variable in Command Prompt
1. Open the command prompt.
2. Set the `SSL_CERT_FILE` environment variable to point to the location where you saved `cacert.pem`:

 ```
set SSL_CERT_FILE=C:\Certificates\cacert.pem
 ```

 And now you can run the rake task again.
