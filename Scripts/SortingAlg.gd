extends Node
const TEST_INVENTORY = preload("res://GEP Core/Items/test_inventory.tres")
const ItemData = preload("res://Scripts/Inventory/ItemData.gd")

enum SortOrder{
	ASCENDING,
	DESCENDING
}

func _ready() -> void:
	#print("before: ")
	#printArr(TEST_INVENTORY.InventoryArray)
	#insertion_sort(TEST_INVENTORY.InventoryArray, 1)
	#print("after: ")
	#printArr(TEST_INVENTORY.InventoryArray)
	pass

#debug
func printArr(arr: Array):
	for i in arr:
		print(i.item_name)

# simple sort that sorts the array alphabetically
func bubbleSort(arr : Array, sort_order : SortOrder):
	var n = arr.size()
	var swapped: bool
	
	for i in range(n - 1):
		swapped = false
		for j in range(n-i-1):
			match sort_order:
				SortOrder.ASCENDING: #Ascending
					if arr[j].item_name > arr[j+1].item_name:
						var temp: ItemData = arr[j]
						arr[j] = arr[j+1]
						arr[j+1] = temp
						swapped = true
				SortOrder.DESCENDING: #Descending
					if arr[j].item_name < arr[j+1].item_name:
						var temp: ItemData = arr[j]
						arr[j] = arr[j+1]
						arr[j+1] = temp
						swapped = true
		if !swapped:
			break

# Sorts by Rarity
func insertionSort(arr: Array, sort_order : SortOrder): # Sorts by Rarity
	var n = arr.size()
	
	for i in range(n):
		var key: ItemData = arr[i]
		var j = i - 1
		match sort_order:
			SortOrder.ASCENDING:
				while j >= 0 && arr[j].rarity > key.rarity:
					arr[j + 1] = arr[j]
					j = j - 1
				arr[j + 1] = key
			SortOrder.DESCENDING:
				while j >= 0 && arr[j].rarity < key.rarity:
					arr[j + 1] = arr[j]
					j = j - 1
				arr[j + 1] = key
	
