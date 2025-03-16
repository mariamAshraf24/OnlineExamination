USE [master]
GO
/****** Object:  Database [ProjectDB]    Script Date: 3/17/2025 12:18:24 AM ******/
CREATE DATABASE [ProjectDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER2022\MSSQL\DATA\ProjectDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER2022\MSSQL\DATA\ProjectDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ProjectDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ProjectDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ProjectDB] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProjectDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProjectDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProjectDB', N'ON'
GO
ALTER DATABASE [ProjectDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [ProjectDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ProjectDB]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudID] [int] NULL,
	[QuestionID] [int] NULL,
	[AnswerText] [varchar](255) NULL,
	[ExamID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[DeptID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NULL,
	[InstID] [int] NULL,
	[ExamDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudID] [int] NULL,
	[CourseID] [int] NULL,
	[GradeValue] [int] NULL,
	[ExamID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[DeptID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorCourse]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorCourse](
	[CourseID] [int] NOT NULL,
	[InstID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[InstID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NULL,
	[QuestionText] [text] NOT NULL,
	[CorrectAnswer] [varchar](255) NULL,
	[QuestionType] [varchar](10) NULL,
	[question_Point] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Number] [varchar](20) NULL,
	[Email] [varchar](255) NULL,
	[DeptID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourse](
	[CourseID] [int] NOT NULL,
	[StudID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[StudID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentInstructor]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentInstructor](
	[InstID] [int] NOT NULL,
	[StudID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstID] ASC,
	[StudID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Grade] ADD  CONSTRAINT [DF_Grade_GradeValue]  DEFAULT ((0)) FOR [GradeValue]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD FOREIGN KEY([StudID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Exam] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Exam]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([InstID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD FOREIGN KEY([StudID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_grade_Exam] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[Grade] CHECK CONSTRAINT [FK_grade_Exam]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([ID])
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD FOREIGN KEY([InstID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([ID])
GO
ALTER TABLE [dbo].[StudentCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[StudentCourse]  WITH CHECK ADD FOREIGN KEY([StudID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[StudentInstructor]  WITH CHECK ADD FOREIGN KEY([InstID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[StudentInstructor]  WITH CHECK ADD FOREIGN KEY([StudID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD CHECK  (([QuestionType]='MCQ' OR [QuestionType]='TF'))
GO
/****** Object:  StoredProcedure [dbo].[AnswerExam]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AnswerExam]  
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
GO
/****** Object:  StoredProcedure [dbo].[DeleteStudent]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteStudent]
    @StudID INT
AS
BEGIN
    DELETE FROM Student WHERE ID = @StudID;
END;
GO
/****** Object:  StoredProcedure [dbo].[ExamCorrection]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[ExamCorrection] @StdID INT  ,@examid int
AS  
BEGIN  
    DECLARE @ExamResults TABLE (
        ExamID INT,
        TotalQuestions INT,
        CorrectAnswers INT,
        ScorePercentage DECIMAL(5,2)
    );

    INSERT INTO @ExamResults (ExamID, TotalQuestions, CorrectAnswers, ScorePercentage)
    SELECT 
        a.examid AS ExamID,
        COUNT(q.id) AS TotalQuestions,
        SUM(CASE WHEN a.answertext = q.CorrectAnswer THEN 1 ELSE 0 END) AS CorrectAnswers,
        CAST(SUM(CASE WHEN a.answertext = q.CorrectAnswer THEN 1 ELSE 0 END) * 100.0 
             / COUNT(q.id) AS DECIMAL(5,2)) AS ScorePercentage
    FROM answer a
    JOIN question q ON a.id = q.id
    WHERE a.studid = @StdID and a.examid=@examID
    GROUP BY a.examid;

    SELECT * FROM @ExamResults;
end;
GO
/****** Object:  StoredProcedure [dbo].[GenerateRandomExam]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateRandomExam]
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
GO
/****** Object:  StoredProcedure [dbo].[GetExamQuestions]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetExamQuestions]
    @ExamID INT
AS
BEGIN
    SELECT QuestionText, QuestionType, CorrectAnswer
    FROM Question
    WHERE ExamID = @ExamID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetInstructorCourses]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInstructorCourses]
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
GO
/****** Object:  StoredProcedure [dbo].[GetStudentExamAnswers]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentExamAnswers]
    @ExamID INT,
    @StudID INT
AS
BEGIN
    SELECT q.QuestionText, q.CorrectAnswer, a.AnswerText
    FROM Question q
    LEFT JOIN Answer a ON q.ID = a.QuestionID AND a.StudID = @StudID
    WHERE q.ExamID = @ExamID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetStudentGrades]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentGrades]
    @StudID INT
AS
BEGIN
    SELECT c.Name AS CourseName, g.GradeValue
    FROM Grade g
    JOIN Course c ON g.CourseID = c.ID
    WHERE g.StudID = @StudID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetStudentsByDepartment]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentsByDepartment]
    @DeptID INT
AS
BEGIN
    SELECT ID, Name, Number, Email
    FROM Student
    WHERE DeptID = @DeptID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetTotalStudentScore]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTotalStudentScore] @StdID INT  
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
GO
/****** Object:  StoredProcedure [dbo].[InsertStudent]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertStudent]
    @Name VARCHAR(255),
    @Number VARCHAR(20),
    @Email VARCHAR(255),
    @DeptID INT
AS
BEGIN
    INSERT INTO Student (Name, Number, Email, DeptID)
    VALUES (@Name, @Number, @Email, @DeptID);
END;
GO
/****** Object:  StoredProcedure [dbo].[SelectStudent]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectStudent]
    @StudID INT
AS
BEGIN
    SELECT * FROM Student WHERE ID = @StudID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudent]    Script Date: 3/17/2025 12:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudent]
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
GO
USE [master]
GO
ALTER DATABASE [ProjectDB] SET  READ_WRITE 
GO
