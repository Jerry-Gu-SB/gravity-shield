extends RigidBody2D

class_name Player

const MOVE_SPEED: int = 100
const PI_OVER_2: float = PI / 2

var angle_respect_to_mouse: float = 0

@onready var shield: Node2D = $Shield
@onready var shield_area_2d: Area2D = $Shield/Area2D
@onready var grav_direction_arrow: Sprite2D = $Shield/Sprite2D

func _enter_tree():
	# With mesh type, be client authority.
	set_multiplayer_authority(str(name).to_int())
	#player_input.set_multiplayer_authority(str(name).to_int())
	
func _ready() -> void:
	if not is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Q:
			angle_respect_to_mouse -= PI_OVER_2
		if event.pressed and event.keycode == KEY_E:
			angle_respect_to_mouse += PI_OVER_2

		grav_direction_arrow.rotation = angle_respect_to_mouse

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if Input.is_action_pressed("ui_right"):
		state.apply_central_force(Vector2(MOVE_SPEED, 0 ))
	if Input.is_action_pressed("ui_left"):
		state.apply_central_force(Vector2(-MOVE_SPEED, 0 ))
	if Input.is_action_pressed("ui_down"):
		state.apply_central_force(Vector2(0, MOVE_SPEED))
	if Input.is_action_pressed("ui_up"):
		state.apply_central_force(Vector2(0, -MOVE_SPEED))

func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	shield.rotation = self.global_position.angle_to_point(mouse_position)
	Vector2.from_angle(shield.rotation + angle_respect_to_mouse)
	shield_area_2d.gravity_direction = Vector2.from_angle(shield.rotation + angle_respect_to_mouse)