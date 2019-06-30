unit RegistrosJSON;
{* RegistrosJSON (HELPER):
 * Unidad dedicada al manejo de los registros JSON de la aplicacion.
 *}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, InitFile, TypInfo, Dialogs;

{TypInfo <- GetEnumName}

function readJSONFile(myfile : string): TJSONData;
function readAPPJSON(): TJSONData;
function jsonIsNull(jData : TJSONData): boolean;
procedure fileSaveString(fileRoute : string; stringTSave : string);
procedure saveJSONbyJSONData(fileRoute : string; jsonToSave : TJSONData);
procedure saveJSONAPP(jsonToSave : TJSONData);
procedure saveDataUserbyId(jData : TJSONObject; userId : integer);
procedure jsonReplace(jsonObject : TJSONObject;keyReplace : string;_value : variant);
procedure jsonReplaceInteger(jsonObject : TJSONObject;keyReplace : string;_value : integer);

implementation

{* IDEA: INVESTIGAR A FONDO QUE ES EL 'TFILEStream'
 *}

{* #ReadFullFile
 * Lee un archivo cualquiera del disco duro
 * @return string | todo el string (texto) que contiene dicho archivo.
 * @param string myfile | la ubicacion del archivo que deseas cargar
 *}

function ReadFullFile(myfile : string): string;
var
tr : string;       //String donde se leera el archivo
fs : TFileStream;  //Instancia del Stremeador de archivo
Begin
   Fs  := TFileStream.Create(myfile, fmOpenRead or fmShareDenyNone);
   SetLength(tr, Fs.Size);
   Fs.Read(tr[1], Fs.Size);
   ReadFullFile := tr;
   Fs.Free;
end;

{* #ReadJSONFile
 * Lee un archivo JSON y retorna un objeto JSON.
 * @return TJSONData | un objecto JSON.
 * @param string myfile | la ubicacion del archivo que deseas cargar
 * @dependencias: ReadFullFile
 *}

function readJSONFile(myfile : string): TJSONData;
var
fileContent : string;   //Contenido del archivo
Begin
  fileContent := ReadFullFile(myfile);
  readJSONFile := GetJSON(fileContent);
end;


{* #readAPPJSON
 * function que lee un archivo JSON y retorna un objeto JSON.
 * @return TJSONData | Objeto JSON.
 * @dependencias: readJSONFile, aPPPath
 *}

function readAPPJSON(): TJSONData;
Begin
  readAPPJSON := readJSONFile(aPPPath + '\data\data.json');
end;

{* #jsonIsNull
 * funcion que te dice si un JSON es nulo o no.
 * @return boolean | ¿lo es? (true), o no lo es (false)
 * @param TJSONData jData, objeto JSON en formato TJSONData
 *}

function jsonIsNull(jData : TJSONData): boolean;
var
  _jsonType: string; //Tipo del Json
  _return: boolean; //Variable que retornare segun si es nulo o no
Begin
  _return := false; //Inicializo por defecto que NO es nulo
{}
  {* Obtengo el tipo de archivo JSON en forma de string con esta function toda
   * rara que vi en internet
   *}
  _jsonType := GetEnumName(TypeInfo(TJSONtype), Ord(jData.JSONType));
  case _jsonType of
     'jtNull' : _return := true;
     'jtObject' : _return := false;//redunda, pero aja
     'jtArray' : _return := false;//redunda, pero aja
  else
    _return := false;//redunda, pero aja
  end;

  jsonIsNull := _return;

end;


{* #saveJSONAPP
 * guarda un objeto JSON en el JSON principal de la aplicacion
 * @param TJSONData jsonToSave | Objeto JSON que deseas guardar
 * @dependencias: saveJSONbyJSONData, aPPPath
 *}

procedure saveJSONAPP(jsonToSave : TJSONData);
Begin
  saveJSONbyJSONData(aPPPath + '\data\data.json',jsonToSave);
end;

{* #saveJSONbyJSONData
 * guarda un objeto JSON en un archivo cualquiera
 * @param string fileRoute | La ruta del archivo a guardar
 * @param TJSONData jsonToSave | Objeto JSON que deseas guardar
 * @dependencias: fileSaveString
 *}

procedure saveJSONbyJSONData(fileRoute : string; jsonToSave : TJSONData);
begin
  fileSaveString(fileRoute,jsonToSave.FormatJSON);
end;

{* #fileSaveString
 * guarda un string en un archivo cualquiera
 * @param string fileRoute | La ruta del archivo a guardar
 * @param string stringTSave | El String a guardar
 *}

procedure fileSaveString(fileRoute : string; stringTSave : string);
var
  fs: TFileStream; //Instancia del Stremeador de archivo
begin
  fs := TFileStream.Create(fileRoute, fmOpenWrite);
  try
    fs.Write(stringTSave[1], Length(stringTSave));
  finally
    fs.Free;
  end;
end;

{* #jsonReplace
 * reemplaza una Key cualquiera en un objeto JSON especificado
 * @param jsonObject jsonObject | el objeto JSON
 * @param string keyReplace | la llave a reemplazar
 * @param variant _value | el nuevo valor
 *}

procedure jsonReplace(jsonObject : TJSONObject;keyReplace : string;_value : variant);
begin
  //Se elimina dicha llave (keyReplace)
  jsonObject.Delete(keyReplace);
  //Se vuelve a crear la llave (keyReplace) con el nuevo valor (_value)
  jsonObject.Add(keyReplace,_value);
end;

{* #jsonReplaceInteger
 * lo mismo que jsonReplace pero esta vez si o si un entero.
 * @param jsonObject jsonObject | el objeto JSON
 * @param string keyReplace | la llave a reemplazar
 * @param integer _value | el nuevo valor
 *
 * JUSTIFICACION:
 * esta funcion nace en base a que jsonReplace lo hacia todo 'string'.
 *}

procedure jsonReplaceInteger(jsonObject : TJSONObject;keyReplace : string;_value : integer);
begin
  jsonObject.Delete(keyReplace);
  jsonObject.Add(keyReplace,_value);
end;

{* #saveDataUserbyId
 * guarda informacion del usuario segun su ID
 * @param TJSONObject jData | el archivo JSON a guardar
 * @param integer userId | el ID del usuario a guardar
 * @dependencias: readAPPJSON, saveJSONAPP
 *}

procedure saveDataUserbyId(jData : TJSONObject; userId : integer);
var
  i:integer; //contador
  jsonData,  //Datos generales (vease el JSON completo) del archivo data.json
  Users,     //JSON con finalidad de arreglo con los usuarios del JSON
  User : TJSONData; //JSON especifico del usuario iterado
begin

  //Leo el archivo data.json
  jsonData := readAPPJSON();

  //Obtengo el arreglo de usuarios
  Users := jsonData.FindPath('usuarios');

  //Itero dicho arreglo
  for i := 0 to Users.Count - 1 do
  begin
      //Obtengo el usuario iterado en este instante
      User := Users.Items[i];
      //Compruebo que la ID del usuario iterado sea igual a la que estoy buscando
      if (TJSONObject(User).get('id') = userId) then begin
         //Se extrae el indice iterado del arreglo de los usuarios
         TJSONArray(Users).Extract(i);
         //Se introduce el nuevo valor (en indice diferente) al arreglo
         TJSONArray(Users).add(jData);
         {* IDEA: Creo que para conservar el INDEX esto se podria poner:
          * Users.add(i,jData), pero no estoy seguro...
          *}
      end;
  end;

  //Guardo los cambios al archivo data.json
  saveJSONAPP(jsonData);

end;

end.
