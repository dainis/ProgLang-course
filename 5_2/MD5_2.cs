using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace MD5_2
{
    public interface Figure
    {
        double area();
        xyPoint weight_center();
    }

    //punkta reprezentācija
    public class xyPoint {

        private double x,y;
        
        //konstruktors
        public xyPoint(double x, double y)
        {
            this.x = x;
            this.y = y;
        }

        //nosaka attālumu starp diviem punktiem
        public double distance(xyPoint point)
        {
            
            return Math.Sqrt(Math.Pow(x-point.get_x(), 2)+ Math.Pow(y-point.get_y(), 2));
        }

        //atgriež x koordinātu
        public double get_x()
        {
            return x;
        }

        //atgriež y koordinātu
        public double get_y()
        {
            return y;
        }

        //izmaina x koordinātu par kādu noteiktu vērtību
        public void adjust_x(double adjustment)
        {
            x = x + adjustment;
        }

        //izmaina y koordinātu par kādu noteiktu vērtību
        public void adjust_y(double adjustment)
        {
            y = y + adjustment;
        }

        //izmaina x un y koordinātu vērtību par noteiktu attiecību
        public void scale(double ratio)
        {
            y = y * ratio;
            x = x * ratio;
        }
    }

    class Triangle : Figure
    {

        private xyPoint v1, v2, v3;

        //konstruktors ar koordinātām
        public Triangle(double xv1, double yv1, double xv2, double yv2, double xv3, double yv3)
        {
            v1 = new xyPoint(xv1, yv1);
            v2 = new xyPoint(xv2, yv2);
            v3 = new xyPoint(xv3, yv3);
        }

        //konstruktors izmantojot punktus
        public Triangle(xyPoint v1, xyPoint v2, xyPoint v3)
        {
            this.v1 = v1;
            this.v2 = v2;
            this.v3 = v3;
        }


        //Laukumu aprēķina izmantojot hērona formulu
        public double area()
        {
            double a, b, c, p;

            a = v1.distance(v2);
            b = v2.distance(v3);
            c = v3.distance(v1);

            p = (a + b + c) / 2;

            return Math.Sqrt(p * (p - a) * (p - b) * (p - c));
        }

        //Trijstūra smaguma centrs atrodas mediānu krustpunktā
        public xyPoint weight_center()
        {
            return new xyPoint((v1.get_x() + v2.get_x() + v3.get_x()) / 3, (v1.get_y() + v2.get_y() + v3.get_y()) / 3);
        }
    }

    class Quad : Figure
    {
        private xyPoint v1, v2, v3, v4;

        //Konstruktors izmantojot koordinātas, koordinātām ir jābūt sakārtotām pulksteņa rādītāja virzienā
        public Quad(double xv1, double yv1, double xv2, double yv2, double xv3, double yv3, double xv4, double yv4)
        {
            v1 = new xyPoint(xv1, yv1);
            v2 = new xyPoint(xv2, yv2);
            v3 = new xyPoint(xv3, yv3);
            v4 = new xyPoint(xv4, yv4);
        }

        //Konstruktors izmantojot punktus, koordinātām ir jābūt sakārtotām pulksteņa rādītāja virzienā
        public Quad(xyPoint v1, xyPoint v2, xyPoint v3, xyPoint v4)
        {
            this.v1 = v1;
            this.v2 = v2;
            this.v3 = v3;
            this.v4 = v4;
        }

        //Četrstūra laukumu aprēķina to sadalot 2 trijstūros, un aprēķinot tiem laukumu un atgriežot šo laukumu summu
        public double area()
        {
            Triangle t1, t2;

            t1 = new Triangle(v1, v2, v3);
            t2 = new Triangle(v1, v3, v4);

            return t1.area() + t2.area();
        }

        //Atrod četrstūra smaguma centru
        public xyPoint weight_center()
        {
            Triangle t1, t2, t3, t4;

            //sadala divos trijstūru pāros, kas veidojas četrstūri dalot pa diognālēm 
            t1 = new Triangle(v1, v2, v3);
            t2 = new Triangle(v1, v3, v4);

            t3 = new Triangle(v1, v2, v4);
            t4 = new Triangle(v2, v3, v4);

            xyPoint p1, p2, p3, p4;

            //Atrod katra trijstūra smaguma centru
            p1 = t1.weight_center();
            p2 = t2.weight_center();

            p3 = t3.weight_center();
            p4 = t4.weight_center();

            double k1, k2, b1, b2;


            //atrod taisnes vienādojumus vienas un tās pašas diognāles trijstūriem
            k1 = (p2.get_y() - p1.get_y()) / (p2.get_x() - p1.get_x());
            b1 = p1.get_y() - k1 * p1.get_x();

            k2 = (p4.get_y() - p3.get_y()) / (p4.get_x() - p3.get_x());
            b2 = p3.get_y() - k2 * p3.get_x();

            double x, y;

            //atrod dažādo diognāļu trijstūru smagumu centru krustojošo taišņu krustpunktu koordinātas
            x = (b2 - b1) / (k1 - k2);
            y = k1 * x + b1;

            return new xyPoint(x, y);
        }
    }

    class Circle : Figure
    {
        private double r;
        private xyPoint c;

        //Riņķis izmantojot punktu
        public Circle(xyPoint c, double r)
        {
            this.c = c;
            this.r = r;
        }

        //Riņķa konstruktors izmantojot koordinātas
        public Circle(double x, double y, double r)
        {
            c = new xyPoint(x, y);
            this.r = r;
        }

        //Aprēķina laukumu
        public double area()
        {
            return Math.PI * Math.Pow(r, 2) / 2;
        }

        //Riņķim smaguma centrs ir tā centrā
        public xyPoint weight_center()
        {
            return c;
        }
    }

    class FigureList : List<Figure>, Figure
    {
        //Atrod kopējo laukumu saskaitot visu saraksta figūru laukumus
        public double area()
        {
            double a = 0;

            foreach (Figure fig in this)
            {
                a += fig.area();
            }

            return a;
        }

        //Atrod sarakstā esošo figūru sistēmas smaguma centru
        public xyPoint weight_center()
        {
            xyPoint p = new xyPoint(0, 0);

            foreach (Figure fig in this)
            {
                p.adjust_x(fig.weight_center().get_x() * fig.area());
                p.adjust_y(fig.weight_center().get_y() * fig.area());
            }

            p.scale(1 / area());

            return p;
        }
    }




    class Root
    {
        static void Main(string[] args)
        {

            Triangle t = new Triangle(0, 2, 0, 5, 4, 2);

            Quad q = new Quad(0, 0, 0, 2, 4, 2, 4, 0);

            Circle c = new Circle(0, 0, 3);

            FigureList l = new FigureList();

            l.Add(q);
            l.Add(t);
            l.Add(c);

            Console.WriteLine(l.area());
            Console.WriteLine("x: " + l.weight_center().get_x() + " y: " + l.weight_center().get_y());
            Console.ReadLine();
        }
    }
}
