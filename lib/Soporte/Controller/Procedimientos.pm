package Soporte::Controller::Procedimientos;
use Moose;
use namespace::autoclean;
use Data::Dumper;
use utf8;
BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub buscar : Local {
  my ($self, $c) = @_;

  my $busqueda = $c->request->params->{buscar};

  my @palabras = split " ",$busqueda;

  my $procedimientos =   $c->model('DB::Procedimiento')->search;
  foreach my $palabra_clave (@palabras)
  {
    $procedimientos = $procedimientos->search({desarrollo=>{like=>'%'.$palabra_clave.'%'}});
  }

  $c->stash->{resultados} = [$procedimientos->all];
  $c->stash->{template} = 'procedimientos/resultados.tt';

  $c->forward('View::DOM');
}

sub ver : Local {
  my ($self, $c, $claveid) = @_;

  my $procedimiento = $c->model('DB::Procedimiento')->find($claveid);

  $c->stash->{procedimiento} = $procedimiento;
}

sub nuevo : Local{
  my ($self, $c) = @_;

  my $actividad = $c->request->params->{actividad};
  my $alcance = $c->request->params->{alcance};
  my $area = $c->request->params->{area};
  my $desarrollo = $c->request->params->{desarrollo};
  my $fecha_modificacion = $c->request->params->{fecha_modificacion};
  my $fecha_registro = $c->request->params->{fecha_registro};
  my $objetivo = $c->request->params->{objetivo};
  my $referencia = $c->request->params->{referencia};
  my $revision = $c->request->params->{revision};
  my $titulo = $c->request->params->{titulo};
  my $empleadoid = $c->request->params->{empleadoid};

  if($actividad)
  {
      my $procedimiento = $c->model('DB::Procedimiento')->search({        clavereg => $referencia      })->first;

      if($procedimiento)
      {
        $c->stash->{error} = "La referencia $referencia ya está en uso, pruebe a agregar un dígito adicional";
        $c->stash->{parametros => {$c->request->params}};
        return;
      }

      $procedimiento = $c->model('DB::Procedimiento')->create({
        clavereg => $referencia,
        fechareg => $fecha_registro,
        norevision => $revision,
        fechamod => $fecha_modificacion,
        areaprocedimiento => $area,
        tituloprocedimiento => $titulo,
        actividad => $actividad,
        objetivo => $objetivo,
        alcance => $alcance,
        desarrollo => $desarrollo,
        empleadoid => $empleadoid
      });

      $c->response->redirect($c->uri_for('/procedimientos/ver/'.$procedimiento->claveid));

  }
  else
  {
    $c->stash->{usuarios} = [ $c->model('DB::Empleado')->search({}, {order_by => {-asc=>['paterno','materno','nombre']}} )->all];
  }
}

__PACKAGE__->meta->make_immutable;

1;
