use utf8;
package Soporte::Schema::Result::Avance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Avance

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

=head1 TABLE: C<avance>

=cut

__PACKAGE__->table("avance");

=head1 ACCESSORS

=head2 avanceid

  data_type: 'integer'
  is_nullable: 0

=head2 estatus

  data_type: 'char'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "avanceid",
  { data_type => "integer", is_nullable => 0 },
  "estatus",
  { data_type => "char", is_nullable => 1, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</avanceid>

=back

=cut

__PACKAGE__->set_primary_key("avanceid");

=head1 RELATIONS

=head2 proyectoes

Type: has_many

Related object: L<Soporte::Schema::Result::Proyecto>

=cut

__PACKAGE__->has_many(
  "proyectoes",
  "Soporte::Schema::Result::Proyecto",
  { "foreign.avance" => "self.avanceid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tablasoportes

Type: has_many

Related object: L<Soporte::Schema::Result::Tablasoporte>

=cut

__PACKAGE__->has_many(
  "tablasoportes",
  "Soporte::Schema::Result::Tablasoporte",
  { "foreign.avanceid" => "self.avanceid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-05-28 12:30:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:buWDaQrl1bWnDQZYNEXcRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
