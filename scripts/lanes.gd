extends MeshInstance3D

# Speed of the UV scrolling
@export var speed : float = 5.0

var material : Material

func _ready():
	material = self.get_surface_override_material(0)

func _process(delta):
	if material:
		var uv_offset = material.get_uv1_offset()
		uv_offset += Vector3.UP * speed * delta
		print(uv_offset)
		material.set_uv1_offset(uv_offset)
		self.set_surface_override_material(0, material)
