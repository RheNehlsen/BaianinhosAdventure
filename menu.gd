extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://copia_main.tscn")


func _on_start_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()
