package Soporte::Controller::Reportes;
use Moose;
use namespace::autoclean;
use utf8;
use PDF::API2;


#Variables y objetos para la generacion del PDF
my ($pdf,$page,$gfx,$f1,$bold,$t,$ipp,$host,$fechai,$fechaf,$tabla,$tipoReporte);

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Soporte::Controller::Reportes in Reportes.');
}

sub catorcenal : Local{
  my ($self, $c) = @_;

  my $fechainicio = $c->request->params->{inicio};
  my $fechafin = $c->request->params->{fin};
  my $usuario = $c->request->params->{usuarioid};

  if(! $usuario)
  {
    $c->stash->{template} = "reportes/catorcenal_form.tt";
    $c->stash->{usuarios} = [$c->model('DB::Empleado')->search({},{order_by=>{-asc=>['paterno','materno','nombre']}})->all];
    return;
  }
  else
  {
    $c->stash->{template} = "reportes/catorcenal.tt";
    $c->stash->{atenciones} = [
      $c->model('DB::Atencion')->search({usuarioid=>$usuario,fechahorainicio=>{'>=',$fechainicio,'<=',$fechafin}},{order_by=>'fechahorainicio'})->all
    ];
    $c->stash->{usuario}=$c->model('DB::Empleado')->search({usuario => $usuario})->single;

    $c->forward("View::DOM");

  }

}

sub auxiliar : Local {
  my ($self, $c) = @_;

  my $fechainicio = $c->request->params->{fechainicio};

  if($fechainicio)
  {
    $c->stash->{atenciones} = [$c->model('DB::Atencion')->search({fechahorainicio=>{'>',$fechainicio},usuarioid=>$c->user->username},{order_by=>{-asc=>['entidadid','fechahorainicio']}})->all];
    $c->stash->{template} = 'reportes/lista.tt';
  }
}

sub atencion_cliente : Local {
  my ($self, $c) = @_;

  my $fechainicio = $c->request->params->{fechainicio};
  my $entidad = $c->request->params->{entidad};
  if ($fechainicio && $entidad){
    my $cliente = $c->model('DB::Entidade')->find($entidad);
    $c->stash->{atenciones} = [$cliente->search_related('atencions', {fechahorainicio => {'>=', $fechainicio}}, {order_by=>'fechahorainicio'})];
    $c->stash->{entidad} = $cliente
  }
  else
  {
    $c->stash->{clientes} = [$c->model('DB::Entidade')->search({},{'order_by'=>'nombreentidad'})];
    $c->stash->{template} = 'reportes/lista_clientes.tt';
  }

}

sub global : Local {
  my ($self, $c) = @_;

  my $fechainicio = $c->request->params->{fechainicio};
  my $pdf = $c->request->params->{pdf};

  $c->log->debug("ENTRA $fechainicio");

  if(! $fechainicio)
  {
    $c->stash->{template} = 'reportes/global_fecha.tt';
  }
  else
  {
    # $c->stash->{clientes}  = [$c->model('DB::Entidade')->search({},{'order_by'=>'nombreentidad'})];
    $c->stash->{atenciones} = [$c->model('DB::Atencion')->search({fechahorainicio => {'>=', $fechainicio}}, {order_by=>['entidadid','fechahorainicio']})->all];
    $c->stash->{fecha} = $fechainicio;
    if($pdf)
    {
      $c->stash->{pdf_template} = 'reporte_global.tt';
      $c->forward('View::PDF');
    }

  }
}

sub imprimiractividades : Local {
  my ($self, $c) = @_;

  $tabla  = $c->request->params->{tabla};
  $tipoReporte  = $c->request->params->{tiporeporte};
	my $orientacion  = $c->request->params->{orientacion};
	my $fechainicio  = $c->request->params->{fechainicio};
	my $fechafinal  = $c->request->params->{fechafinal};

  $c->log->debug("ENTRA $fechainicio");

  if(! $fechainicio)
  {
    $c->stash->{template} = 'actividades/index.tt';
  }
  else
  {
    if($tabla eq "soporte")
    {
      generaReporteSoporte($c,$fechainicio, $fechafinal,$tipoReporte,$orientacion);
      $c->response->redirect($c->uri_for("../upload/GraficaSoporte-".$fechainicio."a".$fechafinal.".pdf"));
    }
    else
    {
      generaReporteAtencion($c,$fechainicio, $fechafinal,$tipoReporte,$orientacion);
      $c->response->redirect($c->uri_for("../upload/GraficaAtencion-".$fechainicio."a".$fechafinal.".pdf"));
    }
  }
}

