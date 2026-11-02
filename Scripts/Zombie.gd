extends Node2D

var speed = 25
var direction = 1

## Arranca con la animacion de "Walk" (Caminar) yendo hacia la derecha.
func _ready() -> void:
	$AnimatedSprite2D.play("Walk")
	$AnimatedSprite2D.flip_h = (direction == 1)
	
func _process(delta: float) -> void:
	position.x += speed * direction * delta	
	verificar_pared()

## El RayCast2D verifica si el Zombie choca contra una pared y cambie de dirección cambiando su eje X y su animacion.	
func verificar_pared():
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():
		direction = -direction
		
		$AnimatedSprite2D.flip_h = (direction == 1)
		
		$RayCast2D.target_position.x = -$RayCast2D.target_position.x

## Si el Jugador colisiona sobre la cabeza del Zombie: elimina al Zombie y salta hacia arriba.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.y=-300
		queue_free()
	

## Si el cuerpo del Zombie colisiona con el Jugador, pierde una vida / reset del nivel.
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._loseLife()
		
func change_direction():
	direction = -direction
	$AnimatedSprite2D.flip_h = (direction == 1)
