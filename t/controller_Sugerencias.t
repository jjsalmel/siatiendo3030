use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Soporte';
use Soporte::Controller::Sugerencias;

ok( request('/sugerencias')->is_success, 'Request should succeed' );
done_testing();
