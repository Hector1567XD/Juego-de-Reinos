unit MessagesHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, InitFile, Dialogs;

procedure MessageSuccess(msgText : String);
procedure MessageWarning(msgText : String);
procedure MessageError(msgText : String);

implementation

procedure MessageError(msgText : String);
begin
  //Si los mensajes estan activados y los mensajes de error tambien...
  if (AppShowMessage and AppShowMessage_E) then begin
     ShowMessage(msgText);
   end;
end;
procedure MessageWarning(msgText : String);
begin
  //Si los mensajes estan activados y los mensajes de warning tambien...
  if (AppShowMessage and AppShowMessage_W) then begin
     ShowMessage(msgText);
   end;
end;
procedure MessageSuccess(msgText : String);
begin
  //Si los mensajes estan activados y los mensajes de felicitaciones tambien...
  if (AppShowMessage and AppShowMessage_S) then begin
     ShowMessage(msgText);
   end;
end;

end.
