{ Subprogramas a Implementar }

{
Devuelve en t un Tablero para el cual todas sus Casillas:
  * Están ocultas
  * Están libres
  * No tienen minas alrededor
}
procedure IniciarTableroVacio (var t : Tablero);
//Precondicion: arreglo bidimensional
var i, j : integer;
begin
  for i := 1 to CANT_FIL do
    for j := 1 to CANT_COL do
      begin
        t[i,j].oculto := true;
        t[i,j].tipo := Libre;
        t[i,j].minasAlrededor := 0;
      end;
end;

{
Para toda Casilla c del Tablero que es una Mina, c deja de estar oculta
}
procedure DesocultarMinas (var t : Tablero);
var i, j : integer;
begin
  for i := 1 to CANT_FIL do
    for j := 1 to CANT_COL do
        if t[i,j].tipo = Mina then t[i,j].oculto := false;
end;
{
Devuelve true si tanto la fila f como la columna c son válidas,
es decir corresponden a una casilla del tablero.
De lo contrario devuelve false.
}
function EsPosicionValida (f, c : integer) : boolean;
begin
  EsPosicionValida := ((f > 0) and (f <= CANT_FIL)) and ((c > 0) and (c <= CANT_COL));
end;

{
Agrega minas al Tablero t en cada una de las casillas c correspondientes a
posiciones contenidas en m, es decir que dichas casillas cambien su tipo a Mina.

Adicionalmente asigna el valor del campo minasAlrededor de las casillas del tablero
que queden libres. Este deberá contener la cantidad de casillas adyacentes que 
son minas.
}
procedure AgregarMinas (m : Minas; var t : Tablero);
var i, fila, columna, j, k : integer;
begin
  for i := 1 to m.tope do
  begin
    fila := m.elems[i].fila;
    columna := m.elems[i].columna;
    t[fila, columna].tipo := Mina;
        for j := fila - 1 to fila + 1 do
          for k := columna - 1 to columna + 1 do
            if EsPosicionValida(j, k) and (t[j,k].tipo = Libre) then
              t[j,k].minasAlrededor := t[j,k].minasAlrededor + 1;
  end;
end;

{
Si la fila f y columna c corresponden a una Casilla cas válida del Tablero t 
(ver procedimiento EsPosicionValida) y cas es Libre entonces cas deja de estar 
oculta.
Adicionalmente si la Casilla cumple con lo anterior y no tiene minas alrededor 
entonces se agrega la Posicion correspondiente a dicha casilla al final de la 
listaPos libres.
}
procedure Desocultar (f, c : integer; var t : Tablero; var libres : ListaPos);
var pos : Posicion;
begin
  if EsPosicionValida(f, c) and (t[f,c].tipo = Libre) then
  begin
    t[f,c].oculto := false;
    if t[f,c].minasAlrededor = 0 then
    begin
      pos.fila := f;
      pos.columna := c;
      AgregarAlFinal(pos, libres);
    end;
  end;
end;
{
Desoculta (ver procedimiento Desocultar) todas las casillas adyacentes a la
Casilla del Tablero t asociada a la fila f y la columna c.
}
procedure DesocultarAdyacentes (f, c : integer; var t : Tablero; var libres : ListaPos);
var j, k : integer;
begin
  for j := f - 1 to f + 1 do
    for k := c - 1 to c + 1 do
      if EsPosicionValida(j, k) and (t[j,k].tipo = Libre) then
        Desocultar(j, k, t, libres);
end;


{
Desoculta (ver procedimiento Desocultar) la Casilla del Tablero t asociada a la 
fila f y la columna c. Si esa casilla está libre y no tiene minas alrededor, 
también se desocultan todas sus casillads adyacentes. Para las casillas adyacentes 
desocultadas se repite el mismo procedimiento de desocultar a sus adyacentes si 
no tienen minas alrededor, y así sucesivamente hasta que no queden más casillas 
adyacentes que cumplan con estas condiciones.
}
procedure DesocultarDesde (f : RangoFilas;  c : RangoColum; var t : Tablero);
var 
    listaCelda, alias:   ListaPos;
Begin
  If t[f,c].tipo = Libre Then
    Begin
      New(listaCelda);
      listaCelda^.pos.fila := f;
      listaCelda^.pos.columna := c;
      listaCelda^.sig := Nil;
      Desocultar(f,c,t,listaCelda);
      If t[f,c].minasAlrededor = 0 Then
        Begin
          alias := listaCelda;
          writeln(alias.pos.fila, alias.pos.columna);
          While alias <> Nil Do
            Begin
              DesocultarAdyacentes(alias^.pos.fila,alias^.pos.columna,t,listaCelda);
              alias := alias^.sig;
              write(alias.pos.fila, alias.pos.columna);
            End;
        End;
    End;
End;

{
Devuelve true si no existe ninguna Casilla en el Tablero t que cumpla con estar 
oculta y ser Libre. En otro caso devuelve false.
}
function EsTableroCompleto(t : Tablero) : boolean;
var completo : boolean;
    i, j : integer;
begin
  completo := true;
  i := 1;
  j := 1;
  while (j <= CANT_COL) and (completo = true) do
  begin
    if(t[i,j].tipo = Libre) and (t[i,j].oculto = true) then
      completo := false;
    i := i + 1;
    if(i > CANT_FIL) then
      begin
        i:= 1;
        j:= j +1;
      end;
  end;
  EsTableroCompleto := completo;
end;
