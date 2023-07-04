extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		get_tree().change_scene_to_file('res://copia_main.tscn')

func _on_start_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()
