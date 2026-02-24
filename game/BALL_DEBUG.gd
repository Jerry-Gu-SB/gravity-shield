extends RigidBody2D

@onready var authority_label : Label = $Label

# these are configured as "Watch" in the MultiplayerSynchronizer
#@export var replicated_position : Vector2
#@export var replicated_rotation : float
#@export var replicated_linear_velocity : Vector2
#@export var replicated_angular_velocity : float

func _ready() -> void:		
	authority_label.text = str(get_multiplayer_authority())
#	
#func _integrate_forces(state : PhysicsDirectBodyState2D) -> void:
#	# Synchronizing the physics values directly causes problems since you can't
#	# directly update physics values outside of _integrate_forces. This is
#	# an attempt to resolve that problem while still being able to use
#	# MultiplayerSynchronizer to replicate the values.
#
#	# The object owner makes shadow copies of the physics values.
#	# These shadow copies get synchronized by the MultiplyaerSynchronizer	
#	# The client copies the synchronized shadow values into the 
#	# actual physics properties inside integrate_forces
#	if is_multiplayer_authority():
#		replicated_position = position
#		replicated_rotation = rotation
#		replicated_linear_velocity = linear_velocity
#		replicated_angular_velocity = angular_velocity
#	else:
#		# Only sync velocities, not position/rotation (MultiplayerSynchronizer handles those)
#		state.linear_velocity = replicated_linear_velocity
#		state.angular_velocity = replicated_angular_velocity
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not multiplayer.is_server(): return
			var temp: Transform2D = Transform2D(0, Vector2(0, 0), 0, get_global_mouse_position())
			teleport(self, temp)

func teleport(rb : RigidBody2D, target : Transform2D) -> void:
	rb.linear_velocity = Vector2.ZERO
	rb.angular_velocity = 0.0
	rb.global_transform = target
	PhysicsServer2D.body_set_state(rb.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, target)
	rb.reset_physics_interpolation()