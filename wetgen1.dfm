�
 TCLI_TOOL 0  TPF0	Tcli_toolcli_toolLeftZTopGCaption Climate DataClientHeight�ClientWidthZColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoScreenCenter
OnActivateFormActivateOnClose	FormClosePixelsPerInch`
TextHeight TLabelLabel3LeftTopWidthCHeightHint
short nameCaptionclimate stationFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontParentShowHintShowHint	  TPageControlPageControl1Left� Top	Width�Height�
ActivePage	TabSheet1TabOrder  	TTabSheet	TabSheet2Caption	DataTable
ImageIndex TDBGridDBGrid1LeftTopWidth�Height2HintN   NIED:precipitation [mm], LTEM: air temp.[°C]; GLOB:global radiation [J/cm²] 
DataSourceDataSource1ParentShowHint	PopupMenu
PopupMenu1ShowHint	TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style OnMouseDownDBGrid1MouseDown  TDBNavigatorDBNavigator1LeftTop@Width�Height
DataSourceDataSource1TabOrder  	TGroupBox	GroupBox1Left�TopWidth� Height2Captionappend dataTabOrder TLabelLabel5LeftTop WidthfHeightCaptionstation name (3 char.)  TLabelLabel6Left`Top8WidthHeightCaptionyear  TButtonButton7LeftTop� Width� HeightCaptioncreate data setTabOrder OnClickButton7Click  TEditEdit2LeftxTop Width)HeightTabOrderText???  TEditEdit3LeftxTop8Width)HeightTabOrderText2003  TRadioButtonRadioButton1LeftTophWidth� HeightCaption   global radiation in J/cm²Checked	TabOrderTabStop	  TRadioButtonRadioButton2LeftTop� Width� HeightCaptionsun shine duration in h/dTabOrder  	TCheckBox	CheckBox1LeftTop� WidthaHeightCaptionuse generatorTabOrderVisible  TMemoMemo1LeftTop� Width� HeightYLines.StringsPlease use cut and paste mechanism to fill in datafrom other sourcesAttention !This mechanism is working only columnwise! TabOrder   TButtonButton3Left�Top@Width� HeightCaptioncopy to EXCELTabOrderOnClickButton3Click   	TTabSheet	TabSheet1CaptionGraphics TLabelLabel7Left� TopCWidthHeightCaption ColorclBlackParentColor  TRadioGroupelm_grpLeft TopWidth� Height6CaptionElementsTabOrder OnClickelm_grpClick  TDBChartDBChart1Left� TopWidth�Height6Title.Text.StringsTDBChart Legend.VisibleView3D
BevelInner	bvLowered
BevelOuter	bvLoweredColorclWhiteTabOrderDefaultCanvasTGDIPlusCanvasColorPaletteIndex TFastLineSeriesSeries2
DataSource	fdc.wdqryLinePen.ColorDf� XValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedatumYValues.NameYYValues.OrderloNoneYValues.ValueSourcex    	TTabSheet	TabSheet3Caption	Generator
ImageIndex TLabelLabel1Left�TopWidth%HeightCaption	latitude:  TLabelLabel2LeftTopWidth2HeightCaptionWG-Name  TLabelLabel4Left� Top/Width'HeightCaptionProtocol  TEditwgnameLeftHTopWidth9HeightTabOrder Textwgname  TEditEdit1Left�TopWidth1HeightTabOrderText51  TButtonButton1Left� TopWidth� HeightCaption%build wg file from selected data setsTabOrderOnClickButton1Click  TListBoxlbLeft� Top@WidthHeight� 
ItemHeightTabOrder  TPBCheckListBox	wstat_clbLeftTop@WidthyHeight� 
ItemHeightTabOrder  TButtonButton4LeftTop!Width)HeightCaptionallTabOrderOnClickButton4Click  TButtonButton5Left,Top!Width)HeightCaptionnonTabOrderOnClickButton5Click  TButtonButton6LeftVTop!Width&HeightCaptioninvertTabOrderOnClickButton6Click    TButtonButton2LeftTop}Width� HeightCaptionreturnTabOrderOnClickButton2Click  TDBLookupComboBoxDBLookupComboBox1LeftTopWidth� HeightKeyFieldwstat	ListFieldwstatListFieldIndex
ListSourceDataSource2TabOrder	OnCloseUpDBLookupComboBox1CloseUp  TDBGridDBGrid2LeftTop6Width� HeightA
DataSourceDataSource3TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickDBGrid2DblClickColumnsExpanded	FieldNamewidxWidthXVisible	    TDataSourceDataSource1DataSetfdc.htabLeftXTopP  
TPopupMenu
PopupMenu1Left\Top 	TMenuItem
pastedata1Caption
paste dataOnClickpastedata1Click   TDataSourceDataSource2DataSetfdc.wcntOnDataChangeDataSource2DataChangeLeftXTop�   TDataSourceDataSource3DataSetfdc.wyrOnDataChangeDataSource3DataChangeLeftXTop�    