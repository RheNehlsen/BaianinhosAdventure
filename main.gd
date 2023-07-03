extends Node3D


const MOVING_THRESHOLD = 0.1

const FORCA_TACADA = 3
var moved = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var cameraTaco = $Taco/CameraTaco
	cameraTaco.current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	var bola_branca = $TampoMesa/bola_branca
	var taco = $Taco/pool_cue
	var mesa = $TampoMesa/TecidoMesa
	
	if bola_branca.position.y < mesa.position.y - 3:
		bola_branca.set_linear_velocity(Vector3(0,0,0))
		
	if bola_branca.linear_velocity.length_squared() > MOVING_THRESHOLD**2:
		taco.visible = false
		moved = false
		switch_camera()
		
	else:
		
		if bola_branca.position.y < mesa.position.y:
			bola_branca.set_position(Vector3(mesa.position.x ,mesa.position.y, mesa.position.z + 0.5))
			bola_branca.sleeping = true
		taco.visible = true
		if not moved :
			switch_camera()
			taco.move_to_branca(bola_branca.position)
			moved = true
		
		if Input.is_action_just_pressed("left_click"):
			taco.cue_move(true)
		elif Input.is_action_just_released("left_click"):
			taco.cue_move(false)
			bola_branca.apply_central_impulse(FORCA_TACADA*taco.get_impulse_coords())
	

func switch_camera():
	var cameraTaco = $Taco/CameraTaco
	var cameraGlobal = $CameraGlobal
	
	cameraTaco.current = !cameraTaco.current
	cameraGlobal.current = !cameraGlobal.current

