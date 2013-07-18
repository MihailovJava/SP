unit DefencePoint;

interface
uses line,point,triangle;

type

 CDefencePoint = class(CPoint)
 private
  ftriangle:CTriangle;
 public
   function isInsideTriangle(triangle:CTriangle):boolean;
   property triangle : CTriangle read ftriangle;
 end;

implementation

{
  Функция опрееляет принадлежит ли точка треугольнику
  на вход подается треугольник, если точка лежит левее всех  его сторон
  то принадлежит
}

function CDefencePoint.isInsideTriangle(triangle:CTriangle):boolean;
  var
    flag:boolean;
  function isTheLeftFromLine(line:CLine):boolean;
    begin
       if (x-line.A.x)*(line.A.y-line.B.y)
                      -(y-line.A.y)*(line.A.x-line.B.x) < 0 then
          result:=true
       else
          result:=false;
    end;

begin
 flag:= isTheLeftFromLine(triangle.lines[0]);
 if  (flag = isTheLeftFromLine(triangle.lines[1])) and
      (flag = isTheLeftFromLine(triangle.lines[2])) then
 begin
      result := true;
      ftriangle := triangle;
 end
 else
      result := false;

end;

end.
