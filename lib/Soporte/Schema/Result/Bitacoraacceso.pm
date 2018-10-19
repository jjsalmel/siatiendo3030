use utf8;
package Soporte::Schema::Result::Bitacoraacceso;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Bitacoraacceso

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

=head1 TABLE: C<bitacoraaccesos>

=cut

__PACKAGE__->table("bitacoraaccesos");

=head1 ACCESSORS

=head2 bitacoraid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'bitacoraaccesos_bitacoraid_seq'

=head2 clavemodulo

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 descripcionmodulos

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 usuarioid

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 fecha

  data_type: 'date'
  is_nullable: 1

=head2 fechahora

  data_type: 'timestamp'
  is_nullable: 1

=head2 acceso

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "bitacoraid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "bitacoraaccesos_bitacoraid_seq",
  },
  "clavemodulo",
  { data_type => "char", is_nullable => 1, size => 10 },
  "descripcionmodulos",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "usuarioid",
  { data_type => "char", is_nullable => 1, size => 20 },
  "fecha",
  { data_type => "date", is_nullable => 1 },
  "fechahora",
  { data_type => "timestamp", is_nullable => 1 },
  "acceso",
  { data_type => "char", is_nullable => 1, size => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:31WgiaOcScUAA5oKCWzJoQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
