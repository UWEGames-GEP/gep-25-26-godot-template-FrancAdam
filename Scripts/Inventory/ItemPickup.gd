extends Area3D

@export var item_data : ItemData


func _ready():
	if item_data: # if item_data exists
		var mat = StandardMaterial3D.new()
		# creates new material and assigns a color to it
		mat.albedo_color = item_data.getColor() # gets color based on rarity
		$MeshInstance3D.material_override = mat # overrides material 
	else: # if not, prints an error message
		print("Could not access item_data")

func _on_body_entered(body):
	if body.has_method("getInventory"):
		if item_data.pickupable:
			body.getInventory().addItem(item_data)
			queue_free()
