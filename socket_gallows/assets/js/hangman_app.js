import HangmanSocket from "./hangman_socket.js"

const RESPONSES = {
  "initializing": ["info", "Initializing"],
  "won": ["success", "You Won!"],
  "lost": ["danger", "You Lost!"],
  "good_guess": ["success", "Good Guess!"],
  "bad_guess": ["warning", "Bad Guess!"],
  "already_used": ["info", "You already guessed that!"]
};

let view = function(hangman) {
  let app = new Vue({
    el: "#app",
    data: {
      tally: hangman.tally
    },
    computed: {
      game_over: function() {
        let state = this.tally.game_state;
        return (state == "won") || (state == "lost")
      },
      game_state_message: function() {
        let state = this.tally.game_state;
        return RESPONSES[state][1]
      },
      game_state_class: function() {
        let state = this.tally.game_state;
        return RESPONSES[state][0]
      }
    },
    methods: {
      guess: function(ch) {
        hangman.make_move(ch);
      },
      new_game: function() {
        hangman.new_game();
      },
      already_guessed: function(ch) {
        return this.tally.used.indexOf(ch) >= 0;
      },
      correct_guess: function(ch) {
        return this.already_guessed(ch) && (this.tally.letters.indexOf(ch) >= 0);
      },
      turns_gt: function(left) {
        return this.tally.turns_left > left;
      }
    }
  });

  window.addEventListener('keyup', keyUpHandler);

  function keyUpHandler(e) {
    hangman.make_move(e.key);
  }

  return app;
};

window.onload = function() {

  let tally = {
    turns_left: 7,
    letters: ["_", "_", "_", "_"],
    game_state: "initializing",
    used: []
  };

  let hangman = new HangmanSocket(tally);
  let app = view(hangman);

  hangman.connect_to_hangman();
}
