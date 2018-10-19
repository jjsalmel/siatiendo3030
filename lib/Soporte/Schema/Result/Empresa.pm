use utf8;
package Soporte::Schema::Result::Empresa;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Empresa

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

=head1 TABLE: C<empresa>

=cut

__PACKAGE__->table("empresa");

=head1 ACCESSORS

=head2 empresaid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'empresa_empresaid_seq'

=head2 sucid

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 nombreempresa

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 gerente

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 nconcurrencias

  data_type: 'integer'
  is_nullable: 1

=head2 version

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 correo_elec

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "empresaid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "empresa_empresaid_seq",
  },
  "sucid",
  { data_type => "char", is_nullable => 1, size => 4 },
  "nombreempresa",
  { data_type => "char", is_nullable => 1, size => 80 },
  "gerente",
  { data_type => "char", is_nullable => 1, size => 80 },
  "nconcurrencias",
  { data_type => "integer", is_nullable => 1 },
  "version",
  { data_type => "char", is_nullable => 1, size => 20 },
  "correo_elec",
  { data_type => "varchar", is_nullable => 1, size => 50 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FyCmGzqCTlVpNk7EtgR6iA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
