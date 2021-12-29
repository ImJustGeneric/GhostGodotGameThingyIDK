extends Control


func _physics_process(delta):
	$Mana.value = get_node("/root/World/Player").mana
