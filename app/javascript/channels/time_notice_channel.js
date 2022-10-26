import consumer from "channels/consumer"

consumer.subscriptions.create("TimeNoticeChannel", {
  received(data) {
    console.log(data)
    this.appendLine(data)
  },

  appendLine(data) {
    const html = this.createLine(data)
    const element = document.querySelector(".data-chat-room")
    element.insertAdjacentHTML("beforeend", html)
  },

  createLine(data) {
    return `
      <article class="chat-line">
        <span class="body">${data["body"]}</span>
      </article>
    `
  }
});
