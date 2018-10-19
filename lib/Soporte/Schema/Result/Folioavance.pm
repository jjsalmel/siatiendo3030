use utf8;
package Soporte::Schema::Result::Folioavance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Folioavance

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

=head1 TABLE: C<folioavance>

=cut

__PACKAGE__->table("folioavance");

=head1 ACCESSORS

=head2 folioavanceid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'folioavance_folioavanceid_seq'

=head2 folioid

  data_type: 'integer'
  is_nullable: 1

=head2 avanceid

  data_type: 'integer'
  is_nullable: 1

=head2 fecha

  data_type: 'date'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "folioavanceid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "folioavance_folioavanceid_seq",
  },
  "folioid",
  { data_type => "integer", is_nullable => 1 },
  "avanceid",
  { data_type => "integer", is_nullable => 1 },
  "fecha",
  { data_type => "date", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s/HaUiZBu6SE+R0RUWEOEw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
