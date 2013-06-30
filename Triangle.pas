unit Triangle;

interface
uses  Line,Point;

type

  points_type = array [0..2] of CPoint;
  lines_type = array [0..2] of CLine;

  CTriangle = class
    private
      fPoints : points_type;
      fLines  : lines_type;
      fname   : string;
    public
      property points : points_type read fPoints;
      property lines : lines_type read fLines;
      property name : string  read fname;
      constructor create(A,B,C:CPoint);
  end;

implementation


  constructor CTriangle.create(A: CPoint; B: CPoint; C: CPoint);
  begin
    fPoints[0]:=A;     fPoints[1]:=B;       fPoints[2]:=C;
    fLines[0]:=CLine.create(A,B);
    fLines[1]:=CLine.create(B,C);
    fLines[2]:=CLine.create(C,A);
    fname:=A.name+B.name+C.name;
  end;

end.
