unit Point;

interface
uses Triangle,classes;

type
  CPoint = class
    protected
      fx:real;
      fy:real;
      fname:String;
    public
     property x: real read fx;
     property y: real read fy;
     property name: String read fname;
     constructor create(ax,ay:Real;aname:string);
  end;

  CDefencePoint = class (CPoint)
    triangle:CTriangle;
    constructor create(ax,ay:Real; aname:string; lines:TList);
  end;

  CAttackPoint = class (CPoint)
    target:CDefencePoint;
    constructor create(ax,ay:Real; aname:string; atarget:CDefencePoint);
  end;


implementation
  uses Line;

  constructor CPoint.create(ax: Real; ay: Real; aname: string);
  begin
    fx:=ax;
    fy:=ay;
    fname:=aname;
  end;

  constructor CAttackPoint.create(ax: Real; ay: Real; aname: string; atarget: CDefencePoint);
  begin
    inherited create(ax,ay,aname);
    target:=atarget;
  end;


  {
    Конструктор защищаемой точки, в котором предусмотрен поиск треугольника
    внутри которого лежит эта точка, и запись ссылки треугольника в точку
  }
  constructor CDefencePoint.create(ax,ay:Real; aname:string; lines:TList);
  var
    triangles:TList;
    currentPoints:Tlist;
    currentPoint:CPoint;
    i,j:integer;
    currentTriangle:CTriangle;
    x1,y1,x2,y2,x3,y3:real;
    a,b,c:real;
  begin
    inherited create(ax,ay,aname);
    triangles:=TList.Create;
    currentPoints:=Tlist.Create;
    for i := 0 to lines.Count-1 do
      begin
        currentTriangle:=CLine(lines[i]).triangles[0];
        if triangles.IndexOf(currentTriangle)=-1 then
           triangles.Add(currentTriangle);
      end;
    for i := 0 to triangles.Count-1 do
      begin
        for j := 0 to 1 do
          begin
            currentPoint:=(CLine(CTriangle(triangles[i]).lines[j]).A);
            if currentPoints.IndexOf(currentPoint)=-1 then
               currentPoints.Add(currentPoint);
            currentPoint:=(CLine(CTriangle(triangles[i]).lines[j]).B);
            if currentPoints.IndexOf(currentPoint)=-1 then
               currentPoints.Add(currentPoint);
          end;

        x1:=CPoint(currentPoints[0]).x;
        y1:=CPoint(currentPoints[0]).y;

        x2:=CPoint(currentPoints[1]).x;
        y2:=CPoint(currentPoints[1]).y;

        x3:=CPoint(currentPoints[2]).x;
        y3:=CPoint(currentPoints[2]).y;

        a:=(x1 - ax) * (y2 - y1) - (x2 - x1) * (y1 - ay); // если точка лежит с одной стороны
        b:=(x2 - ax) * (y3 - y2) - (x3 - x2) * (y2 - ay); // от всех трех сторон треугольника
        c:=(x3 - ax) * (y1 - y3) - (x1 - x3) * (y3 - ay); // то а,b,c будут одного знака

        if ((a > 0) and (b > 0) and (c > 0)) or ((a < 0) and (b < 0) and (c < 0)) then
          triangle:=triangles[i];
        currentPoints.Clear;
      end;
  end;

end.
