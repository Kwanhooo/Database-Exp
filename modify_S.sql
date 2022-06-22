alter table S
    add SBirth date
go

exec sp_addextendedproperty 'MS_Description', N'学生生日', 'SCHEMA', 'dbo', 'TABLE', 'S', 'COLUMN', 'SBirth'
go

alter table S
    add SHeight float
go

exec sp_addextendedproperty 'MS_Description', N'学生身高（cm作为单位）', 'SCHEMA', 'dbo', 'TABLE', 'S', 'COLUMN', 'SHeight'
go
alter table S
    drop column SHeight
go
