use student_200504
go

create table SC
(
    Sno   bigint not null
        constraint Sno_FK
            references S,
    Cno   bigint not null
        constraint Cno_FK
            references C,
    grade float,
    constraint SC_pk
        primary key (Sno, Cno)
)
go

create unique index SC_Sno_Cno_uindex
    on SC (Sno, Cno)
go

