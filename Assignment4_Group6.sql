/*
 ---------------------------
 ASSIGNMENT - 4
 ---------------------------
 CREATED BY:- 
 GROUP #6
 MARK RANDALL (301178066)
 AMEEK GUPTA (301170579)
 CHITWAN KATYAL (301169422)
 ---------------------------
 SUBMITTED TO:-
 PROF. AYESHA MANZER
 ---------------------------
*/


-- CREATING STUDENT TABLE
CREATE TABLE STUDENT
(
    Student_id NUMBER(5),
    Fname VARCHAR2(30) NOT NULL,
    Lname VARCHAR2(30) NOT NULL,
    Date_of_birth DATE,
    Register_Date DATE DEFAULT SYSDATE,
        CONSTRAINT student_studentid_pk PRIMARY KEY (Student_id)
);

-- CREATING COURSE TABLE
CREATE TABLE COURSE 
(
    course_title VARCHAR2(10),
    course_name VARCHAR2(20) NOT NULL,
        CONSTRAINT course_coursetitle_pk PRIMARY KEY (course_title)
);

-- CREATING ENROLLMENT TABLE
CREATE TABLE ENROLLMENT
(
    course_title VARCHAR2(10),
    Student_id NUMBER(5),
    enroll_date DATE DEFAULT SYSDATE,
    course_grade VARCHAR2(2),
        CONSTRAINT enrollment_coursetitle_fk FOREIGN KEY (course_title)
            REFERENCES course (course_title),
        CONSTRAINT enrollment_stdtid_crstitle_pk 
        PRIMARY KEY (Student_id, course_title),
        CONSTRAINT enrollment_studentid_fk FOREIGN KEY (Student_id)
            REFERENCES student (Student_id)
);


-- Question 1

-- INSERTING VALUES INTO STUDENT TABLE
INSERT INTO student (
    student_id, Fname, Lname, 
    Date_of_birth, 
    Register_Date
)
    VALUES (
        10001, 'MARK', 'RANDALL', 
        TO_DATE('28-JAN-87', 'DD-MON-YY'), 
        TO_DATE('01-AUG-21', 'DD-MON-YY')
);

INSERT INTO student (
    student_id, Fname, Lname,
    Date_of_birth,
    Register_Date
)
    VALUES (
        10002, 'AMEEK', 'GUPTA',
        TO_DATE('11-JULY-94', 'DD-MON-YY'),
        TO_DATE('02-AUG-21', 'DD-MON-YY')
);
    
INSERT INTO student (
    student_id, Fname, Lname,
    Date_of_birth,
    Register_Date
)
    VALUES (
        10003, 'CHITWAN', 'KATYAL',
        TO_DATE('03-OCTOBER-93', 'DD-MON-YY'),
        TO_DATE('03-AUG-21', 'DD-MON-YY')
);

INSERT INTO student (
    student_id, Fname, Lname,
    Date_of_birth
)
    VALUES (
        10004, 'MR. PEANUT', 'BUTTER',
        TO_DATE('01-JAN-78', 'DD-MON-YY')
);

-- INSERTING VALUES INTO COURSE TABLE
INSERT INTO course (
    course_title, course_name
)
    VALUES (
        'COMP122', 'DATABASE'
);

INSERT INTO course (
    course_title, course_name
)
    VALUES (
        'COMP125', 'JAVASCRIPT'
);

INSERT INTO course (
    course_title, course_name
)
    VALUES (
        'COMP213', 'WEB DESIGN'
);

-- Inserting Enrollment Values
INSERT ALL 
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP122', 10001, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP122', 10002, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP122', 10003, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP122', 10004, 'B')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP213', 10001, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP125', 10002, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP125', 10003, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP125', 10001, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP213', 10002, 'A+')
    INTO enrollment(course_title, Student_id, course_grade) 
        VALUES('COMP213', 10003, 'A+')
SELECT * FROM dual;


-- Question 2

SELECT student_id "Student #", course_title "Courses"
    FROM student JOIN enrollment USING (student_id)
        WHERE student_id = 10001;

SELECT student_id "Student #", course_title "Courses"
    FROM student JOIN enrollment USING (student_id)
        WHERE student_id = 10002;
        
SELECT student_id "Student #", course_title "Courses"
    FROM student JOIN enrollment USING (student_id)
        WHERE student_id = 10003;
        
        
--Question 3 

SELECT course_title "Course", INITCAP(lname) || ', ' || 
        INITCAP(fname) "Full Name"
    FROM student JOIN enrollment USING (student_id)
        WHERE course_title = 'COMP122';
        
        
--Question 4 

SELECT CONCAT(CONCAT(fname, ' '), lname) "Full Name", course_name "Course Name",
            LPAD(course_grade, 3, ' ') "Grade"
    FROM student JOIN enrollment USING (student_id)
        JOIN course USING (course_title)
            WHERE student_id = 10003;
            

--Question 5

SELECT course_title "Course", COUNT(student_id) "Total Students"
    FROM enrollment
        GROUP BY course_title;


--Question 6

SELECT course_title "Highest Enrolled", COUNT(student_id) "Number Enrolled"
    FROM enrollment
        GROUP BY course_title
            HAVING COUNT(student_id) = (
                    SELECT MAX(COUNT(student_id))
                    FROM enrollment
                    GROUP BY course_title
                    );
                    
                    
--Question 7

SELECT REPLACE(course_title, 'COMP122', 'COMP123') "Changed title"
    FROM course
        WHERE course_title = 'COMP122';

--Reference
SELECT *
FROM student;
SELECT *
FROM course;
SELECT *
FROM enrollment;

SELECT * 
FROM user_cons_columns
WHERE table_name = 'COURSE';

--In case a reset is needed
--**Drop course table before student
DROP TABLE student;
DROP TABLE course;
DROP TABLE enrollment;
