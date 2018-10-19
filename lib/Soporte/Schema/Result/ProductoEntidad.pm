use utf8;
package Soporte::Schema::Result::ProductoEntidad;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::ProductoEntidad

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

=head1 TABLE: C<producto_entidad>

=cut

__PACKAGE__->table("producto_entidad");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'producto_entidad_id_seq'

=head2 entidad

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 producto

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
    sequence          => "producto_entidad_id_seq",
  },
  "entidad",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "producto",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 detalle_producto_entidads

Type: has_many

Related object: L<Soporte::Schema::Result::DetalleProductoEntidad>

=cut

__PACKAGE__->has_many(
  "detalle_producto_entidads",
  "Soporte::Schema::Result::DetalleProductoEntidad",
  { "foreign.producto_entidad" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entidad

Type: belongs_to

Related object: L<Soporte::Schema::Result::Entidade>

=cut

__PACKAGE__->belongs_to(
  "entidad",
  "Soporte::Schema::Result::Entidade",
  { entidadid => "entidad" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 producto

Type: belongs_to

Related object: L<Soporte::Schema::Result::Producto>

=cut

__PACKAGE__->belongs_to(
  "producto",
  "Soporte::Schema::Result::Producto",
  { id => "producto" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tBn6txdKIpZQoDHQ+UVBAw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
