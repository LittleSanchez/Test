using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentDLL
{
    [Serializable]
    public class Student
    {
        public int Age { get; set; }
        public string Name { get; set; }

        public string LastName { get; set; }

        public List<Mark> Marks { get; set; }

        public Student(string name, string lastname, int age)
        {
            Marks = new List<Mark>();
            Name = name;
            LastName = lastname;
            Age = age;
        }

        public void AddMarks(string subject, int mark)
        {
            if (!Marks.Exists(x => x.Subject.Equals(subject)))
                Marks.Add(new Mark { Subject = subject, Rating = mark });
        }

        public override string ToString()
        {
            string result = $"Student{{{Name} {LastName}, {Age}}}";
            if (Marks != null)
            {
                result += $"Marks{{{string.Join(" ", Marks)}}}";
            }
            return result;
        }

    }

    [Serializable]

    public class Mark
    {
        public int Rating { get; set; }
        public string Subject { get; set; }

        public override string ToString()
        {
            return $"{Subject} - {Rating}";
        }
    }
}
