CREATE DATABASE ProjectDB;
USE ProjectDB;

CREATE TABLE Department (
    ID INT PRIMARY KEY Identity,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Instructor (
    ID INT PRIMARY KEY Identity,
    Name VARCHAR(255) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(ID)
);

CREATE TABLE Course (
    ID INT PRIMARY KEY Identity,
    Name VARCHAR(255) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(ID)
);

CREATE TABLE Student (
    ID INT PRIMARY KEY Identity,
    Name VARCHAR(255) NOT NULL,
    Number VARCHAR(20),
    Email VARCHAR(255) UNIQUE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(ID)
);

CREATE TABLE StudentCourse (
    CourseID INT,
    StudID INT,
    PRIMARY KEY (CourseID, StudID),
    FOREIGN KEY (CourseID) REFERENCES Course(ID),
    FOREIGN KEY (StudID) REFERENCES Student(ID)
);

CREATE TABLE InstructorCourse (
    CourseID INT,
    InstID INT,
    PRIMARY KEY (CourseID, InstID),
    FOREIGN KEY (CourseID) REFERENCES Course(ID),
    FOREIGN KEY (InstID) REFERENCES Instructor(ID)
);

CREATE TABLE StudentInstructor (
    InstID INT,
    StudID INT,
    PRIMARY KEY (InstID, StudID),
    FOREIGN KEY (InstID) REFERENCES Instructor(ID),
    FOREIGN KEY (StudID) REFERENCES Student(ID)
);

CREATE TABLE Exam (
    ID INT PRIMARY KEY Identity,
    CourseID INT,
    InstID INT,
    ExamDate DATE,
    FOREIGN KEY (CourseID) REFERENCES Course(ID),
    FOREIGN KEY (InstID) REFERENCES Instructor(ID)
);

create TABLE Question (
    ID INT PRIMARY KEY Identity,
    ExamID INT,
    QuestionText TEXT NOT NULL,
    CorrectAnswer VARCHAR(255),
    QuestionType VARCHAR(10), CHECK (QuestionType IN ('TF', 'MCQ')),
    FOREIGN KEY (ExamID) REFERENCES Exam(ID)
);


CREATE TABLE Answer (
    ID INT PRIMARY KEY Identity,
    StudID INT,
    QuestionID INT,
    AnswerText VARCHAR(255),
    FOREIGN KEY (StudID) REFERENCES Student(ID),
    FOREIGN KEY (QuestionID) REFERENCES Question(ID)
);

CREATE TABLE Grade (
    ID INT PRIMARY KEY Identity,
    StudID INT,
    CourseID INT,
    GradeValue DECIMAL(5,2),
    FOREIGN KEY (StudID) REFERENCES Student(ID),
    FOREIGN KEY (CourseID) REFERENCES Course(ID)
);

INSERT INTO Department ( Name) VALUES
( 'Computer Science'),
( 'Information Systems'),
( 'Software Engineering');

INSERT INTO Student ( Name, Number, Email, DeptID) VALUES
( 'Ali Ahmed', '01012345678', 'ali@gmail.com', 1),
( 'Mona Saeed', '01098765432', 'mona@gmail.com', 2),
( 'Omar Mahmoud', '01123456789', 'omar@gmail.com', 3);

INSERT INTO Instructor ( Name, DeptID) VALUES
( 'Dr. Ahmed Tarek', 1),
( 'Dr. Sara Adel', 2),
( 'Dr. Mohamed Hassan', 3);

INSERT INTO Course ( Name, DeptID) VALUES
( 'Database Systems', 1),
( 'Data Structures', 1),
( 'Web Development', 2);

INSERT INTO StudentInstructor (InstID, StudID) VALUES
(1,1),
(1, 2),
(2, 3),
(3, 1);

INSERT INTO InstructorCourse (CourseID, InstID) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO StudentCourse (CourseID, StudID) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 3);

INSERT INTO Exam ( CourseID, InstID, ExamDate) VALUES
( 1, 1, '2025-03-15'),
( 2, 2, '2025-03-16');

INSERT INTO Question (ExamID, QuestionText, CorrectAnswer, QuestionType) VALUES
( 1, 'What is SQL?', 'Structured Query Language', 'MCQ'),
( 1, 'Is MySQL a relational database?', 'True', 'TF');

INSERT INTO Answer ( StudID, QuestionID, AnswerText) VALUES
( 1, 1, 'Structured Query Language'),
( 2, 2, 'True');

INSERT INTO Grade ( StudID, CourseID, GradeValue) VALUES
( 1, 1, 85.5),
( 2, 2, 90.0),
( 3, 3, 88.0);

SELECT s.Name, s.Email
FROM Student s
JOIN Department d ON s.DeptID = d.ID
WHERE d.Name = 'Computer Science';

