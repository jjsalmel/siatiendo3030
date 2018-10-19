package Soporte::Controller::Sugerencias;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{quejas} = [$c->model('DB::QuejaSugerencia')->search({},{'order_by'=>['fecha','empleado']})];
}

sub nueva : Local {
  my($self, $c) = @_;

  my $detalle = $c->request->params->{detalle};

  $c->model('DB::QuejaSugerencia')->create({
    detalle=>$detalle
  });

  $c->response->redirect('/sugerencias');
}

__PACKAGE__->meta->make_immutable;

1;
