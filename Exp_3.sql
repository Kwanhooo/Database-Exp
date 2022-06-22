-- （一）以S , C , SC表为基础完成以下视图定义及使用
-- 1．定义“SSCH”院学生基本情况视图V_SSCH；
create view V_SSCH as
(
select S.Sno, S.Sname, S.Sage, S.Sdept
from S
where S.Sdept = 'SSCH');

-- 2．将S，C，SC表中学生的学号，姓名，课程号，课程名，成绩定义为视图V_S_C_G;
create view V_S_C_G as
(
select stu.sno, ss.sname, course.cno, course.cname
from SC as stu
         join C as course on stu.Cno = course.Cno
         join S as ss on stu.Sno = ss.Sno
    );


-- 3．将各院学生人数，平均年龄定义为视图V_NUM_AVG;
create view V_NUM_AVG as
(
select count(*) as stu_amount, avg(stu.sage) as avg_age
from S as stu
group by stu.Sdept
    );


-- 4．将各位学生选修课程的门数及平均成绩定义为视图V_AVG_S_G并查询结果;
create view V_AVG_S_G as
(
select sgrade.Sno, count(*) as '门数', avg(sgrade.grade) as '平均成绩'
from SC as sgrade
group by sgrade.Sno
    );

select *
from V_AVG_S_G;


-- 5．查询平均成绩为90分以上的学生学号、姓名和成绩；
create view avg_grade as
(
select Sno, avg(grade) as avg_val
from SC
group by Sno
    );


select stu.sno, stu.sname, (select avg_val from avg_grade where stu.Sno = avg_grade.Sno)
from S as stu
         join SC sgrade on stu.Sno = sgrade.Sno
where stu.Sno in (select Sno from avg_grade where avg_val > 90)
group by stu.sno, stu.sname;


-- 6．通过视图V_SSCH，新增加一个学生记录 ('S12','YAN XI',19, 'SSCH')，并查询结果；
insert into V_SSCH
values (12, 'YAN XI', 19, 'SSCH');

select *
from V_SSCH;

-- 7．通过视图V_SSCH，删除学号为“S12”学生信息，并查询结果；
delete
from V_SSCH
where Sno = 12;


-- 8．将视图V_SSCH中学号为“S12”的学生改名“中南人”。
update V_SSCH
set Sname=N'中南人'
where Sno = 12;


-- （二）使用SQL进行数据完整性控制：包括三类完整性、check短语、constrain子句。
-- 1. 在创建下列关系表时完成如下约束：定义实体完整性;
--    参照完整性（外码、在删除S中的元组时级联删除SC中相应元组、当更新S中的Sno时同时更新SC中的Sno）;
--    用户定义完整性：学生年龄<30。

-- 创建 S，定义实体完整性，学生年龄<30
-- alter table S add constraint check(Sage < 30)
use student_200504
go

create table S
(
    Sno   bigint not null
        constraint S_pk
            primary key,
    Sname varchar(1024),
    Ssex  tinyint,
    Sage  int,
    Sdept varchar(1024),
    check (Sage < 30)
)
go

create unique index S_Sno_uindex
    on S (Sno)
go

-- 创建 C，定义实体完整性
use student_200504
go

create table C
(
    Cno     bigint not null
        constraint C_pk
            primary key,
    Cname   varchar(1024),
    Cpno    int,
    Ccredit float
)
go

create unique index C_Cno_uindex
    on C (Cno)
go

-- 创建 SC表，定义实体完整性以及参照完整性，同步于引用表的更新以及删除
create table SCC
(
    Sno   bigint not null
        constraint Sno_FK
            references S
            on update cascade on delete cascade,
    Cno   bigint not null
        constraint Cno_FK
            references C
            on update cascade on delete cascade,
    grade float,
    constraint SC_pk
        primary key (Sno, Cno)
)
go

create unique index SC_Sno_Cno_uindex
    on SC (Sno, Cno)
go


-- 2. 修改S中的约束条件，学号在100－1000之间。
-- 学生关系表S ：
-- 学号	姓名	性别	年龄	所在系
-- Sno	Sname	Ssex	Sage	sdept
--   创建课程关系表C ：
--  课程号	课程名	先行课	学分
-- Cno	Cname	Cpno	ccredit
--  创建学生-课程表SC ：
-- 学号	课程号	成绩
-- Sno	Cno	grade

alter table S
    add check (Sno between 100 and 1000);

alter table S
    add check (Sage between 0 and 30)

-- 3．用实验验证当操作违反了完整性约束时，系统如何处理？
insert into S(Sno, Sname, Ssex, Sage, Sdept)
values (1, 'd', 1, 666, 'dd');