using System;
using System.Collections.Generic;
using System.IO;

namespace _2019_okt
{
    class Bejegyzes
    {
        public int Ora { get; set; }
        public int Perc { get; set; }
        public int AdasDb { get; set; }
        public string Nev { get; set; }
    }

    class Program
    {
        static int AtszamolPercre(int ora, int perc)
        {
            return ora * 60 + perc;
        }

        static void Main(string[] args)
        {
            List<Bejegyzes> adatok = new List<Bejegyzes>();
            string[] sorok = File.ReadAllLines("cb.txt");

            for (int i = 1; i < sorok.Length; i++)
            {
                string[] reszek = sorok[i].Split(';');
                adatok.Add(new Bejegyzes
                {
                    Ora = int.Parse(reszek[0]),
                    Perc = int.Parse(reszek[1]),
                    AdasDb = int.Parse(reszek[2]),
                    Nev = reszek[3]
                });
            }

            Console.WriteLine($"3. feladat: Bejegyzések száma: {adatok.Count} db");

            bool voltNegy = false;
            foreach (var b in adatok)
            {
                if (b.AdasDb == 4)
                {
                    voltNegy = true;
                    break;
                }
            }

            Console.WriteLine("4. feladat: Volt négy adást indító sofőr.");

            Console.Write("5. feladat: Kérek egy nevet: ");
            string nev = Console.ReadLine();
            int hivasok = 0;
            bool talalat = false;

            foreach (var b in adatok)
            {
                if (b.Nev == nev)
                {
                    hivasok += b.AdasDb;
                    talalat = true;
                }
            }

            if (talalat)
            {
                Console.WriteLine($"\t{nev} {hivasok}x használta a CB-rádiót.");
            }
            else
            {
                Console.WriteLine("\tNincs ilyen nevű sofőr!");
            }

            List<string> kimenet = new List<string>();
            kimenet.Add("Kezdes;Nev;AdasDb");

            foreach (var b in adatok)
            {
                int perc = AtszamolPercre(b.Ora, b.Perc);
                kimenet.Add($"{perc};{b.Nev};{b.AdasDb}");
            }

            File.WriteAllLines("cb2.txt", kimenet);
        }
    }
}