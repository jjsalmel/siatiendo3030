package Soporte::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Soporte::Schema',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=soporte',
        user => '',
        password => '',
    }
);

=head1 NAME

Soporte::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<Soporte>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Soporte::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Coral Tecnología y Sistemas

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
