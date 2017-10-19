extends VehicleBody

export var acc=200
export var max_speed=20
var bike
var explo
func _ready():
	explo=get_parent().explo
	set_engine_force(acc)
	bike=get_parent().get_node("../warbike")
	set_fixed_process(true)
func _fixed_process(delta):
	var pos3d=get_global_transform().origin
	var bike3d=bike.get_global_transform().origin
	var po=get_node("Position3D")
	po.look_at(bike3d,Vector3(0,1,0))
	set_steering(po.get_rotation().y*0.3)
	
	#Destroy if far
	if ((bike3d-pos3d).length())>200:
		queue_free()
		
	#SPEED LIMITER
	if get_linear_velocity().length()>max_speed:
		set_engine_force(0)
	else:
		set_engine_force(acc)
func _exit_tree(): #EXPLODE
	var e=explo.instance()
	get_parent().add_child(e)
	e.set_global_transform(get_global_transform())
func _on_Area_body_enter( body ): #DIE
	if body.is_in_group('cop') and body!=self:
		queue_free()
