extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var gcn
var done=false
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	gcn=load("res://ground.tscn")
	connect("body_enter",self,"_on_Area_body_enter")

func _on_Area_body_enter( body ):
	print("Detected creater",body)
	if body.is_in_group("bike"):
		var gn=gcn.instance()
		var pn=get_node("Position3D")

		gn.set_translation(pn.get_global_transform().origin)
		get_parent().get_parent().add_child(gn)
		disconnect("body_enter",self,"_on_Area_body_enter")