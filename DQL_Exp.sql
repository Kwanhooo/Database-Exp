-- 1． 查询学生的基本信息；
select *
from S;

-- 2． 查询“CS”系学生的基本信息；
select *
from S as stu
where stu.Sdept = 'CS';

-- 3． 查询“CS”系学生年龄不在19到21之间的学生的学号、姓名；
select stu.Sno as 学号, stu.Sname as 姓名
from S as stu
where stu.Sage not between 19 and 21;

-- 4． 找出“CS”系年龄最大的学生，显示其学号、姓名；
select top (1) stu.Sno as 学号, stu.Sname as 姓名
from S as stu
order by stu.Sage desc

-- 5． 找出各系年龄最大的学生，显示其学号、姓名；
select stu.Sno as 学号, stu.Sname as 姓名
from S as stu
where stu.Sage = (select max(ss.Sage) from S as ss where ss.Sdept = stu.Sdept group by ss.Sdept);

-- 6． 统计“CS”系学生的人数；
select count(*)
from S as stu
where stu.Sdept = 'CS';

-- 7． 统计各系学生的人数，结果按升序排列；
select stu.Sdept, count(*) as scount
from S as stu
group by stu.Sdept
order by scount

-- 8． 按系统计各系学生的平均年龄，结果按降序排列；
select stu.Sdept, avg(stu.Sage) as avg_age
from S as stu
group by stu.Sdept
order by avg_age desc;

-- 9． 查询无先修课的课程的课程名和学分数；
select course.Cname, course.Ccredit
from C as course
where isnull(course.Cpno, -1) = -1;

-- 10．统计每位学生选修课程的门数、学分及其平均成绩；
select grade.Sno, S2.Sname, count(*) as course_amount, sum(course.Ccredit) as 学分, avg(grade.grade) as 平均成绩
from SC as grade
         join C as course on grade.Cno = course.Cno
         join S S2 on grade.Sno = S2.Sno
group by grade.Sno, S2.Sname;

-- 11．统计选修每门课程的学生人数及各门课程的平均成绩；
select count(*), avg(grade)
from SC
group by Cno;

-- 12．找出平均成绩在85分以上的学生，结果按系分组，并按平均成绩的升序排列；
select sss.Sno
from S as sss
         join SC as sssccc on sss.Sno = sssccc.Sno
group by sss.Sno
having avg(sssccc.grade) > 85

select ss.Sdept, avg(sscc.grade) as avg_grade
from SC as sscc
         join S ss on ss.Sno = sscc.Sno
where ss.Sno in (select sss.Sno
                 from S as sss
                          join SC as sssccc on sss.Sno = sssccc.Sno
                 group by sss.Sno
                 having avg(sssccc.grade) > 85)
group by ss.Sdept
order by avg_grade;

-- 13．查询选修了“1”或“2”号课程的学生学号和姓名；
select stu.Sno, stu.Sname
from S as stu
         join SC as grade on stu.Sno = grade.Sno
where grade.Sno in (1, 2);

-- 14．查询选修了课程名为“数据库系统”且成绩在60分以下的学生的学号、姓名和成绩；
select stu.Sno, stu.Sname, course.Cname, grade.grade
from S as stu
         join SC as grade on stu.Sno = grade.Sno
         join C as course on grade.Cno = course.Cno
where course.Cname = N'数据库系统'
  and grade.grade < 60;

-- 15．查询每位学生选修了课程的学生信息（显示：学号，姓名，课程号，课程名，成绩）；
select stu.Sno, stu.Sname, grade.Cno, course.Cname, grade.grade
from S as stu
         join SC as grade on stu.Sno = grade.Sno
         join C as course on grade.Cno = course.Cno;

-- 16．查询没有选修课程的学生的基本信息；
select S.*
from S
         join SC on S.Sno = SC.Sno
where S.Sno not in (select S.Sno from S);

-- 17．查询选修了3门以上课程的学生学号；
select stu.Sno
from S as stu
where stu.Sno in (select ss.Sno
                  from S as ss
                           join SC as grade on ss.Sno = grade.Sno
                  where ss.Sno = stu.Sno
                  group by ss.Sno
                  having count(grade.Sno) > 3);

-- 18．查询选修课程成绩至少有一门在80分以上的学生学号；
select stu.Sno
from S as stu
where exists(select ss.Sno, min(sscc.grade)
             from S as ss
                      join SC as sscc on ss.Sno = sscc.Sno
             where ss.Sno = stu.Sno
             group by ss.Sno
             having max(sscc.grade) > 80);

-- 19．查询选修课程成绩均在80分以上的学生学号；
select stu.Sno
from S as stu
where exists(select ss.Sno, min(sscc.grade)
             from S as ss
                      join SC as sscc on ss.Sno = sscc.Sno
             where ss.Sno = stu.Sno
             group by ss.Sno
             having min(sscc.grade) > 80);

