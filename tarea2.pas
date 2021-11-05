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
      begin
        for j := 1 to CANT_COL do
          begin
            t[i,j].oculto := true;
            t[i,j].tipo := Libre(0);
            j := + 1
          end;
          i := i + 1;
      end;
end;

{
Para toda Casilla c del Tablero que es una Mina, c deja de estar oculta
}
procedure DesocultarMinas (var t : Tablero);
var i, j : integer;
begin
  for i := 1 to CANT_FIL do
      begin
        for j := 1 to CANT_COL do
          begin
            if t[i,j].tipo = Mina then t[i,j].oculto := false;
            j := + 1
          end;
        i := i + 1;
      end;
end;
{
Devuelve true si tanto la fila f como la columna c son válidas,
es decir corresponden a una casilla del tablero.
De lo contrario devuelve false.
}
function EsPosicionValida (f, c : integer) : boolean;
var isValidColum, isValidField : boolean;
var i, j : integer;
begin
    for i := 1 to CANT_FIL do
    begin
      if(i <> c) then i := i + 1
      else isValidField := true;
    end;

    for j := 1 to CANT_COL do
    begin
      if(j <> c) then j := j + 1
      else isValidColum := true;
    end;
  end;
  EsPosicionValida := isValidColum and isValidField;
end;

{
Agrega minas al Tablero t en cada una de las casillas c correspondientes a
posiciones contenidas en m, es decir que dichas casillas cambien su tipo a Mina.

Adicionalmente asigna el valor del campo minasAlrededor de las casillas del tablero
que queden libres. Este deberá contener la cantidad de casillas adyacentes que 
son minas.
}
procedure AgregarMinas (m : Minas; var t : Tablero);


{
Si la fila f y columna c corresponden a una Casilla cas válida del Tablero t 
(ver procedimiento EsPosicionValida) y cas es Libre entonces cas deja de estar 
oculta.
Adicionalmente si la Casilla cumple con lo anterior y no tiene minas alrededor 
entonces se agrega la Posicion correspondiente a dicha casilla al final de la 
listaPos libres.
}
procedure Desocultar (f, c : integer; var t : Tablero; var libres : ListaPos);


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
