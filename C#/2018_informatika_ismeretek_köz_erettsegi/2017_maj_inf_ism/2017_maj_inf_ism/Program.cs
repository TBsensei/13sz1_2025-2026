using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace _2017_maj_inf_ism_
{
    public class Helsinki
    {
        public class Eredmeny
        {
            public int Helyezes { get; set; }
            public int ErmekSzama { get; set; }
            public string Sportag { get; set; }
            public string Versenyszam { get; set; }

            public Eredmeny(string sor)
            {
                char[] elvalasztoKarakterek = new char[] { ' ', '\t' };
                string[] adatok = sor.Split(elvalasztoKarakterek, StringSplitOptions.RemoveEmptyEntries);

                if (adatok.Length >= 4)
                {
                    int hely;
                    int eremSzam;

                    if (int.TryParse(adatok[0], out hely) && int.TryParse(adatok[1], out eremSzam))
                    {
                        this.Helyezes = hely;
                        this.ErmekSzama = eremSzam;
                        this.Sportag = adatok[2];
                        this.Versenyszam = string.Join(" ", adatok.Skip(3));

                        this.Sportag = this.Sportag.Replace('–', '-').Replace('_', ' ');
                        this.Versenyszam = this.Versenyszam.Replace('–', '-').Replace('_', ' ');
                    }
                }
            }

            public int GetPontszam()
            {
                switch (this.Helyezes)
                {
                    case 1:
                        return 7;
                    case 2:
                        return 5;
                    case 3:
                        return 4;
                    case 4:
                        return 3;
                    case 5:
                        return 2;
                    case 6:
                        return 1;
                    default:
                        return 0;
                }
            }
        }

        public static void Megoldas()
        {
            List<Eredmeny> eredmenyek = new List<Eredmeny>();
            string fajlNev = "helsinki.txt";

            try
            {
                string[] sorok = File.ReadAllLines(fajlNev);
                foreach (string sor in sorok)
                {
                    if (!string.IsNullOrWhiteSpace(sor))
                    {
                        Eredmeny ujEredmeny = new Eredmeny(sor);
                        eredmenyek.Add(ujEredmeny);
                    }
                }
                Console.WriteLine("Sikeresen beolvasva {0} eredmény a(z) {1} fájlból.", eredmenyek.Count, fajlNev);
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("HIBA: A(z) {0} fájl nem található!", fajlNev);
                return;
            }
            catch (Exception ex)
            {
                Console.WriteLine("HIBA a fájl beolvasása közben: {0}", ex.Message);
                return;
            }

            Console.WriteLine(new string('-', 50));

            int arany = 0;
            int ezust = 0;
            int bronz = 0;

            foreach (Eredmeny e in eredmenyek)
            {
                if (e.Helyezes == 1)
                {
                    arany += e.ErmekSzama;
                }
                else if (e.Helyezes == 2)
                {
                    ezust += e.ErmekSzama;
                }
                else if (e.Helyezes == 3)
                {
                    bronz += e.ErmekSzama;
                }
            }

            int osszErem = arany + ezust + bronz;

            Console.WriteLine("Arany: {0}", arany);
            Console.WriteLine("Ezüst: {0}", ezust);
            Console.WriteLine("Bronz: {0}", bronz);
            Console.WriteLine("Összes érem: {0}", osszErem);

            Console.WriteLine(new string('-', 50));

            int osszPont = 0;
            foreach (Eredmeny e in eredmenyek)
            {
                osszPont += e.ErmekSzama * e.GetPontszam();
            }
            Console.WriteLine("Összes pontszám: {0}", osszPont);

            Console.WriteLine(new string('-', 50));

            Console.WriteLine("A magyar sportolók által szerzett érmek száma:");
            Console.WriteLine("Arany: {0}, Ezüst: {1}, Bronz: {2}, Összesen: {3}", arany, ezust, bronz, osszErem);

            if (arany > ezust && arany > bronz)
            {
                Console.WriteLine("Több arany van, mint ezüst vagy bronz (a fájl adatai szerint).");
            }
            else if (ezust > arany && ezust > bronz)
            {
                Console.WriteLine("Több ezüst van, mint arany vagy bronz (a fájl adatai szerint).");
            }
            else if (bronz > arany && bronz > ezust)
            {
                Console.WriteLine("Több bronz van, mint arany vagy ezüst (a fájl adatai szerint).");
            }
            else
            {
                Console.WriteLine("Nincs egyértelműen legtöbb érem valamelyik kategóriában (a fájl adatai szerint).");
            }

            Console.WriteLine(new string('-', 50));

            Dictionary<string, int> pontszamokSportagankent = new Dictionary<string, int>();

            foreach (Eredmeny e in eredmenyek)
            {
                int pont = e.ErmekSzama * e.GetPontszam();
                if (pontszamokSportagankent.ContainsKey(e.Sportag))
                {
                    pontszamokSportagankent[e.Sportag] += pont;
                }
                else
                {
                    pontszamokSportagankent.Add(e.Sportag, pont);
                }
            }

            string legtobbPontSportag = string.Empty;
            int maxPont = -1;

            foreach (KeyValuePair<string, int> pair in pontszamokSportagankent)
            {
                if (pair.Value > maxPont)
                {
                    maxPont = pair.Value;
                    legtobbPontSportag = pair.Key;
                }
            }

            if (maxPont > 0)
            {
                Console.WriteLine("A legtöbb pontot hozó sportág: {0}", legtobbPontSportag);
                Console.WriteLine("Pontszám: {0}", maxPont);
            }

            Console.WriteLine(new string('-', 50));

            string ujFajlNev = "helsinki2.txt";

            try
            {
                List<string> kiirandoSorok = new List<string>();
                foreach (Eredmeny er in eredmenyek)
                {
                    int osszPontszam = er.GetPontszam() * er.ErmekSzama;
                    string sor = string.Format("{0}\t{1}\t{2}\t{3}\t{4}", er.Helyezes, er.ErmekSzama, osszPontszam, er.Sportag, er.Versenyszam);
                    kiirandoSorok.Add(sor);
                }

                File.WriteAllLines(ujFajlNev, kiirandoSorok);
                Console.WriteLine("Sikeresen kiírva a(z) {0} sor a(z) {1} fájlba.", eredmenyek.Count, ujFajlNev);
            }
            catch (Exception ex)
            {
                Console.WriteLine("HIBA a fájl kiírása közben: {0}", ex.Message);
            }
        }
    }

    public class Program
    {
        public static void Main(string[] args)
        {
            Helsinki.Megoldas();
        }
    }
}