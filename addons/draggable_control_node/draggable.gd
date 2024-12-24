extends Control

## Draggable item like a button
class_name Draggable

## Emmited right after dragging started
signal dragged

## Emmited right after dragging ends
signal dropped

## When selected, dropping will always make the node travel back to its last position before dragging
@export var drop_to_origin:bool

## Last position before dragging
var position_before_dragging:Vector2

var _original_z_index:int = 0

## When true, control is beeing dragged
var dragging:bool = false:
	set(val):
		if dragging == val: return
		dragging = val
		if dragging:
			position_before_dragging = position
			dragged.emit()
			_original_z_index = z_index
			z_index = RenderingServer.CANVAS_ITEM_Z_MAX
			mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			if drop_to_origin: position = position_before_dragging
			dropped.emit()
			z_index = _original_z_index
			mouse_filter = Control.MOUSE_FILTER_PASS

## When true, mouse pointer is inside this control node
var hover:bool = false

func _ready():
	set_process_input(true) # needed??
	mouse_entered.connect(func(): hover=true)
	mouse_exited.connect(func(): hover=false)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if hover: dragging = true
			else:
				if dragging: dragging = false
	
	if !dragging: return
	if event is InputEventMouseMotion:
		position += event.relative
