extends Resource
class_name Spring

@export var percentageDecay : float = 0.1
@export var frequency : float = 1.0
@export var timeDecay : float = 5.0

var position : Vector3 = Vector3.ZERO
var velocity : Vector3 = Vector3.ZERO
var targetPosition : Vector3 = Vector3.ZERO

var pulling : bool = false

func simulate(delta):
	
	if pulling:
		return
		
	var omega = 2.0 * PI * frequency
	var zeta = log(percentageDecay) / (-omega * timeDecay);
	
	var result = _springer(position.x, velocity.x, targetPosition.x, zeta, omega, delta)
	position.x = result[0]
	velocity.x = result[1]
	
	result = _springer(position.y, velocity.y, targetPosition.y, zeta, omega, delta)
	position.y = result[0]
	velocity.y = result[1]
	
	result = _springer(position.z, velocity.z, targetPosition.z, zeta, omega, delta)
	position.z = result[0]
	velocity.z = result[1]

func reset(p : Vector3):
	targetPosition = p
	position = p

func _springer(x : float, v : float, xt : float, zeta : float, omega : float, dt : float) -> Array:
	var f = 1.0 + 2.0 * dt * zeta * omega
	var oo = omega * omega
	var hoo = dt * oo
	var hhoo = dt * hoo
	var detInv = 1.0 / (f + hhoo)
	var detX = f * x + dt * v + hhoo * xt
	var detV = v + hoo * (xt - x)
	v = detV * detInv
	return [detX * detInv, v]

func pull(p : Vector3):
	pulling = true
	position = p

func release():
	pulling = false
