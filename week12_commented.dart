// The abstract Student class stores information shared by regular and irregular students.
// It defines a performance-checking method that each student type must implement.
abstract class Student {

  String name;
  String course;
  double _grade;
  int completedActivities;
  int totalActivities;

  // The constructor sets the student information when an object is created.
  Student(
    this.name,
    this.course,
    this._grade,
    this.completedActivities,
    this.totalActivities,
  );

  // Returns the private grade without exposing the field directly.
  double getGrade() {
    return _grade;
  }

  // Updates the grade only when the new value is between 0 and 100.
  void updateGrade(double newGrade) {

    if (newGrade >= 0 && newGrade <= 100) {
      _grade = newGrade;
    } else {
      print('Invalid grade. Enter a value from 0 to 100.');
    }

  }

  // Calculates completed activities as a percentage and avoids division by zero.
  double calculateProgress() {

    if (totalActivities <= 0) {
      return 0;
    }

    return (completedActivities / totalActivities) * 100;

  }

  // Prints the student details and calculated activity progress.
  void displayInformation() {

    print('Student Name: $name');
    print('Course: $course');
    print('Grade: ${getGrade().toStringAsFixed(2)}');
    print('Completed Activities: $completedActivities');
    print('Total Activities: $totalActivities');
    print(
      'Activity Progress: ${calculateProgress().toStringAsFixed(2)}%',
    );

  }

  // Each student type supplies its own performance rules.
  void checkPerformance();

}

// This mixin shares a report-printing behavior with the separate ActivityReport class.
mixin StudentReport {

  // Displays the message provided by the report.
  void displayReport(String message) {

    print('Student Report: $message');

  }

}

// A regular student inherits common data and applies the regular passing rule.
class RegularStudent extends Student {

  // Passes the starting values to the Student constructor.
  RegularStudent(
    String name,
    String course,
    double grade,
    int completedActivities,
    int totalActivities,
  ) : super(
          name,
          course,
          grade,
          completedActivities,
          totalActivities,
        );

  // Overrides the abstract performance check for this student type.
  @override
  void checkPerformance() {

    if (getGrade() >= 75) {
      print('Performance: Passed');
    } else {
      print('Performance: Failed');
    }

  }

  @override
  // Prints the student details and calculated activity progress.
  void displayInformation() {

    print('REGULAR STUDENT');

    super.displayInformation();

    checkPerformance();

    print('-----------------------------------');

  }

}

// An irregular student inherits common data but uses a different progress rule.
class IrregularStudent extends Student {

  // Passes the starting values to the Student constructor.
  IrregularStudent(
    String name,
    String course,
    double grade,
    int completedActivities,
    int totalActivities,
  ) : super(
          name,
          course,
          grade,
          completedActivities,
          totalActivities,
        );

  // Overrides the abstract performance check for this student type.
  @override
  void checkPerformance() {

    if (getGrade() >= 75 && calculateProgress() >= 80) {
      print('Performance: Passed and on track');
    } else if (getGrade() >= 75) {
      print('Performance: Passed with pending activities');
    } else {
      print('Performance: Needs improvement');
    }

  }

  @override
  // Prints the student details and calculated activity progress.
  void displayInformation() {

    print('IRREGULAR STUDENT');

    super.displayInformation();

    checkPerformance();

    print('-----------------------------------');

  }

}

// This independent class uses the StudentReport mixin to display reports.
class ActivityReport with StudentReport {

  // Prints a confirmation that the activity evaluation is complete.
  void generateReport() {

    displayReport('Student activity evaluation completed.');

  }

  // Simulates saving a report, then returns a success message after two seconds.
  // The Future allows the caller to wait for the result with await.
  Future<String> saveReport() async {

    await Future.delayed(Duration(seconds: 2));

    return 'Student activity report saved successfully.';

  }

}

// Creates student objects, displays their results, updates a grade, and awaits the report.
Future<void> main() async {

  RegularStudent student1 = RegularStudent(
    'Student 1',
    'BSIT',
    91.50,
    10,
    10,
  );

  IrregularStudent student2 = IrregularStudent(
    'Ashanti P. Artista',
    'BSIT',
    89.75,
    8,
    10,
  );

  List<Student> students = [
    student1,
    student2,
  ];

  print('STUDENT ACTIVITY TRACKER');
  print('===================================');

  for (Student student in students) {

    student.displayInformation();

  }

  print('UPDATING STUDENT GRADE');
  print('===================================');

  student2.updateGrade(92.00);

  print(
    'Updated Grade: ${student2.getGrade().toStringAsFixed(2)}',
  );

  student2.checkPerformance();

  print('===================================');

  ActivityReport report = ActivityReport();

  report.generateReport();

  print('Saving student activity report...');

  String result = await report.saveReport();

  print(result);

  print('===================================');

}