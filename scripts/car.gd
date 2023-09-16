extends Node3D

@export var debugLabel : Label
@export var showDebug : bool
@export var spring : Spring

@export var laneOffset : float = 3
@export var turnSpeed : float = 5.0

var _basePosition : Vector3;
var _move : float
var _turning : float = 0.0

func _ready():
	spring.reset(position)
	_basePosition = position
	pass
	
func _physics_process(delta):
	spring.simulate(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if showDebug:
		debugLabel.text = str(position)
	
	position = spring.position
	
	if (abs(_move) < 0.01):
		_turning = position.x
		spring.release()
		return
	
	_turning += turnSpeed * delta * _move
	_turning = clampf(_turning, -laneOffset, laneOffset)
	spring.pull(_basePosition + _turning * Vector3.RIGHT)

func _input(event):
	if event is InputEventScreenTouch:
		var halfScreenWidth = get_viewport().size.x * 0.5
		if event.pressed:
			if event.position.x > halfScreenWidth:
				_move = -1;
			else:
				_move = 1;
		else:
			_move = 0
	else: if event.is_action("move_left") or event.is_action("move_right"):
		_move = Input.get_axis("move_right", "move_left")
