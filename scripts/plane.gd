extends MeshInstance

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var bike
var tex
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	bike=get_parent().get_node("warbike")
	set_fixed_process(true)
	set_process(true)
func _fixed_process(delta):
	var bt=bike.get_translation()
	var st=get_translation()
	set_translation(Vector3(bt.x,st.y,bt.z))
func _process(delta):
	var mat=get_material_override()
	var sp=bike.get_linear_velocity()*0.0004
	mat.set_shader_param("uv1_offset",mat.get_shader_param("uv1_offset")+Vector3(-sp.z,sp.x,0))