package Soporte::Controller::Productos;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{productos} = [$c->model('DB::Producto')->search({},{order_by => 'id'})->all];
}

sub nuevo : Local {
  my ( $self, $c ) = @_;

  my $nombre = $c->request->params->{nombre};
  my $descripcion = $c->request->params->{descripcion};

  $c->model('DB::Producto')->create({
    nombre => $nombre,
    descripcion => $descripcion
  });

  $c->response->redirect('/productos');
}



__PACKAGE__->meta->make_immutable;

1;
