use utf8;
package Soporte::Schema::Result::Reporte;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Reporte

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

=head1 TABLE: C<reportes>

=cut

__PACKAGE__->table("reportes");

=head1 ACCESSORS

=head2 reporteid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'reportes_reporteid_seq'

=head2 descripcion

  data_type: 'char'
  is_nullable: 1
  size: 60

=head2 valor1

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y1

  data_type: 'integer'
  is_nullable: 1

=head2 n1

  data_type: 'integer'
  is_nullable: 1

=head2 valor2

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y2

  data_type: 'integer'
  is_nullable: 1

=head2 n2

  data_type: 'integer'
  is_nullable: 1

=head2 valor3

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y3

  data_type: 'integer'
  is_nullable: 1

=head2 n3

  data_type: 'integer'
  is_nullable: 1

=head2 valor4

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y4

  data_type: 'integer'
  is_nullable: 1

=head2 n4

  data_type: 'integer'
  is_nullable: 1

=head2 valor5

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y5

  data_type: 'integer'
  is_nullable: 1

=head2 n5

  data_type: 'integer'
  is_nullable: 1

=head2 valor6

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y6

  data_type: 'integer'
  is_nullable: 1

=head2 n6

  data_type: 'integer'
  is_nullable: 1

=head2 valor7

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y7

  data_type: 'integer'
  is_nullable: 1

=head2 n7

  data_type: 'integer'
  is_nullable: 1

=head2 valor8

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y8

  data_type: 'integer'
  is_nullable: 1

=head2 n8

  data_type: 'integer'
  is_nullable: 1

=head2 valor9

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y9

  data_type: 'integer'
  is_nullable: 1

=head2 n9

  data_type: 'integer'
  is_nullable: 1

=head2 valor10

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 y10

  data_type: 'integer'
  is_nullable: 1

=head2 n10

  data_type: 'integer'
  is_nullable: 1

=head2 orden1

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 query

  data_type: 'text'
  is_nullable: 1

=head2 t1

  data_type: 'integer'
  is_nullable: 1

=head2 t2

  data_type: 'integer'
  is_nullable: 1

=head2 t3

  data_type: 'integer'
  is_nullable: 1

=head2 t4

  data_type: 'integer'
  is_nullable: 1

=head2 t5

  data_type: 'integer'
  is_nullable: 1

=head2 t6

  data_type: 'integer'
  is_nullable: 1

=head2 t7

  data_type: 'integer'
  is_nullable: 1

=head2 t8

  data_type: 'integer'
  is_nullable: 1

=head2 t9

  data_type: 'integer'
  is_nullable: 1

=head2 t10

  data_type: 'integer'
  is_nullable: 1

=head2 largo

  data_type: 'numeric'
  is_nullable: 1

=head2 ancho

  data_type: 'numeric'
  is_nullable: 1

=head2 orientacion

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "reporteid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "reportes_reporteid_seq",
  },
  "descripcion",
  { data_type => "char", is_nullable => 1, size => 60 },
  "valor1",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y1",
  { data_type => "integer", is_nullable => 1 },
  "n1",
  { data_type => "integer", is_nullable => 1 },
  "valor2",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y2",
  { data_type => "integer", is_nullable => 1 },
  "n2",
  { data_type => "integer", is_nullable => 1 },
  "valor3",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y3",
  { data_type => "integer", is_nullable => 1 },
  "n3",
  { data_type => "integer", is_nullable => 1 },
  "valor4",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y4",
  { data_type => "integer", is_nullable => 1 },
  "n4",
  { data_type => "integer", is_nullable => 1 },
  "valor5",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y5",
  { data_type => "integer", is_nullable => 1 },
  "n5",
  { data_type => "integer", is_nullable => 1 },
  "valor6",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y6",
  { data_type => "integer", is_nullable => 1 },
  "n6",
  { data_type => "integer", is_nullable => 1 },
  "valor7",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y7",
  { data_type => "integer", is_nullable => 1 },
  "n7",
  { data_type => "integer", is_nullable => 1 },
  "valor8",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y8",
  { data_type => "integer", is_nullable => 1 },
  "n8",
  { data_type => "integer", is_nullable => 1 },
  "valor9",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y9",
  { data_type => "integer", is_nullable => 1 },
  "n9",
  { data_type => "integer", is_nullable => 1 },
  "valor10",
  { data_type => "char", is_nullable => 1, size => 20 },
  "y10",
  { data_type => "integer", is_nullable => 1 },
  "n10",
  { data_type => "integer", is_nullable => 1 },
  "orden1",
  { data_type => "char", is_nullable => 1, size => 20 },
  "query",
  { data_type => "text", is_nullable => 1 },
  "t1",
  { data_type => "integer", is_nullable => 1 },
  "t2",
  { data_type => "integer", is_nullable => 1 },
  "t3",
  { data_type => "integer", is_nullable => 1 },
  "t4",
  { data_type => "integer", is_nullable => 1 },
  "t5",
  { data_type => "integer", is_nullable => 1 },
  "t6",
  { data_type => "integer", is_nullable => 1 },
  "t7",
  { data_type => "integer", is_nullable => 1 },
  "t8",
  { data_type => "integer", is_nullable => 1 },
  "t9",
  { data_type => "integer", is_nullable => 1 },
  "t10",
  { data_type => "integer", is_nullable => 1 },
  "largo",
  { data_type => "numeric", is_nullable => 1 },
  "ancho",
  { data_type => "numeric", is_nullable => 1 },
  "orientacion",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-11-28 13:20:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hneEipLsu2fuejjsRJhohQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
