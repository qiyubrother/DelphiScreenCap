unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, jpeg,
  System.DateUtils, VCLTee.TeCanvas, VCLTee.TeePenDlg, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    tmr: TTimer;
    dtInterval: TEdit;
    Label1: TLabel;
    btnStart: TButton;
    btnStop: TButton;
    procedure ScreenCap(LeftPos, TopPos, RightPos, BottomPos: integer);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
begin
  btnStop.Enabled := true;
  btnStart.Enabled := false;
  dtInterval.Enabled := false;
  tmr.Interval := StrToInt(dtInterval.Text);
  tmr.Enabled := true;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  btnStop.Enabled := false;
  btnStart.Enabled := true;
  dtInterval.Enabled := true;
  tmr.Enabled := false;
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
    MyJpeg.SaveToFile(IntToStr(DateTimeToUnix(Now)) + '.JPG');
  finally
    MyJpeg.Free;
    Bitmap.Free;
    DeleteDC(DestDC);
    ReleaseDC(Bhandle, SourceDC);
  end;
end;

procedure TForm1.tmrTimer(Sender: TObject);
begin
  ScreenCap(0, 0, Screen.Width, Screen.Height);
end;

end.
