use utf8;
package Soporte::Schema::Result::Actividade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Actividade

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

=head1 TABLE: C<actividades>

=cut

__PACKAGE__->table("actividades");

=head1 ACCESSORS

=head2 actividadid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sucursal1.actividades_actividadid_seq'

=head2 empleadoid

  data_type: 'integer'
  is_nullable: 0

=head2 fechainicio

  data_type: 'timestamp'
  is_nullable: 0

=head2 fechatermino

  data_type: 'timestamp'
  is_nullable: 0

=head2 entidadid

  data_type: 'integer'
  is_nullable: 0

=head2 problematica

  data_type: 'text'
  is_nullable: 0

=head2 desarrollo

  data_type: 'text'
  is_nullable: 0

=head2 procedimiento

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 nombre_persona_atendida

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 puesto_persona_atendida

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 empleadoapoyoid

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "actividadid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sucursal1.actividades_actividadid_seq",
  },
  "empleadoid",
  { data_type => "integer", is_nullable => 0 },
  "fechainicio",
  { data_type => "timestamp", is_nullable => 0 },
  "fechatermino",
  { data_type => "timestamp", is_nullable => 0 },
  "entidadid",
  { data_type => "integer", is_nullable => 0 },
  "problematica",
  { data_type => "text", is_nullable => 0 },
  "desarrollo",
  { data_type => "text", is_nullable => 0 },
  "procedimiento",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "nombre_persona_atendida",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "puesto_persona_atendida",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "empleadoapoyoid",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5YgQ8wjmFQYXg7TFmOsJ2Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
