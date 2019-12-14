using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StudentDLL;

namespace StudentConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            StudentService ss = new StudentService();
            //ss.AddStudents(new Student("Ivan", "Ivanov", 20),
            //    new Student("Petro", "Petrenko", 22));
            //Random random = new Random();
            //foreach(var it in ss.students)
            //{
            //    it.AddMarks("Java", random.Next(1, 12));
            //    it.AddMarks("C#", random.Next(1, 12));
            //    it.AddMarks("C++", random.Next(1, 12));
            //}
            foreach(var it in ss.students)
                Console.WriteLine(it);
            ss.Save();
            Console.ReadLine();
        }
    }
}