sub generaReporteSoporte : Private{
	my ($c,$fechai, $fechaf,$tipoReporte,$orientacion) = @_;
	my $totalelementos=0;
	my $valorMaximo=0;
	my @letras=('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AN','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ','BA','BB','BC','BD','BE','BF','BG','BH','BI','BJ');

	#Se instancia el objeto de la base de datos
	my $conexion = $c->connectdbh($c);
	my ($xinicial,$yinicial,$xfinal,$yfinal);#Variables para marco

	$c->log->debug("Orientacion: $orientacion");

	$pdf = PDF::API2->new();
	$page = $pdf->page;
	$t = $page->text;#Importa el orden, si se pone bajo el gfx el texto va sobre las formas
	$gfx = $page->gfx;
	$f1 = $pdf->corefont('Helvetica',-encoding => 'latin1');
	$bold = $pdf->corefont('Helvetica-Bold',-encoding => 'latin1');
	$ipp = 1/72;#  .0138888

	if($orientacion ==1)#Horizontal
	{
		$pdf->mediabox(11/$ipp,8.5/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,7.8/$ipp);
		$t->text("Gráfica de soporte");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,7.5/$ipp);
		$t->text("De $fechai a $fechaf");

	}
	else#Vertical
	{
		$pdf->mediabox(8.5/$ipp,11/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,10.5/$ipp);
		$t->text("Gráfica de soporte");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,10.2/$ipp);
		$t->text("De $fechai a $fechaf");
	}


	#Consulta de actividades registradas en el periodo
	my $query= "SELECT count(*)
				FROM tablasoporte
				WHERE fechainicio>='".$fechai."' and  fechainicio<= '".$fechaf."'";

	my $resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	my $totalactividades = $resultado->fetchrow_array;
	$resultado->finish;

	$t->translate(0.5/$ipp,7.18/$ipp);
	$t->text("Folios registrados: $totalactividades");

	if($totalactividades ==0)
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda en caso de que no existan actividades
			$t->font($f1,12);
			$t->translate(4/$ipp,5/$ipp);
			$t->text("No se registraron folios en el mes");
		}
		else
		{
			#Leyenda en caso de que no existan actividades
			$t->font($f1,12);
			$t->translate(2.8/$ipp,9/$ipp);
			$t->text("No se registraron folios en el mes");
		}
	}

	$c->log->debug("Actividades: $totalactividades");

	if($tipoReporte==1) #Si el reporte es por empleados
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,7.35/$ipp);
			$t->text("Tipo de reporte: por empleado");
		}
		else
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,10.05/$ipp);
			$t->text("Tipo de reporte: por empleado");
		}

		#Consulta el valor maximo
		$query="SELECT max(cantidad)
				FROM(SELECT sum (cantidad) as cantidad
					 FROM  (SELECT count(*)as cantidad,empleadoid,0
							FROM tablasoporte
							WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf'
							GROUP BY empleadoid
							UNION
							SELECT count(*)as cantidad,asignadoa,1
							FROM tablasoporte
							WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf' and asignadoa IS NOT NULL
							GROUP BY asignadoa)as q
					GROUP BY empleadoid) as q1";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$valorMaximo = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Valor Maximo: $valorMaximo");

		#Consulta del numero de empleados que realizo actividades
		$query="SELECT count(*)
				FROM (	SELECT  distinct empleadoid
						FROM tablasoporte
						WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf'
						UNION
						SELECT distinct asignadoa
						FROM tablasoporte
						WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf' and asignadoa IS NOT NULL) as q";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$totalelementos = $resultado->fetchrow_array;
		$resultado->finish;

		#Graficado
		my $b=0;

		#Consulta de actividades por empleado
		$query="SELECT sum (cantidad) as cantidad,empleadoid,nombre
				FROM (SELECT count(*)as cantidad,s.empleadoid, substring (e.nombre||' '||e.paterno||' '||e.materno from 1 for 35) as nombre,0
					  FROM tablasoporte s JOIN empleados e ON s.empleadoid=e.empleadoid
					  WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf'
					  GROUP BY s.empleadoid,e.nombre,e.paterno,e.materno
					  UNION
					  SELECT count(*)as cantidad,asignadoa, substring (e.nombre||' '||e.paterno||' '||e.materno from 1 for 35) as nombre,1
					  FROM tablasoporte s JOIN empleados e ON s.asignadoa=e.empleadoid
					  WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf' and asignadoa IS NOT NULL
					  GROUP BY s.asignadoa,e.nombre,e.paterno,e.materno)as q
				GROUP BY empleadoid,nombre ORDER BY nombre" ;

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		my($cantidad,$idEmpleado,$nombre);
		my $conta=1;
		my $contay=1;
		while (($cantidad,$idEmpleado,$nombre) = $resultado ->fetchrow_array)
		{
			if($orientacion ==1)#Horizontal
			{
				if($b==0)
				{
					pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$letras[$conta-1]);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$letras[$conta-1]);
						$b++;
					}
					else
					{
						pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$letras[$conta-1]);
						$b=0;
					}
				}
			}
			else
			{
				if($b==0)
				{
					pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}else
				{
					if($b==1)
					{
						pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}

			if($orientacion ==1)#Este c�digo va fuera de las condicionales pasadas porque marca errores con el uso del switch
			{
				if($totalelementos<=19)
				{
					if($conta==1)
					{
						$t->font($bold,9);
						$t->translate(6.5/$ipp,7.8/$ipp);
						$t->text("Empleados");
					}

					$t->font($f1,7.5);
					$t->translate(6.5/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text($letras[$conta-1]);

					$t->translate(6.63/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text(" - ".$nombre);
				}
				else
				{
					if($conta<=19)
					{
						if($conta==1)
						{
							$t->font($bold,9);
							$t->translate(3.3/$ipp,7.8/$ipp);
							$t->text("Empleados");
						}

						$t->font($f1,7.5);
						$t->translate(3.3/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(3.43/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text(" - ".$nombre);
					}
					if($conta>19 &&$conta<=38 )
					{
						$t->font($f1,7.5);
						$t->translate(6.0/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(6.13/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
					if($conta>38)
					{
						if($conta==39)
						{
							$contay=1;
						}
						$t->font($f1,7.5);
						$t->translate(8.7/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(8.83/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
				}
			}

			$conta++;
		}

		$resultado->finish;
	}
	else #Si el reporte es por entidad
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,7.35/$ipp);
			$t->text("Tipo de reporte: por entidad");
		}
		else
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,10.05/$ipp);
			$t->text("Tipo de reporte: por entidad");
		}

		#Consulta el valor maximo
		$query="SELECT max (cantidad)
				FROM (SELECT count(*)as cantidad,entidadid
					  FROM tablasoporte
					  WHERE fechainicio>='".$fechai."' and  fechainicio<= '".$fechaf."'
					  GROUP BY entidadid)as consulta";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$valorMaximo = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Valor Maximo: $valorMaximo");

		#Consulta del numero de entidades
		$query="SELECT count(distinct(entidadid))
				FROM tablasoporte
				WHERE fechainicio>='".$fechai."' and  fechainicio<= '".$fechaf."'";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$totalelementos = $resultado->fetchrow_array;
		$resultado->finish;

		#Graficado
		my $b=0;

		#Consulta de actividades por entidad
		$query="SELECT count(*),s.entidadid,substring(e.nombreentidad from 1 for 35)
				FROM tablasoporte s JOIN entidades e ON s.entidadid=e.entidadid
				WHERE fechainicio>='".$fechai."' and  fechainicio<= '".$fechaf."'
				GROUP BY s.entidadid,e.nombreentidad"
				;

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		my($cantidad,$idEntidad,$nombre);
		my $conta=1;
		my $contay=1;
		while (($cantidad,$idEntidad,$nombre) = $resultado ->fetchrow_array)
		{
			if($orientacion ==1)#Horizontal
			{
				if($b==0)
				{

					pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$letras[$conta-1]);
					$b++;
				}else
				{
					if($b==1)
					{
						pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$letras[$conta-1]);
						$b++;
					}
					else
					{
						pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$letras[$conta-1]);
						$b=0;
					}
				}
			}
			else
			{
				if($b==0)
				{
					pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}

			if($orientacion ==1)#Este c�digo va fuera de las condicionales pasadas porque marca errores con el uso del switch
      {
				if($totalelementos<=19){
					if($conta==1){
						$t->font($bold,9);
						$t->translate(6.5/$ipp,7.8/$ipp);
						$t->text("Entidades");
					}

					$t->font($f1,7.5);
					$t->translate(6.5/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text($letras[$conta-1]);

					$t->translate(6.63/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text(" - ".$nombre);
				}
				else
				{
					if($conta<=19){
						if($conta==1){
							$t->font($bold,9);
							$t->translate(3.3/$ipp,7.8/$ipp);
							$t->text("Entidades");
						}

						$t->font($f1,7.5);
						$t->translate(3.3/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(3.43/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text(" - ".$nombre);
					}
					if($conta>19 &&$conta<=38 ){
						$t->font($f1,7.5);
						$t->translate(6.0/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(6.13/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
					if($conta>38){
						if($conta==39){
							$contay=1;
						}
						$t->font($f1,7.5);
						$t->translate(8.7/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(8.83/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
				}
			}

			$conta++;
		}

		$resultado->finish;
	}

	#------------------------------------------------------------------------------------
	# Notas:
	#        strokecolor(color)   -> establece el color de la linea, contorno.
	#        stroke()             -> dibuja la linea, contorno.
	#        fillcolor(color)     -> establece el color de relleno.
	#        fill()               -> dibuja el relleno.
	#        fillstroke()         -> dibuja la linea y el relleno en una instrucion.
	#--------------------------------------------------------------------------------------

  #barra circulada
  #$gfx->linewidth(0.5);
  #$gfx->strokecolor("yellow");
  #$gfx->fillcolor("yellow");
  #$gfx->circle(0.8/$ipp,6.6/$ipp,0.1/$ipp);
  #$gfx->circle(7.7/$ipp,6.6/$ipp,0.1/$ipp);
  #$gfx->rect(0.8/$ipp,6.5/$ipp,6.9/$ipp,0.2/$ipp);
  #$gfx->fillstroke();

  #Circulo
  #$gfx->strokecolor("red");
  #$gfx->fillcolor("red");
  #$gfx->circle(2.8/$ipp,8/$ipp,0.5/$ipp);
  #$gfx->fillstroke();

  my $ruta = $c->path_to('/root/upload','GraficaSoporte-'.$fechai.'a'.$fechaf.'.pdf')->absolute;
  $pdf->saveas("$ruta");
  ##$pdf->saveas("/home/crediweb/cvs/soporteweb/root/upload/reportes/GraficaSoporte-".$fechai."a".$fechaf.".pdf");
	##$pdf->saveas("/home/crediweb/git/soporteweb/root/upload/GraficaSoporte-".$fechai."a".$fechaf.".pdf");
	$pdf->end();
}

sub generaReporteAtencion : Private{
	my ($c,$fechai, $fechaf,$tipoReporte,$orientacion) = @_;
	my $totalelementos=0;
	my $valorMaximo=0;
	my @letras=('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AN','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ','BA','BB','BC','BD','BE','BF','BG','BH','BI','BJ');

	#Se instancia el objeto de la base de datos
	my $conexion = $c->connectdbh($c);
	my ($xinicial,$yinicial,$xfinal,$yfinal);#Variables para marco

	$c->log->debug("****ATENCION****");

	$c->log->debug("Orientacion: $orientacion");

	$pdf = PDF::API2->new();
	$page = $pdf->page;
	$t = $page->text;#Importa el orden, si se pone bajo el gfx el texto va sobre las formas
	$gfx = $page->gfx;
	$f1 = $pdf->corefont('Helvetica',-encoding => 'latin1');
	$bold = $pdf->corefont('Helvetica-Bold',-encoding => 'latin1');
	$ipp = 1/72;#  .0138888

	if($orientacion ==1)#Horizontal
	{
		$pdf->mediabox(11/$ipp,8.5/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,7.8/$ipp);
		$t->text("Gráfica de atención");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,7.5/$ipp);
		$t->text("De $fechai a $fechaf");
	}
	else#Vertical
	{
		$pdf->mediabox(8.5/$ipp,11/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,10.5/$ipp);
		$t->text("Gráfica de atención");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,10.2/$ipp);
		$t->text("De $fechai a $fechaf");
	}


	#Consulta de actividades registradas en el periodo
	my $query= "SELECT count(*)
				FROM atencion
				WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."' "; 			#and entidadid<>44";

	my $resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	my $totalactividades = $resultado->fetchrow_array;
	$resultado->finish;

	$t->translate(0.5/$ipp,7.18/$ipp);
	$t->text("Actividades registradas: $totalactividades");

	if($totalactividades ==0)
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda en caso de que no existan actividades
			$t->font($f1,12);
			$t->translate(4/$ipp,5/$ipp);
			$t->text("No se registraron actividades en el mes");
		}
		else
		{
			#Leyenda en caso de que no existan actividades
			$t->font($f1,12);
			$t->translate(2.8/$ipp,9/$ipp);
			$t->text("No se registraron actividades en el mes");
		}
	}

	$c->log->debug("Actividades: $totalactividades");

	if($tipoReporte==1) #Si el reporte es por empleados
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,7.35/$ipp);
			$t->text("Tipo de reporte: por empleado");
		}
		else
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,10.05/$ipp);
			$t->text("Tipo de reporte: por empleado");
		}

		#Consulta el valor maximo
		$query="SELECT max (cantidad)
				FROM (SELECT count(*)as cantidad,usuarioid
					  FROM atencion
					  WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."'
					  GROUP BY usuarioid)as consulta";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$valorMaximo = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Valor Maximo: $valorMaximo");

		#Consulta del numero de empleados que realizo actividades
		$query="SELECT count(distinct(empleadoid))
				FROM atencion a JOIN empleados e ON a.usuarioid=e.usuario
				WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."' ";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$totalelementos = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Total de elementos: $totalelementos");

		#Graficado
		my $b=0;

		#Consulta de actividades por empleado
		$query="SELECT count(*),s.usuarioid, substring (e.nombre||' '||e.paterno||' '||e.materno from 1 for 35) as nombre
				FROM atencion s JOIN empleados e ON s.usuarioid=e.usuario
				WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."'
				GROUP BY s.usuarioid,e.nombre,e.paterno,e.materno
				ORDER BY e.nombre" ;

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		my($cantidad,$idEmpleado,$nombre);
		my $conta=1;
		my $contay=1;
		while (($cantidad,$idEmpleado,$nombre) = $resultado ->fetchrow_array)
		{
			if($orientacion ==1)#Horizontal
			{
				if($b==0)
				{
					pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$letras[$conta-1]);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$letras[$conta-1]);
						$b++;
					}
					else
					{
						pintaBarra($c,$idEmpleado,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$letras[$conta-1]);
						$b=0;
					}
				}
			}
			else
			{
				if($b==0)
				{
					pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarraVertical($c,$idEmpleado,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}

			if($orientacion ==1)#Este c�digo va fuera de las condicionales pasadas porque marca errores con el uso del switch
			{
				if($totalelementos<=19)
				{
					if($conta==1)
					{
						$t->font($bold,9);
						$t->translate(6.5/$ipp,7.8/$ipp);
						$t->text("Empleados");
					}

					$t->font($f1,7.5);
					$t->translate(6.5/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text($letras[$conta-1]);

					$t->translate(6.63/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text(" - ".$nombre);
				}
				else
				{
					if($conta<=19)
					{
						if($conta==1)
						{
							$t->font($bold,9);
							$t->translate(3.3/$ipp,7.8/$ipp);
							$t->text("Empleados");
						}

						$t->font($f1,7.5);
						$t->translate(3.3/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(3.43/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text(" - ".$nombre);
					}
					if($conta>19 &&$conta<=38 )
					{
						$t->font($f1,7.5);
						$t->translate(6.0/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(6.13/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
					if($conta>38)
					{
						if($conta==39)
						{
							$contay=1;
						}
						$t->font($f1,7.5);
						$t->translate(8.7/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(8.83/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
				}
			}

			$conta++;
		}

		$resultado->finish;
	}
	else #Si el reporte es por entidad
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,7.35/$ipp);
			$t->text("Tipo de reporte: por entidad");
		}
		else
		{
			#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,10.05/$ipp);
			$t->text("Tipo de reporte: por entidad");
		}

		#Consulta el valor maximo
		$query="SELECT max (cantidad)
				FROM (SELECT count(*)as cantidad,entidadid
					  FROM atencion
					  WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."'
					  GROUP BY entidadid)as consulta";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$valorMaximo = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Valor Maximo: $valorMaximo");

		#Consulta del numero de entidades
		$query="SELECT count(distinct(a.entidadid))
				FROM atencion a JOIN entidades e ON a.entidadid=e.entidadid
				WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date<='".$fechaf."' ";

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		$totalelementos = $resultado->fetchrow_array;
		$resultado->finish;

		$c->log->debug("Total de elementos: $totalelementos");

		#Graficado
		my $b=0;

		#Consulta de actividades por entidad
		$query="SELECT count(*),s.entidadid,substring(e.nombreentidad from 1 for 35)
				FROM atencion s JOIN entidades e ON s.entidadid=e.entidadid
				WHERE fechahorainicio>='".$fechai."' and fechahorainicio::date <='".$fechaf."'
				GROUP BY s.entidadid,e.nombreentidad" ;

		$resultado = $conexion->prepare($query) || die $conexion->errstr;
		$resultado ->execute  || die $conexion->errstr;

		my($cantidad,$idEntidad,$nombre);
		my $conta=1;
		my $contay=1;
		while (($cantidad,$idEntidad,$nombre) = $resultado ->fetchrow_array)
		{
			if($orientacion ==1)#Horizontal
			{
				if($b==0)
				{
					pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$letras[$conta-1]);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$letras[$conta-1]);
						$b++;
					}
					else
					{
						pintaBarra($c,$idEntidad,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$letras[$conta-1]);
						$b=0;
					}
				}
			}
			else
			{
				if($b==0)
				{
					pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarraVertical($c,$idEntidad,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}


			if($orientacion ==1)#Este c�digo va fuera de las condicionales pasadas porque marca errores con el uso del switch
			{
				if($totalelementos<=19)
				{
					if($conta==1)
					{
						$t->font($bold,9);
						$t->translate(6.5/$ipp,7.8/$ipp);
						$t->text("Entidades");
					}

					$t->font($f1,7.5);
					$t->translate(6.5/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text($letras[$conta-1]);

					$t->translate(6.63/$ipp,(7.75-($conta*0.15))/$ipp);
					$t->text(" - ".$nombre);
				}
				else
				{
					if($conta<=19)
					{
						if($conta==1)
						{
							$t->font($bold,9);
							$t->translate(3.3/$ipp,7.8/$ipp);
							$t->text("Entidades");
						}

						$t->font($f1,7.5);
						$t->translate(3.3/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(3.43/$ipp,(7.75-($conta*0.15))/$ipp);
						$t->text(" - ".$nombre);
					}
					if($conta>19 &&$conta<=38 )
					{
						$t->font($f1,7.5);
						$t->translate(6.0/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(6.13/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
					if($conta>38)
					{
						if($conta==39)
						{
							$contay=1;
						}
						$t->font($f1,7.5);
						$t->translate(8.7/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text($letras[$conta-1]);

						$t->translate(8.83/$ipp,(7.75-($contay*0.15))/$ipp);
						$t->text(" - ".$nombre);

						$contay++;
					}
				}
			}

			$conta++;
		}

		$resultado->finish;
	}

  my $ruta = $c->path_to('/root/upload','GraficaAtencion-'.$fechai.'a'.$fechaf.'.pdf')->absolute;
  $pdf->saveas("$ruta");
  ##$pdf->saveas("/home/crediweb/cvs/soporteweb/root/upload/reportes/GraficaAtencion-".$fechai."a".$fechaf.".pdf");
	##$pdf->saveas("/home/crediweb/git/soporteweb/root/upload/GraficaAtencion-".$fechai."a".$fechaf.".pdf");
	$pdf->end();
}



sub imprimirgrafica : Local {
  my ($self, $c) = @_;

  my $fechainicio = $c->request->params->{fechainicio};
  my $fechafinal = $c->request->params->{fechafinal};
  my $orientacion = $c->request->params->{orientacion};

  my $pdf = $c->request->params->{pdf};

  $c->log->debug("ENTRA $fechainicio");

  if(! $fechainicio)
  {
    $c->stash->{template} = 'graficas/index.tt';
  }
  else
  {
    generaReporte($c, $fechainicio, $fechafinal, $orientacion);
    $c->response->redirect($c->uri_for("../upload/GraficaFolios-".$fechainicio."a".$fechafinal.".pdf"));
  }
}

sub generaReporte : Private{
	my ($c,$fechai,$fechaf,$orientacion) = @_;
	my $totalelementos=0;
	my $valorMaximo=0;

	$c->log->debug("Orientacion: $orientacion");

	$pdf = PDF::API2->new();
	$page = $pdf->page;
	$t = $page->text;#Importa el orden, si se pone bajo el gfx el texto va sobre las formas
	$gfx = $page->gfx;
	$f1 = $pdf->corefont('Helvetica',-encoding => 'latin1');
	$bold = $pdf->corefont('Helvetica-Bold',-encoding => 'latin1');
	$ipp = 1/72;#  .0138888

	if($orientacion ==1)#Horizontal
	{
		$pdf->mediabox(11/$ipp,8.5/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,7.8/$ipp);
		$t->text("Gráfica de folios");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,7.5/$ipp);
		$t->text("De $fechai a $fechaf");

		#Leyenda de tipo de reporte
		$t->font($f1,11);
		$t->translate(0.5/$ipp,7.35/$ipp);
		$t->text("Tipo de reporte: por estatus");
	}
	else#Vertical
	{
		$pdf->mediabox(8.5/$ipp,11/$ipp);

		#Enabezados
		$t->font($bold,13);
		$t->translate(0.5/$ipp,10.5/$ipp);
		$t->text("Gráfica de folios");

		$t->font($f1,11);
		$t->translate(0.5/$ipp,10.2/$ipp);
		$t->text("De $fechai a $fechaf");

		#Leyenda de tipo de reporte
			$t->font($f1,11);
			$t->translate(0.5/$ipp,10.05/$ipp);
			$t->text("Tipo de reporte: por estatus");
	}

	#Consulta de folios registrados en el periodo

  my $conexion = $c->connectdbh($c);

	my $query= "SELECT count(*)
				FROM tablasoporte
				WHERE fechainicio>='$fechai' and  fechainicio<= '$fechaf'";

	my $resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	my $totalactividades = $resultado->fetchrow_array;
	$resultado->finish;

	$t->translate(0.5/$ipp,7.18/$ipp);
	$t->text("Folios registrados: $totalactividades");

	if($totalactividades ==0)
	{
		if($orientacion ==1)#Horizontal
		{
			#Leyenda en caso de que no existan folios
			$t->font($f1,12);
			$t->translate(4/$ipp,5/$ipp);
			$t->text("No se registraron folios en el mes");
		}
		else
		{
			#Leyenda en caso de que no existan actividades
			$t->font($f1,12);
			$t->translate(2.8/$ipp,9/$ipp);
			$t->text("No se registraron folios en el mes");
		}
	}
	#Consulta el valor maximo
	$query="SELECT max(cantidad)
			FROM(SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio<='$fechaf' and avanceid = 1 GROUP BY avanceid
				  UNION
				  SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio>='$fechai' and fechainicio<='$fechaf' and avanceid = 4 GROUP BY avanceid
				  UNION
				  SELECT count(*), avanceid
				  FROM tablasoporte
				  WHERE avanceid in (2,3) and fechainicio>='2013-01-01'
				  GROUP BY avanceid) as q1";

	$resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	$valorMaximo = $resultado->fetchrow_array;
	$resultado->finish;

	#Consulta del numero de estatus que tienen los folios
	$query="SELECT count(distinct(avanceid))
			FROM (SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio<='$fechaf' and avanceid = 1 GROUP BY avanceid
				  UNION
				  SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio>='$fechai' and fechainicio<='$fechaf' and avanceid = 4 GROUP BY avanceid
				  UNION
				  SELECT count(*), avanceid
				  FROM tablasoporte
				  WHERE avanceid in (2,3) and fechainicio>='2013-01-01'
				  GROUP BY avanceid
				  ) as q1;";

	$resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	$totalelementos = $resultado->fetchrow_array;
	$resultado->finish;

	#Graficado
	my $b=0;

	#Consulta de folios por estatus
	$query="SELECT cantidad,q.avanceid,a.estatus
			FROM (SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio<='$fechaf' and avanceid = 1 GROUP BY avanceid
				  UNION
				  SELECT count(*) as cantidad, avanceid
				  FROM tablasoporte
				  WHERE fechainicio>='$fechai' and fechainicio<='$fechaf' and avanceid = 4 GROUP BY avanceid
				  UNION
				  SELECT count(*), avanceid
				  FROM tablasoporte
				  WHERE avanceid in (2,3) and fechainicio>='2013-01-01'
				  GROUP BY avanceid
				  )as q JOIN avance a ON q.avanceid=a.avanceid" ;

	$resultado = $conexion->prepare($query) || die $conexion->errstr;
	$resultado ->execute  || die $conexion->errstr;

	my($cantidad,$idEstatus,$nombre);
	my $conta=1;
	my $contay=1;
	while (($cantidad,$idEstatus,$nombre) = $resultado ->fetchrow_array)
	{
		if($orientacion ==1)#Horizontal
			{
				if($b==0)
				{
					pintaBarra($c,$idEstatus,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}
				else
				{
					if($b==1)
					{
						pintaBarra($c,$idEstatus,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarra($c,$idEstatus,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}
			else
			{
				if($b==0)
				{
					pintaBarraVertical($c,$idEstatus,$valorMaximo,$totalelementos, "#0A1A28",$conta,$cantidad,$nombre);
					$b++;
				}else
				{
					if($b==1)
					{
						pintaBarraVertical($c,$idEstatus,$valorMaximo,$totalelementos, "#2188F7",$conta,$cantidad,$nombre);
						$b++;
					}
					else
					{
						pintaBarraVertical($c,$idEstatus,$valorMaximo,$totalelementos, "#7DE230",$conta,$cantidad,$nombre);
						$b=0;
					}
				}
			}


		$conta++;
	}

	$resultado->finish;

  my $ruta = $c->path_to('/root/upload','GraficaFolios-'.$fechai.'a'.$fechaf.'.pdf')->absolute;
  $pdf->saveas("$ruta");
  ##$pdf->saveas("/home/crediweb/git/soporteweb/root/upload/reportes/GraficaFolios-".$fechai."a".$fechaf.".pdf");
	$pdf->end();

  #$c->response->redirect($c->uri_for("../upload/reportes/GraficaFolios-".$fechai."a".$fechaf.".pdf"));
}

sub pintaBarra : Private
{
	my ($c,$id,$valorMaximo,$totalelementos, $color,$numero,$valor,$identificador) = @_;

	my ($ancho,$x,$tamano);

	$ancho=9.1/$totalelementos;

	if($numero==1)
	{
		$x=0.95;
	}
	else
	{
		$x = 0.95+ ($numero * $ancho)-$ancho;
	}

	$tamano=(4/$valorMaximo)*$valor;

	#Rectangulo
	$gfx->strokecolor($color);
	$gfx->fillcolor($color);
	$gfx->rect($x/$ipp,0.7/$ipp,$ancho/$ipp,$tamano/$ipp);
	$gfx->fillstroke();

	#Cantidad
	if($totalelementos>35)
	{
		$t->font($bold,7);
		$t->translate(($x)/$ipp,($tamano+0.74)/$ipp);
	}
	else
	{
		$t->font($bold,9);
		$t->translate(($x+$ancho/2.4)/$ipp,($tamano+0.74)/$ipp);
	}
	$t->text($valor);

	#Identificador
	if($totalelementos>35)
	{
		$t->font($bold,7);
	}
	else
	{
		$t->font($bold,9);
	}
	$t->translate(($x+$ancho/2.7)/$ipp,(0.5)/$ipp);
	$t->text($identificador);

	#Link
	my $url= $c->uri_for("../reportefolios/subreporte")."?id=$id&fechai=$fechai&fechaf=$fechaf";

	my $annot = $page->annotation();
	$annot->url($url,-rect=>[$x/$ipp,0.7/$ipp,($x+$ancho)/$ipp,(0.7+$tamano)/$ipp], -border => [1,1,1]);
}


sub pintaBarraVertical : Private {
	my ($c,$id,$valorMaximo,$totalelementos, $color,$numero,$valor,$identificador) = @_;

	my ($ancho,$y,$tamano);
	$ancho=8.8/$totalelementos;

	if($numero==1){
		$y=9.5 -$ancho;
	}
	else{
		$y = 9.5 - ($numero * $ancho);
	}
	$tamano=(4.5/$valorMaximo)*$valor;
	#Rectangulo
	$gfx->strokecolor($color);
	$gfx->fillcolor($color);
	$gfx->rect(3.0/$ipp,$y/$ipp,$tamano/$ipp,$ancho/$ipp);
	$gfx->fillstroke();

	#Cantidad
	if($totalelementos>35){
		$t->font($bold,7);
	}
	else{
		$t->font($bold,9);
	}
	$t->translate((3.0+$tamano+.2)/$ipp,($y+$ancho/2.6)/$ipp);
	$t->text($valor);
	#Identificador
	$t->font($f1,7);
	$t->translate((0.7)/$ipp,($y+$ancho/2.6)/$ipp);
	$t->text($identificador);
	#Link
	my $url= $c->uri_for("../reportefolios/subreporte")."?id=$id&fechai=$fechai&fechaf=$fechaf";
	my $annot = $page->annotation();
	$annot->url($url,-rect=>[3/$ipp,$y/$ipp,($tamano+3)/$ipp,($y+$ancho)/$ipp], -border => [1,1,1]);
}

__PACKAGE__->meta->make_immutable;

1;
