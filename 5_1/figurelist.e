class
	FIGURELIST
inherit
	FIGURE undefine is_equal, copy end
	LINKED_LIST[FIGURE]
create
	make
feature
	weight_center: POINT --aprekina sistemas smaguma centru
	local
		p:POINT
	do
		create p.make_xy(0, 0);

		from start
		until exhausted
		loop
			p.adjust_x(item.weight_center().get_x() * item.area());
			p.adjust_y(item.weight_center().get_y() * item.area());
			forth;
		end

		p.scale(1 / area());

		Result := p;
	end

	area: REAL_64 --aprekina saraksta kopejo laukumu, saskaitot kopa visu elementu laukumus
	local
		a: REAL_64
	do
		from start
		until exhausted
		loop
			a := a + item.area;
			forth;
		end

		Result := a;
	end
end
