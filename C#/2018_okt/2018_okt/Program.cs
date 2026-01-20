using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Uzemanyag
{
    class Arvaltozas
    {
        public string DatumString { get; set; }
        public DateTime Datum { get; set; }
        public int BenzinAr { get; set; }
        public int GazolajAr { get; set; }

        public Arvaltozas(string sor)
        {
            string[] adatok = sor.Split(';');
            DatumString = adatok[0];
            Datum = DateTime.Parse(adatok[0].Replace('.', '-'));
            BenzinAr = int.Parse(adatok[1]);
            GazolajAr = int.Parse(adatok[2]);
        }

        public int Kulonbseg()
        {
            return Math.Abs(BenzinAr - GazolajAr);
        }
    }

    class Program
    {
        static int ElteltNapok(int ev, int elozoHo, int elozoNap, int aktHo, int aktNap)
        {
            int[] napokSzama = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

            if (ev % 4 == 0)
            {
                napokSzama[1] = 29;
            }

            if (elozoHo == aktHo)
            {
                return aktNap - elozoNap;
            }
            else
            {
                return (napokSzama[elozoHo - 1] - elozoNap) + aktNap;
            }
        }

        static void Main(string[] args)
        {
            List<Arvaltozas> valtozasok = new List<Arvaltozas>();
            string[] sorok = File.ReadAllLines("uzemanyag.txt");

            foreach (var sor in sorok)
            {
                valtozasok.Add(new Arvaltozas(sor));
            }

            Console.WriteLine($"3. feladat: Változások száma: {valtozasok.Count}");

            int minKulonbseg = int.MaxValue;
            foreach (var v in valtozasok)
            {
                int aktKulonbseg = v.Kulonbseg();
                if (aktKulonbseg < minKulonbseg)
                {
                    minKulonbseg = aktKulonbseg;
                }
            }
            Console.WriteLine($"4. feladat: A legkisebb különbség: {minKulonbseg}");

            int elofordulas = 0;
            foreach (var v in valtozasok)
            {
                if (v.Kulonbseg() == minKulonbseg)
                {
                    elofordulas++;
                }
            }
            Console.WriteLine($"5. feladat: A legkisebb különbség előfordulása: {elofordulas}");

            bool voltSzokonap = false;
            foreach (var v in valtozasok)
            {
                if (v.Datum.Year % 4 == 0 && v.Datum.Month == 2 && v.Datum.Day == 24)
                {
                    voltSzokonap = true;
                    break;
                }
            }

            if (voltSzokonap)
            {
                Console.WriteLine("6. feladat: Volt változás szökőnapon!");
            }
            else
            {
                Console.WriteLine("6. feladat: Nem volt változás szökőnapon!");
            }

            int bekertEv;
            do
            {
                Console.Write("8. feladat: Kérem adja meg az évszámot [2011..2016]: ");
                bekertEv = int.Parse(Console.ReadLine());
            } while (bekertEv < 2011 || bekertEv > 2016);

            int maxIdoszak = 0;

            for (int i = 0; i < valtozasok.Count - 1; i++)
            {
                var jelenlegi = valtozasok[i];
                var kovetkezo = valtozasok[i + 1];

                int eltelt = ElteltNapok(jelenlegi.Datum.Year,
                                         jelenlegi.Datum.Month, jelenlegi.Datum.Day,
                                         kovetkezo.Datum.Month, kovetkezo.Datum.Day);

                if (eltelt > maxIdoszak)
                {
                    maxIdoszak = eltelt;
                }
            }

            Console.WriteLine($"10. feladat: {bekertEv} évben a leghosszabb időszak {maxIdoszak} nap volt.");

            Console.ReadKey();
        }
    }
}