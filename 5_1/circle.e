class
	CIRCLE
inherit
	FIGURE
create make_point, make_xy
feature
	make_point(cc: POINT; rr: REAL_64) --izveido rinki centra koordinatas izmantojot ka POINT objektu
	do
		c := cc;
		r := rr;
	end

	make_xy(xx, yy, rr : REAL_64) --izveido rinki izmantojot centra x un y koordinatas
	local
		p: POINT
	do
		create p.make_xy (xx, yy);
		r := rr;
		c := p;
	end

	area: REAL_64 --aprekina laukumu
	do
		Result := PI * r * r /2;
	end

	weight_center: POINT --rinka smaguma centrs atrodas ta centra
	do
		Result := c;
	end
feature {NONE}
	c : POINT;
	r : REAL_64;
end
