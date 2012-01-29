class POINT
inherit DOUBLE_MATH

create make_xy

feature
	get_x: REAL_64
	do
		Result := x
	end --atgriez x vertibu
	get_y: REAL_64
	do
		Result := y
	end --atgriez y vertibu

	adjust_x(adjustment: REAL_64)
	do
		x := x + adjustment; --izmaina x vertibu
	end

	adjust_y(adjustment: REAL_64)
	do
		y := y + adjustment; --izmaina y vertibu
	end

	distance(p:POINT): REAL_64
	do
		Result := sqrt((x-p.get_x())^2+(y-p.get_y())^2) --aprekina attalumu starp punktiem
	end

	scale(ratio: REAL_64) --izmaina x un y vertibu par noteiktu attiecibu
	do
		x := x * ratio;
		y := y * ratio;
	end

	make_xy(xx:REAL_64; yy: REAL_64) --konstruktors
	do
		x:=xx;
		y:=yy;
	end
feature {NONE}
	x,y: REAL_64 -- x un y ir privati
invariant
	invariant_clause: True
end
