/*
 * Dainis Tillers
 * dt08050
 */

using System;
using System.Collections.Generic;
using System.Collections;

namespace ConsoleApplication1
{

    /**
     * Satur vienu skaitli un norādi uz nākamo sarakstā, ja tāds ir
     */
    class Number 
    {
        //norāde uz nākamo skaitli
        private Number next = null;

        //skaitļa vērtība
        private int val = 0;

        public Number(int val) 
        {
            this.val = val;
        }

        /**
         * Pievieno jaunu skaitli
         */
        public Number addNext(int val) 
        {
            this.next = new Number(val);
            return this.next;
        }

        /**
         * Atgriež nākamo ierakstu rindā
         */
        public Number getNext()
        {
            return next;
        }

        /**
         * Atgriež skaitļa vērtību
         */
        public int getVal()
        {
            return val;
        }
    }

    /**
     * Veido saistīto sarakstu ar skaitļiem
     */
    class NumberContainer : IEnumerable
    {
        //Norādes uz saraksta pirmo un pēdējo ierakstu
        private Number first = null;
        private Number last  = null;

        /**
         * Pievieno jaunu skaitli sarakstam
         */
        public void add(int num) 
        {
            //ja pievieno pirmo skaitli, tad gan saraksta sākums, gan beigas norāda uz vienu un to pašu skaitli
            if (first == null)
            {
                last = first = new Number(num);
                return;
            }

            //peivienotais skaitlis kļūst par pēdējo
            last = last.addNext(num);
        }

        /**
         * Enumerable interfeisa implementācija
         */
        public IEnumerator GetEnumerator()
        {
            Number number = first;

            //Kamēr rindā ir skaitļi, tos atgriežam
            while (number != null)
            {
                yield return number.getVal();
                number = number.getNext();
            }
        }

    }


    class Program
    {
        /**
         * Realizācija izmantojot ArrayList
         */
        private static int FunkcijaA(int n) 
        {

            Console.WriteLine("FunkcijaA");

            //Pievieno pirmo izmantojamo skaitli sarakstam
            ArrayList primes = new ArrayList();
            primes.Add(2);
            int last_prime = 2;

            //izpilda n-1 reizes, jo 2 ir jau pievienots
            for(int i = 1; i < n; i++)
            {
                bool found = false;

                //Nākamais pirmskaitlis tiek meklēts tik ilgi kamēr tas nav atrasts
                while (!found)
                {

                    last_prime++;
                    found = true;

                    //Pārskaita visus iepriekšējos pirmskaitļus, lai pārliecinātos, ka pašreizējais skaitlis ir pirmskaitlis
                    foreach(int prime in primes)
                    {
                        //Ja dalās ar kādu no iepriekšējiem pirmskaitļiem, tad skaitlis nav pirmskaitlis
                        if (last_prime % prime == 0)
                        {
                            found = false;
                            break;
                        }
                    }
                }

                primes.Add(last_prime);
            }

            //Saskaita pirmskaitļu summu
            int sum = 0;
            foreach (int prime in primes)
            {
                sum += prime;
            }

            
            return sum;
        }

        /**
         * Realizācija izmantojot NumberContainer, kas ir saistītais saraksts. Realizācija ir tādi pati kā FunkcijaA gadījumā, jo NumberContainer implementē Enumerable interfeisu, 
         * kas ļauj izmantot foreach ciklu, lai pārskaitītu visas NumberContainer vērtības
         */
        private static int FunkcijaB(int n)
        {
            Console.WriteLine("FunkcijaB");

            //Pievieno pirmo izmantojamo skaitli sarakstam
            NumberContainer primes = new NumberContainer();
            primes.add(2);
            int last_prime = 2;

            //izpilda n-1 reizes, jo 2 ir jau pievienots
            for (int i = 1; i < n; i++)
            {
                bool found = false;

                //Nākamais pirmskaitlis tiek meklēts tik ilgi kamēr tas nav atrasts
                while (!found)
                {

                    last_prime++;
                    found = true;

                    //Pārskaita visus iepriekšējos pirmskaitļus, lai pārliecinātos, ka pašreizējais skaitlis ir pirmskaitlis
                    foreach (int prime in primes)
                    {
                        //Ja dalās ar kādu no iepriekšējiem pirmskaitļiem, tad skaitlis nav pirmskaitlis
                        if (last_prime % prime == 0)
                        {
                            found = false;
                            break;
                        }
                    }
                }

                primes.add(last_prime);
            }

            //Saskaita pirmskaitļu summu
            int sum = 0;
            foreach (int prime in primes)
            {
                sum += prime;
            }

            return sum;
        }

        static void Main(string[] args)
        {

            Console.WriteLine("Dainis");
            Console.WriteLine("Tillers");
            Console.WriteLine("dt08050");
            Console.Write("Ievadiet n : ");

            int n = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine(FunkcijaA(n));
            Console.WriteLine(FunkcijaB(n));

            Console.ReadKey();
        }
    }
}
