unit Triangle;

interface
type

  lines_type = array [0..2] of pointer;

  CTriangle = class
    private
      fLines  : lines_type;
      fname   : string;
    public
      property lines : lines_type read fLines;
      property name : string  read fname;
      constructor create(AB,BC,CA:pointer);
  end;

implementation
  uses Line;

  constructor CTriangle.create(AB: pointer; BC: pointer; CA: pointer);
  var
    i:integer;
  begin
    fLines[0]:=AB;
    fLines[1]:=BC;
    fLines[2]:=CA;
    CLine(AB).addTriangle(self);
    CLine(BC).addTriangle(self);
    CLine(CA).addTriangle(self);
    for i := 0 to 2 do
      fname:=fname+CLine(flines[i]).name;
  end;



end.
