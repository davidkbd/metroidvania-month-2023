class_name Levels

static func get_levels() -> Array:
	var level_names = []

	var dir = DirAccess.open(Directories.LEVELS_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name.begins_with("level"):
				level_names.append(file_name)
			file_name = dir.get_next()
	level_names.sort()
	
	var r = []
	for n in level_names:
		r.append({"name": n, "is_first": false, "is_last": false})
	r[0].is_first = true
	r[r.size()-1].is_last = true
	
	var prev = r[0]
	for l in r:
		prev["next"] = l
		prev = l
			
	return r

static func find_level(level_name : String) -> Dictionary:
	var levels = get_levels()
	for r in levels:
		if r.name == level_name:
			return r
	return null
