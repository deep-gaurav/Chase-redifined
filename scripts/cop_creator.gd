extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var cop_distance=100
export var max_cop=5
export(NodePath) var bikepath
var bike
var cop
var explo
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	explo=load("res://explode.tscn")
	set_process(true)
	cop=load("res://models/cars/Polite Car.scn")
	bike=get_node(bikepath)
func _process(delta):
	if get_tree().get_nodes_in_group('cop').size()<5:
		copgen()

func randgen():
	randomize()
	return(randf()*2*PI)

func copgen():
	var angle=randgen()
	var xc=cop_distance*cos(angle)
	var zc=cop_distance*sin(angle)
	var bt=bike.get_translation()
	var tempt=Vector3(xc,0,zc)
	var c=cop.instance()
	add_child(c)
	c.set_translation(bt+tempt)
	c.look_at(bike.get_global_transform().origin,Vector3(0,1,0))
	c.rotate_y(deg2rad(180))