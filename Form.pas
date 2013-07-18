unit Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Point,Line,Triangle,Trace,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   A,B,C,D,E:CPoint;
   Targets:TList;
   Missiles:TList;
   ABC,ACD,BCE,CED:CTriangle;
   Lines:TList;
   w,h:integer;
   TraceMaker:CTrace;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  A:=CPoint.create(0,0,'a');
  B:=CPoint.create(0,40,'b');
  C:=CPoint.create(40,40,'c');
  D:=CPoint.create(40,0,'d');
  E:=CPoint.create(50,50,'e');
  Lines:=TList.create;
  Lines.Add(CLine.create(A,B));    //0
  Lines.Add(CLine.create(B,E));    //1
  Lines.Add(CLine.create(E,D));    //2
  Lines.Add(CLine.create(D,A));    //3
  Lines.Add(CLine.create(C,A));    //4
  Lines.Add(CLine.create(C,B));    //5
  Lines.Add(CLine.create(C,D));    //6
  Lines.Add(CLine.create(C,E));    //7
  ABC:=CTriangle.create(lines[0],lines[5],lines[4]);
  ACD:=CTriangle.create(lines[4],lines[6],lines[3]);
  BCE:=CTriangle.create(lines[5],lines[7],lines[1]);
  CED:=CTriangle.create(lines[7],lines[2],lines[6]);
  Targets:=TList.Create;
  Targets.add(CDefencePoint.create(10,30,'T1',lines));
  Missiles:=TList.Create;
  Missiles.Add(CAttackPoint.create(60,60,'M1',CDefencePoint(Targets[0])));
  TraceMaker:=CTrace.create(lines,targets,missiles);
  TraceMaker.tracing;
end;

end.
