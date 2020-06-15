class Student {
  final String firstname, lastname, reg_id,father, mother, gender, caste,symbol_no,dob_year, dob_mon, dob_day,school_name;
  final int id, school_id, year ;
  
  Student({this.reg_id, 
    this.firstname,
    this.lastname,
    this.mother,
    this.gender,
    this.caste,
    this.school_id,
    this.year,
    this.dob_year,
    this.dob_mon,
    this.dob_day,
    this.symbol_no,
    this.father,
    this.school_name,
    this.id,
    
  });

  factory Student.fromJson(Map<String, dynamic> data) {
    
    print("namellllllllllll");
    print(data["first_name"]);
    
    return Student(
        firstname: data["first_name"],
        lastname: data["last_name"],
        father: data["fathers_name"],
        mother: data["mothers_name"],
        gender: data["sex"],
        caste: data["caste"],
        symbol_no: data["symbol_no"],
        id: data["id"],
        school_id: data["School_ID"],
        year: data["year"],
        dob_day: data["dob_day"],
        dob_year: data["dob_year"],
        dob_mon: data["dob_month"],
        school_name: data["school_name"],
        reg_id: data["reg_id"]
        );
  }
}

class Akodata{
  final Student student;
final List<Udata> udata;
final dynamic avggpa;
  Akodata({this.avggpa, this.student,this.udata,});
  factory Akodata.fromJson(Map<String, dynamic> data){
    var categories = data['subject_grades'] as List;
    var student_data = data['student'];
    List<Udata> catlist = categories.map((f) => Udata.fromJson(f)).toList();
    return(Akodata( student: Student.fromJson(student_data),udata: catlist,avggpa:data["avg_gpa"]));

  }
}

class Udata {
  final dynamic  gpa;
  final String credit,name, lable, grade;

  Udata({
    this.credit,
    this.gpa,
    this.name,
    this.lable,
    this.grade,
  });

  factory Udata.fromJson(Map<String, dynamic> data) {
    print("udata ko ho");
    print(data);
    return Udata(
        credit: data["credit"] as String,
        gpa: data["gpa"] ,
        name: data["name"] as String,
        lable: data["label"] as String,
        grade: data["grade"] as String);
  }
}
