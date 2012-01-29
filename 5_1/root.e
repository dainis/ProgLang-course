class
	ROOT

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
	local
		q: QUAD;
		t: TRIANGLE;
		c: CIRCLE;
		l: FIGURELIST;
		p: POINT
	do
		create l.make;



		create q.make_xy(0, 0, 0, 2, 4, 2, 4, 0);
		p := q.weight_center();
		l.put_front(q);

		create t.make_xy(0, 2, 0, 5, 4, 2);

		l.put_front(t);

		create c.make_xy(0, 0, 3);
		l.put_front(c);

		print(l.area());
		print("%N");

		p := l.weight_center();

		print("x: ");
		print(p.get_x);
		print(" y: ")
		print(p.get_y());
		print("%N");
	end

end
