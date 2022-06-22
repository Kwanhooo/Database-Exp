-- 1．  将数据分别插入表S、C、SC；
insert into S(sno, sname, ssex, sage, sdept, sbirth, sheight)
values (8209200555, N'张四', 1, 20, N'数统院', '2001-11-11', 11);

insert into C(Cno, Cname, Cpno, Ccredit)
values (1250, N'专业前沿理论讲座', null, 0.5);

insert into SC(Sno, Cno, grade)
values (8209200555, 1250, 78);

-- 2．  将表S、C、SC中的数据保存在磁盘上。
-- 使用bcl命令完成此操作
-- PS C:\Users\11957> bcp student_200504.dbo.S out E:\S.dat.bak -T -c
-- PS C:\Users\11957> bcp student_200504.dbo.C out E:\C.dat.bak -T -c
-- PS C:\Users\11957> bcp student_200504.dbo.SC out E:\SC.dat.bak -T -c

-- 3．  在表S、C、SC上练习数据的插入、修改、删除操作。（比较在表上定义/未定义主码（Primary Key）或外码（Foreign Key）时的情况）
-- A.插入
insert into S(sno, sname, ssex, sage, sdept, sbirth, sheight)
values (8209200504, N'张四', 1, 20, N'数统院', '2001-11-11', 11);

insert into C(Cno, Cname, Cpno, Ccredit)
values (1250, N'专业前沿理论讲座', null, 0.5);

insert into SC(Sno, Cno, grade)
values (8209200555, 1250, 78);

-- 受PK约束，不能重复
insert into S(sno, sname, ssex, sage, sdept, sbirth, sheight)
values (8209200555, N'不能重复', 0, 27, N'材料院', '2001-11-21', 133);

-- 受FK约束，Sno和Cno必须在S以及C表中，不可插入
insert into SC(Sno, Cno, grade)
values (123456, 666, 78);

-- 去掉PK、FK约束
alter table S
    drop S_pk;

alter table SC
    drop Cno_FK,Sno_FK

-- B.更新
update S
set Sname=N'李荣浩'
where Sno = 8209200504;

-- C.删除
delete
from S
where Sno = 8209200555;

-- 4．  将表S、C、SC中的数据全部删除，再利用磁盘上备份的数据来恢复数据。
drop table S
drop table C
drop table SC

delete
from S
where true;

delete
from C
where true;

delete
from SC;

bulk insert S
    from 'E:\S.dat.bak'
    with (
    fieldterminator ='\t' ,
    rowterminator = '\n'
    );


bulk insert C
    from 'E:\C.dat.bak'
    with (
    fieldterminator ='\t' ,
    rowterminator = '\n'
    );

bulk insert SC
    from 'E:\SC.dat.bak'
    with (
    fieldterminator ='\t' ,
    rowterminator = '\n'
    );

-- 5．  如果要在表SC中插入某个学生的选课信息（如：学号为“2007001005”，课程号为“c123”，成绩待定），应如何进行？
-- 在设计表的时候，SC.grade 使用 null 约束，也就是说允许这一列存在空值，这样表示待定，那么在插入数据的时候，可以不指定grade值。
insert into S(Sno)
values (2007001005);
insert into C(Cno)
values ('123')
insert into SC(Sno, Cno)
values (2007001005, 123)

-- 6．  求各系学生的平均成绩，并把结果存入数据库；
select *
into avg_grade_by_dept
from (select stu.Sdept as dept, avg(sgrade.grade) as avg_grade
      from S as stu
               join SC as sgrade on stu.Sno = sgrade.Sno
      group by stu.Sdept) as avg_temp;

-- 7．  将“CS”系全体学生的成绩置零；
update SC
set grade=0
where Sno in (select Sno from S where Sdept = 'CS');

-- 8．  删除“CS”系全体学生的选课记录；
delete
from SC
where Sno in (select Sno from S where Sdept = 'CS');

-- 9．  删除学号为“S1”的相关信息；
-- 由于有FK约束，因此必须先删除SC中的相关数据，再删除S中的相关数据。
delete
from SC
where Sno = 1;
delete
from S
where Sno = 1;

-- 10．将学号为“S1”的学生的学号修改为“S001”；
-- 先复制一行，但是更新Sno
insert into S(Sno, sname, ssex, sage, sdept, sbirth, sheight)
    (select 001, sname, ssex, sage, sdept, sbirth, sheight
     from S
     where Sno = 1);
-- 为SC更新Sno
update SC
set Sno=001
where Sno = 1;
-- 删除原有的一行
delete
from S
where Sno = 1;

-- 11．把平均成绩大于80分的男同学的学号和平均成绩存入另一个表S——GRADE（SNO，AVG_GRADE）；
select *
into s_grade
from (select stu.Sno as Sno, avg(sgrade.grade) as avg_grade
      from S as stu
               join SC as sgrade on stu.Sno = sgrade.Sno
      where Ssex = 1
      group by stu.Sno
      having avg(sgrade.grade) > 80) as s_grade_temp;

-- 12． 把选修了课程名为“数据结构”的学生的成绩提高10%；
update SC
set grade=1.1 * grade
where Cno = (select Cno from C where Cname = N'数据结构');

-- 13． 把选修了“C2”号课程，且成绩低于该门课程的平均成绩的学生成绩删除掉。
delete
from SC
where Cno = 2
  and grade < (select avg(grade) from SC where Cno = 2);
