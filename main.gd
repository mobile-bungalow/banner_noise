extends Node2D

@export var noise : FastNoiseLite
@onready var time = 0.0

func setup():
	for i in range(self.get_child_count() - 1):
		var new_name = self.get_child(i).get_name()
		if new_name == "bg":
			continue
		if new_name != "sprite":
			self.get_child(i).queue_free()
	
	var size = get_viewport().size
	var sprite = get_node("%sprite")
	var width = size[0] / sprite.width()
	var height = size[1] / sprite.height()
	var dims = Vector2(sprite.width(), sprite.height())
	
	for i in range((height + 3) * (width + 1)):
		var dup = sprite.duplicate()
		dup.position = Vector2((i % int(width + 2.0)) * sprite.width(), int(i / (width + 2.0)) * sprite.height()) - dims / 2
		dup.frame = randi() % 5600
		self.add_child(dup)

func _ready():
	get_tree().get_root().size_changed.connect(setup)
	setup()
	initialize_noise()

func initialize_noise():
	noise.seed = randi()
	noise.frequency = 0.001
	noise.fractal_octaves = 4
	noise.fractal_lacunarity = 10.0
	noise.fractal_gain = 0.5

func get_noise(pos: Vector2, total_time: float) -> float:
	return (noise.get_noise_3d(pos.x, pos.y, total_time) + 1.0) / 2.0

func _process(delta):
	time += delta * 35
	
	for i in range(self.get_child_count()):
		var child = self.get_child(i)
		if child.get_name() == "bg":
			continue
		
		var noise_value = 1.0 - get_noise(child.position, time)
		if noise_value < 0.53:
			child.visible = false
		else:
			child.visible = true
		
		child.frame = (child.frame + (randi() % 1000) / 998) % 5600
