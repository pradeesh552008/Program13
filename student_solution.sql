CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Faculty table
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Course table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    FacultyID INT NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- Student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- StudentCourse relationship table
CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Department records
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');

-- Faculty records
INSERT INTO Faculty (FacultyID, FacultyName, DepartmentID) VALUES
(101, 'Dr. Ravi', 1),
(102, 'Dr. Meena', 2);

-- Course records
INSERT INTO Course (CourseID, CourseName, FacultyID) VALUES
(201, 'Database Systems', 101),
(202, 'Data Structures', 101),
(203, 'Mathematics', 102);

-- Student records
INSERT INTO Student (StudentID, StudentName) VALUES
(1001, 'Arun'),
(1002, 'Priya'),
(1003, 'Kumar');

-- Student-Course records
INSERT INTO StudentCourse (StudentID, CourseID) VALUES
(1001, 201),
(1001, 202),
(1002, 203),
(1003, 201);

-- Display normalized data using JOIN
SELECT
    s.StudentID,
    s.StudentName,
    c.CourseName,
    f.FacultyName,
    d.DepartmentName
FROM Student s
JOIN StudentCourse sc
    ON s.StudentID = sc.StudentID
JOIN Course c
    ON sc.CourseID = c.CourseID
JOIN Faculty f
    ON c.FacultyID = f.FacultyID
JOIN Department d
    ON f.DepartmentID = d.DepartmentID
ORDER BY s.StudentID, c.CourseID;
