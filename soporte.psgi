use strict;
use warnings;

use Soporte;

my $app = Soporte->apply_default_middlewares(Soporte->psgi_app);
$app;

