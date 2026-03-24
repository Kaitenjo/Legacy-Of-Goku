extends Node

var states: Dictionary = {}
var current_state: PlayerBaseState
const player_base_states: int = 14
var player: Player

signal state_changed

func init(player: Player) -> void:
	load_Base_states()

	for child in get_children():
		child.player = player

	self.player = player
	
	change_state(PlayerBaseState.State.Idle)

#CALLED ONCE IN THE READY ROOT
func load_Base_states():
	var temp = {
		PlayerBaseState.State.Null: null,
		PlayerBaseState.State.Idle: $Idle,
		PlayerBaseState.State.Walk: $Walk,
		PlayerBaseState.State.ChangeMap: $ChangeMap,
		PlayerBaseState.State.FlyChangeMap: $FlyChangeMap,
		PlayerBaseState.State.Run: $Run,
		PlayerBaseState.State.BaseAttack: $BaseAttack,
		PlayerBaseState.State.Defense: $Defense,
		PlayerBaseState.State.Shield: $Shield,
		PlayerBaseState.State.FastAttack: $FastAttack,
		PlayerBaseState.State.KiBlast: $KiBlast,
		PlayerBaseState.State.Teleport: $Teleport,
		PlayerBaseState.State.Hit: $Hit,
		PlayerBaseState.State.HitWall: $HitWall,
		PlayerBaseState.State.Dead: $Dead
	}
	
	for key in temp:
		states[key] = temp[key]
	
func load_character_states(player: Player, character_name: String, character_states: Array) -> void:
	for i in range(player_base_states, get_children().size()): remove_child(get_child(i))
	var new_nodes: Array = create_characters_states(player, character_name, character_states)
	for node in new_nodes: add_child(node)
	
	for key in states.keys(): 
		if key > player_base_states:
			states.erase(key)
			
	for i in range(0, new_nodes.size()): states[character_states[i].action.state] = new_nodes[i]
		
func create_characters_states(player: Player, character_name: String, character_states: Array) -> Array:
	var new_nodes: Array = []
	
	for state in character_states:
		var new_node: PlayerBaseState = PlayerBaseState.new()
		new_node.script = load(Paths.PLAYER_STATES + character_name + '/' + state.node_script + '.gd')
		new_node.player = player
		new_nodes.append(new_node)
	
	return new_nodes
	
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	change_state(new_state)

func change_state(new_state: int) -> void:
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	player.state_timer.state_changed()
	current_state = states[new_state]
	current_state.enter()
