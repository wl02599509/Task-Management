import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  changeState(){
    const taskId = this.element.dataset.taskId
    console.log(taskId)
  }

}
