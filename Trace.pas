unit Trace;

interface
uses Line,Classes,Point,Triangle;

type

   TTrace = record
   var
    lenght:real;
    name:String;
   end;

  CTrace = class
    private
      fLines:TList;
      fDefence:TList;
      fAttack:Tlist;
      traces : array [0..100] of tTrace;
      fTraceCount:integer;
      function isCrossing(line1,line2:CLine):boolean;
      function makeTrace(line:CLine;beginIndex:integer;atrace:tTrace;history:Tlist):boolean;
      function getLenght(p1,p2:CPoint):real;
    public
      constructor create(lines,targets,missiles:TList);
      procedure tracing();
      property lines : TList read fLines;
      property count : integer read fTraceCount;
  end;

implementation

  constructor CTrace.create(lines,targets,missiles:TList);
  begin
    fLines:=Lines;
    fDefence:=targets;
    fAttack:=missiles;
    fTraceCount:=0;
  end;

  procedure CTrace.tracing();
  var
    BeginLines:Tlist;
    BeginLine:Cline;
    i,j,k:integer;
    crossCount:integer;
    myTrace:TTrace;
  begin

    BeginLines:=Tlist.Create;
    for i := 0 to fAttack.Count-1 do
      begin
        for j := 0 to fLines.Count-1 do
          begin
             crossCount:=0;
             BeginLine:=CLine.create(fAttack[i],CLine(fLines[j]).midle);
             for k := 0 to fLines.Count-1 do
               begin
                if isCrossing(BeginLine,CLine(flines[k])) then
                   inc(crossCount);
               end;
             if crossCount < 2 then
              begin
                BeginLines.Add(CLine(fLines[j]));
                myTrace.lenght:=getLenght(CLine(BeginLines[BeginLines.Count-1]).midle,
                                          CPoint(fAttack[i]));
                myTrace.name:=CPoint(fAttack[i]).name+
                              CLine(BeginLines[BeginLines.Count-1]).midle.name;
                makeTrace(CLine(BeginLines[BeginLines.Count-1]),
                          i,
                          myTrace,
                          TList.Create);
              end;
          end;
      end;
  end;

  function CTrace.getLenght(p1,p2:CPoint):real;
   begin
    result:=sqrt(sqr(p1.x-p2.x)+sqr(p1.y-p2.y));
   end;


 {
  функция прокладки пути, возвращает true если удалось дойти до конца.
  входные параметры
  @param line - линия входа в очередной треугольник
  @param beginIndex - номер атакующей точки, необходима для поиска точки конца
  @param atrace - путь, в нем храниться длина пути, а также имена пройденых отрезков
  @param history - история, в которой содержуться линии, через центры которых мы прошли
 }

 function CTrace.makeTrace(line:CLine;beginIndex:integer;atrace:tTrace;history:Tlist):boolean;
 var
  i:integer;
  pass1,pass2:real;
  savelenght:real;
  savename:string;
  neighbors:TList;
  j: Integer;
  flag:boolean;
  tmpLine:Cline;
 begin
   history.Add(line);
   if line.triangles.IndexOf(CAttackPoint(fAttack[beginIndex]).target.triangle)>-1 then   // положительный исход
       begin                                                                             // среди треугольников, к которым принадлежит линия,
          atrace.lenght:=atrace.lenght+getLenght(                                        // есть треугольник, в нутри которого есть точка конца.
                                      CAttackPoint(fAttack[beginIndex]).target,          // расчитываем растояние до конца, добавляем в путь
                                       line.midle);                                      // сохраняем путь в массиве
          atrace.name:=atrace.name+CAttackPoint(fAttack[beginIndex]).target.name;
          traces[count].lenght:=atrace.lenght;
          traces[count].name:=atrace.name;
          inc(fTraceCount);
          result:=true;
          exit;
        end
    else
      begin                                             // если у линии нету треугольника, содержашего точку конца
        for i := 0 to line.triangles.Count-1 do         // то среди треугольников линии
          begin                                         // ищем тот через который еще не прошли
            flag:=false;
            for j := 0 to 2 do
              begin
                tmpLine:=CTriangle(line.triangles[i]).lines[j];
                if not(tmpLine=line) then
                  if history.IndexOf(tmpLine)>0 then   // если среди линий треугольника есть линия в истории
                    begin                              // то мы были в этом треугольнике и туда нам не надо
                      flag:=true;
                      break;
                    end;
              end;

             if not(flag) then                        // если таких линий нету то
              begin                                   /// линии-соседи все отличные от @param line такого треугольника
                neighbors:=TList.Create;
                for j := 0 to 2 do
                  begin
                    tmpLine:=CTriangle(line.triangles[i]).lines[j];
                    if not(tmpLine=line) then
                      neighbors.Add(tmpLine);
                  end;
                  pass1:=getLenght(CLine(neighbors[0]).midle,line.midle);  // формируем новый путь к 1 соседу
                  savelenght:=atrace.lenght;
                  atrace.lenght:=savelenght+pass1;
                  savename:=atrace.name;
                  atrace.name:=savename+CLine(neighbors[0]).midle.name;
                  makeTrace( CLine(neighbors[0]),beginIndex,atrace,history);

                  pass2:=getLenght(CLine(neighbors[1]).midle,line.midle);   // формируем новый путь ко 2 соседу
                  atrace.lenght:=savelenght+pass2;
                  atrace.name:=savename+CLine(neighbors[1]).midle.name;
                  makeTrace( CLine(neighbors[1]),beginIndex,atrace,history);
              end
          end;
      end;
 end;

 {
  функция которая определяет пересекаються ли два отрезка между собой
 }
  function CTrace.isCrossing(line1,line2:CLine):boolean;
    var
      x1,y1,x2,y2,x3,y3,x4,y4:real;
      x,y:real;
      k1,k2:real;
      b1,b2:real;
     procedure swap(var a,b:real);
      var
        c:real;
      begin
        c:=a;
        a:=b;
        b:=c;
      end;
     function isCorrectPoint(x,y:real):boolean;
       begin
          if (y1 > y2) then
             swap(y1,y2);
          if (y3 > y4) then
             swap(y3,y4);
          if (round(x) >= x1)  and  (round(x) <= x2) and
             (round(y) <= y2)  and  (round(y) >= y1) and
             (round(x) >= x3)  and  (round(x) <= x4) and
             (round(y) <= y4)  and  (round(y) >= y3) then
             result:=true
          else
            result:=false;
       end;
    begin
      x1:=line1.A.x; y1:=line1.A.y;
      x2:=line1.B.x; y2:=line1.B.y;
      x3:=line2.A.x; y3:=line2.A.y;
      x4:=line2.B.x; y4:=line2.B.y;
      if not(x1<=x2) then
        begin
          swap(x1,x2); swap(y1,y2);
        end;
      if not(x3<=x4) then
        begin
          swap(x3,x4); swap(y3,y4);
        end;

        if x1=x2 then
          begin
            x:=x1;
            if (x4 = x3) and (x4 <> x1) then
              begin
                result:=false;
                exit;
              end
            else
              begin
                k2 :=( y4 - y3 ) / ( x4 - x3 );
                b2 := y3 - k2 * x3;
                y :=  k2*x + b2;
                result:=isCorrectPoint(x,y);
                exit;
              end
          end
          else
            k1:=( y2 - y1 ) / ( x2 - x1 );

         if x4=x3 then
          begin
           x:=x4;
           if (x2 = x1) and (x4 <> x1) then
              begin
                result:=false;
                exit;
              end
            else
              begin
                k1:=( y2 - y1 ) / ( x2 - x1 );
                b1 := y1 - k1 * x1;
                y :=  k1*x + b1;
                result:=isCorrectPoint(x,y);
                exit;
              end
          end
          else
            k2 :=( y4 - y3 ) / ( x4 - x3 );

          b1 := y1 - k1 * x1;
          b2 := y3 - k2 * x3;

          if not(k1=k2) then
            begin
              x := ( b2 - b1 ) / ( k1 -  k2 );
              y :=  k1*x + b1;
              result:=isCorrectPoint(x,y);
               exit;
            end
          else
            begin
              result:=false;
              exit;
            end;

    end;



end.
