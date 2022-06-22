use student_200504
go

-- 1、 设置一个触发器，该触发器仅允许“dbo”用户可以删除学生表内数据。
drop trigger tr_delDataInTableS
go

create trigger tr_delDataInTableS
    on S
    for delete as
    declare
        @action_user varchar
    select @action_user = user
    if @action_user <> 'dbo'
        begin
            print '您不能执行删除操作：对于表S的删除操作，仅允许用户dbo执行！'
            rollback transaction
        end
go

-- 此处无法执行
delete
from S
where Sno = 0;
go


-- 2、 针对学生表写一个DELETE触发器。
drop trigger tr_deleteTriggerForS

create trigger tr_deleteTriggerForS
    on S
    for delete as
    declare
        @action varchar(255)
    select @action = concat('S表中发生DELETE操作，id = ', CURRENT_TRANSACTION_ID(), '    操作者：', USER)
    print @action
go

delete
from S
where Sno = 0;
go


-- 3、 针对学生表写一个UPDATE触发器。
drop trigger tr_updateTriggerForS

create trigger tr_updateTriggerForS
    on S
    for update as
    declare
        @action varchar(255)
    select @action = concat('S表中发生UPDATE操作，id = ', CURRENT_TRANSACTION_ID(), '    操作者：', USER)
    print @action
go

update S
set Sdept = '计算机学院'
where Sno = 0;
go

-- 4、 统计学生的平均成绩，输出低于平均分的成绩（使用游标）。
declare
    cur_grade scroll cursor for
        select sgrade.sno, stu.sname, sgrade.grade
        from sc as sgrade
                 join s as stu on sgrade.Sno = stu.Sno
        order by stu.Sno
go

open cur_grade
go

declare @Sno      bigint
declare @Sname    varchar(255)
declare @Grade    float
declare @avgGrade float

select @avgGrade = (select avg(grade) from SC)

fetch next from cur_grade into @Sno,@Sname,@Grade
print concat('平均成绩 = ', @avgGrade)
while (@@FETCH_STATUS = 0)
    begin
        if @Grade < @avgGrade
            begin
                select @Sno as 学号, @Sname as 姓名, @Grade as 成绩
                print concat(@Sno, @Sname, @Grade)
            end
        fetch next from cur_grade into @Sno,@Sname,@Grade
    end
close cur_grade
deallocate cur_grade
go

