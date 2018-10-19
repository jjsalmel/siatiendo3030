package Soporte::Controller::Root;
use Moose;
use namespace::autoclean;
use DateTime;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{atenciones} = [$c->model('DB::Atencion')->search({fechahorainicio=>{'>',DateTime->now(time_zone=>'local')->strftime('%Y-%m-%d')}},{order_by=>'usuarioid'})->all];
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

sub auto :Private{
  my ($self, $c) = @_;

  if($c->controller eq $c->controller('Login'))
  {
    return 1;
  }

  if(!$c->user_exists){
    $c->response->redirect($c->uri_for('/login'));
    return 0;
  }

  return 1;
}

sub logout :Local {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->response->redirect($c->uri_for('/'));
}

__PACKAGE__->meta->make_immutable;

1;
