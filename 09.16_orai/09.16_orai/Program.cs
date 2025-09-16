using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace _09._16_orai
{
    internal class Program
    {
        static void f1()
        {
            Console.WriteLine("Hello world!");
        }
        static void f2() { 
            Console.Write("Add meg a neved: "); 
            string nev = Console.ReadLine();
            Console.WriteLine("Szia! " + nev);
        }
        static void f3()
        {
            Console.Write("Adj meg egy számot: ");
            int szam = int.Parse(Console.ReadLine());
            Console.WriteLine(szam * 2);
        }
        static void f4()
        {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());
            Console.WriteLine("A két szám összege: " + (szam1+szam2));
            Console.WriteLine("A két szám különbsége: " + (szam1 - szam2));
            Console.WriteLine("A két szám szorzata: " + (szam1 * szam2));
            if (szam1 != 0 || szam2 != 0)
            {
                Console.WriteLine("A két szám hányadosa: " + (szam1/szam2));

            }
        }
        static void f5()
        {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());

            if (szam1 > szam2)
            {
                Console.WriteLine("A(z) " + szam1 + " nagyobb");
            }
            else
            {
                Console.WriteLine("A(z) " + szam2 + " nagobb");
            }
        }
        static void f6()
        {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a harmadik számot: ");
            int szam3 = int.Parse(Console.ReadLine());

            if (szam1 > szam2 & szam2 < szam3)
            {
                Console.WriteLine("A(z) " + szam2 + " legkisebb");
            }
            else if (szam1 < szam2 & szam1 < szam3)
            {
                Console.WriteLine("A(z) " + szam1 + " legkisebb");
            }
            else {
                Console.WriteLine("A(z) " + szam3 + " legkisebb");
            }

        }
        static void f7()
        {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a harmadik számot: ");
            int szam3 = int.Parse(Console.ReadLine());

            if (szam1 > (szam2 + szam3) || szam2 > (szam1 + szam3) || szam3 > (szam1 + szam2))
            {
                Console.WriteLine("A háromszög szerkezthető!");
            }
            else { Console.WriteLine("A háromszög nem szerkezthető"); }
        }
        static void f8()
        {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());
            int szorzat = szam1 * szam2;

            Console.WriteLine("A két szám számtani közepe: "+ ((szam1+szam2)/2));
            Console.WriteLine("A két szám mértani közepe: "+ (Math.Sqrt(szorzat)));
        }
        static void f9()
        {
            Console.Write("Add meg a b-t: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a c-t: ");
            int szam2 = int.Parse(Console.ReadLine());
            Console.Write("Add meg az a-t: ");
            int szam3 = int.Parse(Console.ReadLine());

            int d = (szam1*szam1) - 4 * szam3 * szam2;
            if (d < 0)
            {
                Console.WriteLine("A másodfkú egyenletnek nincsen megoldása!");
            }
        }
        static void f10()
        {
            Console.Write("Add meg a b-t: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a c-t: ");
            int szam2 = int.Parse(Console.ReadLine());
            Console.Write("Add meg az a-t: ");
            int szam3 = int.Parse(Console.ReadLine());

            int d = (szam1 * szam1) - 4 * szam3 * szam2;

            double x1 = (-szam1 + (Math.Sqrt(d))) / (2*szam3);
            double x2 = (-szam1 - (Math.Sqrt(d))) / (2*szam3);
            Console.WriteLine(x1);
            Console.WriteLine(x2);
        }
        static void f11() {
            Console.Write("Add meg az első számot: ");
            int szam1 = int.Parse(Console.ReadLine());
            Console.Write("Add meg a második számot: ");
            int szam2 = int.Parse(Console.ReadLine());
            double atfogo = Math.Sqrt((szam1 * szam1) + (szam2*szam2));
            Console.WriteLine("Az átfogó hossza: " + Math.Round(atfogo, 2));
        }
        static void f13() {
            Console.Write("Add meg a kör átmérőjét: ");
            int d = int.Parse(Console.ReadLine());
            Console.WriteLine("A kör kerülete: "+ d*Math.PI);
            Console.WriteLine("A kör területe: " + ((d / 2) * (d / 2))*Math.PI);
        }

            static void Main(string[] args)
        {
            f1();
            f2();
            f3();
            f4();
            f5();
            f6();
            f7();
            f8();
            f9();
            f10();
            f11();
            f13();
        }
    }
}
