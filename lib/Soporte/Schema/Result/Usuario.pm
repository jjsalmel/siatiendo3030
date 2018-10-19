use utf8;
package Soporte::Schema::Result::Usuario;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Soporte::Schema::Result::Usuario

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
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<usuario>

=cut

__PACKAGE__->table("usuario");
__PACKAGE__->result_source_instance->view_definition(" SELECT pg_shadow.usename AS username,\n    pg_shadow.passwd AS password\n   FROM pg_shadow");

=head1 ACCESSORS

=head2 username

  data_type: 'name'
  is_nullable: 1
  size: 64

=head2 password

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "username",
  { data_type => "name", is_nullable => 1, size => 64 },
  "password",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-12-19 10:19:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mY7za45uvc3sTX3BWODENQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
