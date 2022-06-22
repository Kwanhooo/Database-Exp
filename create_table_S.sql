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
    Sdept varchar(1024)
)
go

create unique index S_Sno_uindex
    on S (Sno)
go