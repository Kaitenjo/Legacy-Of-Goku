extends Node
class_name StatesManager

var states := {}
var current_state: PlayerBaseState
const player_base_states := 14
var player: Player

signal state_changed

func init(player: Player) -> void:
	self.load_Base_states()

	for child in self.get_children():
		child.player = player

	self.player = player
	
	self.change_state(PlayerBaseState.State.Idle)

func load_Base_states():
	var temp := {
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
		self.states[key] = temp[key]
	
func load_character_states(player: Player, character_name: String, character_states: Array) -> void:
	for i in range(self.player_base_states, self.get_children().size()): self.remove_child(self.get_child(i))
	var new_nodes: Array = self.create_characters_states(player, character_name, character_states)
	for node in new_nodes: self.add_child(node)
	
	for key in self.states.keys(): 
		if key > self.player_base_states:
			self.states.erase(key)
			
	for i in range(0, new_nodes.size()): self.states[character_states[i].action.state] = new_nodes[i]
		
func create_characters_states(player: Player, character_name: String, character_states: Array) -> Array[BaseState]:
	var new_nodes: Array[BaseState] = []
	
	for state in character_states:
		var new_node := PlayerBaseState.new()
		new_node.script = load(Paths.PLAYER_STATES + character_name + '/' + state.node_script + Paths.SCRIPT_EXTENSION)
		new_node.player = player
		new_nodes.append(new_node)
	
	return new_nodes
	
func physics_process(delta: float) -> void:
	var new_state = self.current_state.physics_process(delta)
	self.change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = self.current_state.input(event)
	self.change_state(new_state)

func change_state(new_state: int) -> void:
	if not new_state:
		return
	
	if self.current_state:
		self.current_state.exit()
	
	self.player.state_timer.state_changed()
	self.current_state = self.states[new_state]
	self.current_state.enter()
