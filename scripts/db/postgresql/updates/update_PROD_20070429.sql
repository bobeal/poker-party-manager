alter table party add column kind varchar(255);
alter table party add column buyin double precision;
alter table party add column coins_per_buyin integer;

update party set kind = 'Cash Game';
update party set buyin = '2.5';
update party set coins_per_buyin = '100';

alter table player add column can_manage_championship boolean;

update player set can_manage_championship = 'f';
update player set can_manage_championship = 't' where login = 'bobeal';
update player set is_super_admin = 'f' where login != 'bobeal';

alter table score add column prize integer;
alter table score add column position integer;

update score set prize = '0';
update score set position = '0';
