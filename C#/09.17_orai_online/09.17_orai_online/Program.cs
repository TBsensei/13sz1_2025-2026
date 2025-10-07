using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _09._17_orai_online
{
    class Program
    {
        static int EgeszSzamBeker(string uzenet)
        {
            int szam;
            while (true)
            {
                Console.Write(uzenet);
                try
                {
                    szam = int.Parse(Console.ReadLine());
                    return szam;
                }
                catch (FormatException)
                {
                    Console.WriteLine("Hiba! Kérlek adj meg egy érvényes egész számot!");
                }
                catch (OverflowException)
                {
                    Console.WriteLine("Hiba! A szám túl nagy vagy túl kicsi!");
                }
            }
        }

        static double ValosszamBeker(string uzenet)
        {
            double szam;
            while (true)
            {
                Console.Write(uzenet);
                try
                {
                    szam = double.Parse(Console.ReadLine());
                    return szam;
                }
                catch (FormatException)
                {
                    Console.WriteLine("Hiba! Kérlek adj meg egy érvényes számot!");
                }
                catch (OverflowException)
                {
                    Console.WriteLine("Hiba! A szám túl nagy vagy túl kicsi!");
                }
            }
        }

        static string SzovegBeker(string uzenet)
        {
            Console.Write(uzenet);
            return Console.ReadLine();
        }

        static void f1()
        {
            Console.WriteLine("Hello world!");
        }

        static void f2()
        {
            string nev = SzovegBeker("Add meg a neved: ");
            Console.WriteLine("Szia! " + nev);
        }

        static void f3()
        {
            int szam = EgeszSzamBeker("Adj meg egy számot: ");
            Console.WriteLine(szam * 2);
        }

        static void f4()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");

            Console.WriteLine("A két szám összege: " + (szam1 + szam2));
            Console.WriteLine("A két szám különbsége: " + (szam1 - szam2));
            Console.WriteLine("A két szám szorzata: " + (szam1 * szam2));

            if (szam2 != 0)
            {
                Console.WriteLine("A két szám hányadosa: " + ((double)szam1 / szam2));
            }
            else
            {
                Console.WriteLine("Nem lehet nullával osztani!");
            }
        }

        static void f5()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");

            if (szam1 > szam2)
            {
                Console.WriteLine("A(z) " + szam1 + " nagyobb");
            }
            else if (szam2 > szam1)
            {
                Console.WriteLine("A(z) " + szam2 + " nagyobb");
            }
            else
            {
                Console.WriteLine("A két szám egyenlő");
            }
        }

        static void f6()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");
            int szam3 = EgeszSzamBeker("Add meg a harmadik számot: ");

            int legkisebb = Math.Min(Math.Min(szam1, szam2), szam3);
            Console.WriteLine("A(z) " + legkisebb + " legkisebb");
        }

        static void f7()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");
            int szam3 = EgeszSzamBeker("Add meg a harmadik számot: ");

            if (szam1 + szam2 > szam3 && szam1 + szam3 > szam2 && szam2 + szam3 > szam1)
            {
                Console.WriteLine("A háromszög szerkeszthető!");
            }
            else
            {
                Console.WriteLine("A háromszög nem szerkeszthető");
            }
        }

        static void f8()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");
            int szorzat = szam1 * szam2;

            Console.WriteLine("A két szám számtani közepe: " + ((double)(szam1 + szam2) / 2));

            if (szorzat >= 0)
            {
                Console.WriteLine("A két szám mértani közepe: " + Math.Sqrt(szorzat));
            }
            else
            {
                Console.WriteLine("A mértani közép nem számítható (negatív szorzat)!");
            }
        }

        static void f9()
        {
            int b = EgeszSzamBeker("Add meg a b-t: ");
            int c = EgeszSzamBeker("Add meg a c-t: ");
            int a = EgeszSzamBeker("Add meg az a-t: ");

            if (a == 0)
            {
                Console.WriteLine("Az 'a' nem lehet 0 másodfokú egyenletnél!");
                return;
            }

            int d = (b * b) - 4 * a * c;
            if (d < 0)
            {
                Console.WriteLine("A másodfokú egyenletnek nincsen valós megoldása!");
            }
            else if (d == 0)
            {
                Console.WriteLine("A másodfokú egyenletnek egy megoldása van!");
            }
            else
            {
                Console.WriteLine("A másodfokú egyenletnek két megoldása van!");
            }
        }

        static void f10()
        {
            int b = EgeszSzamBeker("Add meg a b-t: ");
            int c = EgeszSzamBeker("Add meg a c-t: ");
            int a = EgeszSzamBeker("Add meg az a-t: ");

            if (a == 0)
            {
                Console.WriteLine("Az 'a' nem lehet 0 másodfokú egyenletnél!");
                return;
            }

            int d = (b * b) - 4 * a * c;

            if (d < 0)
            {
                Console.WriteLine("A másodfokú egyenletnek nincsen valós megoldása!");
            }
            else if (d == 0)
            {
                double x = (double)(-b) / (2 * a);
                Console.WriteLine("Egy megoldás: " + x);
            }
            else
            {
                double x1 = (-b + Math.Sqrt(d)) / (2.0 * a);
                double x2 = (-b - Math.Sqrt(d)) / (2.0 * a);
                Console.WriteLine("Első megoldás: " + x1);
                Console.WriteLine("Második megoldás: " + x2);
            }
        }

        static void f11()
        {
            int szam1 = EgeszSzamBeker("Add meg az első számot: ");
            int szam2 = EgeszSzamBeker("Add meg a második számot: ");
            double atfogo = Math.Sqrt((szam1 * szam1) + (szam2 * szam2));
            Console.WriteLine("Az átfogó hossza: " + Math.Round(atfogo, 2));
        }

        static void f13()
        {
            int d = EgeszSzamBeker("Add meg a kör átmérőjét: ");
            if (d <= 0)
            {
                Console.WriteLine("Az átmérő nem lehet nulla vagy negatív!");
                return;
            }
            Console.WriteLine("A kör kerülete: " + (d * Math.PI));
            Console.WriteLine("A kör területe: " + (Math.Pow(d / 2.0, 2) * Math.PI));
        }

        static void f15()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
            if (szam <= 0)
            {
                Console.WriteLine("A szám nem pozitív!");
                return;
            }

            Console.Write("Számok 1-től " + szam + "-ig: ");
            for (int i = 1; i <= szam; i++)
            {
                Console.Write(i);
                if (i < szam)
                {
                    Console.Write(" ");
                }
            }
            Console.WriteLine();
        }

        static void f16()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
            if (szam <= 0)
            {
                Console.WriteLine("A szám nem pozitív!");
                return;
            }

            Console.WriteLine("Számok 1-től " + szam + "-ig:");
            for (int i = 1; i <= szam; i++)
            {
                Console.WriteLine(i);
            }
        }

        static void f17()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
            if (szam <= 0)
            {
                Console.WriteLine("A szám nem pozitív!");
                return;
            }

            Console.Write("A(z) " + szam + " osztói: ");
            for (int i = 1; i <= szam; i++)
            {
                if (szam % i == 0)
                {
                    Console.Write(i + " ");
                }
            }
            Console.WriteLine();
        }

        static void f18()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
            if (szam <= 0)
            {
                Console.WriteLine("A szám nem pozitív!");
                return;
            }

            int osszeg = 0;
            for (int i = 1; i <= szam; i++)
            {
                if (szam % i == 0)
                {
                    osszeg += i;
                }
            }
            Console.WriteLine("A(z) " + szam + " osztóinak összege: " + osszeg);
        }

        static void f19()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
            if (szam <= 0)
            {
                Console.WriteLine("A szám nem pozitív!");
                return;
            }

            int osszeg = 0;
            for (int i = 1; i <= szam; i++)
            {
                if (szam % i == 0)
                {
                    osszeg += i;
                }
            }

            if (osszeg == 2 * szam)
            {
                Console.WriteLine("A(z) " + szam + " tökéletes szám!");
            }
            else
            {
                Console.WriteLine("A(z) " + szam + " nem tökéletes szám.");
            }
        }

        static void f20()
        {
            int alap = EgeszSzamBeker("Add meg a hatványalapot: ");
            int kitevo = EgeszSzamBeker("Add meg a kitevőt: ");

            double eredmeny = Math.Pow(alap, kitevo);
            Console.WriteLine("Hatványalap: " + alap);
            Console.WriteLine("Kitevő: " + kitevo);
            Console.WriteLine("Hatványérték: " + eredmeny);
        }

        static void f21()
        {
            int szam;
            do
            {
                szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");
                if (szam <= 0)
                {
                    Console.WriteLine("A szám nem pozitív! Próbáld újra!");
                }
            } while (szam <= 0);

            Console.WriteLine("Köszönöm! A szám: " + szam);
        }

        static void f22()
        {
            int szam;
            int osszeg = 0;

            Console.WriteLine("Adj meg számokat! (A program addig kér be számokat, amíg egy 10-nél nagyobbat nem adsz meg)");

            do
            {
                szam = EgeszSzamBeker("Add meg egy számot: ");
                osszeg += szam;
            } while (szam <= 10);

            Console.WriteLine("A beolvasott számok összege: " + osszeg);
        }

        static void f23()
        {
            int szam = EgeszSzamBeker("Add meg egy egész számot: ");

            if (szam == 0)
            {
                Console.WriteLine("0 = 0");
                return;
            }

            int eredeti = Math.Abs(szam);
            int aktualis = eredeti;
            string eredmeny = "";
            int kettesek = 0;

            while (aktualis % 2 == 0)
            {
                kettesek++;
                aktualis = aktualis / 2;
            }

            Console.Write("Kérek egy egész számot: " + szam + "\n");
            Console.Write(eredeti + " = ");

            if (kettesek > 0)
            {
                for (int i = 0; i < kettesek; i++)
                {
                    eredmeny += "2*";
                }
                eredmeny += aktualis;
            }
            else
            {
                eredmeny = aktualis.ToString();
            }

            Console.WriteLine(eredmeny);
        }

        static void f24()
        {
            string szoveg;
            do
            {
                szoveg = SzovegBeker("Adj meg egy szöveget: ");
                if (szoveg != "alma")
                {
                    Console.WriteLine("Az \"alma\" szót hajlandó beolvasni!");
                }
            } while (szoveg != "alma");

            Console.WriteLine("Köszönöm! Az alma gyümölcs!");
        }

        static void f25()
        {
            int szam = EgeszSzamBeker("Add meg egy egész számot: ");

            if (szam < 3)
            {
                Console.WriteLine("A szám kisebb mint 3, nem lehet hárommal maradékosan osztani!");
                return;
            }

            int hanyszor = szam / 3;
            int maradek = szam % 3;

            Console.WriteLine("Kérek egy egész számot: " + szam);
            Console.WriteLine(szam + " = " + hanyszor + "*3+" + maradek);
        }

        static void f26()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");

            if (szam <= 1)
            {
                Console.WriteLine("A(z) " + szam + " nem prímszám.");
                return;
            }

            bool prim = true;
            for (int i = 2; i <= Math.Sqrt(szam); i++)
            {
                if (szam % i == 0)
                {
                    prim = false;
                    break;
                }
            }

            if (prim)
            {
                Console.WriteLine("A(z) " + szam + " prímszám.");
            }
            else
            {
                Console.WriteLine("A(z) " + szam + " nem prímszám.");
            }
        }

        static void f27()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");

            if (szam < 2)
            {
                Console.WriteLine("Nincsenek prímszámok 2-nél kisebb számok alatt.");
                return;
            }

            Console.Write("Prímszámok 2-től " + szam + "-ig: ");
            bool elso = true;

            for (int n = 2; n <= szam; n++)
            {
                bool prim = true;
                for (int i = 2; i <= Math.Sqrt(n); i++)
                {
                    if (n % i == 0)
                    {
                        prim = false;
                        break;
                    }
                }

                if (prim)
                {
                    if (!elso) Console.Write(" ");
                    Console.Write(n);
                    elso = false;
                }
            }
            Console.WriteLine();
        }

        static void f28()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");

            if (szam <= 1)
            {
                Console.WriteLine("A(z) " + szam + " prím osztói: nincsenek");
                return;
            }

            Console.Write("A(z) " + szam + " prím osztói: ");
            int eredeti = szam;
            bool elso = true;

            while (szam % 2 == 0)
            {
                if (!elso) Console.Write(" * ");
                Console.Write("2");
                elso = false;
                szam = szam / 2;
            }

            for (int i = 3; i <= Math.Sqrt(szam); i += 2)
            {
                while (szam % i == 0)
                {
                    if (!elso) Console.Write(" * ");
                    Console.Write(i);
                    elso = false;
                    szam = szam / i;
                }
            }

            if (szam > 2)
            {
                if (!elso) Console.Write(" * ");
                Console.Write(szam);
            }

            Console.WriteLine();
        }

        static void f29()
        {
            int szam = EgeszSzamBeker("Add meg egy pozitív egész számot: ");

            if (szam <= 1)
            {
                Console.WriteLine("A(z) " + szam + " prímtényezős felbontása: nincs");
                return;
            }

            Console.Write("A(z) " + szam + " prímtényezős felbontása: ");
            int eredeti = szam;
            bool elso = true;

            while (szam % 2 == 0)
            {
                if (!elso) Console.Write(" × ");
                Console.Write("2");
                elso = false;
                szam = szam / 2;
            }

            for (int i = 3; i <= Math.Sqrt(szam); i += 2)
            {
                while (szam % i == 0)
                {
                    if (!elso) Console.Write(" × ");
                    Console.Write(i);
                    elso = false;
                    szam = szam / i;
                }
            }

            if (szam > 2)
            {
                if (!elso) Console.Write(" × ");
                Console.Write(szam);
            }

            Console.WriteLine();
        }

        static void f30()
        {
            int a = EgeszSzamBeker("Add meg az első számot: ");
            int b = EgeszSzamBeker("Add meg a második számot: ");

            int eredeti_a = a;
            int eredeti_b = b;

            a = Math.Abs(a);
            b = Math.Abs(b);

            while (b > 0)
            {
                int t = b;
                b = a % b;
                a = t;
            }

            Console.WriteLine("A " + eredeti_a + " és " + eredeti_b + " legnagyobb közös osztója: " + a);
        }

        static void f31()
        {
            int a = EgeszSzamBeker("Add meg az első számot: ");
            int b = EgeszSzamBeker("Add meg a második számot: ");

            if (a == 0 || b == 0)
            {
                Console.WriteLine("A legkisebb közös többszörös nem értelmezhető nulla esetén!");
                return;
            }

            int eredeti_a = Math.Abs(a);
            int eredeti_b = Math.Abs(b);
            int lnko_a = eredeti_a;
            int lnko_b = eredeti_b;

            while (lnko_b > 0)
            {
                int t = lnko_b;
                lnko_b = lnko_a % lnko_b;
                lnko_a = t;
            }

            int lkt = (eredeti_a * eredeti_b) / lnko_a;

            Console.WriteLine("A " + a + " és " + b + " legkisebb közös többszöröse: " + lkt);
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
            f15();
            f16();
            f17();
            f18();
            f19();
            f20();
            f21();
            f22();
            f23();
            f24();
            f25();
            f26();
            f27();
            f28();
            f29();
            f30();
            f31();
        }
    }
}
