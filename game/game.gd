extends Node2D

@onready var buttons: Array[Button] = [$"1", $"2", $"3", $"4", $"5", $"6", $"7", $"8", $"9"];
@onready var label: RichTextLabel = $Label;
@onready var game_over_timer: Timer = $GameOverTimer;

var has_won: String = "";
var turn: String = "X";

func _ready() -> void:
  setup_board();

# Used to initially setup the game. This can be used to reset the board also.
func setup_board() -> void:
  for button in buttons:
    button.text = "";
  
  label.text = "";
  turn = "X";
  has_won = "";
  set_turn_label();

# Takes an id for the button that was pressed and attempts to use that as a turn
func _on_pressed(id: int) -> void:
  
  # If noone has won and the button doesn't already have a mark
  if buttons[id-1].text == "" && has_won == "":
    # Set the button to the current turn
    buttons[id-1].text = turn;
  
  # flip the turn
  turn = "X" if turn == "O" else "O";
  
  set_turn_label();

  check_win();

func set_turn_label():
  # Set the label
  label.text = "Turn: " + turn;

# Checks if there is a win. If there is has_won will be set and the label text will be changed
func check_win() -> void:
  # Row win
  for i in range(3):
    if (
      buttons[(i*3)+2].text != ""
      && buttons[(i*3)+0].text == buttons[(i*3)+1].text
      && buttons[(i*3)+1].text == buttons[(i*3)+2].text
      ):
      has_won = buttons[(i*3)+2].text;

  # Column Win
  for i in range(3):
    if (
      buttons[i].text != ""
      && buttons[i].text == buttons[i+3].text
      && buttons[i+3].text == buttons[i+6].text
      ):
      has_won = buttons[i].text;

  # Win via cross
  if (
    buttons[4].text != ""
    && (
    (
      buttons[4].text == buttons[0].text
      && buttons[4].text == buttons[8].text
    )
    || (
      buttons[4].text == buttons[2].text
      && buttons[4].text == buttons[6].text
    )
    )
  ):
    has_won = buttons[4].text;

  if has_won != "":
   label.text = has_won + " Has won";
   game_over_timer.start();


func _on_game_over_timer_timeout() -> void:
  Globals.game_over.emit();
