import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['modal', 'title'];

  showModal(event) {
    const albumTitle = event.currentTarget.dataset.albumTitle;

    this.titleTarget.textContent = albumTitle;

    const element = this.modalTarget;
    element.classList.replace('hide', 'show');
  }

  hideModal() {
    const element = this.modalTarget;
    element.classList.replace('show', 'hide');
  }
}
