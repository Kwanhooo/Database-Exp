INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (1212, N'李均浩', 1, 20, N'计算机学院', N'2022-03-01', 190);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (4545, N'马啸塽', 1, 20, N'计算机学院', N'2022-03-16', 169);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8201220311, N'李四', 1, 23, N'土木院', N'2022-04-07', 177);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8201220312, N'张三', 0, 1, N'湘雅医学院', N'2022-04-08', 166);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8209200502, N'张晓阳', 1, 20, N'计算机学院', N'2022-03-09', 170);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8209200503, N'王一凡', 1, 20, N'计算机学院', N'2022-03-01', 171);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8209200504, N'李均浩', 1, 20, N'计算机学院', N'2022-03-01', 190);
INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (8209200555, N'张四', 1, 20, N'数统院', N'2001-11-11', 11);

INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1001, N'数据库系统', null, 3);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1002, N'SSD1', null, 2.5);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1003, N'SSD4', 1003, 2);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1004, N'编译原理', 2, 3);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1005, N'离散数学', 1005, 3);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1006, N'C++', 1002, 3);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1007, N'Java', 1006, 3);
INSERT INTO student_200504.dbo.C (Cno, Cname, Cpno, Ccredit)
VALUES (1250, N'专业前沿理论讲座', null, 0.5);

INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (4545, 1001, 99);
INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (8209200503, 1005, 79);
INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (8209200504, 1001, 2);
INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (8209200504, 1003, 2121);
INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (8209200504, 1004, 100);
INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (8209200555, 1250, 78);


INSERT INTO student_200504.dbo.S (Sno, Sname, Ssex, Sage, Sdept, SBirth, SHeight)
VALUES (123456, N'李七', 1, 48, N'数统院', N'1973-11-11', 171);

INSERT INTO student_200504.dbo.SC (Sno, Cno, grade)
VALUES (9999999, 1001, 88);