use student_200504
go

-- 1、设计查找自己的学号、选修课程及成绩的存储过程，以自己的学号作为参数，调用存储过程。
drop procedure sp_getInfoBySno

create procedure sp_getInfoBySno @Sno bigint as
select @Sno as 学号, course.Cno as 课程编号, Cname as 课程名, Ccredit 课程学分, sgrade.grade 成绩
from sc as sgrade
         join c as course on sgrade.Cno = course.Cno
where sgrade.Sno = @Sno;
go

exec sp_getInfoBySno 8209200504

-- 2、设计存储过程查找姓“李”并且性别为“M”的学生学号、选修课程并调用。
drop procedure sp_getByLastNameAndGender

create procedure sp_getByLastNameAndGender @lastName varchar(255), @gender tinyint as
select stu.Sno, stu.Sname, stu.Ssex, course.Cno, Cname, Cpno, Ccredit
from s as stu
         left outer join sc as sgrade on stu.Sno = sgrade.Sno
         left outer join c as course on sgrade.Cno = course.Cno
where stu.Sname like concat(@lastName, '%')
  and stu.Ssex = @gender
order by stu.Sno
go

exec sp_getByLastNameAndGender '李', 1


-- 3、设计存储过程计算某同学（学号作为存储过程的参数）所选课程的平均分并调用。
drop procedure sp_calAvgGrade

create procedure sp_calAvgGrade @Sno bigint as
select stu.Sno, stu.Sname, isnull(avg(sgrade.grade), 0)
from s as stu
         left join sc as sgrade on stu.Sno = sgrade.Sno
where stu.Sno = @Sno
group by stu.Sno, stu.Sname
go

exec sp_calAvgGrade 8209200504