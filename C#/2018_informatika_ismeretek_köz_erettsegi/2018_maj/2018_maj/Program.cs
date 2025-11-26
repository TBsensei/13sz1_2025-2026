using System;
using System.IO;    
using System.Collections.Generic;
using System.Linq;

namespace _2018_maj
{
    public class Program
    {
        public struct Versenyzo
        {
            public string Nev;
            public string Kategoria;
            public string Egyesulet;
            public List<int> ForduloPontok;

            public Versenyzo(string sor)
            {
                string[] adatok = sor.Split(';');
                this.Nev = adatok[0];
                this.Kategoria = adatok[1];
                this.Egyesulet = adatok[2];

                this.ForduloPontok = new List<int>();
                for (int i = 3; i < 11; i++)
                {
                    this.ForduloPontok.Add(int.Parse(adatok[i]));
                }
            }

            public int OsszPontszamSzamitas()
            {
                List<int> masolatiPontok = new List<int>(this.ForduloPontok);
                masolatiPontok.Sort();
                masolatiPontok.RemoveAt(0);
                masolatiPontok.RemoveAt(0);

                int osszeg = 0;
                foreach (int pont in masolatiPontok)
                {
                    osszeg += pont;
                }

                int nullaFordulokSzama = 0;
                foreach (int pont in this.ForduloPontok)
                {
                    if (pont == 0)
                    {
                        nullaFordulokSzama++;
                    }
                }

                if (nullaFordulokSzama > 0)
                {
                    osszeg += nullaFordulokSzama * 10;
                }

                return osszeg;
            }
        }

        static List<Versenyzo> versenyzok = new List<Versenyzo>();
        const string FILENEV = "fob2016.txt";

        public static void Main(string[] args)
        {
            try
            {
                string[] sorok = File.ReadAllLines(FILENEV);
                foreach (string sor in sorok)
                {
                    versenyzok.Add(new Versenyzo(sor));
                }
            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("Hiba: A 'fob2016.txt' fájl nem található!");
                return;
            }
            catch (Exception)
            {
                Console.WriteLine("Hiba a fájl beolvasása során.");
                return;
            }

            Console.WriteLine("2. feladat: Adatok beolvasva.");
            Console.WriteLine("------------------------------------------");

            Feladat3();
            Console.WriteLine("------------------------------------------");
            Feladat4();
            Console.WriteLine("------------------------------------------");
            Feladat6();
            Console.WriteLine("------------------------------------------");
            Feladat7();
            Console.WriteLine("------------------------------------------");
            Feladat8();
            Console.WriteLine("------------------------------------------");
        }

        static void Feladat3()
        {
            Console.WriteLine("3. feladat: Versenyzők száma: " + versenyzok.Count.ToString());
        }

        static void Feladat4()
        {
            int noiVersenyzokSzama = 0;
            foreach (Versenyzo v in versenyzok)
            {
                if (v.Kategoria == "Noi")
                {
                    noiVersenyzokSzama++;
                }
            }
            int osszesVersenyzoSzama = versenyzok.Count;
            double arany = (double)noiVersenyzokSzama / osszesVersenyzoSzama * 100;

            Console.WriteLine("4. feladat: A női versenyzők aránya: " + arany.ToString("F2") + "%");
        }

        static void Feladat6()
        {
            List<Versenyzo> noiVersenyzok = new List<Versenyzo>();
            foreach (Versenyzo v in versenyzok)
            {
                if (v.Kategoria == "Noi")
                {
                    noiVersenyzok.Add(v);
                }
            }

            int maxPontszam = -1;
            Versenyzo bajnok = new Versenyzo();

            foreach (Versenyzo v in noiVersenyzok)
            {
                int pontszam = v.OsszPontszamSzamitas();
                if (pontszam > maxPontszam)
                {
                    maxPontszam = pontszam;
                    bajnok = v;
                }
            }

            Console.WriteLine("6. feladat: A bajnok női versenyző");
            Console.WriteLine("Név: " + bajnok.Nev);
            Console.WriteLine("Egyesület: " + bajnok.Egyesulet);
            Console.WriteLine("Összpont: " + maxPontszam.ToString());
        }

        static void Feladat7()
        {
            List<Versenyzo> felnottFerfiak = new List<Versenyzo>();
            foreach (Versenyzo v in versenyzok)
            {
                if (v.Kategoria == "Felnott ferfi")
                {
                    felnottFerfiak.Add(v);
                }
            }

            List<string> kiirandoSorok = new List<string>();
            foreach (Versenyzo v in felnottFerfiak)
            {
                kiirandoSorok.Add(v.Nev + ";" + v.OsszPontszamSzamitas().ToString());
            }

            kiirandoSorok.Sort();

            File.WriteAllLines("osszpontFF.txt", kiirandoSorok);

            Console.WriteLine("7. feladat: összpontFF.txt elkészült.");
        }

        static void Feladat8()
        {
            Console.WriteLine("8. feladat: Egyesület statisztika");

            Dictionary<string, int> statisztika = new Dictionary<string, int>();

            foreach (Versenyzo v in versenyzok)
            {
                if (v.Egyesulet != "n.a." && v.Egyesulet.Length > 0)
                {
                    if (statisztika.ContainsKey(v.Egyesulet))
                    {
                        statisztika[v.Egyesulet]++;
                    }
                    else
                    {
                        statisztika.Add(v.Egyesulet, 1);
                    }
                }
            }

            List<KeyValuePair<string, int>> rendezettStatisztika = new List<KeyValuePair<string, int>>(statisztika);

            for (int i = 0; i < rendezettStatisztika.Count - 1; i++)
            {
                for (int j = i + 1; j < rendezettStatisztika.Count; j++)
                {
                    if (rendezettStatisztika[i].Value < rendezettStatisztika[j].Value)
                    {
                        KeyValuePair<string, int> temp = rendezettStatisztika[i];
                        rendezettStatisztika[i] = rendezettStatisztika[j];
                        rendezettStatisztika[j] = temp;
                    }
                    else if (rendezettStatisztika[i].Value == rendezettStatisztika[j].Value)
                    {
                        if (string.Compare(rendezettStatisztika[i].Key, rendezettStatisztika[j].Key) > 0)
                        {
                            KeyValuePair<string, int> temp = rendezettStatisztika[i];
                            rendezettStatisztika[i] = rendezettStatisztika[j];
                            rendezettStatisztika[j] = temp;
                        }
                    }
                }
            }

            foreach (KeyValuePair<string, int> item in rendezettStatisztika)
            {
                Console.WriteLine(item.Key + " - " + item.Value.ToString() + " fő");
            }
        }
    }
}