class
	TRIANGLE
inherit
	FIGURE
create make_points, make_xy
feature

	make_points(vv1, vv2, vv3 : POINT) --izviedo trijsturi izmantojot POINT objektus ka ta virsotnes
	do
		v1 := vv1;
		v2 := vv2;
		v3 := vv3;
	end

	make_xy(xv1, yv1, xv2, yv2, xv3, yv3: REAL_64) --izveido trijsturi pec ta virsotnu koordinatas
	do
		create v1.make_xy(xv1, yv1);
		create v2.make_xy(xv2, yv2);
		create v3.make_xy(xv3, yv3);
	end

	area: REAL_64 --aprekina trijstura laukumu
	local
		a, b, c, p: REAL_64
	do
		--malu garumi
		a := v1.distance(v2);
		b := v2.distance(v3);
		c := v3.distance(v1);

		p := (a + b + c) / 2; --herona formula

		Result := sqrt(p*(p-a)*(p-b)*(p-c));
	end

	weight_center: POINT --aprekina smaguma centru
	local
		p: POINT
	do
		create p.make_xy ((v1.get_x() + v2.get_x() + v3.get_x()) / 3, (v1.get_y() + v2.get_y() + v3.get_y()) / 3); --smaguma centrs atrodas medianu krustpunkta

		Result := p;
	end
feature {NONE}
	v1, v2, v3: POINT;
end
