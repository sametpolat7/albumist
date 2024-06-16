import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  query(event) {
    const query = event.target.value.trim();
    this.fetchWithQuery(query);
  }

  clear() {
    this.element.querySelector('#search').value = '';
    this.fetchWithQuery('');
  }

  fetchWithQuery(query) {
    fetch(`/users?search=${query}`, {
      headers: { Accept: 'text/vnd.turbo-stream.html' }
    })
      .then((response) => response.text())
      .then((html) => {
        document.getElementById('users_list').innerHTML = html;
      });
  }
}
