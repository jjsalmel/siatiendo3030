package Soporte::Controller::Login;
use Moose;
use utf8;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }


sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};

    my $dig = Digest::MD5->new;
		$dig->add("$password$username");

		my $shadow = 'md5'.$dig->hexdigest();

    if($username && $shadow)
    {
      if($c->authenticate({username=>$username,password=>$shadow}))
      {
        $c->response->redirect($c->uri_for('/'))
      }
      else
      {
        $c->stash(template=>'login.tt',error=>'Usuario o Contraseña incorrectos');
      }
    }
    else
    {
      $c->response->redirect($c->uri_for('/')) if $c->user_exists;
    }

    $c->stash(template => 'login.tt');
}


__PACKAGE__->meta->make_immutable;

1;
