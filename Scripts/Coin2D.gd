extends Area2D

# Para que inicie la animación al iniciar la escena.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")

# Para que cuando el jugador colisione con la moneda automaticamente desaparezca.
func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		body.add_coin()
		queue_free()
	
