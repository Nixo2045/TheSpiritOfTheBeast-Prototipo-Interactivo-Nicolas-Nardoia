extends Node

@onready var coin_label = $CoinsCollectedText

func set_coins(amount):
	coin_label.text = str(amount)
