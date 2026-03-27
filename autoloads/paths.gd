extends Node

#REGION FILES
const CHARACTERS := 'user://characters/'
const MAPS := 'user://maps/'
const LOCAL := 'user://local/'
const LOCAL_MAPS := 'user://local/maps/'
const LOCAL_CHARACTERS := 'user://local/characters/'
const SAVE := 'user://save'
const CHARACTERS_UNLOCKED := 'unlocked'
const WORLD_MAP_FILE := 'WorldMap'
const SETTINGS := 'user://settings'
const UPDATE := 'user://Updates'
const SAVE_EXTENTION := '.save'
const CONFIG_EXTENTION := '.cfg'
const UPDATE_EXTENTION := '.txt'
const WAV_EXTENTION := '.wav'
#END REGION FILES

#REGION SCENES
const ROOT := 'res://Scenes/Control/Root.tscn'
const ENTITIES_FOLDER = 'res://Scenes/Entities/'
const GHOST_ATTACK := ENTITIES_FOLDER + 'Abilities/Ghost.tscn'
const KAMEHAMEHA := ENTITIES_FOLDER + 'Abilities/Kamehameha.tscn'
const SPECIAL_BEAM_CANNON := ENTITIES_FOLDER + 'Abilities/SpecialBeamCannon.tscn'
const FINAL_FLASH := ENTITIES_FOLDER + 'Abilities/FinalFlash.tscn'
const KI_BLAST := ENTITIES_FOLDER + 'Abilities/KiBlast.tscn'
#const SHIELD := ENTITIES_FOLDER + 'Abilities/Shield.tscn'
const SHIELD := 'res://scenes/attacks/shield/shield.tscn'
const CUTSCENE_CAMERA = ENTITIES_FOLDER + 'Maps/DynamicCameraCutScenes.tscn'
const CUTSCENE_CHARACTERS = ENTITIES_FOLDER + 'BaseCharacterCutScene.tscn'
const ENEMY = ENTITIES_FOLDER + 'BaseEnemy.tscn'
const NPC = ENTITIES_FOLDER + 'BaseNpc.tscn'
const ITEM = ENTITIES_FOLDER + 'Item.tscn'
const MAPS_FOLDER := ENTITIES_FOLDER + 'Maps/'
const WORLD_MAP := MAPS_FOLDER + 'WorldMap/WorldMap.tscn'
#const PLAYER := ENTITIES_FOLDER + 'BasePlayer.tscn'
const PLAYER := 'res://scenes/player/player.tscn'
const ROCK_DROPS := ENTITIES_FOLDER + 'Rocks/'
const SPRITES := ENTITIES_FOLDER + 'Sprites/'
const ATTACK_BALL := SPRITES + 'AttackBall.tscn'
const EXPLOSION := SPRITES + 'ExplosionEffect.tscn'
const SPRITE_WORLD_MAP_FOLDER := SPRITES + 'WorldMap/'
const TELEPORT_COLLISION := ENTITIES_FOLDER + 'TeleportCollision.tscn'
const DUMMY_COLLISION := ENTITIES_FOLDER + 'DummyCollision.tscn'

