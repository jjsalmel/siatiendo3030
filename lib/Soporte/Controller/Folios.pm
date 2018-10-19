package Soporte::Controller::Folios;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

my $filas=10;
sub index :Path :Args(0) {
    my ( $self, $c) = @_;
    lista($self, $c, 1);
}

sub lista : Local{
  my ($self, $c, $pagina) = @_;

  my $empleado = $c->model('DB::Empleado')->search({usuario=>$c->user->username},{})->single;
  $c->stash->{folios} = [$c->model('DB::Tablasoporte')->search({-or=>{empleadoid=>$empleado->empleadoid,asignadoa=>$empleado->empleadoid}}, {order_by=>{-desc=>'nofolio'},page=>$pagina,rows=>$filas})->all];
  $c->stash->{pagina} = $pagina;
  $c->stash->{template} = 'folios/index.tt';
}

sub ver : Local{
  my ($self, $c, $nofolio) = @_;

  my $folio = $c->model("DB::Tablasoporte")->find($nofolio);

  $c->stash->{estados} = [$c->model('DB::Avance')->search(undef,{order_by=>'avanceid'})->all];
  $c->stash->{folio} = $folio;
}

sub actualizar: Local{
  my ($self, $c, $nofolio) = @_;

  my $estatus = $c->request->params->{estatus};
  my $observaciones = $c->request->params->{observaciones};
  $c->model('DB::Tablasoporte')->find($nofolio)->update({
    avanceid=>$estatus,
    observaciones=>$observaciones
  });

  $c->response->redirect('/folios');
}

sub nuevo: Local{
  my ($self, $c) = @_;

  my $asignadoa = $c->request->params->{asignadoa};
  my $empleadoid = $c->request->params->{empleadoid};
  my $entidadid = $c->request->params->{entidadid};
  my $fechasolicitud = $c->request->params->{fechasolicitud};
  my $fechainicio = $c->request->params->{fechainicio};
  my $fechatermino = $c->request->params->{fechatermino};
  my $nombresolicitante = $c->request->params->{nombresolicitante};
  my $descripcion = $c->request->params->{descripcion};

  if($descripcion)
  {
    my $folio = $c->model('DB::Tablasoporte')->create({
      asignadoa => $asignadoa,
      empleadoid => $empleadoid,
      entidadid => $entidadid,
      fechasolicitud => $fechasolicitud,
      fechainicio => $fechainicio,
      fechatermino => $fechatermino,
      nombresolicitante => $nombresolicitante,
      descripcion => $descripcion
    });

    $c->response->redirect($c->uri_for('/folios/ver').'/'.$folio->nofolio);
  }
  else
  {
    $c->stash->{empleados} = [$c->model('DB::Empleado')->search({},{order_by=>{-asc=>['paterno','materno','nombre']}})->all];
    $c->stash->{entidades} = [$c->model('DB::Entidade')->search({},{order_by=>'nombreentidad'})->all];
  }
}
__PACKAGE__->meta->make_immutable;

1;
