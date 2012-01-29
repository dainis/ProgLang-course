class
	QUAD
inherit
	FIGURE
create make_points, make_xy
feature
	make_points(vv1, vv2, vv3, vv4: POINT) --konstruktors, kas izveido cetrsturi izmantojot padotos POINT objektus, virsotnes ir japadod sakartotas pulkstena raditaja virziena
	do
		v1 := vv1;
		v2 := vv2;
		v3 := vv3;
		v4 := vv4;
	end

	make_xy(xv1, yv1, xv2, yv2, xv3, yv3, xv4, yv4: REAL_64) --konstruktors kas izveido cetrsturi no padotajam koordinatem, virsotnes ir japadod sakartotas pulkstena raditaja virziena
	do
		create v1.make_xy(xv1, yv1);
		create v2.make_xy(xv2, yv2);
		create v3.make_xy(xv3, yv3);
		create v4.make_xy(xv4, yv4);
	end

	area: REAL_64 --aprekina cetrstura laukumu, laukums tiek aprekinats sadalot cetrsturi divos trijsturos, siem trijsturiem aprekinot laukumu un tos saskaitot kopa iegust cetrstrura laukumu
	local
		t1, t2: TRIANGLE
	do
		create t1.make_points(v1, v2, v3);
		create t2.make_points(v1, v3, v4);

		Result := t1.area() + t2.area();
	end

	weight_center: POINT --smaguma centra aprekinasana
	local

		p, p1, p2, p3, p4: POINT;
		t1, t2, t3, t4: TRIANGLE;
		k1, k2, b1, b2, x, y: REAL_64

	do

		create t1.make_points (v1, v2, v3); --tiek izveidoti 4 trijsturi, kurus iegust cetrsturi sadalot pa diognali
		create t2.make_points (v1, v3, v4);

		create t3.make_points (v1, v2, v4);
		create t4.make_points (v2, v3, v4);

		p1 := t1.weight_center(); --ar diognali sadalitajiem trijsturu pariem atrod smaguma centrus
		p2 := t2.weight_center();

		p3 := t3.weight_center();
		p4 := t4.weight_center();

		--pirmas diognales trijsturu para apstrade
		k1 := (p2.get_y() - p1.get_y()) / (p2.get_x() - p1.get_x()); --atrod taisnes vienadojuma koeficentu
		b1 := -p1.get_x() * k1 + p1.get_y(); --atrod taisnes vienadojuma parametru

		--otras diognales trijsturu paru apstrade
		k2 := (p4.get_y() - p3.get_y()) / (p4.get_x() - p3.get_x());
		b2 := -p3.get_x() * k2 + p3.get_y();

		--atrod krustpunktu, diognales pretejas puses atrodosos trijsturu ar otras diognales tada pasa veida izveidoto trijsturu smagumu centru savienojosajam taisnem
		x := (b2 - b1) / (k1 - k2);
		y := k1 * x + b1;

		create p.make_xy (x, y);

		Result := p;
	end

feature {NONE}
	v1, v2, v3, v4: POINT;
end
