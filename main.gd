extends Node2D

@onready var buttons: Array[Button] = [$"1", $"2", $"3", $"4", $"5", $"6", $"7", $"8", $"9"];
@onready var label: RichTextLabel = $Label;

var has_won: String = "";
var turn: String = "x";

func _ready():
  for button in buttons:
    button.text = "";
  label.text = "";

func _on_pressed(id: int) -> void:
  if buttons[id-1].text == "" && has_won == "":
    buttons[id-1].text = turn;
    turn = "x" if turn == "o" else "o"
  check_win()

func check_win():
  for i in range(3):
    if buttons[(i*3)+2].text != "" && buttons[(i*3)+0].text == buttons[(i*3)+1].text  && buttons[(i*3)+1].text == buttons[(i*3)+2].text:
      has_won = buttons[(i*3)+2].text
      label.text = has_won + " Has won"
    #print((i*3)+1)
    #print((i*3)+2)
    #print((i*3)+3)
    
    #1, 4, 7
    #2, 5, 8
    #3, 6, 9
