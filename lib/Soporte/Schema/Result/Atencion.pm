use utf8;
package Soporte::Schema::Result::Atencion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Atencion

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

=head1 TABLE: C<atencion>

=cut

__PACKAGE__->table("atencion");

=head1 ACCESSORS

=head2 atencionid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'atencion_atencionid_seq'

=head2 usuarioid

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=head2 entidadid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 fechahorainicio

  data_type: 'timestamp'
  is_nullable: 1

=head2 fechahorafin

  data_type: 'timestamp'
  is_nullable: 1

=head2 problema

  data_type: 'text'
  is_nullable: 1

=head2 solucion

  data_type: 'text'
  is_nullable: 1

=head2 solicito

  data_type: 'char'
  is_nullable: 1
  size: 60

=head2 proyecto

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "atencionid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "atencion_atencionid_seq",
  },
  "usuarioid",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "entidadid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "fechahorainicio",
  { data_type => "timestamp", is_nullable => 1 },
  "fechahorafin",
  { data_type => "timestamp", is_nullable => 1 },
  "problema",
  { data_type => "text", is_nullable => 1 },
  "solucion",
  { data_type => "text", is_nullable => 1 },
  "solicito",
  { data_type => "char", is_nullable => 1, size => 60 },
  "proyecto",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</atencionid>

=back

=cut

__PACKAGE__->set_primary_key("atencionid");

=head1 RELATIONS

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

=head2 proyecto

Type: belongs_to

Related object: L<Soporte::Schema::Result::Proyecto>

=cut

__PACKAGE__->belongs_to(
  "proyecto",
  "Soporte::Schema::Result::Proyecto",
  { id => "proyecto" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-05-28 12:30:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rhG17ZI4iEhl4uqNlVaVQw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
