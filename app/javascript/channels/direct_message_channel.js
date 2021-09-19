import consumer from "./consumer"

consumer.subscriptions.create("DirectMessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p>${data.nickname} : ${data.content.content}</p>
                  <p>${data.created_at}</p>`;
    const directMessages = document.getElementById('messages');
    const newDirectMessage = document.getElementById('message');
    directMessages.insertAdjacentHTML('afterbegin', html);
    newDirectMessage.value='';
  }
});
