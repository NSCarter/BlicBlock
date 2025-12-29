extends Node2D

const colours = ["blue", "green", "pink", "yellow"]
const block_length = 69
var falling_block: Block
var falling_timer: Timer
var wait_timer: Timer
var falling_pos = 2
var blocks = [[], [], [], [], []]

func _ready() -> void:
	create_block()
	wait_timer = Timer.new()
	add_child(wait_timer)
	wait_timer.timeout.connect(_on_wait_timer_timeout)
	wait_timer.wait_time = 1.0
	wait_timer.one_shot = true
	

func _process(_delta: float) -> void:
	if falling_block && _reached_bottom():
		falling_timer.stop()
		blocks[falling_pos].append(falling_block)
		falling_block = null
		wait_timer.start()
	
	if Input.is_action_just_pressed("Left") && falling_pos != 0:
		falling_block.position.x -= block_length
		falling_pos -= 1
	if Input.is_action_just_pressed("Right") && falling_pos != 4:
		falling_block.position.x += block_length
		falling_pos += 1
	
	
func create_block():
	var colour = colours.pick_random()
	var block = Block.new(colour)
	block.position.x = block_length * 2
	add_child(block)
	falling_block = block
	falling_timer = Timer.new()
	add_child(falling_timer)
	falling_timer.timeout.connect(_on_falling_timer_timeout)
	falling_timer.wait_time = 1.0
	falling_timer.start()
	

func _on_falling_timer_timeout():
	falling_block.position.y += block_length
	
func _on_wait_timer_timeout():
	create_block()
	falling_pos = 2
	
	
func _reached_bottom() -> bool:
	var stack_height = blocks[falling_pos].size() * block_length
	var board_height = block_length * 7
	var bottom = board_height - stack_height - block_length
	return bottom == falling_block.position.y
