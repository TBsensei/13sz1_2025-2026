using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class Program
{
    static void Main()
    {
        // 2. feladat: Adatok beolvasása és tárolása
        string[] sorok = File.ReadAllLines("egyszamjatek.txt");

        List<string> nevek = new List<string>();
        List<List<int>> tippek = new List<List<int>>();

        foreach (var sor in sorok)
        {
            string[] darabok = sor.Split(' ');
            nevek.Add(darabok.Last());

            List<int> jatekosTippjei = new List<int>();
            for (int i = 0; i < darabok.Length - 1; i++)
            {
                jatekosTippjei.Add(int.Parse(darabok[i]));
            }
            tippek.Add(jatekosTippjei);
        }

        // 3. feladat: Játékosok száma
        Console.WriteLine($"3. feladat: Játékosok száma: {nevek.Count}");

        // 4. feladat: Fordulók száma
        int fordulokSzama = tippek[0].Count;
        Console.WriteLine($"4. feladat: Fordulók száma: {fordulokSzama}");

        // 5. feladat: Volt-e 1-es tipp az első fordulóban
        bool voltEgyes = tippek.Any(t => t[0] == 1);
        Console.WriteLine($"5. feladat: Az első fordulóban {(voltEgyes ? "volt egyes tipp!" : "nem volt egyes tipp!")}");

        // 6. feladat: Legnagyobb tipp
        int legnagyobbTipp = tippek.Max(t => t.Max());
        Console.WriteLine($"6. feladat: A legnagyobb tipp a fordulók során: {legnagyobbTipp}");

        // 7. feladat: Forduló sorszámának bekérése
        Console.Write($"7. feladat: Kérem a forduló sorszámát [1-{fordulokSzama}]: ");
        int forduloSorszam;
        if (!int.TryParse(Console.ReadLine(), out forduloSorszam) || forduloSorszam < 1 || forduloSorszam > fordulokSzama)
        {
            forduloSorszam = 1;
        }

        // 8. feladat: Nyertes tipp meghatározása
        int[] forduloTippek = tippek.Select(t => t[forduloSorszam - 1]).ToArray();

        // Egyedi tippek keresése
        var egyediTippek = forduloTippek
            .GroupBy(x => x)
            .Where(g => g.Count() == 1)
            .Select(g => g.Key)
            .ToList();

        if (egyediTippek.Any())
        {
            int nyertesTipp = egyediTippek.Min();
            Console.WriteLine($"8. feladat: A nyertes tipp a megadott fordulóban: {nyertesTipp}");

            // 9. feladat: Nyertes játékos
            int nyertesIndex = Array.IndexOf(forduloTippek, nyertesTipp);
            Console.WriteLine($"9. feladat: A megadott forduló nyertese: {nevek[nyertesIndex]}");

            // 10. feladat: nyertes.txt fájl létrehozása
            File.WriteAllText("nyertes.txt",
                $"Forduló sorszáma: {forduloSorszam}\n" +
                $"Nyertes tipp: {nyertesTipp}\n" +
                $"Nyertes játékos: {nevek[nyertesIndex]}");
        }
        else
        {
            Console.WriteLine("8. feladat: Nem volt egyedi tipp a megadott fordulóban!");
            Console.WriteLine("9. feladat: Nem volt nyertes a megadott fordulóban!");
        }
    }
}