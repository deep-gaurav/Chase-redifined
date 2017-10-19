extends VehicleBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var steer=0.25
export var max_steer=0.3
var max_speed=15
var acc=300
var topcol;var toppos
var downcol;var downpos
var part1;var part2;
export var max_part=20.0
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	part1=get_node("Particles")
	part2=get_node("Particles1")
	topcol=get_node("top")
	downcol=get_node("down")
	acc=get_engine_force()
	downpos=downcol.get_translation()
	set_fixed_process(true)
	set_process_input(false)
func _fixed_process(delta):
	if Input.is_action_pressed("left"):
		if get_steering()>-max_steer:
			set_steering(get_steering()-0.01)
	elif Input.is_action_pressed("right"):
		if get_steering()<max_steer:
			set_steering(get_steering()+0.01)
	else:
		set_steering(0)
		
	#SPEED LIMITER
	if get_linear_velocity().length()>max_speed:
		set_engine_force(0)
	else:
		set_engine_force(acc)
	tilt()
	var speedratio=floor(get_linear_velocity().length()/max_speed*10)/10
	if int(speedratio*10)==9:
		speedratio=1
	var setp=int(max_part*speedratio)+1
	part1.set_amount(setp)
	part2.set_amount(setp)
	#self_rotation()
func tilt():
	var til=get_steering()
	#topcol.set_translation(Vector3(til,toppos.y,toppos.z))
	#downcol.set_translation(Vector3(til,downpos.y,downpos.z))
	downcol.set_rotation(Vector3(0,0,til*2))
func self_rotation( touchpos=Vector2(0,0)):
	var screencenter=Vector2(get_viewport().get_rect().size.x,get_viewport().get_rect().size.y)/2
	var mousepos
	if touchpos!=Vector2(0,0):
		mousepos=touchpos
	else:
		mousepos=get_viewport().get_mouse_pos()
	var mvec=(mousepos-screencenter).normalized()
	var dir=(get_node("Position3D").get_global_transform().origin-get_global_transform().origin)
	var dir_2=Vector2(dir.x,dir.z).normalized()
	
	set_steering(-dir_2.angle_to(mvec)*steer)
	#print("speed is", get_linear_velocity().length())

func slow():
	if int(OS.get_time_scale())==1:
		OS.set_time_scale(0.2)
		get_node("slowtimer").start()
		
func _on_Area_body_enter( body ):
	if body.is_in_group('cop'):
		slow()


func _on_slowtimer_timeout():
	OS.set_time_scale(1)
	