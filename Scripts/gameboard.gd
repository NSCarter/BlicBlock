extends Node2D

var colours = ["blue", "green", "pink", "yellow"]
var block_length = 69
var falling_block: Block
var falling_timer: Timer

func _ready() -> void:
	var block = create_block()
	falling_block = block
	falling_timer = Timer.new()
	add_child(falling_timer)
	falling_timer.timeout.connect(_on_timer_timeout)
	falling_timer.wait_time = 1.0
	falling_timer.start()
	
	
func create_block() -> Block:
	var colour = colours.pick_random()
	var block = Block.new(colour)
	block.position.x = 69 * 2
	add_child(block)
	return block 
	

func _on_timer_timeout():
	falling_block.position.y += block_length
