extends Node
class_name InventoryData

enum SortType{
	BUBBLE,
	INSERT
}
enum InventoryType{
	PLAYER,
	CHEST
}
@export var inventory_type: InventoryType
@export var main_inventory: InventoryData
@export var items : Array[ItemData] = [] #@export is equivalent of [serialized field] in Unity
signal inventory_updated

var sort_order: SortingAlg.SortOrder
var last_sort: SortType

func _ready() -> void:
	sort_order = SortingAlg.SortOrder.ASCENDING

func buttonPressed(item: ItemData) -> void:
	match inventory_type:
		InventoryType.PLAYER:
			removeItem(item)
		InventoryType.CHEST:
			if main_inventory:
				main_inventory.addItem(item)
				items.erase(item)
				inventory_updated.emit()

func addItem(item: ItemData) -> void:
	items.append(item)
	print("Added item:", item.item_name)
	var inventory_size = items.size()
	print("inventory size: " + str(inventory_size))
	inventory_updated.emit()


func removeItem(item: ItemData) ->void:
	# spawn back into world
	# inventory is a child of player
	var player = $"../mannequiny-0_4_0"
	var forward = player.global_transform.basis.z
	var spawn_pos = player.global_transform.origin + forward * 2 + Vector3.UP # position in front of player

	
	var instance = item.scene.instantiate() # initiate node
	instance.global_transform.origin = spawn_pos # set position
	
	instance.item_data = item # sets its item data
	
	# adds the item back into the world under the node ItemObject
	get_tree().current_scene.get_node("ItemObject").add_child(instance) 
	
	# removes the spawned item from the items array
	items.erase(item) # equivalent of .remove() from Unity
	
	#debug
	print(str(item.item_name) + " (" + str(item.rarity) + ") removed from inventory")
	inventory_updated.emit()

func removeFirst():
	if items.size() > 0:
		removeItem(items[0])

func alphabeticalSort():
	SortingAlg.bubble_sort(items, sort_order)
	inventory_updated.emit()
	last_sort = SortType.BUBBLE

func raritySort():
	SortingAlg.insertion_sort(items, sort_order)
	inventory_updated.emit()
	last_sort = SortType.INSERT

func toggleSort(): # toggle for sort order
	match sort_order: # changes sort order
		SortingAlg.SortOrder.ASCENDING:
			sort_order = SortingAlg.SortOrder.DESCENDING
		SortingAlg.SortOrder.DESCENDING:
			sort_order = SortingAlg.SortOrder.ASCENDING
	match last_sort: # reruns the last sort that was used to update inventory after toggleSort
		SortType.BUBBLE:
			alphabeticalSort()
		SortType.INSERT:
			raritySort()

		
func _input(event):
	if (event.is_action_pressed("G")):
		alphabeticalSort()
	if (event.is_action_pressed("H - Print array")):
		raritySort()
	if (event.is_action_pressed("SortToggle")):
		toggleSort()