SELECT c.Name
FROM Course c
JOIN InstructorCourse ic ON c.ID = ic.CourseID
JOIN Instructor i ON ic.InstID = i.ID
WHERE i.Name = 'Dr. Ahmed Tarek';

SELECT q.QuestionText, q.QuestionType
FROM Question q
JOIN Exam e ON q.ExamID = e.ID
JOIN Course c ON e.CourseID = c.ID
WHERE c.Name = 'Database Systems';

SELECT a.AnswerText, q.QuestionText
FROM Answer a
JOIN Question q ON a.QuestionID = q.ID
JOIN Student s ON a.StudID = s.ID
WHERE s.Name = 'Ali Ahmed';

SELECT s.Name, g.GradeValue
FROM Grade g
JOIN Student s ON g.StudID = s.ID
JOIN Course c ON g.CourseID = c.ID
WHERE c.Name = 'Database Systems';


ALTER TABLE Answer
ADD ExamID INT;

-- Add foreign key constraint to link ExamID to the Exam table
ALTER TABLE Answer
ADD CONSTRAINT FK_Answer_Exam
FOREIGN KEY (ExamID) REFERENCES Exam(ID);

----------------------------------------------------------
CREATE PROCEDURE InsertStudent
    @Name VARCHAR(255),
    @Number VARCHAR(20),
    @Email VARCHAR(255),
    @DeptID INT
AS
BEGIN
    INSERT INTO Student (Name, Number, Email, DeptID)
    VALUES (@Name, @Number, @Email, @DeptID);
END;

EXEC InsertStudent 
    @Name = 'Ahmed Mohamed', 
    @Number = '01011223344', 
    @Email = 'ahmed@gmail.com', 
    @DeptID = 1;
----------------------------------------------------------

CREATE PROCEDURE UpdateStudent
    @StudID INT,
    @Name VARCHAR(255),
    @Number VARCHAR(20),
    @Email VARCHAR(255),
    @DeptID INT
AS
BEGIN
    UPDATE Student
    SET Name = @Name, Number = @Number, Email = @Email, DeptID = @DeptID
    WHERE ID = @StudID;
END;

EXEC UpdateStudent 
    @StudID = 1, 
    @Name = 'Ali Ahmed', 
    @Number = '01012345678', 
    @Email = 'ali@gmail.com', 
    @DeptID = 1;
----------------------------------------------------------------
CREATE PROCEDURE DeleteStudent
    @StudID INT
AS
BEGIN
    DELETE FROM Student WHERE ID = @StudID;
END;

EXEC DeleteStudent @StudID = 1;
-------------------------------------------------------------------
CREATE PROCEDURE SelectStudent
    @StudID INT
AS
BEGIN
    SELECT * FROM Student WHERE ID = @StudID;
END;

EXEC SelectStudent @StudID = 1;
-------------------------------------------------------------------
CREATE PROCEDURE GetStudentsByDepartment
    @DeptID INT
AS
BEGIN
    SELECT ID, Name, Number, Email
    FROM Student
    WHERE DeptID = @DeptID;
END;

EXEC GetStudentsByDepartment @DeptID = 1;
--------------------------------------------------------------------
CREATE PROCEDURE GetStudentGrades
    @StudID INT
AS
BEGIN
    SELECT c.Name AS CourseName, g.GradeValue
    FROM Grade g
    JOIN Course c ON g.CourseID = c.ID
    WHERE g.StudID = @StudID;
END;

EXEC GetStudentGrades @StudID = 1;
-----------------------------------------------
CREATE PROCEDURE GetInstructorCourses
    @InstID INT
AS
BEGIN
    SELECT c.Name AS CourseName, COUNT(sc.StudID) AS StudentCount
    FROM InstructorCourse ic
    JOIN Course c ON ic.CourseID = c.ID
    LEFT JOIN StudentCourse sc ON c.ID = sc.CourseID
    WHERE ic.InstID = @InstID
    GROUP BY c.Name;
END;

EXEC GetInstructorCourses @InstID = 1;
-----------------------------------------------------------
CREATE PROCEDURE GetExamQuestions
    @ExamID INT
AS
BEGIN
    SELECT QuestionText, QuestionType, CorrectAnswer
    FROM Question
    WHERE ExamID = @ExamID;
END;

EXEC GetExamQuestions @ExamID = 1;
---------------------------------------------------------------
CREATE PROCEDURE GetStudentExamAnswers
    @ExamID INT,
    @StudID INT
AS
BEGIN
    SELECT q.QuestionText, q.CorrectAnswer, a.AnswerText
    FROM Question q
    LEFT JOIN Answer a ON q.ID = a.QuestionID AND a.StudID = @StudID
    WHERE q.ExamID = @ExamID;
END;

