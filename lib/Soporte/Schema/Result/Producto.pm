use utf8;
package Soporte::Schema::Result::Producto;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Producto

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

=head1 TABLE: C<producto>

=cut

__PACKAGE__->table("producto");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'producto_id_seq'

=head2 nombre

  data_type: 'text'
  is_nullable: 1

=head2 descripcion

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "producto_id_seq",
  },
  "nombre",
  { data_type => "text", is_nullable => 1 },
  "descripcion",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 producto_entidads

Type: has_many

Related object: L<Soporte::Schema::Result::ProductoEntidad>

=cut

__PACKAGE__->has_many(
  "producto_entidads",
  "Soporte::Schema::Result::ProductoEntidad",
  { "foreign.producto" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jRZJCneIhTcea+aD1RH/0g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
