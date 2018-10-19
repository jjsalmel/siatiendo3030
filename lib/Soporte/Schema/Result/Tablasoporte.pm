use utf8;
package Soporte::Schema::Result::Tablasoporte;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Tablasoporte

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

=head1 TABLE: C<tablasoporte>

=cut

__PACKAGE__->table("tablasoporte");

=head1 ACCESSORS

=head2 nofolio

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sucursal1.tablasoporte_nofolio_seq'

=head2 fechainicio

  data_type: 'date'
  is_nullable: 1

=head2 fechatermino

  data_type: 'date'
  is_nullable: 1

=head2 nombreentidad

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 nombresolicitante

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 fechasolicitud

  data_type: 'date'
  is_nullable: 1

=head2 descripcion

  data_type: 'text'
  is_nullable: 1

=head2 observaciones

  data_type: 'char'
  is_nullable: 1
  size: 1000

=head2 encargado

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 estatus

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 entidadid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 empleadoid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 avanceid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 claveid

  data_type: 'integer'
  is_nullable: 1

=head2 asignadoa

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 prioridadid

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "nofolio",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sucursal1.tablasoporte_nofolio_seq",
  },
  "fechainicio",
  { data_type => "date", is_nullable => 1 },
  "fechatermino",
  { data_type => "date", is_nullable => 1 },
  "nombreentidad",
  { data_type => "char", is_nullable => 1, size => 50 },
  "nombresolicitante",
  { data_type => "char", is_nullable => 1, size => 50 },
  "fechasolicitud",
  { data_type => "date", is_nullable => 1 },
  "descripcion",
  { data_type => "text", is_nullable => 1 },
  "observaciones",
  { data_type => "char", is_nullable => 1, size => 1000 },
  "encargado",
  { data_type => "char", is_nullable => 1, size => 80 },
  "estatus",
  { data_type => "char", is_nullable => 1, size => 1 },
  "entidadid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "empleadoid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "avanceid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "claveid",
  { data_type => "integer", is_nullable => 1 },
  "asignadoa",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "prioridadid",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nofolio>

=back

=cut

__PACKAGE__->set_primary_key("nofolio");

=head1 RELATIONS

=head2 asignadoa

Type: belongs_to

Related object: L<Soporte::Schema::Result::Empleado>

=cut

__PACKAGE__->belongs_to(
  "asignadoa",
  "Soporte::Schema::Result::Empleado",
  { empleadoid => "asignadoa" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 avanceid

Type: belongs_to

Related object: L<Soporte::Schema::Result::Avance>

=cut

__PACKAGE__->belongs_to(
  "avanceid",
  "Soporte::Schema::Result::Avance",
  { avanceid => "avanceid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 empleadoid

Type: belongs_to

Related object: L<Soporte::Schema::Result::Empleado>

=cut

__PACKAGE__->belongs_to(
  "empleadoid",
  "Soporte::Schema::Result::Empleado",
  { empleadoid => "empleadoid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 entidadid

Type: belongs_to

Related object: L<Soporte::Schema::Result::Entidade>

=cut

__PACKAGE__->belongs_to(
  "entidadid",
  "Soporte::Schema::Result::Entidade",
  { entidadid => "entidadid" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pyBeYwdpCEAFPDIiob1PfQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
