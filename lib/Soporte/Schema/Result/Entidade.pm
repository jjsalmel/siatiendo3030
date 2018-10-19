use utf8;
package Soporte::Schema::Result::Entidade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Entidade

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

=head1 TABLE: C<entidades>

=cut

__PACKAGE__->table("entidades");

=head1 ACCESSORS

=head2 entidadid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'sucursal1.entidades_entidadid_seq'

=head2 rfc

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 nombreentidad

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 niveloperaciones

  data_type: 'char'
  is_nullable: 1
  size: 30

=head2 nombredecontacto

  data_type: 'char'
  is_nullable: 1
  size: 90

=head2 domicilioentidad

  data_type: 'text'
  is_nullable: 1

=head2 ciudad

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 codigopostal

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 telefono

  data_type: 'char'
  is_nullable: 1
  size: 30

=head2 nombredominioentidad

  data_type: 'char'
  is_nullable: 1
  size: 90

=head2 numerosucursales

  data_type: 'char'
  is_nullable: 1
  size: 90

=head2 nombrebasededatos

  data_type: 'char'
  is_nullable: 1
  size: 50

=head2 correoelectronico

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contratolicencia

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 contratosoporte

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 contratorespaldos

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 observaciones

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ingreso

  data_type: 'numeric'
  is_nullable: 1

=head2 respaldo

  data_type: 'numeric'
  is_nullable: 1

=head2 empresa_soporte

  data_type: 'char'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "entidadid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "sucursal1.entidades_entidadid_seq",
  },
  "rfc",
  { data_type => "char", is_nullable => 1, size => 80 },
  "nombreentidad",
  { data_type => "char", is_nullable => 1, size => 80 },
  "niveloperaciones",
  { data_type => "char", is_nullable => 1, size => 30 },
  "nombredecontacto",
  { data_type => "char", is_nullable => 1, size => 90 },
  "domicilioentidad",
  { data_type => "text", is_nullable => 1 },
  "ciudad",
  { data_type => "char", is_nullable => 1, size => 50 },
  "codigopostal",
  { data_type => "char", is_nullable => 1, size => 20 },
  "telefono",
  { data_type => "char", is_nullable => 1, size => 30 },
  "nombredominioentidad",
  { data_type => "char", is_nullable => 1, size => 90 },
  "numerosucursales",
  { data_type => "char", is_nullable => 1, size => 90 },
  "nombrebasededatos",
  { data_type => "char", is_nullable => 1, size => 50 },
  "correoelectronico",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "contratolicencia",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "contratosoporte",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "contratorespaldos",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "observaciones",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "ingreso",
  { data_type => "numeric", is_nullable => 1 },
  "respaldo",
  { data_type => "numeric", is_nullable => 1 },
  "empresa_soporte",
  { data_type => "char", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</entidadid>

=back

=cut

__PACKAGE__->set_primary_key("entidadid");

=head1 RELATIONS

=head2 atencions

Type: has_many

Related object: L<Soporte::Schema::Result::Atencion>

=cut

__PACKAGE__->has_many(
  "atencions",
  "Soporte::Schema::Result::Atencion",
  { "foreign.entidadid" => "self.entidadid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 producto_entidads

Type: has_many

Related object: L<Soporte::Schema::Result::ProductoEntidad>

=cut

__PACKAGE__->has_many(
  "producto_entidads",
  "Soporte::Schema::Result::ProductoEntidad",
  { "foreign.entidad" => "self.entidadid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 proyectoes

Type: has_many

Related object: L<Soporte::Schema::Result::Proyecto>

=cut

__PACKAGE__->has_many(
  "proyectoes",
  "Soporte::Schema::Result::Proyecto",
  { "foreign.entidad" => "self.entidadid" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tablasoportes

Type: has_many

Related object: L<Soporte::Schema::Result::Tablasoporte>

=cut

__PACKAGE__->has_many(
  "tablasoportes",
  "Soporte::Schema::Result::Tablasoporte",
  { "foreign.entidadid" => "self.entidadid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-07-05 17:16:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bGay+bVB0OJcSs9buytF3A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
