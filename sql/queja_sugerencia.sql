create table queja_sugerencia (
  id serial primary key,
  empleado integer references empleados(empleadoid),
  fecha date default current_date,
  detalle text
);
