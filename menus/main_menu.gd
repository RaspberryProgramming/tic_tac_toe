extends Control

@onready var main_scene = load("res://game/game.tscn");
@onready var start_button = $StartTicTacToeButton;

var current_scene = null;

func _ready():
  Globals.game_over.connect(_game_over);

func _game_over():
  print("Game Over");
  if current_scene != null:
    get_node("/root").remove_child(current_scene)
    current_scene.call_deferred("free")

  start_button.show();

func _on_start_button_pressed() -> void:
  var scene = main_scene.instantiate();

  get_node("/root").add_child(scene);
  
  start_button.hide();
  
  current_scene = scene;
