unit Line;

interface
uses Point,Triangle,classes;
type
   CLine = class (CPoint)
     private
      fA,fB:CPoint;
      fMidle:CPoint;     // указатель на середину
      fTriangles:TList; // список треугольников
     public
      property A:CPoint read fA;
      property B:CPoint read fB;
      property midle:CPoint read fMidle;
      procedure addTriangle(triangle:CTriangle);
      constructor create(aA,aB:CPoint);
      property triangles : TList read fTriangles;
   end;

implementation


  constructor CLine.create(aA: CPoint; aB: CPoint);
  begin
    fname:=aA.name+aB.name;
    fA:=aA;
    fB:=aB;
    fx:=aB.x-aA.x;
    fy:=aB.y-aA.y;
    fMidle:=CPoint.create(aA.x+x/2,aA.y+fy/2,fname+' mid ');
    fTriangles:= Tlist.create;
  end;

  procedure CLine.addTriangle(triangle:CTriangle);
  begin
   if not(triangle = nil) then
     Triangles.add(triangle);
  end;
end.
