package Soporte::Controller::Atencion;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Soporte::Controller::Atencion in Atencion.');
}

sub nueva : Local
{
  my ($self, $c) = @_;

  my $entidad = $c->request->params->{entidad};
  my $usuarioid = $c->request->params->{usuarioid};
  my $problema = $c->request->params->{problema};
  my $solucion = $c->request->params->{solucion};
  my $solicito = $c->request->params->{solicito};

  if($entidad && $problema)
  {
    my $atencion = $c->model('DB::Atencion')->create({
      usuarioid=>$usuarioid,
      entidadid=>$entidad,
      fechahorainicio=>DateTime->now(time_zone=>'local') ,
      problema=>$problema,
      solicito=>$solicito
    });

    if($solucion)
    {
      $atencion->update({
        solucion=>$solucion,
        fechahorafin=>DateTime->now(time_zone=>'local')
      });
    }

    $c->response->redirect('/');
  }
  else
  {
    $c->stash->{usuarios} = [$c->model('DB::Empleado')->search({},{order_by=>{-asc=>['paterno','materno','nombre']}})->all];
    $c->stash->{entidades} = [$c->model('DB::Entidade')->search({},{order_by=>'nombreentidad'})->all];
  }
}

sub ver : Local
{
  my ($self, $c, $atencionid) = @_;

  my $atencion = $c->model('DB::Atencion')->find($atencionid);

  $c->stash->{atencion} = $atencion;
  $c->stash->{ahora} = DateTime->now(time_zone=>'local');
}

sub actualizar : Local
{
  my ($self, $c, $atencionid ) = @_;

  my $atencion = $c->model('DB::Atencion')->find($atencionid);
  my $problema = $c->request->params->{problema};
  my $solucion = $c->request->params->{solucion};

  $atencion->update({
    problema => $problema
  });

  $atencion->update({
    solucion=>$solucion,
    fechahorafin=>DateTime->now(time_zone=>'local')
  }) if($solucion);

  $c->response->redirect('/');
}

sub eliminar : Local{
  my ($self, $c, $atencionid) = @_;

  $c->model('DB::Atencion')->find($atencionid)->delete;

  $c->response->redirect('/');
}

sub pendientes : Local{
  my ($self, $c) = @_;

  $c->stash->{pendientes} = [$c->model('DB::Atencion')->search({fechahorainicio=>undef},{order_by=>'entidadid'})->all];

}

sub nuevopendiente : Local{
  my ($self, $c) = @_;

  my $entidad = $c->request->params->{entidad};
  my $problema = $c->request->params->{problema};

  if($entidad)
  {
    my $atencion = $c->model('DB::Atencion')->create({
      entidadid=>$entidad,
      problema=>$problema
    });

    $c->response->redirect('/atencion/pendientes');
  }
  else
  {
    $c->stash->{entidades} = [$c->model('DB::Entidade')->search({},{order_by=>'nombreentidad'})->all];
    return;
  }

sub asignar : Local {
  my ($self, $c, $atencionid) = @_;

  my $atencion = $c->model('DB::Atencion')->find($atencionid);

  $atencion->update({
    usuarioid=>$c->user->username,
    fechahorainicio=>DateTime->now(time_zone=>'local') ,
  });

  $c->response->redirect('/atencion/ver/'.$atencionid);

}

}
__PACKAGE__->meta->make_immutable;

1;
