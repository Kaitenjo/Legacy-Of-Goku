extends Control

@onready var music := $Soundtrack
@onready var sfx_container := $Sounds

func _ready() -> void:
	Events.connect('music_value_changed', set_music_volume)
	Events.connect('sfx_value_changed', set_sfx_volume)
	var settings := FileManager.load_settings_file()
	music.volume_db = step_to_music_volume(settings.audio.music)
	
	var volume_sfx: int = step_to_sfx_volume(settings.audio.sfx)
	for child in sfx_container.get_children():
		child.volume_db = volume_sfx

func play_music(new_track: String) -> void:
	new_track = Paths.MUSIC + new_track + '.ogg'
	if new_track != music.stream.resource_path:
		music.stream = load(new_track)
		music.play()
		
func stop_music() -> void:
	music.stop()

func play_combact_sound(track: String) -> void:
	play_sound(Paths.COMBACT_AUDIOS + track + Paths.WAV_EXTENTION)

func play_environment_sound(track: String) -> void:
	play_sound(Paths.ENVIRONMENT_AUDIOS + track + Paths.WAV_EXTENTION)

func play_interface_sound(track: String) -> void:
	play_sound(Paths.INTERFACE_AUDIOS + track + Paths.WAV_EXTENTION)

func stop_combact_sound(track: String) -> void:
	stop_sound(Paths.COMBACT_AUDIOS + track + Paths.WAV_EXTENTION)

func stop_environment_sound(track: String) -> void:
	stop_sound(Paths.ENVIRONMENT_AUDIOS + track + Paths.WAV_EXTENTION)

func stop_interface_sound(track: String) -> void:
	stop_sound(Paths.INTERFACE_AUDIOS + track + Paths.WAV_EXTENTION)

func play_sound(path: String) -> void:
	for audio in sfx_container.get_children():
		if not audio.playing:
			audio.stream = load(path)
			audio.play()
			return
			
func stop_sound(path: String) -> void:
	for audio in sfx_container.get_children():
		if audio.playing and audio.stream.resource_path == path:
			audio.stop()
			return

func step_to_music_volume(step: int) -> int:
	return -80 if step == 0 else -44 + (4* step)
	
func set_music_volume(step: int) -> void:
	music.volume_db = step_to_music_volume(step)

func step_to_sfx_volume(step: int) -> int:
	return -80 if step == 0 else -24 + (4* step)
	
func set_sfx_volume(step: int) -> void:
	var volume_sfx: int = step_to_sfx_volume(step)
	for child in sfx_container.get_children():
		child.volume_db = volume_sfx
