extends Camera2D

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCRECEMENT = 0.05

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

func _ready():
	set_camera_limits()

func _input(event):
	if event.is_action("cam_zoom_in"):
		_update_zoom(-ZOOM_INCRECEMENT, get_local_mouse_position())
	elif event.is_action("cam_zoom_out"):
		_update_zoom(ZOOM_INCRECEMENT, get_local_mouse_position())


func _update_zoom(incr, zoom_anchor):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	if _current_zoom_level < MAX_ZOOM_LEVEL:
		_current_zoom_level = MAX_ZOOM_LEVEL
	elif _current_zoom_level > MIN_ZOOM_LEVEL:
		_current_zoom_level = MIN_ZOOM_LEVEL
	if old_zoom == _current_zoom_level:
		return
	
	var zoom_center = zoom_anchor - get_offset()
	var ratio = 1-_current_zoom_level/old_zoom
	set_offset(get_offset() + zoom_center*ratio)
	
	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")
	
func set_camera_limits():
	var map_limits = get_node("../../../Navigation2D/MAPSIZE").get_used_rect()
	var map_cellsize = get_node("../../../Navigation2D/MAPSIZE").cell_size
	
	get_node(".").limit_left = map_limits.position.x * map_cellsize.x
	get_node(".").limit_right = map_limits.end.x * map_cellsize.x
	get_node(".").limit_top = map_limits.position.y * map_cellsize.y
	get_node(".").limit_bottom = map_limits.end.y * map_cellsize.y