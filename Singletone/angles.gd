class_name Angles

static func distance(_angle1 : float, _angle2 : float) -> float:
	var _a = _angle1 + TAU
	var _b = _angle2 + TAU

	var _r = abs(_a - _b)
	while _r > PI: _r -= PI

	return _r

