using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Ultrabalaton
{
    class Versenyzo
    {
        public string Nev { get; set; }
        public int Rajtszam { get; set; }
        public string Kategoria { get; set; }
        public string IdoEredmeny { get; set; }
        public int TavSzazalek { get; set; }

        public Versenyzo(string sor)
        {
            string[] adatok = sor.Split(';');
            Nev = adatok[0];
            Rajtszam = int.Parse(adatok[1]);
            Kategoria = adatok[2];
            IdoEredmeny = adatok[3];
            TavSzazalek = int.Parse(adatok[4]);
        }

        // 6. feladat: Idő átváltása órára
        public double IdoOraban()
        {
            string[] idoTagok = IdoEredmeny.Split(':');
            double ora = double.Parse(idoTagok[0]);
            double perc = double.Parse(idoTagok[1]);
            double masodperc = double.Parse(idoTagok[2]);

            return ora + (perc / 60) + (masodperc / 3600);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // 2. feladat: Adatok beolvasása
            List<Versenyzo> versenyzok = new List<Versenyzo>();

            string[] sorok = File.ReadAllLines("ub2017egyeni.txt");

            for (int i = 1; i < sorok.Length; i++)
            {
                versenyzok.Add(new Versenyzo(sorok[i]));
            }

            // 3. feladat: Egyéni indulók száma
            Console.WriteLine($"3. feladat: Egyéni indulók: {versenyzok.Count} fő");

            // 4. feladat: Célba érkező női sportolók
            int noiCelbaerok = 0;
            foreach (var v in versenyzok)
            {
                if (v.Kategoria == "Noi" && v.TavSzazalek == 100)
                {
                    noiCelbaerok++;
                }
            }
            Console.WriteLine($"4. feladat: Célba érkező női sportolók: {noiCelbaerok} fő");

            // 5. feladat: Sportoló keresése
            Console.Write("5. feladat: Kérem a sportoló nevét: ");
            string keresettNev = Console.ReadLine();

            bool talalat = false;
            foreach (var v in versenyzok)
            {
                if (v.Nev == keresettNev)
                {
                    talalat = true;
                    Console.WriteLine("\tIndult egyéniben a sportoló? Igen");
                    if (v.TavSzazalek == 100)
                    {
                        Console.WriteLine("\tTeljesítette a teljes távot? Igen");
                    }
                    else
                    {
                        Console.WriteLine("\tTeljesítette a teljes távot? Nem");
                    }
                    break;
                }
            }

            if (!talalat)
            {
                Console.WriteLine("\tIndult egyéniben a sportoló? Nem");
            }

            // 7. feladat: Teljes távot teljesítő férfiak átlagos ideje
            double osszido = 0;
            int ferfiDb = 0;

            foreach (var v in versenyzok)
            {
                if (v.Kategoria == "Ferfi" && v.TavSzazalek == 100)
                {
                    osszido += v.IdoOraban();
                    ferfiDb++;
                }
            }

            double atlag = osszido / ferfiDb;
            Console.WriteLine($"7. feladat: Átlagos idő: {atlag} óra");

            // 8. feladat: Verseny győztesei
            Console.WriteLine("8. feladat: Verseny győztesei");

            Versenyzo noiGyoztes = null;
            double legjobbIdoNoi = double.MaxValue;

            foreach (var v in versenyzok)
            {
                if (v.Kategoria == "Noi" && v.TavSzazalek == 100)
                {
                    double aktualisIdo = v.IdoOraban();
                    if (aktualisIdo < legjobbIdoNoi)
                    {
                        legjobbIdoNoi = aktualisIdo;
                        noiGyoztes = v;
                    }
                }
            }

            if (noiGyoztes != null)
            {
                Console.WriteLine($"\tNők: {noiGyoztes.Nev} ({noiGyoztes.Rajtszam}.) - {noiGyoztes.IdoEredmeny}");
            }

            Console.ReadKey();
        }
    }
}