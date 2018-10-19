DO
$$
DECLARE
row record;
BEGIN
FOR row IN SELECT tablename FROM pg_tables WHERE schemaname = 'sucursal1' and tablename not in (select tablename from pg_tables where schemaname='public')
LOOP
EXECUTE 'ALTER TABLE sucursal1.' || quote_ident(row.tablename) || ' SET SCHEMA public;';
END LOOP;
END;
$$;

alter table atencion add primary key (atencionid);
update atencion set entidadid = 44 where entidadid not in (select entidadid from entidades);
alter table atencion add foreign key (entidadid) references entidades (entidadid);

alter table procedimientos add primary key (claveid);
