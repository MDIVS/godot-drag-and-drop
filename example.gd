extends Control

func _ready():
	var draggable = DraggableControl.new()
	draggable.drop_to_origin = false
	draggable.dragged.connect(on_dragged)
	draggable.dropped.connect(on_dropped)
	add_child(draggable)
	
	var icon = TextureRect.new()
	icon.texture = load("res://icon.svg")
	draggable.add_child(icon)

func on_dragged():
	print("Node is being dragged!")

func on_dropped():
	print("Node was dropped!")
