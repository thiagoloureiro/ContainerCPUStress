using System;
using System.Threading.Tasks;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("CPU Stress Test Started...");
        
        int coreCount = Environment.ProcessorCount;
        Console.WriteLine($"Number of logical cores: {coreCount}");

        // Number of threads to create based on available logical cores
        Parallel.For(0, coreCount, (i) =>
        {
            StressCpu();
        });

        Console.WriteLine("CPU Stress Test Completed.");
    }

    static void StressCpu()
    {
        // Heavy computation loop
        for (long i = 0; i < long.MaxValue / 10; i++)
        {
            double result = Math.Sqrt(i) * Math.Sqrt(i);
        }
    }
}