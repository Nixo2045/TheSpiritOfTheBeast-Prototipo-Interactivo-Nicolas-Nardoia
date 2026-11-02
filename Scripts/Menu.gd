extends Control

func _ready() -> void:
	$VBoxContainer/StartGame.grab_focus()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/KeyReassignment.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
