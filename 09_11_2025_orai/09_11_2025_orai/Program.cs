using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _09_11_2025_orai
{
    class Program
    {
        static int LNKO(int n, int m)
        {
            int r = m % n;
            while (r != 0)
            {
                m = n;
                n = r;
                r = m % n;

            }
            return n;
        }
        static void Main(string[] args)
        {
            int n = 0;
            int m = 0;

            while (true)
            {
                Console.Write("Add meg az első számot: ");
                while (!int.TryParse(Console.ReadLine(), out n))
                {
                    Console.Write("Nem számot adtál meg! Próbáld újra: ");
                }
                Console.Write("Add meg a második számot: ");
                while (!int.TryParse(Console.ReadLine(), out m))
                {
                    Console.Write("Nem számot adtál meg! Próbáld újra: ");
                }
                Console.WriteLine(LNKO(n, m));
            }
        }

    }
}
