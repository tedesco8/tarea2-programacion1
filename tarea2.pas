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
  EsPosicionValida := ((f > 0) and (f < CANT_FIL)) and ((c > 0) and (c < CANT_COL));
end;

{
Procedimiento propio, modifica el tablero agregandole la cantidad de minas 
alrededor de una casilla.
}
procedure AgregaMinasAlrededor (f, c : integer; var t : Tablero );
var fila, columna : integer;
begin
  for fila := 1 to CANT_FIL do
    for columna := 1 to CANT_COL do
      if (f = fila) AND (c = columna) then
      begin
          if EsPosicionValida(fila + 1, columna) and (t.tipo = Libre) then
                t[fila + 1, columna].minasAlrededor := +1;
          if EsPosicionValida(fila - 1, columna) and (t.tipo = Libre) then
                t[fila - 1, columna].minasAlrededor := +1;
          if EsPosicionValida(fila, columna + 1) and (t.tipo = Libre) then
                t[fila, columna + 1].minasAlrededor := +1;
          if EsPosicionValida(fila, columna - 1) and (t.tipo = Libre) then
                t[fila, columna - 1].minasAlrededor := +1;
          if EsPosicionValida(fila + 1, columna + 1) and (t.tipo = Libre) then
                t[fila + 1, columna + 1].minasAlrededor := +1;
          if EsPosicionValida(fila - 1, columna + 1) and (t.tipo = Libre) then
                t[fila - 1, columna + 1].minasAlrededor := +1;
          if EsPosicionValida(fila - 1, columna - 1) and (t.tipo = Libre) then
                t[fila - 1, columna - 1].minasAlrededor := +1;
          if EsPosicionValida(fila + 1, columna - 1) and (t.tipo = Libre) then
                t[fila + 1, columna - 1].minasAlrededor := +1
      end;
end;

{
Agrega minas al Tablero t en cada una de las casillas c correspondientes a
posiciones contenidas en m, es decir que dichas casillas cambien su tipo a Mina.

Adicionalmente asigna el valor del campo minasAlrededor de las casillas del tablero
que queden libres. Este deberá contener la cantidad de casillas adyacentes que 
son minas.
}
procedure AgregarMinas (m : Minas; var t : Tablero);
var i, fila, columna : integer;
var adyasentesArr : AdyasentesType;
begin
    for i := 1 to m.tope do
      fila := m.elems[i].fila;
      columna = m.elems[i].columna;
      if EsPosicionValida(fila, columna) then 
      begin
          t[fila, columna].tipo := Mina;
          AgregaMinasAlrededor(fila, columna, t);
      end;
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
begin
  if EsPosicionValida(f, c) and (t[f,c].tipo = Libre) then
  begin
    t[f,c].oculto := false;
    if t[f,c].minasAlrededor = 0 then
      //TODO: agregar f,c al final de la lista libres
  end;
end;
{
Desoculta (ver procedimiento Desocultar) todas las casillas adyacentes a la
Casilla del Tablero t asociada a la fila f y la columna c.
}
procedure DesocultarAdyacentes (f, c : integer; var t : Tablero;
                                var libres : ListaPos);


{
Desoculta (ver procedimiento Desocultar) la Casilla del Tablero t asociada a la 
fila f y la columna c. Si esa casilla está libre y no tiene minas alrededor, 
también se desocultan todas sus casillas adyacentes. Para las casillas adyacentes 
desocultadas se repite el mismo procedimiento de desocultar a sus adyacentes si 
no tienen minas alrededor, y así sucesivamente hasta que no queden más casillas 
adyacentes que cumplan con estas condiciones.
}
procedure DesocultarDesde (f : RangoFilas;  c : RangoColum; var t : Tablero);


{
Devuelve true si no existe ninguna Casilla en el Tablero t que cumpla con estar 
oculta y ser Libre. En otro caso devuelve false.
}
function EsTableroCompleto(t : Tablero) : boolean;
var completo : boolean;
begin
  completo = true;
  repeat
    for i := 1 to CANT_FIL do
      for j := 1 to CANT_COL do
        if (t[i,j].oculto = true) and (t[i,j].tipo = Libre) then
          completo = false;
  until (completo = false) or (i = CANT_FIL and j = CANT_COL );
  EsTableroCompleto := completo;
end;
