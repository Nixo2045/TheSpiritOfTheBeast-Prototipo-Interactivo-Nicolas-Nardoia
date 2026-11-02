extends CharacterBody2D

const moveSpeed = 100
const maxSpeed = 120

const jumpHeight = -300
const gravity = 15

@onready var sprite_2d = $AnimatedSprite2D

## Para cuando recolecte monedas se vea en el UI
var coins = 0
@onready var hud = get_node("/root/Level/CanvasLayer");

func add_coin():
	coins+=1
	hud.set_coins(coins)


## Los movimientos del Jugador segun sus teclas asignadas con sus respectivas animaciones.
func _physics_process(_delta) -> void:
	
	velocity.y += gravity
	var friction = false
	## Le agregamos un multiplicador de velocidad al mantener apretada la tecla asignada a run_fast
	var multiplicador_correr = 1.0
	
	if Input.is_action_pressed("run_fast"):
		multiplicador_correr = 1.6
	
	if Input.is_action_pressed("move_right"):
		sprite_2d.flip_h = false
		sprite_2d.play("Run")
		velocity.x = min( velocity.x + (moveSpeed * multiplicador_correr), maxSpeed * multiplicador_correr )
	
	elif Input.is_action_pressed("move_left"): 
		sprite_2d.flip_h = true
		sprite_2d.play("Run")
		velocity.x = max( velocity.x - (moveSpeed * multiplicador_correr), -(maxSpeed * multiplicador_correr) )
	
	else:
		sprite_2d.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_pressed("move_up"):
			velocity.y = jumpHeight
		if friction == true:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction == true:
			velocity.x = lerp(velocity.x, 0.0, 0.01)
			
	move_and_slide()

## Cada vez que el jugador muera se reincia el nivel automaticamente y se perderá una vida...	
func _loseLife():
	print("Game Over!")
	get_tree().call_deferred("reload_current_scene")
	

## Para que el jugador muera al chocar con los pinchos
func _on_spikes_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		body._loseLife()
