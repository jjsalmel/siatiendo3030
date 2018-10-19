use utf8;
package Soporte::Schema::Result::QuejaSugerencia;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::QuejaSugerencia

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

=head1 TABLE: C<queja_sugerencia>

=cut

__PACKAGE__->table("queja_sugerencia");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'queja_sugerencia_id_seq'

=head2 empleado

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 fecha

  data_type: 'date'
  default_value: ('now'::text)::date
  is_nullable: 1

=head2 detalle

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "queja_sugerencia_id_seq",
  },
  "empleado",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "fecha",
  {
    data_type     => "date",
    default_value => \"('now'::text)::date",
    is_nullable   => 1,
  },
  "detalle",
  { data_type => "text", is_nullable => 1 },
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


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZoY6eh7xxry/J27cirKncA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
