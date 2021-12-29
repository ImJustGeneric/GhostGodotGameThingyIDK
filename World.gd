extends Node2D

var enemy_scene = preload("res://Enemy.tscn")

func _ready():
	for x in range(5):
		var enemy = enemy_scene.instance()
		add_child(enemy)
