extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

enum DoorState{
	Closed,
	Opening,
	Open,
	Closing
}

var target_state = 1

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	collision_layer = 1


#var is_transitioning:bool = false
	
func on_interactable_activated() -> void:
	print("activated")
	#if is_transitioning:
	#	return
		
	#is_transitioning = true
	target_state = DoorState.Open
	
	#collision_layer = 1
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, false)
	
	#if animated_sprite_2d.animation != 'open_door' || !animated_sprite_2d.is_playing():
	animated_sprite_2d.play("open_door")
	await animated_sprite_2d.animation_finished
	
	#is_transitioning = false
	#if target_state == DoorState.Open && animated_sprite_2d.animation == "open_door":
	if target_state == DoorState.Open:
		#collision_layer = 2
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)

func on_interactable_deactivated() -> void:
	print("deactivated")
	#if is_transitioning:
	#	return
		
	#is_transitioning = true
	target_state = DoorState.Closed
	
	#collision_layer = 1
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, false)
	
	#if animated_sprite_2d.animation != 'close_door' || !animated_sprite_2d.is_playing():
	animated_sprite_2d.play("open_door",-1.0,true)
	#await animated_sprite_2d.animation_finished
	
	#is_transitioning = false
	#if target_state == DoorState.Closed && animated_sprite_2d.animation == "close_door":
	#	collision_layer = 1
