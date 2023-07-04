extends Node3D


const MOVING_THRESHOLD = 0.1

const FORCA_TACADA = 3.0
var moveu = false

var tempo_inicio: int
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var cameraTaco = $Taco/CameraTaco
	cameraTaco.current = true

func _input(event):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if Input.is_action_just_pressed("f1"):
		troca_camera(true)
	if Input.is_action_just_pressed("f2"):
		troca_camera(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	var bola_branca = $TampoMesa/bola_branca
	var taco = $Taco/pool_cue
	var mesa = $TampoMesa/TecidoMesa
	var contador = $contador
	
	var pontos = conta_pontos(mesa.position.y)
	contador.text = str(pontos)
	
	if pontos == 5:
		get_tree().change_scene_to_file("res://game_over.tscn")
	
	if bola_branca.position.y < mesa.position.y - 3:
		bola_branca.set_linear_velocity(Vector3(0,0,0))
		
	if bola_branca.linear_velocity.length_squared() > MOVING_THRESHOLD**2:
		taco.visible = false
		moveu = false

		
	else:
		
		if bola_branca.position.y < mesa.position.y:
			bola_branca.set_position(Vector3(mesa.position.x ,mesa.position.y, mesa.position.z + 0.5))
			bola_branca.sleeping = true
		taco.visible = true
		if not moveu :

			taco.move_to_branca(bola_branca.position)
			moveu = true
		
		if Input.is_action_just_pressed("left_click"):
			tempo_inicio = Time.get_ticks_msec()
			taco.cue_move(true)
		elif Input.is_action_just_released("left_click"):
			var tempo_percorrido = Time.get_ticks_msec() - tempo_inicio
			var impulso = min(2.5, tempo_percorrido/400)*FORCA_TACADA*taco.get_impulse_coords()
			print(impulso)
			taco.cue_move(false)
			bola_branca.apply_central_impulse(impulso)
	
	
func troca_camera(toGlobal):
	var cameraTaco = $Taco/CameraTaco
	var cameraGlobal = $CameraGlobal
	
	if toGlobal:
		cameraGlobal.current = true
	else:
		cameraTaco.current = true

func conta_pontos(altura_cacapa):
	var bolas = get_tree().get_nodes_in_group("bolas")
	
	var total = 0
	
	for bola in bolas:
		total += int(bola.position.y < altura_cacapa )
	
	return total
	
	