const INTERFACE_FOLDER = 'res://Scenes/Interface/'
const CHANGE_CHARACTER_BUTTON := INTERFACE_FOLDER + 'ChangeCharacterButton.tscn'
const CHANGE_CHARACTER := INTERFACE_FOLDER + 'ChangeCharacterScreen.tscn'
const DIALOGUE_BOX := INTERFACE_FOLDER + 'CharactersDialogueBox.tscn'
const CHECKPOINT_MENU := INTERFACE_FOLDER + 'CheckPointOptions.tscn'
const DAMAGE_LABEL := INTERFACE_FOLDER + 'DamageLabel.tscn'
const SMALL_BAR := INTERFACE_FOLDER + 'SmallBar.tscn'
const ENTITY_SCOUTER := INTERFACE_FOLDER + 'Menu/EntityScouter.tscn'
const MENU_FOLDER := INTERFACE_FOLDER + 'Menu/'
const MENU := MENU_FOLDER + 'BaseMenu.tscn'
const ITEM_INVENTORY := MENU_FOLDER + 'ItemInventory.tscn'
const SCOUTER := MENU_FOLDER + 'Scouter.tscn'
const NAME_ZONE := INTERFACE_FOLDER + 'NameZone.tscn'
const NARRATOR_DIALOGUE_BOX := INTERFACE_FOLDER + 'NarratorDialogueBox.tscn'
const TITLESCREEN := INTERFACE_FOLDER + 'TitleScreen.tscn'
const KEY_TO_SCENE := {
	'Space': { 
		'Folder': 'Space/',
		'Space': 'RaditzTravel'
	},
	'East District 439': {
		'Folder': 'EastDistrict439/',
		'East District 439': 'EastDistrict439',
		'Grandpa Gohan\'s House': 'GohanHouse',
		'Kitchen': 'Kitchen',
		'Living Room': 'LivingRoom',
		'Goku\'s Room': 'Goku\'s Room',
		'Gohan\'s Room': 'Gohan\'s Room',
		'Cave': 'Cave',
		'Ravine': 'Ravine',
		'Eastern Forest 1': 'EasternForest1',
		'Eastern Forest 2': 'EasternForest2',
		'Eastern Forest 3': 'EasternForest3'
	},
	'Master Roshi\'s Island': {
		'Folder': 'KameHouse/',
		'Kame House': 'KameHouse',
		'First Floor': 'FirstFloor',
		'Second Floor': 'SecondFloor'
	},
	'Northern Wilderness': {
		'Folder': 'NorthernWilderness/',
		'Raditz\'s Landing Site': 'RaditzArena',
		'Mountains': 'Mountains',
		'Northern Wilderness 1': 'NorthernWilderness 1'
	},
	'West City': {
		'Folder': 'WestCity/',
		'Center': 'Center'
	},
	'Kami\'s Lookout': {
		'Folder': 'Kami\'sLookout/',
		'Kami\'s Lookout': 'Kami\'sLookout',
		'First Floor': 'FirstFloor',
		'Second Floor': 'SecondFloor',
		'Throne Room': 'ThroneRoom',
		'Holy Water Room': 'HolyWaterRoom',
		'Korin\'s Tower': 'Korin\'sTower',
		'Bedroom': 'Bedroom'
	},
	'Other World': {
		'Folder': 'OtherWorld/',
		'North Kai\'s Planet': 'NorthKai\'sPlanet',
	}
}

#REGION SCRIPTS
const ATTACK_AREA_SCRIPT := 'res://Scripts/Entities/Abilities/AttackArea.gd'
const CHARACTERS_SCRIPTS := 'res://Scripts/Entities/Characters/'
const ENEMIES_SCRIPTS := 'res://Scripts/Entities/Enemies/Ai/'
const ENEMIES_STATES := 'res://Scripts/Entities/Enemies/States/ActualStates/Specifics/'
const PLAYER_STATES := 'res://Scripts/Entities/Player/States/'

#REGION ASSETS
const COMBACT_AUDIOS := 'res://Audios/Combact/'
const ENVIRONMENT_AUDIOS := 'res://Audios/Environment/'
const INTERFACE_AUDIOS := 'res://Audios/Interface/'
const MUSIC := 'res://Audios/Maps/'

const ITEMS_TEXTURES := 'res://Textures/Items/'
const ENEMIES_TEXTURES := 'res://Textures/Enemies/'
const PNG_PATH := '/Movement/Stand/Down'
const DIALOGUE_TEXTURES := 'res://Textures/Gui/Dialogue/'
const ICON_TEXTURES := DIALOGUE_TEXTURES + 'Icons/'
const KEY_LABEL_TEXTURES := DIALOGUE_TEXTURES + 'Key'
const ABILITIES_TEXTURES := 'res://Textures/Abilities/'
const MAKANKOSAPPO_TEXTURE := ABILITIES_TEXTURES + 'Makankosappo/Horizontal.png'
const FINAL_FLASH_1 := ABILITIES_TEXTURES + 'Final Flash/Body 1.png'
const FINAL_FLASH_2 := ABILITIES_TEXTURES + 'Final Flash/Body 2.png'
const FINAL_FLASH_3 := ABILITIES_TEXTURES + 'Final Flash/Body 3.png'
const PLAYER_GUI_TEXTURES := 'res://Textures/Gui/Player/Log'
const ENEMY_GUI_TEXTURES := 'res://Textures/Gui/Enemy/Log'
const ABILITY_ICONS_TEXTURES := 'res://Textures/Gui/Player/AbilityIcons/'
const CHARACTERS_TEXTURES := 'res://Textures/Characters/'
const GHOST_ICON := '/Attack/BaseAttack/Right/Front 3.png'
const PUNCH_ICON := '/Attack/BaseAttack/Right/Back 2.png'
const FAST_ICON := '/Movement/Teleport/Right/3.png'
const DEFENSE_ICON := '/Movement/Defense/Right.png'
const SHADER := 'res://Resources/Shader'
