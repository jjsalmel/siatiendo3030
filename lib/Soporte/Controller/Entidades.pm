package Soporte::Controller::Entidades;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

my $filas = 8;

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $self->lista($c, 1);
}

sub lista : Local{
  my ($self, $c, $pagina) = @_;

  $c->stash->{entidades} = [$c->model('DB::Entidade')->search({},{order_by=>'nombreentidad',page=>$pagina,rows=>$filas})->all];
  $c->stash->{pagina} = $pagina;

  # $c->stash->{folios} = [$c->model('DB::Tablasoporte')->search({-or=>{encargado=>$empleado->empleadoid,asignadoa=>$empleado->empleadoid}}, {order_by=>{-desc=>'nofolio'},page=>$pagina,rows=>$filas})->all];
  $c->stash->{template} = 'entidades/index.tt';
}

sub detalle : Local{
  my($self, $c, $id) = @_;

  $id = $id || $c->request->params->{entidad};
  my $entidad = $c->model('DB::Entidade')->find($id);

  $c->stash->{entidad} = $entidad;

  $c->forward('View::DOM');
}

sub productos : Local {
  my ($self, $c, $id) = @_;
  $id = $id || $c->request->params->{entidad};
  my $entidad = $c->model('DB::Entidade')->find($id);

  $c->stash->{productos} = [$c->model('DB::Producto')->search({},{order_by=>'id'})->all];
  $c->stash->{entidad} = $entidad;

}

sub asignarproducto : Local {
  my ($self, $c, $id, $producto) = @_;

  my $producto_entidad = $c->model('DB::ProductoEntidad')->find_or_create({
    entidad => $id,
    producto => $producto
  });

  $c->response->redirect('/entidades/detalleproducto/'.$producto_entidad->id);
}

sub detalleproducto : Local {
  my ($self, $c, $id) = @_;

  my $producto_entidad = $c->model('DB::ProductoEntidad')->find($id);

  $c->stash->{producto_entidad} = $producto_entidad;
  $c->stash->{usuarios} = [$c->model('DB::Empleado')->search({},{order_by=>{-asc=>['paterno','materno','nombre']}})->all];
}

sub nuevo_detalleproducto : Local{
  my ($self, $c, $id) = @_;

  my $comentario = $c->request->params->{comentario};
  my $fecha = $c->request->params->{fecha};
  my $usuario = $c->request->params->{usuarioid};

  my $empleado = $c->model('DB::Empleado')->search({usuario => $usuario})->first;
  my $producto_entidad = $c->model('DB::ProductoEntidad')->find($id);

  $producto_entidad->detalle_producto_entidads->create({
    fecha => $fecha,
    comentario => $comentario,
    empleado => $empleado->empleadoid
  });

  $c->response->redirect($c->uri_for('/entidades/detalleproducto/').$id);
}

sub resumen_productos : Local{
  my ($self, $c) = @_;

  $c->stash(
    productos => [$c->model('DB::Producto')->search({},{order_by=>'id'})->all],
    entidades => [$c->model('DB::Entidade')->search({},{order_by=>'nombreentidad'})->all]
  );
}
__PACKAGE__->meta->make_immutable;

1;
