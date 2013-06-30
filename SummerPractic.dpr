program SummerPractic;

uses
  Vcl.Forms,
  Form in 'Form.pas' {Form1},
  Point in 'Point.pas',
  Line in 'Line.pas',
  Triangle in 'Triangle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
