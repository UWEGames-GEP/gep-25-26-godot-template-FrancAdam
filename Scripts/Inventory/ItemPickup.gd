extends Area3D

@export var item_data : ItemData

func _on_body_entered(body):
	if body.has_method("getInventory"):
		body.getInventory().addItem(item_data)
		queue_free()
