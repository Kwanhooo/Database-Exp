select *
into quickSC
from SC;
drop table quickSC;

-- select Sno,grade
-- from SC
-- order by Sno
-- compute avg(grade) by Sno;

sp_addtype student_id, 'char(8)', 'null';
sp_droptype student_id;
alter table SC
    add aa student_id;

alter table SC
    add primary key (Sno);
alter table SC
    add constraint Sno_Check check (Sno >= 0);
alter table SC
    add constraint Sno_FK foreign key (Sno) references dbo.S (Sno);
alter table SC
    drop constraint Sno_Check;

create table test
(
    no   int,
    name char(8),
    primary key (no),
    check (name is not null ),
    foreign key (no) references dbo.S (Sno)
);

grant all privileges on SC to dbo
grant select on S to db_owner
grant create table to dbo
revoke create table from dbo
revoke select on S from db_owner,db_accessadmin

declare @someText char(255);
select @someText = 'Hello World!';
select @someText;

if (@someText = 'Hello World!')
    begin
        print 'Ha ha hai!'
    end
else
    begin
        print 'something'
    end

select @someText =
       case @someText
           when 'dd' then 'aa'
           when 'cc' then 'bb'
           else 'ff'
           end

declare @iii integer
set @iii = 0
while @iii < 100 begin
    set @iii = @iii + 1
    if (@iii = 1) continue
    if (@iii = 3) break
    print @iii
end

create procedure forReview;10086 @param_a int, @param_b char(8) output as
    if (@param_a <> 0)
        begin
            print 'a is not zero'
            return 1
        end
    else
        begin
            print @param_b
        end
go

execute sp_calAvgGrade 114514;
go


drop procedure sp_calAvgGrade;
go

alter table S
    disable trigger tr_deleteTriggerForS;
go

alter table S
    enable trigger tr_deleteTriggerForS;
go

declare tr_test cursor for (select *
                            from SC);
declare @data integer;
declare @data1 integer;
declare @data2 integer;
open tr_test;
fetch next from tr_test into @data,@data1,@data2;
while @@fetch_status = 0
    begin
        -- do something
    end
close tr_test;
deallocate tr_test;
go

select *
from SC
where not exists(select * from SC)

select Sno
from S
where S.Sno <> (select max(Sno) from S);


select Sno
from S
where Sno not in (select max(Sno) from S);

    (select Sno from S)
    except
    (select max(Sno) from S);

update SC
set grade=grade * 1.2
where grade < 10;
go

select emp.dept
from employee as emp
         join sales as sal
              on emp.emp_no = sal.emp_no
where emp.sex = 'nv'
group by emp.dept
having sum(sal.tot_amount) > 100000

select distinct cus.*
from customer as cus
         join sales as sal
              on sal.cust_id = cus.cust_id
where sal.tot_amount > 200000

create procedure getStuffSales @no int as
select tot_amount
from sales
where emp_no = @no
go

create table arm
(
    arm_name     varchar(8),
    produce_time datetime,
    primary key (arm_name)
);
go

select emp.name, emp.dept
from employee as emp
where emp.sex = 'nv'
  and emp.salary > (select avg(salary)
                    from employee)
go

select emp.dept, sum(sal.tot_amount)
from sales as sal
         join employee as emp
              on sal.sale_id = emp.emp_no
group by emp.dept
go


create procedure getSalesAmount as
begin
    select emp.emp_name, sum(sal.tot_amount)
    from employee as emp
             join sales as sal
                  on sal.sale_id = emp.emp_no
    group by emp.emp_no, emp.emp_name
end
go

select S.Sname, sum(Sage) as sum_of_age
from S
group by S.Sno, S.Sname;


create trigger tr
    on SC
    for delete as
begin
    print 'ff'
end
go

declare @cur cursor for
    select *
    from SC;

open @cur;
fetch next from @cur into @???
while(@@fetch_status = 0)
    begin

    end
close @cur
deallocate @cur

-- begin transaction
-- select *
-- from SC;
-- commit
-- rollback
-- select *
-- from go

select ss.sno, count(*)
from S as ss
         join SC as sscc
              on ss.sno = sscc.sno
where sscc.grade > 90
group by sscc.sno, ss.sno
having count(*) >= 3


select ss.Sno, ss.Sname, avg(grade) as avg_grade
from SC as sscc
         join S as ss on sscc.Sno = ss.Sno
where ss.Sno in (select Sno
                 from SC
                          join C on SC.Cno = C.Cno
                 where C.Cname = '计算机网络')
group by ss.Sno, ss.Sname
order by avg_grade desc

select count(*) - (select count(*) from S where Ssex = 0)
from S
where Ssex = 1;