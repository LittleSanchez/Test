using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Serialization;
using System.Threading.Tasks;
using System.Runtime.Serialization.Formatters.Binary;

namespace StudentDLL
{
    public class StudentService
    {
        private const string path = "student.db";

        public IEnumerable<Student> students;

        public StudentService()
        {
            if (!File.Exists(path))
                students = new List<Student>();
            else Load();
        }

        public void AddStudents(params Student[] adds)
        {
            if (adds != null)
                foreach (var it in adds)
                {
                    (students as List<Student>).Add(it);
                }
        }

        public void Remove(string LastName)
        {
            (students as List<Student>).Remove((students as List<Student>).Find(x => x.LastName.Equals(LastName)));
        }

        private void Load()
        {
            using (var fs = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                BinaryFormatter bf = new BinaryFormatter();
                students = bf.Deserialize(fs) as List<Student>;
            }
        }
        
        public void Save()
        {
            using (var fs = new FileStream(path, FileMode.Create, FileAccess.Write))
            {
                BinaryFormatter bf = new BinaryFormatter();
                bf.Serialize(fs, students as List<Student>);
            }
        }

    }
}
