use student_200504

select sgrade.sno
from S as stu
         join SC sgrade on stu.Sno = sgrade.Sno
group by sgrade.Sno
having min(sgrade.grade) > 80;

select stu.Sno
from S as stu
where not exists(select * from SC as sgrade where stu.Sno = sgrade.Sno);

select stu.sno
from SC as stu
group by stu.sno
having count(*) > 3;

