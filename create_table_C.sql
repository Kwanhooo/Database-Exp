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

