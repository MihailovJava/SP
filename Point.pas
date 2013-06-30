unit Point;

interface

type
  CPoint = class
    published
      fx:Real;
      fy:Real;
      fname:String;
    public
     property x: real read fx;
     property y: real read fy;
     property name: String read fname;
     constructor create(ax,ay:Real;aname:string);
  end;

implementation


  constructor CPoint.create(ax: Real; ay: Real; aname: string);
  begin
    fx:=ax;
    fy:=ay;
    fname:=aname;
  end;

end.
