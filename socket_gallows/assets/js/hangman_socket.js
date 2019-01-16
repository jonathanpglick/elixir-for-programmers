import {Socket} from "phoenix"

export default class HangmanSocket {
  constructor(tally) {
    this.tally = tally;
    this.socket = new Socket("/socket", {});
    this.socket.connect();
  }

  connect_to_hangman() {
    this.setup_channel();
    this.channel.on("tally", tally => {
      this.copy_tally(tally)
    });
  }

  setup_channel() {
    this.channel = this.socket.channel("hangman:game", {});
    this.channel
      .join()
      .receive("ok", resp => {
        console.log("connected: " + resp);
        this.fetch_tally();
      })
      .receive("error", resp => {
        laert(resp);
        throw(resp);
      });
  }

  fetch_tally() {
    this.channel.push("tally", {});
  }

  copy_tally(from) {
    for (let k in from) {
      this.tally[k] = from[k];
    }
  }

  new_game() {
    this.channel.push("new_game", {})
  }

  make_move(guess) {
    this.channel.push("make_move", guess)
  }
}
