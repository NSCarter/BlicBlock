class_name Block extends Node2D

var blue = preload("res://Assets/Images/BlueBlock.png")
var green = preload("res://Assets/Images/GreenBlock.png")
var pink = preload("res://Assets/Images/PinkBlock.png")
var yellow = preload("res://Assets/Images/YellowBlock.png")

var colour_textures = {
	"blue": blue,
	"green": green,
	"pink": pink,
	"yellow": yellow
}

var colour

func _init(c) -> void:
	self.colour = c
	
	var texture_rect = TextureRect.new()
	texture_rect.texture = colour_textures[colour]
	add_child(texture_rect)
