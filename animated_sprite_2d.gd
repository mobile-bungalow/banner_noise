extends AnimatedSprite2D

func width():
	return self.sprite_frames.get_frame_texture(self.animation, self.frame).get_size().x

func height():
	return self.sprite_frames.get_frame_texture(self.animation, self.frame).get_size().y

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().transparent_bg = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
