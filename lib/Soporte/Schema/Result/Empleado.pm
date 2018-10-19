use utf8;
package Soporte::Schema::Result::Empleado;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Empleado

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<empleados>

=cut

__PACKAGE__->table("empleados");

=head1 ACCESSORS

=head2 empleadoid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sucursal1.empleados_empleadoid_seq'

=head2 paterno

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 materno

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 nombre

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 area

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 rfc

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 curp

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 fecha_nacimiento

  data_type: 'date'
  is_nullable: 1

=head2 telefono

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 sexo

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 usuario

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 estatus

  data_type: 'integer'
  is_nullable: 1

=head2 correo_elec

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "empleadoid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sucursal1.empleados_empleadoid_seq",
  },
  "paterno",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "materno",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "nombre",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "area",
  { data_type => "char", is_nullable => 1, size => 50 },
  "rfc",
  { data_type => "char", is_nullable => 1, size => 50 },
  "curp",
  { data_type => "char", is_nullable => 1, size => 50 },
  "fecha_nacimiento",
  { data_type => "date", is_nullable => 1 },
  "telefono",
  { data_type => "char", is_nullable => 1, size => 50 },
  "sexo",
  { data_type => "char", is_nullable => 1, size => 50 },
  "usuario",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "estatus",
  { data_type => "integer", is_nullable => 1 },
  "correo_elec",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</empleadoid>

=back

=cut

__PACKAGE__->set_primary_key("empleadoid");

=head1 UNIQUE CONSTRAINTS

=head2 C<empleados_usuario__key>

=over 4

=item * L</usuario>

=back

=cut

__PACKAGE__->add_unique_constraint("empleados_usuario__key", ["usuario"]);

=head1 RELATIONS

=head2 detalle_producto_entidads

Type: has_many

Related object: L<Soporte::Schema::Result::DetalleProductoEntidad>

=cut

__PACKAGE__->has_many(
  "detalle_producto_entidads",
  "Soporte::Schema::Result::DetalleProductoEntidad",
  { "foreign.empleado" => "self.empleadoid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 procedimientos

Type: has_many

Related object: L<Soporte::Schema::Result::Procedimiento>

=cut

__PACKAGE__->has_many(
  "procedimientos",
  "Soporte::Schema::Result::Procedimiento",
  { "foreign.empleadoid" => "self.empleadoid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 queja_sugerencias

Type: has_many

Related object: L<Soporte::Schema::Result::QuejaSugerencia>

=cut

__PACKAGE__->has_many(
  "queja_sugerencias",
  "Soporte::Schema::Result::QuejaSugerencia",
  { "foreign.empleado" => "self.empleadoid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tablasoporte_asignadoas

Type: has_many

Related object: L<Soporte::Schema::Result::Tablasoporte>

=cut

__PACKAGE__->has_many(
  "tablasoporte_asignadoas",
  "Soporte::Schema::Result::Tablasoporte",
  { "foreign.asignadoa" => "self.empleadoid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tablasoporte_empleadoids

Type: has_many

Related object: L<Soporte::Schema::Result::Tablasoporte>

=cut

__PACKAGE__->has_many(
  "tablasoporte_empleadoids",
  "Soporte::Schema::Result::Tablasoporte",
  { "foreign.empleadoid" => "self.empleadoid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AnsYuYYfqoH6BIQ0JAA9xw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
