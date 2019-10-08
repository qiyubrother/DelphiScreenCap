unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, jpeg;

type
  TForm1 = class(TForm)
    btnScreenCap: TButton;
    procedure ScreenCap(LeftPos, TopPos, RightPos, BottomPos: integer);
    procedure btnScreenCapClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnScreenCapClick(Sender: TObject);
begin
  ScreenCap(1, 1, 500, 500);
end;

procedure TForm1.ScreenCap(LeftPos, TopPos, RightPos, BottomPos: integer);
var
  RectWidth, RectHeight: integer;
  SourceDC, DestDC, Bhandle: integer;
  Bitmap: TBitmap;
  MyJpeg: TJpegImage;
  Stream: TMemoryStream;
begin
  MyJpeg := TJpegImage.Create;
  RectWidth := RightPos - LeftPos;
  RectHeight := BottomPos - TopPos;
  SourceDC := CreateDC('DISPLAY', '', '', nil);
  DestDC := CreateCompatibleDC(SourceDC);
  Bhandle := CreateCompatibleBitmap(SourceDC, RectWidth, RectHeight);
  SelectObject(DestDC, Bhandle);
  BitBlt(DestDC, 0, 0, RectWidth, RectHeight, SourceDC, LeftPos,
    TopPos, SRCCOPY);
  Bitmap := TBitmap.Create;
  Bitmap.Handle := Bhandle;
  Stream := TMemoryStream.Create;
  Bitmap.SaveToStream(Stream);
  Stream.Free;
  try
    MyJpeg.Assign(Bitmap);
    MyJpeg.CompressionQuality := 100;
    MyJpeg.Compress;
    MyJpeg.SaveToFile('d:\MyJPEGImage.JPG');
  finally
    MyJpeg.Free;
    Bitmap.Free;
    DeleteDC(DestDC);
    ReleaseDC(Bhandle, SourceDC);
  end;
end;

end.
