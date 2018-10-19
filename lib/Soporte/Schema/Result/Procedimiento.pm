use utf8;
package Soporte::Schema::Result::Procedimiento;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Procedimiento

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

=head1 TABLE: C<procedimientos>

=cut

__PACKAGE__->table("procedimientos");

=head1 ACCESSORS

=head2 claveid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sucursal1.procedimientos_claveid_seq'

=head2 clavereg

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 fechareg

  data_type: 'date'
  is_nullable: 1

=head2 norevision

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 fechamod

  data_type: 'date'
  is_nullable: 1

=head2 areaprocedimiento

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 tituloprocedimiento

  data_type: 'char'
  is_nullable: 1
  size: 500

=head2 actividad

  data_type: 'char'
  is_nullable: 1
  size: 500

=head2 objetivo

  data_type: 'char'
  is_nullable: 1
  size: 500

=head2 alcance

  data_type: 'char'
  is_nullable: 1
  size: 500

=head2 desarrollo

  data_type: 'text'
  is_nullable: 1

=head2 empleadoid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "claveid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sucursal1.procedimientos_claveid_seq",
  },
  "clavereg",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "fechareg",
  { data_type => "date", is_nullable => 1 },
  "norevision",
  { data_type => "char", is_nullable => 1, size => 10 },
  "fechamod",
  { data_type => "date", is_nullable => 1 },
  "areaprocedimiento",
  { data_type => "char", is_nullable => 1, size => 50 },
  "tituloprocedimiento",
  { data_type => "char", is_nullable => 1, size => 500 },
  "actividad",
  { data_type => "char", is_nullable => 1, size => 500 },
  "objetivo",
  { data_type => "char", is_nullable => 1, size => 500 },
  "alcance",
  { data_type => "char", is_nullable => 1, size => 500 },
  "desarrollo",
  { data_type => "text", is_nullable => 1 },
  "empleadoid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</claveid>

=back

=cut

__PACKAGE__->set_primary_key("claveid");

=head1 UNIQUE CONSTRAINTS

=head2 C<procedimientos_clavereg>

=over 4

=item * L</clavereg>

=back

=cut

__PACKAGE__->add_unique_constraint("procedimientos_clavereg", ["clavereg"]);

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-12-01 16:45:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6KLNbk8fn0JIhet7kKLwHg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
