import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.element.classList.add(
        "opacity-0",
        "translate-y-2"
      )

      setTimeout(() => {
        this.element.remove()
      }, 500)

    }, 4000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}