EXEC GetExamQuestions @ExamID = 1; 
------------------------------------------------------------
go
alter PROCEDURE GenerateRandomExam
	@CourseName varchar(255),
	@NumQuestions int,
    @ExamID INT OUTPUT
AS
BEGIN
  declare @coId int , @instId int 
  select  @coId =Course.ID 
  from Course 
  where Course.name = @CourseName
  
  select @instId = i.id
  from Instructor i, course c, instructorcourse ic
  where i.id = ic.InstID 
	and c.id = ic.CourseID 
	and c.name = @courseName
    
    INSERT INTO Exam (CourseID, InstID, ExamDate)
    VALUES (@coId, @instId, GETDATE()); 
	select @ExamID = Exam.id
	from exam , course c
	where c.name = @CourseName --'Database Systems'

	INSERT INTO Grade(StudID,CourseID,ExamID)
	select sc.StudID , @coId , @ExamID
	from StudentCourse sc join course c on c.ID = sc.CourseID join Student s on s.ID=sc.StudID
	where CourseID=@coId  --'Database Systems'

	INSERT INTO Question (ExamID, QuestionText, CorrectAnswer, QuestionType , question_Point)
	SELECT @ExamID, q.QuestionText, q.CorrectAnswer, q.QuestionType  , q.question_Point
	FROM (
    SELECT TOP(@NumQuestions) 
           q.ID AS QuestionID, 
           q.ExamID, 
           c.ID AS CourseID, 
           q.QuestionText, 
           q.CorrectAnswer, 
           q.QuestionType ,
		   q.question_Point
    FROM Question q join Exam e on q.ExamID=e.ID 
    JOIN Course c ON c.ID= e.CourseID
    WHERE c.Name = @CourseName --'Database Systems'
    ORDER BY NEWID()
) q

	INSERT INTO Answer (StudID, QuestionID, ExamID)
    SELECT s.ID, q.ID, @ExamID 
    FROM (
        SELECT TOP (@NumQuestions) q.ID
		FROM Question q join Exam e on q.ExamID=e.ID 
		JOIN Course c ON c.ID= e.CourseID
		where c.name =  @CourseName --'Database Systems'
        ORDER BY NEWID()
    ) q
    JOIN StudentCourse sc ON sc.CourseID = @CoID
    JOIN Student s ON s.ID = sc.StudID;

END;

declare @x int
exec GenerateRandomExam 'Database Systems' , 1 , @ExamID = @x output
select @x

go 
alter PROCEDURE AnswerExam  
    @studentID INT,  
    @examID INT,  
    @questionID INT,  
    @answerText VARCHAR(255)  
AS  
BEGIN  
    
    DECLARE @correctAnswer VARCHAR(255);  
    DECLARE @questionPoint INT;  
 
    SELECT @correctAnswer = CorrectAnswer,
	       @questionPoint = question_Point  
    FROM question  
    WHERE id = @questionID;
	select @correctAnswer , @questionPoint


	DECLARE @isCorrect int = 0;  
    IF @answerText = @correctAnswer  
    SET @isCorrect = 1;

    UPDATE answer  
    SET answer.AnswerText = @answerText
    WHERE Answer.StudID = @studentID 
	  AND Answer.QuestionID = @questionID
	  and Answer.ExamID = @examID;

     IF @isCorrect = 1  
	BEGIN  
		UPDATE Grade
		SET GradeValue = GradeValue + @questionPoint
		FROM Grade
		JOIN Course ON Course.ID = Grade.CourseID
		WHERE Grade.StudID = @studentID
		  AND Grade.ExamID = @examID;
	END;
end

exec AnswerExam 1 , 9 , 10 , 'True'
exec AnswerExam 3 , 9 , 10 , 'True'
-----------------------------------------------

---GetTotalStudentScore---
go
alter PROCEDURE GetTotalStudentScore @StdID INT  
AS  
BEGIN  
  
    DECLARE @TotalQuestions INT, @CorrectAnswers INT, @ScorePercentage DECIMAL(5,2);

    SELECT 
        @TotalQuestions = COUNT(q.id),
        @CorrectAnswers = SUM(CASE WHEN sa.answertext = q.CorrectAnswer THEN 1 ELSE 0 END)
    FROM answer sa
    JOIN question q ON sa.QuestionID = q.id
    WHERE sa.studid = @StdID;

    SET @ScorePercentage = CASE 
        WHEN @TotalQuestions > 0 
        THEN CAST(@CorrectAnswers * 100.0 / @TotalQuestions AS DECIMAL(5,2))
        ELSE 0
    END;

    SELECT 
        @StdID AS StudentID,
        @TotalQuestions AS TotalQuestions,
        @CorrectAnswers AS CorrectAnswers,
        @ScorePercentage AS ScorePercentage;
END;
go

GetTotalStudentScore 3
go







