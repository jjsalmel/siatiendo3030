use utf8;
package Soporte::Schema::Result::DetalleProductoEntidad;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::DetalleProductoEntidad

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

=head1 TABLE: C<detalle_producto_entidad>

=cut

__PACKAGE__->table("detalle_producto_entidad");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'detalle_producto_entidad_id_seq'

=head2 producto_entidad

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 fecha

  data_type: 'date'
  is_nullable: 1

=head2 comentario

  data_type: 'text'
  is_nullable: 1

=head2 empleado

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "detalle_producto_entidad_id_seq",
  },
  "producto_entidad",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "fecha",
  { data_type => "date", is_nullable => 1 },
  "comentario",
  { data_type => "text", is_nullable => 1 },
  "empleado",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 empleado

Type: belongs_to

Related object: L<Soporte::Schema::Result::Empleado>

=cut

__PACKAGE__->belongs_to(
  "empleado",
  "Soporte::Schema::Result::Empleado",
  { empleadoid => "empleado" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 producto_entidad

Type: belongs_to

Related object: L<Soporte::Schema::Result::ProductoEntidad>

=cut

__PACKAGE__->belongs_to(
  "producto_entidad",
  "Soporte::Schema::Result::ProductoEntidad",
  { id => "producto_entidad" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/4oV/MslwP0c+5FEZd27DQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
