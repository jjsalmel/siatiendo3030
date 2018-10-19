use utf8;
package Soporte::Schema::Result::Modulo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Modulo

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

=head1 TABLE: C<modulos>

=cut

__PACKAGE__->table("modulos");

=head1 ACCESSORS

=head2 clavemodulo

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 descripcionmodulos

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=cut

__PACKAGE__->add_columns(
  "clavemodulo",
  { data_type => "char", is_nullable => 0, size => 10 },
  "descripcionmodulos",
  { data_type => "varchar", is_nullable => 0, size => 80 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ttPcDX0Qv0b9qxrXJpwu2w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
