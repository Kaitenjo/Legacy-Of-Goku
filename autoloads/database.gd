extends Node
	
static func get_new_save_file() -> SaveFile:
	return SaveFile.new(true, true, 'Goku', 'Space', 'Space', 0, 0, {}, {}, {})
 
static func get_updates() -> Dictionary: 
	return {
	  '1': {
		'Kami\'s Lookout': {
		  'Korin\'s Tower': {
			'Actual Event': 0,
			'Event Occurring': false,
			'Items': {},
			'Npcs': {}
		  }
		}
	  }
	}
		
#region maps
static func get_areas() ->  Dictionary:
	return {
		'Space': {
			'Space':{
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'East District 439': {
			'East District 439' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Grandpa Gohan\'s House': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Kitchen': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Living Room': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Gohan\'s Room' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Goku\'s Room': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Cave':{
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Ravine': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Eastern Forest 1': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {
					'0': true
				},
				'Npcs': {}
			},
			'Eastern Forest 2': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Eastern Forest 3': {
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'Master Roshi\'s Island': {
			'Kame House' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'First Floor': {
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Second Floor': {
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'Northern Wilderness': {
			'Raditz\'s Landing Site' : {
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Mountains' : {
				'Event Occurring': true,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Northern Wilderness 1' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'West City': {
			'Center': {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'Kami\'s Lookout': {
			'Kami\'s Lookout' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'First Floor' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Throne Room' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Holy Water Room' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Second Floor' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Korin\'s Tower' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			},
			'Bedroom' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		},
		'Other World': {
			'North Kai\'s Planet' : {
				'Event Occurring': false,
				'Actual Event': 0,
				'Items': {},
				'Npcs': {}
			}
		}
	}
		
static func get_world_map() -> Dictionary:
	return {
		'East District 439': { 'Unlocked' : true, 'Goal': true },
		'Master Roshi\'s Island': { 'Unlocked' : false, 'Goal': false },
		'Northern Wilderness': { 'Unlocked' : false, 'Goal': false },
		'Kami\'s Lookout': { 'Unlocked' : true, 'Goal': false },
		'West City': { 'Unlocked' : true, 'Goal': false },
	}

#endregion maps
		
#region characters
static func get_characters() -> Dictionary:
	return {
		'Goku': {
			'Available' : true,
			'Sprite' : 'Classic',
			'Statistics' : {
				'Level' : 1,
				'Max Health': 20,
				'Health' : 20,
				'Max Energy': 30,
				'Energy': 30,
				'Attack': 5,
				'Power' : 2,
				'Endurance': 7,
				'Shield': 7,
				'Exp Next Level': 50,
				'Exp': 0,
				'Exp Increase': 50
			}
		},
		'Piccolo': {
			'Available' : true,
			'Sprite' : 'Classic',
			'Statistics' : {
				'Level' : 1,
				'Max Health': 40,
				'Health' : 40,
				'Max Energy': 50,
				'Energy': 50,
				'Attack': 3,
				'Power' : 3,
				'Endurance': 3,
				'Shield': 3,
				'Exp Next Level': 20,
				'Exp': 10,
				'Exp Increase': 30
			}
		},
		'Vegeta': {
			'Available' : true,
			'Sprite' : 'Android',
			'Statistics' : {
				'Level' : 1,
				'Max Health': 40,
				'Health' : 40,
				'Max Energy': 50,
				'Energy': 50,
				'Attack': 3,
				'Power' : 3,
				'Endurance': 3,
				'Shield': 3,
				'Exp Next Level': 20,
				'Exp': 10,
				'Exp Increase': 30
			}
		}
	}
	
static func get_characters_unlocked() -> Dictionary:
	return {
		'Goku': true,
		'Piccolo': false,
		'Vegeta': true
	}
#endregion characters
