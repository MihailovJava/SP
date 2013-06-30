unit Line;

interface
uses Point;
type
  CLine = class(CPoint)
    private
      fA,fB:CPoint;
      fMidle:CPoint;
    public
      property A:CPoint read fA;
      property B:CPoint read fB;
      property midle:CPoint read fMidle;
      constructor create(aA,aB:CPoint);
  end;

implementation


  constructor CLine.create(aA: CPoint; aB: CPoint);
  begin
    fname:=aA.name+aB.name;
    fA:=aA;
    fB:=aB;
    fx:=aB.x-aA.x;
    fy:=aB.y-aA.y;
    fMidle:=CPoint.create(fx/2,fy/2,fname);
  end;

end.
