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
Agrega minas al Tablero t en cada una de las casillas c correspondientes a
posiciones contenidas en m, es decir que dichas casillas cambien su tipo a Mina.

Adicionalmente asigna el valor del campo minasAlrededor de las casillas del tablero
que queden libres. Este deberá contener la cantidad de casillas adyacentes que 
son minas.
}
procedure AgregarMinas (m : Minas; var t : Tablero);
var i, j, k : integer;
begin
    i := 1;
    for j := 1 to CANT_FIL do
      for k := 1 to CANT_COL do
        while (i <= Minas.tope) and (t.elems[j] = m.elems[i.fila] and t.elems[k] = m.elems[i.columna]) do
          i:= i + 1;
          t[i,j].tipo := Mina;
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
// f,c) podes ver la fila anterior (f-1) y la fila posterior (f+1), lo mismo con c-1 y c+1

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
