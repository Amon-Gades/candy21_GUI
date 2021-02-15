unit MapWinGIS_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 17.07.2011 16:39:44 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\daten\MapWinGIS\MapWinGIS.ocx (1)
// LIBID: {C368D713-CC5F-40ED-9F53-F84FE197B96A}
// LCID: 0
// Helpfile: C:\daten\MapWinGIS\MapWinGIS.chm
// HelpString: MapWinGIS Components
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Hint: TypeInfo 'Label' changed to 'Label_'
//   Hint: Parameter 'Object' of _DMap.AddLayer changed to 'Object_'
//   Hint: Member 'Label' of 'ILabels' changed to 'Label_'
//   Hint: Parameter 'Type' of ILabels.ApplyColorScheme changed to 'Type_'
//   Hint: Parameter 'Type' of ILabels.ApplyColorScheme2 changed to 'Type_'
//   Hint: Parameter 'Type' of ILabels.ApplyColorScheme3 changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of IShapefileCategories.ApplyColorScheme changed to 'Type_'
//   Hint: Parameter 'Type' of IShapefileCategories.ApplyColorScheme2 changed to 'Type_'
//   Hint: Parameter 'Type' of IShapefileCategories.ApplyColorScheme3 changed to 'Type_'
//   Hint: Parameter 'Type' of ICharts.Generate changed to 'Type_'
//   Hint: Parameter 'Type' of IUtils.TinToShapefile changed to 'Type_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MapWinGISMajorVersion = 4;
  MapWinGISMinorVersion = 8;

  LIBID_MapWinGIS: TGUID = '{C368D713-CC5F-40ED-9F53-F84FE197B96A}';

  DIID__DMap: TGUID = '{1D077739-E866-46A0-B256-8AECC04F2312}';
  IID_IExtents: TGUID = '{A5692259-035E-487A-8D89-509DD6DD0F64}';
  IID_ILabels: TGUID = '{A73AF37E-3A6A-4532-B48F-FA53309FA117}';
  IID_ICallback: TGUID = '{90E6BBF7-A956-49BE-A5CD-A4640C263AB6}';
  IID_ILabelCategory: TGUID = '{4BB3D2B2-A72D-4538-A092-9E1E69ED6001}';
  IID_ILabel: TGUID = '{4B341A36-CFA6-4421-9D08-FD5B06097307}';
  IID_IColorScheme: TGUID = '{D2334B3C-0779-4F5F-8771-2F857F0D601E}';
  IID_IPoint: TGUID = '{74F07889-1380-43EE-837A-BBB268311005}';
  IID_IShapefile: TGUID = '{5DC72405-C39C-4755-8CFC-9876A89225BC}';
  IID_IShape: TGUID = '{5FA550E3-2044-4034-BAAA-B4CCE90A0C41}';
  IID_IField: TGUID = '{3F3751A5-4CF8-4AC3-AFC2-60DE8B90FC7B}';
  IID_IShapeDrawingOptions: TGUID = '{7399B752-61D9-4A23-973F-1033431DD009}';
  IID_IImage: TGUID = '{79C5F83E-FB53-4189-9EC4-4AC25440D825}';
  IID_IGridColorScheme: TGUID = '{1C43B56D-2065-4953-9138-31AFE8470FF5}';
  IID_IGridColorBreak: TGUID = '{1C6ECF5D-04FA-43C4-97B1-22D5FFB55FBD}';
  IID_IVector: TGUID = '{C60625AB-AD4C-405E-8CA2-62E36E4B3F73}';
  IID_ILinePattern: TGUID = '{54EB7DD1-CEC2-4165-8DBA-13115B079DF1}';
  IID_ILineSegment: TGUID = '{56A5439F-F550-434E-B6C5-0508A6461F47}';
  IID_IShapefileCategories: TGUID = '{EC594CB1-FA55-469C-B662-192F7A464C23}';
  IID_IShapefileCategory: TGUID = '{688EB3FF-CF7A-490C-9BC7-BE47CEB32C59}';
  IID_ICharts: TGUID = '{D98BB982-8D47-47BC-81CA-0EFA15D1B4F6}';
  IID_IChart: TGUID = '{34613D99-DDAB-48CA-AB5D-CAD805E7986C}';
  IID_IChartField: TGUID = '{A9C1AFEB-8CC6-4A36-8E41-E643C1302E6F}';
  IID_ITable: TGUID = '{4365A8A1-2E46-4223-B2DC-65764262D88B}';
  IID_IStopExecution: TGUID = '{52A29829-BB46-4D76-8082-55551E538BDA}';
  DIID__DMapEvents: TGUID = '{ABEA1545-08AB-4D5C-A594-D3017211EA95}';
  IID_IShapefileColorScheme: TGUID = '{FAE1B21A-10C5-4C33-8DC2-931EDC9FBF82}';
  IID_IShapefileColorBreak: TGUID = '{E6D4EB7A-3E8F-45B2-A514-90EF7B2F5C0A}';
  CLASS_Map: TGUID = '{54F4C2F7-ED40-43B7-9D6F-E45965DF7F95}';
  CLASS_ShapefileColorScheme: TGUID = '{A038D3E9-46CB-4F95-A40A-88826BF71BA6}';
  CLASS_ShapefileColorBreak: TGUID = '{700A2AAA-0D28-4943-92EC-08AA9682617A}';
  IID_IGrid: TGUID = '{18DFB64A-9E72-4CBE-AFD6-A5B7421DD0CB}';
  CLASS_Grid: TGUID = '{B4A353E3-D3DF-455C-8E4D-CFC937800820}';
  IID_IGridHeader: TGUID = '{E42814D1-6269-41B1-93C2-AA848F00E459}';
  CLASS_GridHeader: TGUID = '{044AFE79-D3DE-4500-A14B-DECEA635B497}';
  IID_IESRIGridManager: TGUID = '{55B3F2DA-EB09-4FA9-B74B-9A1B3E457318}';
  CLASS_ESRIGridManager: TGUID = '{86E02063-602C-47F2-9778-81E6979E3267}';
  CLASS_Image: TGUID = '{0DB362E3-6F79-4226-AF19-47B67B27E99B}';
  CLASS_Shapefile: TGUID = '{C0EAC9EB-1D02-4BD9-8DAB-4BF922C8CD13}';
  CLASS_Shape: TGUID = '{CE7E6869-6F74-4E9D-9F07-3DCBADAB6299}';
  CLASS_Extents: TGUID = '{03F9B3DB-637B-4544-BF7A-2F190F821F0D}';
  CLASS_Point: TGUID = '{CE63AD29-C5EB-4865-B143-E0AC35ED6FBC}';
  CLASS_Table: TGUID = '{97EFB80F-3638-4BDC-9128-C5A30194C257}';
  CLASS_Field: TGUID = '{C2C71E09-3DEB-4E6C-B54A-D5613986BFFE}';
  IID_IShapeNetwork: TGUID = '{2D4968F2-40D9-4F25-8BE6-B51B959CC1B0}';
  CLASS_ShapeNetwork: TGUID = '{B655545F-1D9C-4D81-A73C-205FC2C3C4AB}';
  IID_IUtils: TGUID = '{360BEC33-7703-4693-B6CA-90FEA22CF1B7}';
  CLASS_Utils: TGUID = '{B898877F-DC9E-4FBF-B997-B65DC97B72E9}';
  IID_ITin: TGUID = '{55DD824E-332E-41CA-B40C-C8DC81EE209C}';
  IID_IGeoProjection: TGUID = '{AED5318E-9E3D-4276-BE03-71EDFEDC0F1F}';
  CLASS_Vector: TGUID = '{D226C4B1-C97C-469D-8CBC-8E3DF2139612}';
  CLASS_GridColorScheme: TGUID = '{ECEB5841-F84E-4DFD-8C96-32216C69C818}';
  CLASS_GridColorBreak: TGUID = '{B82B0EB0-05B6-4FF2-AA16-BCD33FDE6568}';
  CLASS_Tin: TGUID = '{677B1AF6-A28D-4FAB-8A5F-0F8763D88638}';
  CLASS_ShapeDrawingOptions: TGUID = '{58804A7F-2C75-41AF-9D32-5BD08DB1BAF6}';
  CLASS_Labels: TGUID = '{CEA6B369-F2EC-4927-BD8C-F0F6A4066EC6}';
  CLASS_LabelCategory: TGUID = '{92ADD941-94C2-4A57-A058-E9999F21D6BF}';
  CLASS_Label_: TGUID = '{4D745AC7-D623-4F51-BA01-18793FC778A6}';
  CLASS_ShapefileCategories: TGUID = '{1A3B0D02-9265-41B0-84BB-9E09F262FF82}';
  CLASS_ShapefileCategory: TGUID = '{51464A2A-69F7-4CAD-8728-9608580210A3}';
  CLASS_Charts: TGUID = '{1176C871-4C0B-48CF-85B6-926A7948E0F7}';
  CLASS_Chart: TGUID = '{A109A2A1-775F-4FBF-B0C7-F703F8B0BC90}';
  CLASS_ColorScheme: TGUID = '{60409E71-BBB8-491C-A48B-ADA7F383CB6E}';
  CLASS_ChartField: TGUID = '{8C429C40-4F0F-479A-B492-98819424801D}';
  CLASS_LinePattern: TGUID = '{FF695B0C-4977-4D9E-88DD-0DF4FF7082BC}';
  CLASS_LineSegment: TGUID = '{03A98C90-70FF-40C7-AD93-6BF8B41B170F}';
  CLASS_GeoProjection: TGUID = '{B0828DB2-3354-419F-82B0-AC0478DDB00D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum tkCursorMode
type
  tkCursorMode = TOleEnum;
const
  cmZoomIn = $00000000;
  cmZoomOut = $00000001;
  cmPan = $00000002;
  cmSelection = $00000003;
  cmNone = $00000004;

// Constants for enum tkCursor
type
  tkCursor = TOleEnum;
const
  crsrMapDefault = $00000000;
  crsrAppStarting = $00000001;
  crsrArrow = $00000002;
  crsrCross = $00000003;
  crsrHelp = $00000004;
  crsrIBeam = $00000005;
  crsrNo = $00000006;
  crsrSizeAll = $00000007;
  crsrSizeNESW = $00000008;
  crsrSizeNS = $00000009;
  crsrSizeNWSE = $0000000A;
  crsrSizeWE = $0000000B;
  crsrUpArrow = $0000000C;
  crsrWait = $0000000D;
  crsrUserDefined = $0000000E;

// Constants for enum tkLockMode
type
  tkLockMode = TOleEnum;
const
  lmUnlock = $00000000;
  lmLock = $00000001;

// Constants for enum tkShapeDrawingMethod
type
  tkShapeDrawingMethod = TOleEnum;
const
  dmStandard = $00000000;
  dmNewWithSelection = $00000001;
  dmNewWithLabels = $00000002;
  dmNewSymbology = $00000003;

// Constants for enum tkUnitsOfMeasure
type
  tkUnitsOfMeasure = TOleEnum;
const
  umDecimalDegrees = $00000000;
  umMiliMeters = $00000001;
  umCentimeters = $00000002;
  umInches = $00000003;
  umFeets = $00000004;
  umYards = $00000005;
  umMeters = $00000006;
  umMiles = $00000007;
  umKilometers = $00000008;

// Constants for enum tkHJustification
type
  tkHJustification = TOleEnum;
const
  hjLeft = $00000000;
  hjCenter = $00000001;
  hjRight = $00000002;
  hjNone = $00000003;
  hjRaw = $00000004;

// Constants for enum tkDrawReferenceList
type
  tkDrawReferenceList = TOleEnum;
const
  dlScreenReferencedList = $00000000;
  dlSpatiallyReferencedList = $00000001;

// Constants for enum tkLineStipple
type
  tkLineStipple = TOleEnum;
const
  lsNone = $00000000;
  lsDotted = $00000001;
  lsDashed = $00000002;
  lsDashDotDash = $00000003;
  lsDoubleSolid = $00000004;
  lsDoubleSolidPlusDash = $00000005;
  lsTrainTracks = $00000006;
  lsCustom = $00000007;
  lsDashDotDot = $00000008;

// Constants for enum tkFillStipple
type
  tkFillStipple = TOleEnum;
const
  fsNone = $00000000;
  fsVerticalBars = $00000001;
  fsHorizontalBars = $00000002;
  fsDiagonalDownRight = $00000003;
  fsDiagonalDownLeft = $00000004;
  fsPolkaDot = $00000005;
  fsCustom = $00000006;
  fsCross = $00000007;
  fsRaster = $00000008;

// Constants for enum tkPointType
type
  tkPointType = TOleEnum;
const
  ptSquare = $00000000;
  ptCircle = $00000001;
  ptDiamond = $00000002;
  ptTriangleUp = $00000003;
  ptTriangleDown = $00000004;
  ptTriangleLeft = $00000005;
  ptTriangleRight = $00000006;
  ptUserDefined = $00000007;
  ptImageList = $00000008;
  ptFontChar = $00000009;

// Constants for enum tkResizeBehavior
type
  tkResizeBehavior = TOleEnum;
const
  rbClassic = $00000000;
  rbModern = $00000001;
  rbIntuitive = $00000002;
  rbWarp = $00000003;
  rbKeepScale = $00000004;

// Constants for enum tkVerticalPosition
type
  tkVerticalPosition = TOleEnum;
const
  vpAboveParentLayer = $00000000;
  vpAboveAllLayers = $00000001;

// Constants for enum tkLabelAlignment
type
  tkLabelAlignment = TOleEnum;
const
  laTopLeft = $00000000;
  laTopCenter = $00000001;
  laTopRight = $00000002;
  laCenterLeft = $00000003;
  laCenter = $00000004;
  laCenterRight = $00000005;
  laBottomLeft = $00000006;
  laBottomCenter = $00000007;
  laBottomRight = $00000008;

// Constants for enum tkLineLabelOrientation
type
  tkLineLabelOrientation = TOleEnum;
const
  lorHorizontal = $00000000;
  lorParallel = $00000001;
  lorPerpindicular = $00000002;

// Constants for enum tkLinearGradientMode
type
  tkLinearGradientMode = TOleEnum;
const
  gmHorizontal = $00000000;
  gmVertical = $00000001;
  gmForwardDiagonal = $00000002;
  gmBackwardDiagonal = $00000003;
  gmNone = $00000004;

// Constants for enum tkLabelFrameType
type
  tkLabelFrameType = TOleEnum;
const
  lfRectangle = $00000000;
  lfRoundedRectangle = $00000001;
  lfPointedRectangle = $00000002;

// Constants for enum tkDashStyle
type
  tkDashStyle = TOleEnum;
const
  dsSolid = $00000000;
  dsDash = $00000001;
  dsDot = $00000002;
  dsDashDot = $00000003;
  dsDashDotDot = $00000004;
  dsCustom = $00000005;

// Constants for enum SelectMode
type
  SelectMode = TOleEnum;
const
  INTERSECTION = $00000000;
  INCLUSION = $00000001;

// Constants for enum tkClassificationType
type
  tkClassificationType = TOleEnum;
const
  ctNaturalBreaks = $00000000;
  ctUniqueValues = $00000001;
  ctEqualIntervals = $00000002;
  ctEqualCount = $00000003;
  ctStandardDeviation = $00000004;
  ctEqualSumOfValues = $00000005;

// Constants for enum tkColorSchemeType
type
  tkColorSchemeType = TOleEnum;
const
  ctSchemeRandom = $00000000;
  ctSchemeGraduated = $00000001;

// Constants for enum tkMapColor
type
  tkMapColor = TOleEnum;
const
  AliceBlue = $FFF0F8FF;
  AntiqueWhite = $FFFAEBD7;
  Aqua = $FF00FFFF;
  Aquamarine = $FF7FFFD4;
  Azure = $FFF0FFFF;
  Beige = $FFF5F5DC;
  Bisque = $FFFFE4C4;
  Black = $FF000000;
  BlanchedAlmond = $FFFFEBCD;
  Blue = $FF0000FF;
  BlueViolet = $FF8A2BE2;
  Brown = $FFA52A2A;
  BurlyWood = $FFDEB887;
  CadetBlue = $FF5F9EA0;
  Chartreuse = $FF7FFF00;
  Chocolate = $FFD2691E;
  Coral = $FFFF7F50;
  CornflowerBlue = $FF6495ED;
  Cornsilk = $FFFFF8DC;
  Crimson = $FFDC143C;
  Cyan = $FF00FFFF;
  DarkBlue = $FF00008B;
  DarkCyan = $FF008B8B;
  DarkGoldenrod = $FFB8860B;
  DarkGray = $FFA9A9A9;
  DarkGreen = $FF006400;
  DarkKhaki = $FFBDB76B;
  DarkMagenta = $FF8B008B;
  DarkOliveGreen = $FF556B2F;
  DarkOrange = $FFFF8C00;
  DarkOrchid = $FF9932CC;
  DarkRed = $FF8B0000;
  DarkSalmon = $FFE9967A;
  DarkSeaGreen = $FF8FBC8B;
  DarkSlateBlue = $FF483D8B;
  DarkSlateGray = $FF2F4F4F;
  DarkTurquoise = $FF00CED1;
  DarkViolet = $FF9400D3;
  DeepPink = $FFFF1493;
  DeepSkyBlue = $FF00BFFF;
  DimGray = $FF696969;
  DodgerBlue = $FF1E90FF;
  Firebrick = $FFB22222;
  FloralWhite = $FFFFFAF0;
  ForestGreen = $FF228B22;
  Fuchsia = $FFFF00FF;
  Gainsboro = $FFDCDCDC;
  GhostWhite = $FFF8F8FF;
  Gold = $FFFFD700;
  Goldenrod = $FFDAA520;
  Gray = $FF808080;
  Green = $FF008000;
  GreenYellow = $FFADFF2F;
  Honeydew = $FFF0FFF0;
  HotPink = $FFFF69B4;
  IndianRed = $FFCD5C5C;
  Indigo = $FF4B0082;
  Ivory = $FFFFFFF0;
  Khaki = $FFF0E68C;
  Lavender = $FFE6E6FA;
  LavenderBlush = $FFFFF0F5;
  LawnGreen = $FF7CFC00;
  LemonChiffon = $FFFFFACD;
  LightBlue = $FFADD8E6;
  LightCoral = $FFF08080;
  LightCyan = $FFE0FFFF;
  LightGoldenrodYellow = $FFFAFAD2;
  LightGray = $FFD3D3D3;
  LightGreen = $FF90EE90;
  LightPink = $FFFFB6C1;
  LightSalmon = $FFFFA07A;
  LightSeaGreen = $FF20B2AA;
  LightSkyBlue = $FF87CEFA;
  LightSlateGray = $FF778899;
  LightSteelBlue = $FFB0C4DE;
  LightYellow = $FFFFFFE0;
  Lime = $FF00FF00;
  LimeGreen = $FF32CD32;
  Linen = $FFFAF0E6;
  Magenta = $FFFF00FF;
  Maroon = $FF800000;
  MediumAquamarine = $FF66CDAA;
  MediumBlue = $FF0000CD;
  MediumOrchid = $FFBA55D3;
  MediumPurple = $FF9370DB;
  MediumSeaGreen = $FF3CB371;
  MediumSlateBlue = $FF7B68EE;
  MediumSpringGreen = $FF00FA9A;
  MediumTurquoise = $FF48D1CC;
  MediumVioletRed = $FFC71585;
  MidnightBlue = $FF191970;
  MintCream = $FFF5FFFA;
  MistyRose = $FFFFE4E1;
  Moccasin = $FFFFE4B5;
  NavajoWhite = $FFFFDEAD;
  Navy = $FF000080;
  OldLace = $FFFDF5E6;
  Olive = $FF808000;
  OliveDrab = $FF6B8E23;
  Orange = $FFFFA500;
  OrangeRed = $FFFF4500;
  Orchid = $FFDA70D6;
  PaleGoldenrod = $FFEEE8AA;
  PaleGreen = $FF98FB98;
  PaleTurquoise = $FFAFEEEE;
  PaleVioletRed = $FFDB7093;
  PapayaWhip = $FFFFEFD5;
  PeachPuff = $FFFFDAB9;
  Peru = $FFCD853F;
  Pink = $FFFFC0CB;
  Plum = $FFDDA0DD;
  PowderBlue = $FFB0E0E6;
  Purple = $FF800080;
  Red = $FFFF0000;
  RosyBrown = $FFBC8F8F;
  RoyalBlue = $FF4169E1;
  SaddleBrown = $FF8B4513;
  Salmon = $FFFA8072;
  SandyBrown = $FFF4A460;
  SeaGreen = $FF2E8B57;
  SeaShell = $FFFFF5EE;
  Sienna = $FFA0522D;
  Silver = $FFC0C0C0;
  SkyBlue = $FF87CEEB;
  SlateBlue = $FF6A5ACD;
  SlateGray = $FF708090;
  Snow = $FFFFFAFA;
  SpringGreen = $FF00FF7F;
  SteelBlue = $FF4682B4;
  Tan = $FFD2B48C;
  Teal = $FF008080;
  Thistle = $FFD8BFD8;
  Tomato = $FFFF6347;
  Transparent = $00FFFFFF;
  Turquoise = $FF40E0D0;
  Violet = $FFEE82EE;
  Wheat = $FFF5DEB3;
  White = $FFFFFFFF;
  WhiteSmoke = $FFF5F5F5;
  Yellow = $FFFFFF00;
  YellowGreen = $FF9ACD32;

// Constants for enum PredefinedColorScheme
type
  PredefinedColorScheme = TOleEnum;
const
  FallLeaves = $00000000;
  SummerMountains = $00000001;
  Desert = $00000002;
  Glaciers = $00000003;
  Meadow = $00000004;
  ValleyFires = $00000005;
  DeadSea = $00000006;
  Highway1 = $00000007;

// Constants for enum tkLabelElements
type
  tkLabelElements = TOleEnum;
const
  leFont = $00000000;
  leFontOutline = $00000001;
  leShadow = $00000002;
  leHalo = $00000003;
  leFrameBackground = $00000004;
  leFrameOutline = $00000005;
  leDefault = $00000006;

// Constants for enum tkLabelPositioning
type
  tkLabelPositioning = TOleEnum;
const
  lpCenter = $00000000;
  lpCentroid = $00000001;
  lpInteriorPoint = $00000002;
  lpFirstSegment = $00000003;
  lpLastSegment = $00000004;
  lpMiddleSegment = $00000005;
  lpLongestSegement = $00000006;
  lpNone = $00000007;

// Constants for enum tkSavingMode
type
  tkSavingMode = TOleEnum;
const
  modeNone = $00000000;
  modeStandard = $00000001;
  modeXML = $00000002;
  modeDBF = $00000003;
  modeXMLOverwrite = $00000004;

// Constants for enum ShpfileType
type
  ShpfileType = TOleEnum;
const
  SHP_NULLSHAPE = $00000000;
  SHP_POINT = $00000001;
  SHP_POLYLINE = $00000003;
  SHP_POLYGON = $00000005;
  SHP_MULTIPOINT = $00000008;
  SHP_POINTZ = $0000000B;
  SHP_POLYLINEZ = $0000000D;
  SHP_POLYGONZ = $0000000F;
  SHP_MULTIPOINTZ = $00000012;
  SHP_POINTM = $00000015;
  SHP_POLYLINEM = $00000017;
  SHP_POLYGONM = $00000019;
  SHP_MULTIPOINTM = $0000001C;
  SHP_MULTIPATCH = $0000001F;

// Constants for enum tkSpatialRelation
type
  tkSpatialRelation = TOleEnum;
const
  srContains = $00000000;
  srCrosses = $00000001;
  srDisjoint = $00000002;
  srEquals = $00000003;
  srIntersects = $00000004;
  srOverlaps = $00000005;
  srTouches = $00000006;
  srWithin = $00000007;

// Constants for enum tkClipOperation
type
  tkClipOperation = TOleEnum;
const
  clDifference = $00000000;
  clIntersection = $00000001;
  clSymDifference = $00000002;
  clUnion = $00000003;
  clClip = $00000004;

// Constants for enum FieldType
type
  FieldType = TOleEnum;
const
  STRING_FIELD = $00000000;
  INTEGER_FIELD = $00000001;
  DOUBLE_FIELD = $00000002;

// Constants for enum tkVectorDrawingMode
type
  tkVectorDrawingMode = TOleEnum;
const
  vdmGDI = $00000000;
  vdmGDIMixed = $00000001;
  vdmGDIPlus = $00000002;

// Constants for enum tkGDIPlusHatchStyle
type
  tkGDIPlusHatchStyle = TOleEnum;
const
  hsNone = $FFFFFFFF;
  hsMin = $00000000;
  hsHorizontal = $00000000;
  hsVertical = $00000001;
  hsForwardDiagonal = $00000002;
  hsBackwardDiagonal = $00000003;
  hsMax = $00000004;
  hsCross = $00000004;
  hsLargeGrid = $00000004;
  hsDiagonalCross = $00000005;
  hsPercent05 = $00000006;
  hsPercent10 = $00000007;
  hsPercent20 = $00000008;
  hsPercent25 = $00000009;
  hsPercent30 = $0000000A;
  hsPercent40 = $0000000B;
  hsPercent50 = $0000000C;
  hsPercent60 = $0000000D;
  hsPercent70 = $0000000E;
  hsPercent75 = $0000000F;
  hsPercent80 = $00000010;
  hsPercent90 = $00000011;
  hsLightDownwardDiagonal = $00000012;
  hsLightUpwardDiagonal = $00000013;
  hsDarkDownwardDiagonal = $00000014;
  hsDarkUpwardDiagonal = $00000015;
  hsWideDownwardDiagonal = $00000016;
  hsWideUpwardDiagonal = $00000017;
  hsLightVertical = $00000018;
  hsLightHorizontal = $00000019;
  hsNarrowVertical = $0000001A;
  hsNarrowHorizontal = $0000001B;
  hsDarkVertical = $0000001C;
  hsDarkHorizontal = $0000001D;
  hsDashedDownwardDiagonal = $0000001E;
  hsDashedUpwardDiagonal = $0000001F;
  hsDashedHorizontal = $00000020;
  hsDashedVertical = $00000021;
  hsSmallConfetti = $00000022;
  hsLargeConfetti = $00000023;
  hsZigZag = $00000024;
  hsWave = $00000025;
  hsDiagonalBrick = $00000026;
  hsHorizontalBrick = $00000027;
  hsWeave = $00000028;
  hsPlaid = $00000029;
  hsDivot = $0000002A;
  hsDottedGrid = $0000002B;
  hsDottedDiamond = $0000002C;
  hsShingle = $0000002D;
  hsTrellis = $0000002E;
  hsSphere = $0000002F;
  hsSmallGrid = $00000030;
  hsSmallCheckerBoard = $00000031;
  hsLargeCheckerBoard = $00000032;
  hsOutlinedDiamond = $00000033;
  hsSolidDiamond = $00000034;

// Constants for enum tkPointShapeType
type
  tkPointShapeType = TOleEnum;
const
  ptShapeRegular = $00000000;
  ptShapeCross = $00000001;
  ptShapeStar = $00000002;
  ptShapeCircle = $00000003;
  ptShapeArrow = $00000004;
  ptShapeFlag = $00000005;

// Constants for enum ImageType
type
  ImageType = TOleEnum;
const
  BITMAP_FILE = $00000000;
  GIF_FILE = $00000001;
  USE_FILE_EXTENSION = $00000002;
  TIFF_FILE = $00000003;
  JPEG_FILE = $00000004;
  PNG_FILE = $00000005;
  PPM_FILE = $00000007;
  ECW_FILE = $00000008;
  JPEG2000_FILE = $00000009;
  SID_FILE = $0000000A;
  PNM_FILE = $0000000B;
  PGM_FILE = $0000000C;
  BIL_FILE = $0000000D;
  ADF_FILE = $0000000E;
  GRD_FILE = $0000000F;
  IMG_FILE = $00000010;
  ASC_FILE = $00000011;
  BT_FILE = $00000012;
  MAP_FILE = $00000013;
  LF2_FILE = $00000014;
  KAP_FILE = $00000015;
  DEM_FILE = $00000016;

// Constants for enum ColoringType
type
  ColoringType = TOleEnum;
const
  Hillshade = $00000000;
  Gradient = $00000001;
  Random = $00000002;

// Constants for enum GradientModel
type
  GradientModel = TOleEnum;
const
  Logorithmic = $00000000;
  Linear = $00000001;
  Exponential = $00000002;

// Constants for enum tkGDALResamplingMethod
type
  tkGDALResamplingMethod = TOleEnum;
const
  grmNone = $00000000;
  grmNearest = $00000001;
  grmGauss = $00000002;
  grmBicubic = $00000003;
  grmAverage = $00000004;

// Constants for enum tkInterpolationMode
type
  tkInterpolationMode = TOleEnum;
const
  imBilinear = $00000003;
  imBicubic = $00000004;
  imNone = $00000005;
  imHighQualityBilinear = $00000006;
  imHighQualityBicubic = $00000007;

// Constants for enum tkImageSourceType
type
  tkImageSourceType = TOleEnum;
const
  istUninitialized = $00000000;
  istDiskBased = $00000001;
  istInMemory = $00000002;
  istGDALBased = $00000003;

// Constants for enum tkFillType
type
  tkFillType = TOleEnum;
const
  ftStandard = $00000000;
  ftHatch = $00000001;
  ftGradient = $00000002;
  ftPicture = $00000003;

// Constants for enum tkGradientType
type
  tkGradientType = TOleEnum;
const
  gtLinear = $00000000;
  gtRectangular = $00000001;
  gtCircle = $00000002;

// Constants for enum tkPointSymbolType
type
  tkPointSymbolType = TOleEnum;
const
  ptSymbolStandard = $00000000;
  ptSymbolFontCharacter = $00000001;
  ptSymbolPicture = $00000002;

// Constants for enum tkGradientBounds
type
  tkGradientBounds = TOleEnum;
const
  gbWholeLayer = $00000000;
  gbPerShape = $00000001;

// Constants for enum tkVertexType
type
  tkVertexType = TOleEnum;
const
  vtSquare = $00000000;
  vtCircle = $00000001;

// Constants for enum tkLineType
type
  tkLineType = TOleEnum;
const
  lltSimple = $00000000;
  lltMarker = $00000001;

// Constants for enum tkDefaultPointSymbol
type
  tkDefaultPointSymbol = TOleEnum;
const
  dpsSquare = $00000000;
  dpsCircle = $00000001;
  dpsDiamond = $00000002;
  dpsTriangleUp = $00000003;
  dpsTriangleDown = $00000004;
  dpsTriangleLeft = $00000005;
  dpsTriangleRight = $00000006;
  dpsCross = $00000007;
  dpsXCross = $00000008;
  dpsStar = $00000009;
  dpsPentagon = $0000000A;
  dpsArrowUp = $0000000B;
  dpsArrowDown = $0000000C;
  dpsArrowLeft = $0000000D;
  dpsArrowRight = $0000000E;
  dpsAsterisk = $0000000F;
  dpsFlag = $00000010;

// Constants for enum tkShapeElements
type
  tkShapeElements = TOleEnum;
const
  shElementDefault = $00000000;
  shElementFill = $00000001;
  shElementFill2 = $00000002;
  shElementLines = $00000003;
  shElementFillBackground = $00000004;

// Constants for enum tkGroupOperation
type
  tkGroupOperation = TOleEnum;
const
  operMin = $00000000;
  operMax = $00000001;
  operCount = $00000002;
  operSum = $00000003;
  operAverage = $00000004;

// Constants for enum tkChartType
type
  tkChartType = TOleEnum;
const
  chtBarChart = $00000000;
  chtPieChart = $00000001;

// Constants for enum tkChartValuesStyle
type
  tkChartValuesStyle = TOleEnum;
const
  vsHorizontal = $00000000;
  vsVertical = $00000001;

// Constants for enum tkValueType
type
  tkValueType = TOleEnum;
const
  vtDouble = $00000000;
  vtString = $00000001;
  vtBoolean = $00000002;

// Constants for enum tkShapefileSourceType
type
  tkShapefileSourceType = TOleEnum;
const
  sstUninitialized = $00000000;
  sstDiskBased = $00000001;
  sstInMemory = $00000002;

// Constants for enum tkGeometryEngine
type
  tkGeometryEngine = TOleEnum;
const
  engineGeos = $00000000;
  engineClipper = $00000001;

// Constants for enum tkSelectionAppearance
type
  tkSelectionAppearance = TOleEnum;
const
  saSelectionColor = $00000000;
  saDrawingOptions = $00000001;

// Constants for enum tkCollisionMode
type
  tkCollisionMode = TOleEnum;
const
  AllowCollisions = $00000000;
  LocalList = $00000001;
  GlobalList = $00000002;

// Constants for enum GridDataType
type
  GridDataType = TOleEnum;
const
  ShortDataType = $00000000;
  LongDataType = $00000001;
  FloatDataType = $00000002;
  DoubleDataType = $00000003;
  InvalidDataType = $FFFFFFFF;
  UnknownDataType = $00000004;
  ByteDataType = $00000005;

// Constants for enum GridFileType
type
  GridFileType = TOleEnum;
const
  Ascii = $00000000;
  Binary = $00000001;
  Esri = $00000002;
  GeoTiff = $00000003;
  Sdts = $00000004;
  PAux = $00000005;
  PCIDsk = $00000006;
  DTed = $00000007;
  Bil = $00000008;
  Ecw = $00000009;
  MrSid = $0000000A;
  Flt = $0000000B;
  Dem = $0000000C;
  UseExtension = $0000000D;
  InvalidGridFileType = $FFFFFFFF;

// Constants for enum AmbiguityResolution
type
  AmbiguityResolution = TOleEnum;
const
  Z_VALUE = $00000000;
  DISTANCE_TO_OUTLET = $00000001;
  NO_RESOLUTION = $00000002;

// Constants for enum PolygonOperation
type
  PolygonOperation = TOleEnum;
const
  DIFFERENCE_OPERATION = $00000000;
  INTERSECTION_OPERATION = $00000001;
  EXCLUSIVEOR_OPERATION = $00000002;
  UNION_OPERATION = $00000003;

// Constants for enum SplitMethod
type
  SplitMethod = TOleEnum;
const
  InscribedRadius = $00000000;
  AngleDeviation = $00000001;

// Constants for enum tkCoordinateSystem
type
  tkCoordinateSystem = TOleEnum;
const
  csWGS84 = $00000000;
  csNAD83 = $00000001;

// Constants for enum tkProjectionParameter
type
  tkProjectionParameter = TOleEnum;
const
  parmLatitudeOfOrigin = $00000000;
  parmCentralMeridian = $00000001;
  parmScaleFactor = $00000002;
  parmFalseEasting = $00000003;
  parmFalseNorthing = $00000004;
  parmLongitudeOfOrigin = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DMap = dispinterface;
  IExtents = interface;
  IExtentsDisp = dispinterface;
  ILabels = interface;
  ILabelsDisp = dispinterface;
  ICallback = interface;
  ICallbackDisp = dispinterface;
  ILabelCategory = interface;
  ILabelCategoryDisp = dispinterface;
  ILabel = interface;
  ILabelDisp = dispinterface;
  IColorScheme = interface;
  IColorSchemeDisp = dispinterface;
  IPoint = interface;
  IPointDisp = dispinterface;
  IShapefile = interface;
  IShapefileDisp = dispinterface;
  IShape = interface;
  IShapeDisp = dispinterface;
  IField = interface;
  IFieldDisp = dispinterface;
  IShapeDrawingOptions = interface;
  IShapeDrawingOptionsDisp = dispinterface;
  IImage = interface;
  IImageDisp = dispinterface;
  IGridColorScheme = interface;
  IGridColorSchemeDisp = dispinterface;
  IGridColorBreak = interface;
  IGridColorBreakDisp = dispinterface;
  IVector = interface;
  IVectorDisp = dispinterface;
  ILinePattern = interface;
  ILinePatternDisp = dispinterface;
  ILineSegment = interface;
  ILineSegmentDisp = dispinterface;
  IShapefileCategories = interface;
  IShapefileCategoriesDisp = dispinterface;
  IShapefileCategory = interface;
  IShapefileCategoryDisp = dispinterface;
  ICharts = interface;
  IChartsDisp = dispinterface;
  IChart = interface;
  IChartDisp = dispinterface;
  IChartField = interface;
  IChartFieldDisp = dispinterface;
  ITable = interface;
  ITableDisp = dispinterface;
  IStopExecution = interface;
  IStopExecutionDisp = dispinterface;
  _DMapEvents = dispinterface;
  IShapefileColorScheme = interface;
  IShapefileColorSchemeDisp = dispinterface;
  IShapefileColorBreak = interface;
  IShapefileColorBreakDisp = dispinterface;
  IGrid = interface;
  IGridDisp = dispinterface;
  IGridHeader = interface;
  IGridHeaderDisp = dispinterface;
  IESRIGridManager = interface;
  IESRIGridManagerDisp = dispinterface;
  IShapeNetwork = interface;
  IShapeNetworkDisp = dispinterface;
  IUtils = interface;
  IUtilsDisp = dispinterface;
  ITin = interface;
  ITinDisp = dispinterface;
  IGeoProjection = interface;
  IGeoProjectionDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Map = _DMap;
  ShapefileColorScheme = IShapefileColorScheme;
  ShapefileColorBreak = IShapefileColorBreak;
  Grid = IGrid;
  GridHeader = IGridHeader;
  ESRIGridManager = IESRIGridManager;
  Image = IImage;
  Shapefile = IShapefile;
  Shape = IShape;
  Extents = IExtents;
  Point = IPoint;
  Table = ITable;
  Field = IField;
  ShapeNetwork = IShapeNetwork;
  Utils = IUtils;
  Vector = IVector;
  GridColorScheme = IGridColorScheme;
  GridColorBreak = IGridColorBreak;
  Tin = ITin;
  ShapeDrawingOptions = IShapeDrawingOptions;
  Labels = ILabels;
  LabelCategory = ILabelCategory;
  Label_ = ILabel;
  ShapefileCategories = IShapefileCategories;
  ShapefileCategory = IShapefileCategory;
  Charts = ICharts;
  Chart = IChart;
  ColorScheme = IColorScheme;
  ChartField = IChartField;
  LinePattern = ILinePattern;
  LineSegment = ILineSegment;
  GeoProjection = IGeoProjection;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PDouble1 = ^Double; {*}
  PWideString1 = ^WideString; {*}
  PSYSINT1 = ^SYSINT; {*}
  PPSYSINT1 = ^PSYSINT1; {*}
  PWordBool1 = ^WordBool; {*}


// *********************************************************************//
// DispIntf:  _DMap
// Flags:     (4112) Hidden Dispatchable
// GUID:      {1D077739-E866-46A0-B256-8AECC04F2312}
// *********************************************************************//
  _DMap = dispinterface
    ['{1D077739-E866-46A0-B256-8AECC04F2312}']
    property ShapeLayerFillColor[LayerHandle: Integer]: OLE_COLOR dispid 58;
    property LayerVisible[LayerHandle: Integer]: WordBool dispid 57;
    property LayerPosition[LayerHandle: Integer]: Integer readonly dispid 55;
    function MoveLayer(InitialPosition: Integer; TargetPosition: Integer): WordBool; dispid 27;
    procedure Resize(Width: Integer; Height: Integer); dispid 43;
    property LayerHandle[LayerPosition: Integer]: Integer readonly dispid 56;
    property ShapeLayerLineColor[LayerHandle: Integer]: OLE_COLOR dispid 60;
    property ShapeFillColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR dispid 59;
    property ShapeLineColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR dispid 61;
    function MoveLayerDown(InitialPosition: Integer): WordBool; dispid 26;
    procedure ZoomToLayer(LayerHandle: Integer); dispid 31;
    procedure RemoveLayerWithoutClosing(LayerHandle: Integer); dispid 138;
    procedure RemoveAllLayers; dispid 24;
    function SnapShot(const BoundBox: IDispatch): IDispatch; dispid 40;
    procedure ClearDrawing(DrawHandle: Integer); dispid 38;
    procedure ClearDrawings; dispid 39;
    procedure RemoveLayer(LayerHandle: Integer); dispid 23;
    function MoveLayerBottom(InitialPosition: Integer): WordBool; dispid 29;
    procedure ZoomToMaxExtents; dispid 30;
    function MoveLayerTop(InitialPosition: Integer): WordBool; dispid 28;
    procedure Redraw; dispid 21;
    function AddLayer(const Object_: IDispatch; Visible: WordBool): Integer; dispid 22;
    function MoveLayerUp(InitialPosition: Integer): WordBool; dispid 25;
    property LayerKey[LayerHandle: Integer]: WideString dispid 54;
    property ShapeLayerStippleTransparent[LayerHandle: Integer]: WordBool dispid 147;
    function AdjustLayerExtents(LayerHandle: Integer): WordBool; dispid 150;
    property DrawingLabels[DrawingLayerIndex: Integer]: ILabels dispid 157;
    property TrapRMouseDown: WordBool dispid 148;
    property ShapeStippleTransparent[LayerHandle: Integer; Shape: Integer]: WordBool dispid 146;
    procedure DrawWideCircleEx(LayerHandle: Integer; x: Double; y: Double; radius: Double; 
                               Color: OLE_COLOR; fill: WordBool; OutlineWidth: Smallint); dispid 160;
    procedure DrawPolygonEx(LayerHandle: Integer; var xPoints: OleVariant; var yPoints: OleVariant; 
                            numPoints: Integer; Color: OLE_COLOR; fill: WordBool); dispid 155;
    function SnapShotToDC(var hdc: {??Pointer}OleVariant; const Extents: IExtents; Width: Integer): WordBool; dispid 159;
    procedure DrawWidePolygonEx(LayerHandle: Integer; var xPoints: OleVariant; 
                                var yPoints: OleVariant; numPoints: Integer; Color: OLE_COLOR; 
                                fill: WordBool; OutlineWidth: Smallint); dispid 161;
    function SnapShot3(left: Double; right: Double; top: Double; bottom: Double; Width: Integer): IDispatch; dispid 153;
    property DisableWaitCursor: WordBool dispid 149;
    procedure ShowToolTip(const Text: WideString; Milliseconds: Integer); dispid 44;
    procedure AddLabel(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; x: Double; 
                       y: Double; hJustification: tkHJustification); dispid 45;
    function NewDrawing(Projection: tkDrawReferenceList): Integer; dispid 49;
    procedure LayerFont(LayerHandle: Integer; const FontName: WideString; FontSize: Integer); dispid 47;
    function GetColorScheme(LayerHandle: Integer): IDispatch; dispid 48;
    procedure ClearLabels(LayerHandle: Integer); dispid 46;
    procedure DrawPolygon(var xPoints: OleVariant; var yPoints: OleVariant; numPoints: Integer; 
                          Color: OLE_COLOR; fill: WordBool); dispid 53;
    procedure DrawLine(x1: Double; y1: Double; x2: Double; y2: Double; pixelWidth: Integer; 
                       Color: OLE_COLOR); dispid 51;
    procedure DrawCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; fill: WordBool); dispid 52;
    procedure DrawPoint(x: Double; y: Double; pixelSize: Integer; Color: OLE_COLOR); dispid 50;
    property ShapeLayerDrawFill[LayerHandle: Integer]: WordBool dispid 64;
    property ShapeLayerDrawLine[LayerHandle: Integer]: WordBool dispid 66;
    property ShapeLayerPointColor[LayerHandle: Integer]: OLE_COLOR dispid 62;
    property ShapeDrawFill[LayerHandle: Integer; Shape: Integer]: WordBool dispid 65;
    property ImageLayerPercentTransparent[LayerHandle: Integer]: Single dispid 81;
    property ShapeVisible[LayerHandle: Integer; Shape: Integer]: WordBool dispid 80;
    property ShapePointSize[LayerHandle: Integer; Shape: Integer]: Single dispid 73;
    property ShapePointColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR dispid 63;
    property ShapeDrawLine[LayerHandle: Integer; Shape: Integer]: WordBool dispid 67;
    property ShapeLayerDrawPoint[LayerHandle: Integer]: WordBool dispid 68;
    property ShapeLayerLineWidth[LayerHandle: Integer]: Single dispid 70;
    property ShapeDrawPoint[LayerHandle: Integer; Shape: Integer]: WordBool dispid 69;
    property ShapeLayerPointSize[LayerHandle: Integer]: Single dispid 72;
    property ShapeLineWidth[LayerHandle: Integer; Shape: Integer]: Single dispid 71;
    property ShapeFillStipple[LayerHandle: Integer; Shape: Integer]: tkFillStipple dispid 79;
    property ShapeLayerLineStipple[LayerHandle: Integer]: tkLineStipple dispid 76;
    property ShapeLineStipple[LayerHandle: Integer; Shape: Integer]: tkLineStipple dispid 77;
    function ZoomToPrev: Integer; dispid 35;
    property ShapeLayerFillStipple[LayerHandle: Integer]: tkFillStipple dispid 78;
    procedure ProjToPixel(projX: Double; projY: Double; var pixelX: Double; var pixelY: Double); dispid 36;
    procedure PixelToProj(pixelX: Double; pixelY: Double; var projX: Double; var projY: Double); dispid 37;
    function ApplyLegendColors(const Legend: IDispatch): WordBool; dispid 41;
    procedure LockWindow(LockMode: tkLockMode); dispid 42;
    procedure ZoomOut(Percent: Double); dispid 34;
    procedure ZoomToShape(LayerHandle: Integer; Shape: Integer); dispid 32;
    procedure ZoomIn(Percent: Double); dispid 33;
    property ShapePointType[LayerHandle: Integer; Shape: Integer]: tkPointType dispid 85;
    property ShapeLayerPointType[LayerHandle: Integer]: tkPointType dispid 84;
    property DrawingKey[DrawHandle: Integer]: WideString dispid 83;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 82;
    property ShapeLayerFillTransparency[LayerHandle: Integer]: Single dispid 74;
    property ShapeFillTransparency[LayerHandle: Integer; Shape: Integer]: Single dispid 75;
    property GridFileName[LayerHandle: Integer]: WideString dispid 93;
    property LayerName[LayerHandle: Integer]: WideString dispid 91;
    property LayerLabelsVisible[LayerHandle: Integer]: WordBool dispid 86;
    property UDPointType[LayerHandle: Integer]: IDispatch dispid 89;
    function SetImageLayerColorScheme(LayerHandle: Integer; const ColorScheme: IDispatch): WordBool; dispid 92;
    property DrawingLabelsScale[DrawHandle: Integer]: WordBool dispid 126;
    property DrawingLabelsShadow[DrawHandle: Integer]: WordBool dispid 127;
    property GetObject[LayerHandle: Integer]: IDispatch readonly dispid 90;
    procedure ZoomToMaxVisibleExtents; dispid 107;
    property UseLabelCollision[LayerHandle: Integer]: WordBool dispid 104;
    property LayerLabelsOffset[LayerHandle: Integer]: Integer dispid 102;
    property LayerLabelsShadowColor[LayerHandle: Integer]: OLE_COLOR dispid 103;
    function IsTIFFGrid(const Filename: WideString): WordBool; dispid 105;
    function IsSameProjection(const proj4_a: WideString; const proj4_b: WideString): WordBool; dispid 106;
    property UDFillStipple[LayerHandle: Integer; StippleRow: Integer]: Integer dispid 88;
    property UDLineStipple[LayerHandle: Integer]: Integer dispid 87;
    procedure UpdateImage(LayerHandle: Integer); dispid 94;
    property DrawingLabelsOffset[DrawHandle: Integer]: Integer dispid 125;
    property MapResizeBehavior: tkResizeBehavior dispid 108;
    function HWnd: Integer; dispid 109;
    function get_UDPointImageListItem(LayerHandle: Integer; ImageIndex: Integer): IDispatch; dispid 113;
    function get_UDPointImageListCount(LayerHandle: Integer): Integer; dispid 112;
    function set_UDPointImageListAdd(LayerHandle: Integer; const newValue: IDispatch): Integer; dispid 110;
    procedure LabelColor(LayerHandle: Integer; LabelFontColor: OLE_COLOR); dispid 119;
    procedure ClearUDPointImageList(LayerHandle: Integer); dispid 114;
    procedure DrawLineEx(LayerHandle: Integer; x1: Double; y1: Double; x2: Double; y2: Double; 
                         pixelWidth: Integer; Color: OLE_COLOR); dispid 115;
    procedure DrawPointEx(LayerHandle: Integer; x: Double; y: Double; pixelSize: Integer; 
                          Color: OLE_COLOR); dispid 116;
    procedure SetDrawingLayerVisible(LayerHandle: Integer; Visiable: WordBool); dispid 120;
    procedure ClearDrawingLabels(DrawHandle: Integer); dispid 121;
    procedure DrawCircleEx(LayerHandle: Integer; x: Double; y: Double; pixelRadius: Double; 
                           Color: OLE_COLOR; fill: WordBool); dispid 117;
    property ShapePointImageListID[LayerHandle: Integer; Shape: Integer]: Integer dispid 111;
    property DrawingLabelsVisible[DrawHandle: Integer]: WordBool dispid 130;
    procedure AddDrawingLabelEx(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                                x: Double; y: Double; hJustification: tkHJustification; 
                                Rotation: Double); dispid 123;
    procedure AddDrawingLabel(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                              x: Double; y: Double; hJustification: tkHJustification); dispid 124;
    procedure GetDrawingStandardViewWidth(DrawHandle: Integer; var Width: Double); dispid 131;
    property UseDrawingLabelCollision[DrawHandle: Integer]: WordBool dispid 129;
    procedure DrawingFont(DrawHandle: Integer; const FontName: WideString; FontSize: Integer); dispid 122;
    property DrawingLabelsShadowColor[DrawHandle: Integer]: OLE_COLOR dispid 128;
    function LoadMapState(const Filename: WideString; const Callback: IDispatch): WordBool; dispid 179;
    function SaveLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                              Overwrite: WordBool; const Description: WideString): WordBool; dispid 180;
    function DeserializeLayer(LayerHandle: Integer; const newVal: WideString): WordBool; dispid 177;
    procedure ReSourceLayer(LayerHandle: Integer; const newSrcPath: WideString); dispid 143;
    property MapRotationAngle: Double dispid 162;
    function SaveMapState(const Filename: WideString; RelativePaths: WordBool; Overwrite: WordBool): WordBool; dispid 178;
    property Image[LayerHandle: Integer]: IImage dispid 175;
    function RemoveLayerOptions(LayerHandle: Integer; const OptionsName: WideString): WordBool; dispid 185;
    property LayerSkipOnSaving[LayerHandle: Integer]: WordBool dispid 186;
    function SerializeLayer(LayerHandle: Integer): WideString; dispid 176;
    function LoadLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                              var Description: WideString): WordBool; dispid 181;
    property ShapePointFontCharListID[LayerHandle: Integer; Shape: Integer]: Integer dispid 142;
    function SnapShot2(ClippingLayerNbr: Integer; Zoom: Double; pWidth: Integer): IDispatch; dispid 136;
    procedure SetDrawingStandardViewWidth(DrawHandle: Integer; Width: Double); dispid 132;
    procedure DrawWidePolygon(var xPoints: OleVariant; var yPoints: OleVariant; numPoints: Integer; 
                              Color: OLE_COLOR; fill: WordBool; Width: Smallint); dispid 134;
    procedure LayerFontEx(LayerHandle: Integer; const FontName: WideString; FontSize: Integer; 
                          isBold: WordBool; isItalic: WordBool; isUnderline: WordBool); dispid 137;
    procedure set_UDPointFontCharFont(LayerHandle: Integer; const FontName: WideString; 
                                      FontSize: Single; isBold: WordBool; isItalic: WordBool; 
                                      isUnderline: WordBool); dispid 139;
    function set_UDPointFontCharListAdd(LayerHandle: Integer; newValue: Integer; Color: OLE_COLOR): Integer; dispid 140;
    procedure DrawWideCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; 
                             fill: WordBool; Width: Smallint); dispid 135;
    property ShapeStippleColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR dispid 145;
    property ShapeLayerStippleColor[LayerHandle: Integer]: OLE_COLOR dispid 144;
    procedure set_UDPointFontCharFontSize(LayerHandle: Integer; FontSize: Single); dispid 141;
    function SerializeMapState(RelativePaths: WordBool; const BasePath: WideString): WideString; dispid 184;
    property LayerDynamicVisibility[LayerHandle: Integer]: WordBool dispid 169;
    procedure AddLabelEx(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; x: Double; 
                         y: Double; hJustification: tkHJustification; Rotation: Double); dispid 99;
    property Shapefile[LayerHandle: Integer]: IShapefile dispid 174;
    procedure DrawBackBuffer(hdc: {??PPSYSINT1}OleVariant; ImageWidth: SYSINT; ImageHeight: SYSINT); dispid 170;
    property LayerMinVisibleScale[LayerHandle: Integer]: Double dispid 168;
    procedure GetLayerStandardViewWidth(LayerHandle: Integer; var Width: Double); dispid 100;
    property LayerLabelsShadow[LayerHandle: Integer]: WordBool dispid 97;
    property LayerLabelsScale[LayerHandle: Integer]: WordBool dispid 98;
    procedure SetLayerStandardViewWidth(LayerHandle: Integer; Width: Double); dispid 101;
    property LayerLabels[LayerHandle: Integer]: ILabels dispid 171;
    property CanUseImageGrouping: WordBool dispid 165;
    property LayerMaxVisibleScale[LayerHandle: Integer]: Double dispid 167;
    property LayerDescription[LayerHandle: Integer]: WideString dispid 182;
    function DeserializeMapState(const State: WideString; LoadLayers: WordBool; 
                                 const BasePath: WideString): WordBool; dispid 183;
    function GetBaseProjectionPoint(rotX: Double; rotY: Double): IPoint; dispid 164;
    function GetRotatedExtent: IExtents; dispid 163;
    property ShowVersionNumber: WordBool dispid 173;
    property ShowRedrawTime: WordBool dispid 172;
    property VersionNumber: Integer dispid 166;
    property MapUnits: tkUnitsOfMeasure dispid 158;
    property CurrentScale: Double dispid 156;
    property ShapeDrawingMethod: tkShapeDrawingMethod dispid 154;
    property MouseWheelSpeed: Double dispid 152;
    property UseSeamlessPan: WordBool dispid 151;
    property MultilineLabels: WordBool dispid 133;
    property SendOnDrawBackBuffer: WordBool dispid 118;
    property LineSeparationFactor: Integer dispid 96;
    property SerialNumber: WideString dispid 95;
    property MapState: WideString dispid 20;
    property IsLocked: tkLockMode dispid 19;
    property LastErrorCode: Integer dispid 18;
    property Extents: IDispatch dispid 17;
    property NumLayers: Integer dispid 16;
    property GlobalCallback: IDispatch dispid 15;
    property DoubleBuffer: WordBool dispid 14;
    property Key: WideString dispid 13;
    property ExtentHistory: Integer dispid 12;
    property ExtentPad: Double dispid 11;
    property SendSelectBoxFinal: WordBool dispid 10;
    property SendSelectBoxDrag: WordBool dispid 9;
    property SendMouseMove: WordBool dispid 8;
    property SendMouseUp: WordBool dispid 7;
    property SendMouseDown: WordBool dispid 6;
    property UDCursorHandle: Integer dispid 5;
    property MapCursor: tkCursor dispid 4;
    property CursorMode: tkCursorMode dispid 3;
    property ZoomPercent: Double dispid 2;
    property BackColor: OLE_COLOR dispid 1;
  end;

// *********************************************************************//
// Interface: IExtents
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A5692259-035E-487A-8D89-509DD6DD0F64}
// *********************************************************************//
  IExtents = interface(IDispatch)
    ['{A5692259-035E-487A-8D89-509DD6DD0F64}']
    procedure SetBounds(xMin: Double; yMin: Double; zMin: Double; xMax: Double; yMax: Double; 
                        zMax: Double); safecall;
    procedure GetBounds(out xMin: Double; out yMin: Double; out zMin: Double; out xMax: Double; 
                        out yMax: Double; out zMax: Double); safecall;
    function Get_xMin: Double; safecall;
    function Get_xMax: Double; safecall;
    function Get_yMin: Double; safecall;
    function Get_yMax: Double; safecall;
    function Get_zMin: Double; safecall;
    function Get_zMax: Double; safecall;
    function Get_mMin: Double; safecall;
    function Get_mMax: Double; safecall;
    procedure GetMeasureBounds(out mMin: Double; out mMax: Double); safecall;
    procedure SetMeasureBounds(mMin: Double; mMax: Double); safecall;
    property xMin: Double read Get_xMin;
    property xMax: Double read Get_xMax;
    property yMin: Double read Get_yMin;
    property yMax: Double read Get_yMax;
    property zMin: Double read Get_zMin;
    property zMax: Double read Get_zMax;
    property mMin: Double read Get_mMin;
    property mMax: Double read Get_mMax;
  end;

// *********************************************************************//
// DispIntf:  IExtentsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A5692259-035E-487A-8D89-509DD6DD0F64}
// *********************************************************************//
  IExtentsDisp = dispinterface
    ['{A5692259-035E-487A-8D89-509DD6DD0F64}']
    procedure SetBounds(xMin: Double; yMin: Double; zMin: Double; xMax: Double; yMax: Double; 
                        zMax: Double); dispid 1;
    procedure GetBounds(out xMin: Double; out yMin: Double; out zMin: Double; out xMax: Double; 
                        out yMax: Double; out zMax: Double); dispid 2;
    property xMin: Double readonly dispid 3;
    property xMax: Double readonly dispid 4;
    property yMin: Double readonly dispid 5;
    property yMax: Double readonly dispid 6;
    property zMin: Double readonly dispid 7;
    property zMax: Double readonly dispid 8;
    property mMin: Double readonly dispid 9;
    property mMax: Double readonly dispid 10;
    procedure GetMeasureBounds(out mMin: Double; out mMax: Double); dispid 11;
    procedure SetMeasureBounds(mMin: Double; mMax: Double); dispid 12;
  end;

// *********************************************************************//
// Interface: ILabels
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A73AF37E-3A6A-4532-B48F-FA53309FA117}
// *********************************************************************//
  ILabels = interface(IDispatch)
    ['{A73AF37E-3A6A-4532-B48F-FA53309FA117}']
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_VerticalPosition: tkVerticalPosition; safecall;
    procedure Set_VerticalPosition(retval: tkVerticalPosition); safecall;
    function Get_Category(Index: Integer): ILabelCategory; safecall;
    procedure Set_Category(Index: Integer; const pVal: ILabelCategory); safecall;
    procedure AddLabel(const Text: WideString; x: Double; y: Double; Rotation: Double; 
                       Category: Integer); safecall;
    function InsertLabel(Index: Integer; const Text: WideString; x: Double; y: Double; 
                         Rotation: Double; Category: Integer): WordBool; safecall;
    function RemoveLabel(Index: Integer): WordBool; safecall;
    procedure AddPart(Index: Integer; const Text: WideString; x: Double; y: Double; 
                      Rotation: Double; Category: Integer); safecall;
    function InsertPart(Index: Integer; Part: Integer; const Text: WideString; x: Double; 
                        y: Double; Rotation: Double; Category: Integer): WordBool; safecall;
    function RemovePart(Index: Integer; Part: Integer): WordBool; safecall;
    function AddCategory(const Name: WideString): ILabelCategory; safecall;
    function InsertCategory(Index: Integer; const Name: WideString): ILabelCategory; safecall;
    function RemoveCategory(Index: Integer): WordBool; safecall;
    procedure Clear; safecall;
    procedure ClearCategories; safecall;
    function Select(const BoundingBox: IExtents; Tolerance: Integer; SelectMode: SelectMode; 
                    var LabelIndices: OleVariant; var PartIndices: OleVariant): WordBool; safecall;
    function Get_Count: Integer; safecall;
    function Get_NumParts(Index: Integer): Integer; safecall;
    function Get_NumCategories: Integer; safecall;
    function Get_Label_(Index: Integer; Part: Integer): ILabel; safecall;
    function Get_Synchronized: WordBool; safecall;
    procedure Set_Synchronized(retval: WordBool); safecall;
    function Get_ScaleLabels: WordBool; safecall;
    procedure Set_ScaleLabels(retval: WordBool); safecall;
    function Get_BasicScale: Double; safecall;
    procedure Set_BasicScale(retval: Double); safecall;
    function Get_MaxVisibleScale: Double; safecall;
    procedure Set_MaxVisibleScale(retval: Double); safecall;
    function Get_MinVisibleScale: Double; safecall;
    procedure Set_MinVisibleScale(retval: Double); safecall;
    function Get_DynamicVisibility: WordBool; safecall;
    procedure Set_DynamicVisibility(retval: WordBool); safecall;
    function Get_AvoidCollisions: WordBool; safecall;
    procedure Set_AvoidCollisions(retval: WordBool); safecall;
    function Get_CollisionBuffer: Integer; safecall;
    procedure Set_CollisionBuffer(retval: Integer); safecall;
    function Get_UseWidthLimits: WordBool; safecall;
    procedure Set_UseWidthLimits(retval: WordBool); safecall;
    function Get_RemoveDuplicates: WordBool; safecall;
    procedure Set_RemoveDuplicates(retval: WordBool); safecall;
    function Get_UseGdiPlus: WordBool; safecall;
    procedure Set_UseGdiPlus(retval: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(retval: WordBool); safecall;
    function Get_OffsetX: Double; safecall;
    procedure Set_OffsetX(retval: Double); safecall;
    function Get_OffsetY: Double; safecall;
    procedure Set_OffsetY(retval: Double); safecall;
    function Get_Alignment: tkLabelAlignment; safecall;
    procedure Set_Alignment(retval: tkLabelAlignment); safecall;
    function Get_LineOrientation: tkLineLabelOrientation; safecall;
    procedure Set_LineOrientation(retval: tkLineLabelOrientation); safecall;
    function Get_FontName: WideString; safecall;
    procedure Set_FontName(const retval: WideString); safecall;
    function Get_FontSize: Integer; safecall;
    procedure Set_FontSize(retval: Integer); safecall;
    function Get_FontItalic: WordBool; safecall;
    procedure Set_FontItalic(retval: WordBool); safecall;
    function Get_FontBold: WordBool; safecall;
    procedure Set_FontBold(retval: WordBool); safecall;
    function Get_FontUnderline: WordBool; safecall;
    procedure Set_FontUnderline(retval: WordBool); safecall;
    function Get_FontStrikeOut: WordBool; safecall;
    procedure Set_FontStrikeOut(retval: WordBool); safecall;
    function Get_FontColor: OLE_COLOR; safecall;
    procedure Set_FontColor(retval: OLE_COLOR); safecall;
    function Get_FontColor2: OLE_COLOR; safecall;
    procedure Set_FontColor2(retval: OLE_COLOR); safecall;
    function Get_FontGradientMode: tkLinearGradientMode; safecall;
    procedure Set_FontGradientMode(retval: tkLinearGradientMode); safecall;
    function Get_FontTransparency: Integer; safecall;
    procedure Set_FontTransparency(retval: Integer); safecall;
    function Get_FontOutlineVisible: WordBool; safecall;
    procedure Set_FontOutlineVisible(retval: WordBool); safecall;
    function Get_ShadowVisible: WordBool; safecall;
    procedure Set_ShadowVisible(retval: WordBool); safecall;
    function Get_HaloVisible: WordBool; safecall;
    procedure Set_HaloVisible(retval: WordBool); safecall;
    function Get_FontOutlineColor: OLE_COLOR; safecall;
    procedure Set_FontOutlineColor(retval: OLE_COLOR); safecall;
    function Get_ShadowColor: OLE_COLOR; safecall;
    procedure Set_ShadowColor(retval: OLE_COLOR); safecall;
    function Get_HaloColor: OLE_COLOR; safecall;
    procedure Set_HaloColor(retval: OLE_COLOR); safecall;
    function Get_FontOutlineWidth: Integer; safecall;
    procedure Set_FontOutlineWidth(retval: Integer); safecall;
    function Get_ShadowOffsetX: Integer; safecall;
    procedure Set_ShadowOffsetX(retval: Integer); safecall;
    function Get_ShadowOffsetY: Integer; safecall;
    procedure Set_ShadowOffsetY(retval: Integer); safecall;
    function Get_HaloSize: Integer; safecall;
    procedure Set_HaloSize(retval: Integer); safecall;
    function Get_FrameType: tkLabelFrameType; safecall;
    procedure Set_FrameType(retval: tkLabelFrameType); safecall;
    function Get_FrameOutlineColor: OLE_COLOR; safecall;
    procedure Set_FrameOutlineColor(retval: OLE_COLOR); safecall;
    function Get_FrameBackColor: OLE_COLOR; safecall;
    procedure Set_FrameBackColor(retval: OLE_COLOR); safecall;
    function Get_FrameBackColor2: OLE_COLOR; safecall;
    procedure Set_FrameBackColor2(retval: OLE_COLOR); safecall;
    function Get_FrameGradientMode: tkLinearGradientMode; safecall;
    procedure Set_FrameGradientMode(retval: tkLinearGradientMode); safecall;
    function Get_FrameOutlineStyle: tkDashStyle; safecall;
    procedure Set_FrameOutlineStyle(retval: tkDashStyle); safecall;
    function Get_FrameOutlineWidth: Integer; safecall;
    procedure Set_FrameOutlineWidth(retval: Integer); safecall;
    function Get_FramePaddingX: Integer; safecall;
    procedure Set_FramePaddingX(retval: Integer); safecall;
    function Get_FramePaddingY: Integer; safecall;
    procedure Set_FramePaddingY(retval: Integer); safecall;
    function Get_FrameTransparency: Integer; safecall;
    procedure Set_FrameTransparency(retval: Integer); safecall;
    function Get_InboxAlignment: tkLabelAlignment; safecall;
    procedure Set_InboxAlignment(retval: tkLabelAlignment); safecall;
    function Get_ClassificationField: Integer; safecall;
    procedure Set_ClassificationField(FieldIndex: Integer); safecall;
    function GenerateCategories(FieldIndex: Integer; ClassificationType: tkClassificationType; 
                                numClasses: Integer): WordBool; safecall;
    procedure ApplyCategories; safecall;
    function Get_Options: ILabelCategory; safecall;
    procedure Set_Options(const retval: ILabelCategory); safecall;
    procedure ApplyColorScheme(Type_: tkColorSchemeType; const ColorScheme: IColorScheme); safecall;
    procedure ApplyColorScheme2(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                Element: tkLabelElements); safecall;
    procedure ApplyColorScheme3(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                Element: tkLabelElements; CategoryStartIndex: Integer; 
                                CategoryEndIndex: Integer); safecall;
    function Get_FrameVisible: WordBool; safecall;
    procedure Set_FrameVisible(retval: WordBool); safecall;
    function Get_VisibilityExpression: WideString; safecall;
    procedure Set_VisibilityExpression(const retval: WideString); safecall;
    function Get_MinDrawingSize: Integer; safecall;
    procedure Set_MinDrawingSize(retval: Integer); safecall;
    function MoveCategoryUp(Index: Integer): WordBool; safecall;
    function MoveCategoryDown(Index: Integer): WordBool; safecall;
    function Get_AutoOffset: WordBool; safecall;
    procedure Set_AutoOffset(retval: WordBool); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    function Get_Expression: WideString; safecall;
    procedure Set_Expression(const retval: WideString); safecall;
    function SaveToXML(const Filename: WideString): WordBool; safecall;
    function LoadFromXML(const Filename: WideString): WordBool; safecall;
    function SaveToDbf(saveText: WordBool; saveCategory: WordBool): WordBool; safecall;
    function SaveToDbf2(const xField: WideString; const yField: WideString; 
                        const angleField: WideString; const textField: WideString; 
                        const categoryField: WideString; saveText: WordBool; saveCategory: WordBool): WordBool; safecall;
    function LoadFromDbf(loadText: WordBool; loadCategory: WordBool): WordBool; safecall;
    function LoadFromDbf2(const xField: WideString; const yField: WideString; 
                          const angleField: WideString; const textField: WideString; 
                          const categoryField: WideString; loadText: WordBool; 
                          loadCategory: WordBool): WordBool; safecall;
    function Generate(const Expression: WideString; Method: tkLabelPositioning; 
                      LargestPartOnly: WordBool): Integer; safecall;
    function Get_SavingMode: tkSavingMode; safecall;
    procedure Set_SavingMode(retval: tkSavingMode); safecall;
    function Get_Positioning: tkLabelPositioning; safecall;
    procedure Set_Positioning(pVal: tkLabelPositioning); safecall;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property VerticalPosition: tkVerticalPosition read Get_VerticalPosition write Set_VerticalPosition;
    property Category[Index: Integer]: ILabelCategory read Get_Category write Set_Category;
    property Count: Integer read Get_Count;
    property NumParts[Index: Integer]: Integer read Get_NumParts;
    property NumCategories: Integer read Get_NumCategories;
    property Label_[Index: Integer; Part: Integer]: ILabel read Get_Label_;
    property Synchronized: WordBool read Get_Synchronized write Set_Synchronized;
    property ScaleLabels: WordBool read Get_ScaleLabels write Set_ScaleLabels;
    property BasicScale: Double read Get_BasicScale write Set_BasicScale;
    property MaxVisibleScale: Double read Get_MaxVisibleScale write Set_MaxVisibleScale;
    property MinVisibleScale: Double read Get_MinVisibleScale write Set_MinVisibleScale;
    property DynamicVisibility: WordBool read Get_DynamicVisibility write Set_DynamicVisibility;
    property AvoidCollisions: WordBool read Get_AvoidCollisions write Set_AvoidCollisions;
    property CollisionBuffer: Integer read Get_CollisionBuffer write Set_CollisionBuffer;
    property UseWidthLimits: WordBool read Get_UseWidthLimits write Set_UseWidthLimits;
    property RemoveDuplicates: WordBool read Get_RemoveDuplicates write Set_RemoveDuplicates;
    property UseGdiPlus: WordBool read Get_UseGdiPlus write Set_UseGdiPlus;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property OffsetX: Double read Get_OffsetX write Set_OffsetX;
    property OffsetY: Double read Get_OffsetY write Set_OffsetY;
    property Alignment: tkLabelAlignment read Get_Alignment write Set_Alignment;
    property LineOrientation: tkLineLabelOrientation read Get_LineOrientation write Set_LineOrientation;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Integer read Get_FontSize write Set_FontSize;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontStrikeOut: WordBool read Get_FontStrikeOut write Set_FontStrikeOut;
    property FontColor: OLE_COLOR read Get_FontColor write Set_FontColor;
    property FontColor2: OLE_COLOR read Get_FontColor2 write Set_FontColor2;
    property FontGradientMode: tkLinearGradientMode read Get_FontGradientMode write Set_FontGradientMode;
    property FontTransparency: Integer read Get_FontTransparency write Set_FontTransparency;
    property FontOutlineVisible: WordBool read Get_FontOutlineVisible write Set_FontOutlineVisible;
    property ShadowVisible: WordBool read Get_ShadowVisible write Set_ShadowVisible;
    property HaloVisible: WordBool read Get_HaloVisible write Set_HaloVisible;
    property FontOutlineColor: OLE_COLOR read Get_FontOutlineColor write Set_FontOutlineColor;
    property ShadowColor: OLE_COLOR read Get_ShadowColor write Set_ShadowColor;
    property HaloColor: OLE_COLOR read Get_HaloColor write Set_HaloColor;
    property FontOutlineWidth: Integer read Get_FontOutlineWidth write Set_FontOutlineWidth;
    property ShadowOffsetX: Integer read Get_ShadowOffsetX write Set_ShadowOffsetX;
    property ShadowOffsetY: Integer read Get_ShadowOffsetY write Set_ShadowOffsetY;
    property HaloSize: Integer read Get_HaloSize write Set_HaloSize;
    property FrameType: tkLabelFrameType read Get_FrameType write Set_FrameType;
    property FrameOutlineColor: OLE_COLOR read Get_FrameOutlineColor write Set_FrameOutlineColor;
    property FrameBackColor: OLE_COLOR read Get_FrameBackColor write Set_FrameBackColor;
    property FrameBackColor2: OLE_COLOR read Get_FrameBackColor2 write Set_FrameBackColor2;
    property FrameGradientMode: tkLinearGradientMode read Get_FrameGradientMode write Set_FrameGradientMode;
    property FrameOutlineStyle: tkDashStyle read Get_FrameOutlineStyle write Set_FrameOutlineStyle;
    property FrameOutlineWidth: Integer read Get_FrameOutlineWidth write Set_FrameOutlineWidth;
    property FramePaddingX: Integer read Get_FramePaddingX write Set_FramePaddingX;
    property FramePaddingY: Integer read Get_FramePaddingY write Set_FramePaddingY;
    property FrameTransparency: Integer read Get_FrameTransparency write Set_FrameTransparency;
    property InboxAlignment: tkLabelAlignment read Get_InboxAlignment write Set_InboxAlignment;
    property ClassificationField: Integer read Get_ClassificationField write Set_ClassificationField;
    property Options: ILabelCategory read Get_Options write Set_Options;
    property FrameVisible: WordBool read Get_FrameVisible write Set_FrameVisible;
    property VisibilityExpression: WideString read Get_VisibilityExpression write Set_VisibilityExpression;
    property MinDrawingSize: Integer read Get_MinDrawingSize write Set_MinDrawingSize;
    property AutoOffset: WordBool read Get_AutoOffset write Set_AutoOffset;
    property Expression: WideString read Get_Expression write Set_Expression;
    property SavingMode: tkSavingMode read Get_SavingMode write Set_SavingMode;
    property Positioning: tkLabelPositioning read Get_Positioning write Set_Positioning;
  end;

// *********************************************************************//
// DispIntf:  ILabelsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A73AF37E-3A6A-4532-B48F-FA53309FA117}
// *********************************************************************//
  ILabelsDisp = dispinterface
    ['{A73AF37E-3A6A-4532-B48F-FA53309FA117}']
    property LastErrorCode: Integer readonly dispid 1;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 2;
    property GlobalCallback: ICallback dispid 3;
    property Key: WideString dispid 4;
    property VerticalPosition: tkVerticalPosition dispid 5;
    property Category[Index: Integer]: ILabelCategory dispid 6;
    procedure AddLabel(const Text: WideString; x: Double; y: Double; Rotation: Double; 
                       Category: Integer); dispid 7;
    function InsertLabel(Index: Integer; const Text: WideString; x: Double; y: Double; 
                         Rotation: Double; Category: Integer): WordBool; dispid 8;
    function RemoveLabel(Index: Integer): WordBool; dispid 9;
    procedure AddPart(Index: Integer; const Text: WideString; x: Double; y: Double; 
                      Rotation: Double; Category: Integer); dispid 10;
    function InsertPart(Index: Integer; Part: Integer; const Text: WideString; x: Double; 
                        y: Double; Rotation: Double; Category: Integer): WordBool; dispid 11;
    function RemovePart(Index: Integer; Part: Integer): WordBool; dispid 12;
    function AddCategory(const Name: WideString): ILabelCategory; dispid 13;
    function InsertCategory(Index: Integer; const Name: WideString): ILabelCategory; dispid 14;
    function RemoveCategory(Index: Integer): WordBool; dispid 15;
    procedure Clear; dispid 16;
    procedure ClearCategories; dispid 17;
    function Select(const BoundingBox: IExtents; Tolerance: Integer; SelectMode: SelectMode; 
                    var LabelIndices: OleVariant; var PartIndices: OleVariant): WordBool; dispid 20;
    property Count: Integer readonly dispid 21;
    property NumParts[Index: Integer]: Integer readonly dispid 22;
    property NumCategories: Integer readonly dispid 23;
    property Label_[Index: Integer; Part: Integer]: ILabel readonly dispid 24;
    property Synchronized: WordBool dispid 25;
    property ScaleLabels: WordBool dispid 26;
    property BasicScale: Double dispid 27;
    property MaxVisibleScale: Double dispid 28;
    property MinVisibleScale: Double dispid 29;
    property DynamicVisibility: WordBool dispid 30;
    property AvoidCollisions: WordBool dispid 31;
    property CollisionBuffer: Integer dispid 32;
    property UseWidthLimits: WordBool dispid 33;
    property RemoveDuplicates: WordBool dispid 34;
    property UseGdiPlus: WordBool dispid 35;
    property Visible: WordBool dispid 36;
    property OffsetX: Double dispid 37;
    property OffsetY: Double dispid 38;
    property Alignment: tkLabelAlignment dispid 39;
    property LineOrientation: tkLineLabelOrientation dispid 40;
    property FontName: WideString dispid 41;
    property FontSize: Integer dispid 42;
    property FontItalic: WordBool dispid 43;
    property FontBold: WordBool dispid 44;
    property FontUnderline: WordBool dispid 45;
    property FontStrikeOut: WordBool dispid 46;
    property FontColor: OLE_COLOR dispid 47;
    property FontColor2: OLE_COLOR dispid 48;
    property FontGradientMode: tkLinearGradientMode dispid 49;
    property FontTransparency: Integer dispid 50;
    property FontOutlineVisible: WordBool dispid 51;
    property ShadowVisible: WordBool dispid 52;
    property HaloVisible: WordBool dispid 53;
    property FontOutlineColor: OLE_COLOR dispid 54;
    property ShadowColor: OLE_COLOR dispid 55;
    property HaloColor: OLE_COLOR dispid 56;
    property FontOutlineWidth: Integer dispid 57;
    property ShadowOffsetX: Integer dispid 58;
    property ShadowOffsetY: Integer dispid 59;
    property HaloSize: Integer dispid 60;
    property FrameType: tkLabelFrameType dispid 61;
    property FrameOutlineColor: OLE_COLOR dispid 62;
    property FrameBackColor: OLE_COLOR dispid 63;
    property FrameBackColor2: OLE_COLOR dispid 64;
    property FrameGradientMode: tkLinearGradientMode dispid 65;
    property FrameOutlineStyle: tkDashStyle dispid 66;
    property FrameOutlineWidth: Integer dispid 67;
    property FramePaddingX: Integer dispid 68;
    property FramePaddingY: Integer dispid 69;
    property FrameTransparency: Integer dispid 70;
    property InboxAlignment: tkLabelAlignment dispid 71;
    property ClassificationField: Integer dispid 72;
    function GenerateCategories(FieldIndex: Integer; ClassificationType: tkClassificationType; 
                                numClasses: Integer): WordBool; dispid 73;
    procedure ApplyCategories; dispid 74;
    property Options: ILabelCategory dispid 75;
    procedure ApplyColorScheme(Type_: tkColorSchemeType; const ColorScheme: IColorScheme); dispid 76;
    procedure ApplyColorScheme2(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                Element: tkLabelElements); dispid 77;
    procedure ApplyColorScheme3(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                Element: tkLabelElements; CategoryStartIndex: Integer; 
                                CategoryEndIndex: Integer); dispid 78;
    property FrameVisible: WordBool dispid 79;
    property VisibilityExpression: WideString dispid 80;
    property MinDrawingSize: Integer dispid 81;
    function MoveCategoryUp(Index: Integer): WordBool; dispid 82;
    function MoveCategoryDown(Index: Integer): WordBool; dispid 83;
    property AutoOffset: WordBool dispid 84;
    function Serialize: WideString; dispid 85;
    procedure Deserialize(const newVal: WideString); dispid 86;
    property Expression: WideString dispid 87;
    function SaveToXML(const Filename: WideString): WordBool; dispid 88;
    function LoadFromXML(const Filename: WideString): WordBool; dispid 89;
    function SaveToDbf(saveText: WordBool; saveCategory: WordBool): WordBool; dispid 90;
    function SaveToDbf2(const xField: WideString; const yField: WideString; 
                        const angleField: WideString; const textField: WideString; 
                        const categoryField: WideString; saveText: WordBool; saveCategory: WordBool): WordBool; dispid 91;
    function LoadFromDbf(loadText: WordBool; loadCategory: WordBool): WordBool; dispid 92;
    function LoadFromDbf2(const xField: WideString; const yField: WideString; 
                          const angleField: WideString; const textField: WideString; 
                          const categoryField: WideString; loadText: WordBool; 
                          loadCategory: WordBool): WordBool; dispid 93;
    function Generate(const Expression: WideString; Method: tkLabelPositioning; 
                      LargestPartOnly: WordBool): Integer; dispid 94;
    property SavingMode: tkSavingMode dispid 95;
    property Positioning: tkLabelPositioning dispid 96;
  end;

// *********************************************************************//
// Interface: ICallback
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {90E6BBF7-A956-49BE-A5CD-A4640C263AB6}
// *********************************************************************//
  ICallback = interface(IDispatch)
    ['{90E6BBF7-A956-49BE-A5CD-A4640C263AB6}']
    procedure Progress(const KeyOfSender: WideString; Percent: Integer; const Message: WideString); safecall;
    procedure Error(const KeyOfSender: WideString; const ErrorMsg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  ICallbackDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {90E6BBF7-A956-49BE-A5CD-A4640C263AB6}
// *********************************************************************//
  ICallbackDisp = dispinterface
    ['{90E6BBF7-A956-49BE-A5CD-A4640C263AB6}']
    procedure Progress(const KeyOfSender: WideString; Percent: Integer; const Message: WideString); dispid 1;
    procedure Error(const KeyOfSender: WideString; const ErrorMsg: WideString); dispid 2;
  end;

// *********************************************************************//
// Interface: ILabelCategory
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4BB3D2B2-A72D-4538-A092-9E1E69ED6001}
// *********************************************************************//
  ILabelCategory = interface(IDispatch)
    ['{4BB3D2B2-A72D-4538-A092-9E1E69ED6001}']
    function Get_Priority: Integer; safecall;
    procedure Set_Priority(retval: Integer); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const retval: WideString); safecall;
    function Get_Expression: WideString; safecall;
    procedure Set_Expression(const retval: WideString); safecall;
    function Get_MinValue: OleVariant; safecall;
    procedure Set_MinValue(pVal: OleVariant); safecall;
    function Get_MaxValue: OleVariant; safecall;
    procedure Set_MaxValue(pVal: OleVariant); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(retval: WordBool); safecall;
    function Get_OffsetX: Double; safecall;
    procedure Set_OffsetX(retval: Double); safecall;
    function Get_OffsetY: Double; safecall;
    procedure Set_OffsetY(retval: Double); safecall;
    function Get_Alignment: tkLabelAlignment; safecall;
    procedure Set_Alignment(retval: tkLabelAlignment); safecall;
    function Get_LineOrientation: tkLineLabelOrientation; safecall;
    procedure Set_LineOrientation(retval: tkLineLabelOrientation); safecall;
    function Get_FontName: WideString; safecall;
    procedure Set_FontName(const retval: WideString); safecall;
    function Get_FontSize: Integer; safecall;
    procedure Set_FontSize(retval: Integer); safecall;
    function Get_FontItalic: WordBool; safecall;
    procedure Set_FontItalic(retval: WordBool); safecall;
    function Get_FontBold: WordBool; safecall;
    procedure Set_FontBold(retval: WordBool); safecall;
    function Get_FontUnderline: WordBool; safecall;
    procedure Set_FontUnderline(retval: WordBool); safecall;
    function Get_FontStrikeOut: WordBool; safecall;
    procedure Set_FontStrikeOut(retval: WordBool); safecall;
    function Get_FontColor: OLE_COLOR; safecall;
    procedure Set_FontColor(retval: OLE_COLOR); safecall;
    function Get_FontColor2: OLE_COLOR; safecall;
    procedure Set_FontColor2(retval: OLE_COLOR); safecall;
    function Get_FontGradientMode: tkLinearGradientMode; safecall;
    procedure Set_FontGradientMode(retval: tkLinearGradientMode); safecall;
    function Get_FontTransparency: Integer; safecall;
    procedure Set_FontTransparency(retval: Integer); safecall;
    function Get_FontOutlineVisible: WordBool; safecall;
    procedure Set_FontOutlineVisible(retval: WordBool); safecall;
    function Get_ShadowVisible: WordBool; safecall;
    procedure Set_ShadowVisible(retval: WordBool); safecall;
    function Get_HaloVisible: WordBool; safecall;
    procedure Set_HaloVisible(retval: WordBool); safecall;
    function Get_FontOutlineColor: OLE_COLOR; safecall;
    procedure Set_FontOutlineColor(retval: OLE_COLOR); safecall;
    function Get_ShadowColor: OLE_COLOR; safecall;
    procedure Set_ShadowColor(retval: OLE_COLOR); safecall;
    function Get_HaloColor: OLE_COLOR; safecall;
    procedure Set_HaloColor(retval: OLE_COLOR); safecall;
    function Get_FontOutlineWidth: Integer; safecall;
    procedure Set_FontOutlineWidth(retval: Integer); safecall;
    function Get_ShadowOffsetX: Integer; safecall;
    procedure Set_ShadowOffsetX(retval: Integer); safecall;
    function Get_ShadowOffsetY: Integer; safecall;
    procedure Set_ShadowOffsetY(retval: Integer); safecall;
    function Get_HaloSize: Integer; safecall;
    procedure Set_HaloSize(retval: Integer); safecall;
    function Get_FrameType: tkLabelFrameType; safecall;
    procedure Set_FrameType(retval: tkLabelFrameType); safecall;
    function Get_FrameOutlineColor: OLE_COLOR; safecall;
    procedure Set_FrameOutlineColor(retval: OLE_COLOR); safecall;
    function Get_FrameBackColor: OLE_COLOR; safecall;
    procedure Set_FrameBackColor(retval: OLE_COLOR); safecall;
    function Get_FrameBackColor2: OLE_COLOR; safecall;
    procedure Set_FrameBackColor2(retval: OLE_COLOR); safecall;
    function Get_FrameGradientMode: tkLinearGradientMode; safecall;
    procedure Set_FrameGradientMode(retval: tkLinearGradientMode); safecall;
    function Get_FrameOutlineStyle: tkDashStyle; safecall;
    procedure Set_FrameOutlineStyle(retval: tkDashStyle); safecall;
    function Get_FrameOutlineWidth: Integer; safecall;
    procedure Set_FrameOutlineWidth(retval: Integer); safecall;
    function Get_FramePaddingX: Integer; safecall;
    procedure Set_FramePaddingX(retval: Integer); safecall;
    function Get_FramePaddingY: Integer; safecall;
    procedure Set_FramePaddingY(retval: Integer); safecall;
    function Get_FrameTransparency: Integer; safecall;
    procedure Set_FrameTransparency(retval: Integer); safecall;
    function Get_InboxAlignment: tkLabelAlignment; safecall;
    procedure Set_InboxAlignment(retval: tkLabelAlignment); safecall;
    function Get_FrameVisible: WordBool; safecall;
    procedure Set_FrameVisible(retval: WordBool); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(retval: WordBool); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    property Priority: Integer read Get_Priority write Set_Priority;
    property Name: WideString read Get_Name write Set_Name;
    property Expression: WideString read Get_Expression write Set_Expression;
    property MinValue: OleVariant read Get_MinValue write Set_MinValue;
    property MaxValue: OleVariant read Get_MaxValue write Set_MaxValue;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property OffsetX: Double read Get_OffsetX write Set_OffsetX;
    property OffsetY: Double read Get_OffsetY write Set_OffsetY;
    property Alignment: tkLabelAlignment read Get_Alignment write Set_Alignment;
    property LineOrientation: tkLineLabelOrientation read Get_LineOrientation write Set_LineOrientation;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Integer read Get_FontSize write Set_FontSize;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontStrikeOut: WordBool read Get_FontStrikeOut write Set_FontStrikeOut;
    property FontColor: OLE_COLOR read Get_FontColor write Set_FontColor;
    property FontColor2: OLE_COLOR read Get_FontColor2 write Set_FontColor2;
    property FontGradientMode: tkLinearGradientMode read Get_FontGradientMode write Set_FontGradientMode;
    property FontTransparency: Integer read Get_FontTransparency write Set_FontTransparency;
    property FontOutlineVisible: WordBool read Get_FontOutlineVisible write Set_FontOutlineVisible;
    property ShadowVisible: WordBool read Get_ShadowVisible write Set_ShadowVisible;
    property HaloVisible: WordBool read Get_HaloVisible write Set_HaloVisible;
    property FontOutlineColor: OLE_COLOR read Get_FontOutlineColor write Set_FontOutlineColor;
    property ShadowColor: OLE_COLOR read Get_ShadowColor write Set_ShadowColor;
    property HaloColor: OLE_COLOR read Get_HaloColor write Set_HaloColor;
    property FontOutlineWidth: Integer read Get_FontOutlineWidth write Set_FontOutlineWidth;
    property ShadowOffsetX: Integer read Get_ShadowOffsetX write Set_ShadowOffsetX;
    property ShadowOffsetY: Integer read Get_ShadowOffsetY write Set_ShadowOffsetY;
    property HaloSize: Integer read Get_HaloSize write Set_HaloSize;
    property FrameType: tkLabelFrameType read Get_FrameType write Set_FrameType;
    property FrameOutlineColor: OLE_COLOR read Get_FrameOutlineColor write Set_FrameOutlineColor;
    property FrameBackColor: OLE_COLOR read Get_FrameBackColor write Set_FrameBackColor;
    property FrameBackColor2: OLE_COLOR read Get_FrameBackColor2 write Set_FrameBackColor2;
    property FrameGradientMode: tkLinearGradientMode read Get_FrameGradientMode write Set_FrameGradientMode;
    property FrameOutlineStyle: tkDashStyle read Get_FrameOutlineStyle write Set_FrameOutlineStyle;
    property FrameOutlineWidth: Integer read Get_FrameOutlineWidth write Set_FrameOutlineWidth;
    property FramePaddingX: Integer read Get_FramePaddingX write Set_FramePaddingX;
    property FramePaddingY: Integer read Get_FramePaddingY write Set_FramePaddingY;
    property FrameTransparency: Integer read Get_FrameTransparency write Set_FrameTransparency;
    property InboxAlignment: tkLabelAlignment read Get_InboxAlignment write Set_InboxAlignment;
    property FrameVisible: WordBool read Get_FrameVisible write Set_FrameVisible;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
  end;

// *********************************************************************//
// DispIntf:  ILabelCategoryDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4BB3D2B2-A72D-4538-A092-9E1E69ED6001}
// *********************************************************************//
  ILabelCategoryDisp = dispinterface
    ['{4BB3D2B2-A72D-4538-A092-9E1E69ED6001}']
    property Priority: Integer dispid 1;
    property Name: WideString dispid 2;
    property Expression: WideString dispid 3;
    property MinValue: OleVariant dispid 4;
    property MaxValue: OleVariant dispid 5;
    property Visible: WordBool dispid 6;
    property OffsetX: Double dispid 7;
    property OffsetY: Double dispid 8;
    property Alignment: tkLabelAlignment dispid 9;
    property LineOrientation: tkLineLabelOrientation dispid 10;
    property FontName: WideString dispid 11;
    property FontSize: Integer dispid 12;
    property FontItalic: WordBool dispid 13;
    property FontBold: WordBool dispid 14;
    property FontUnderline: WordBool dispid 15;
    property FontStrikeOut: WordBool dispid 16;
    property FontColor: OLE_COLOR dispid 17;
    property FontColor2: OLE_COLOR dispid 18;
    property FontGradientMode: tkLinearGradientMode dispid 19;
    property FontTransparency: Integer dispid 20;
    property FontOutlineVisible: WordBool dispid 21;
    property ShadowVisible: WordBool dispid 22;
    property HaloVisible: WordBool dispid 23;
    property FontOutlineColor: OLE_COLOR dispid 24;
    property ShadowColor: OLE_COLOR dispid 25;
    property HaloColor: OLE_COLOR dispid 26;
    property FontOutlineWidth: Integer dispid 27;
    property ShadowOffsetX: Integer dispid 28;
    property ShadowOffsetY: Integer dispid 29;
    property HaloSize: Integer dispid 30;
    property FrameType: tkLabelFrameType dispid 31;
    property FrameOutlineColor: OLE_COLOR dispid 32;
    property FrameBackColor: OLE_COLOR dispid 33;
    property FrameBackColor2: OLE_COLOR dispid 34;
    property FrameGradientMode: tkLinearGradientMode dispid 35;
    property FrameOutlineStyle: tkDashStyle dispid 36;
    property FrameOutlineWidth: Integer dispid 37;
    property FramePaddingX: Integer dispid 38;
    property FramePaddingY: Integer dispid 39;
    property FrameTransparency: Integer dispid 40;
    property InboxAlignment: tkLabelAlignment dispid 41;
    property FrameVisible: WordBool dispid 42;
    property Enabled: WordBool dispid 43;
    function Serialize: WideString; dispid 44;
    procedure Deserialize(const newVal: WideString); dispid 45;
  end;

// *********************************************************************//
// Interface: ILabel
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4B341A36-CFA6-4421-9D08-FD5B06097307}
// *********************************************************************//
  ILabel = interface(IDispatch)
    ['{4B341A36-CFA6-4421-9D08-FD5B06097307}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(retval: WordBool); safecall;
    function Get_Rotation: Double; safecall;
    procedure Set_Rotation(retval: Double); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const retval: WideString); safecall;
    function Get_x: Double; safecall;
    procedure Set_x(retval: Double); safecall;
    function Get_y: Double; safecall;
    procedure Set_y(retval: Double); safecall;
    function Get_IsDrawn: WordBool; safecall;
    function Get_Category: Integer; safecall;
    procedure Set_Category(retval: Integer); safecall;
    function Get_ScreenExtents: IExtents; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Rotation: Double read Get_Rotation write Set_Rotation;
    property Text: WideString read Get_Text write Set_Text;
    property x: Double read Get_x write Set_x;
    property y: Double read Get_y write Set_y;
    property IsDrawn: WordBool read Get_IsDrawn;
    property Category: Integer read Get_Category write Set_Category;
    property ScreenExtents: IExtents read Get_ScreenExtents;
  end;

// *********************************************************************//
// DispIntf:  ILabelDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4B341A36-CFA6-4421-9D08-FD5B06097307}
// *********************************************************************//
  ILabelDisp = dispinterface
    ['{4B341A36-CFA6-4421-9D08-FD5B06097307}']
    property Visible: WordBool dispid 1;
    property Rotation: Double dispid 2;
    property Text: WideString dispid 3;
    property x: Double dispid 4;
    property y: Double dispid 5;
    property IsDrawn: WordBool readonly dispid 6;
    property Category: Integer dispid 7;
    property ScreenExtents: IExtents readonly dispid 8;
  end;

// *********************************************************************//
// Interface: IColorScheme
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D2334B3C-0779-4F5F-8771-2F857F0D601E}
// *********************************************************************//
  IColorScheme = interface(IDispatch)
    ['{D2334B3C-0779-4F5F-8771-2F857F0D601E}']
    procedure SetColors(Color1: OLE_COLOR; Color2: OLE_COLOR); safecall;
    procedure SetColors2(Color1: tkMapColor; Color2: tkMapColor); safecall;
    procedure SetColors3(MinRed: Smallint; MinGreen: Smallint; MinBlue: Smallint; MaxRed: Smallint; 
                         MaxGreen: Smallint; MaxBlue: Smallint); safecall;
    procedure SetColors4(Scheme: PredefinedColorScheme); safecall;
    procedure AddBreak(Value: Double; Color: OLE_COLOR); safecall;
    function Remove(Index: Integer): WordBool; safecall;
    procedure Clear; safecall;
    function Get_NumBreaks: Integer; safecall;
    function Get_RandomColor(Value: Double): OLE_COLOR; safecall;
    function Get_GraduatedColor(Value: Double): OLE_COLOR; safecall;
    function Get_BreakColor(Index: Integer): OLE_COLOR; safecall;
    procedure Set_BreakColor(Index: Integer; retval: OLE_COLOR); safecall;
    function Get_BreakValue(Index: Integer): Double; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    property NumBreaks: Integer read Get_NumBreaks;
    property RandomColor[Value: Double]: OLE_COLOR read Get_RandomColor;
    property GraduatedColor[Value: Double]: OLE_COLOR read Get_GraduatedColor;
    property BreakColor[Index: Integer]: OLE_COLOR read Get_BreakColor write Set_BreakColor;
    property BreakValue[Index: Integer]: Double read Get_BreakValue;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IColorSchemeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D2334B3C-0779-4F5F-8771-2F857F0D601E}
// *********************************************************************//
  IColorSchemeDisp = dispinterface
    ['{D2334B3C-0779-4F5F-8771-2F857F0D601E}']
    procedure SetColors(Color1: OLE_COLOR; Color2: OLE_COLOR); dispid 1;
    procedure SetColors2(Color1: tkMapColor; Color2: tkMapColor); dispid 2;
    procedure SetColors3(MinRed: Smallint; MinGreen: Smallint; MinBlue: Smallint; MaxRed: Smallint; 
                         MaxGreen: Smallint; MaxBlue: Smallint); dispid 3;
    procedure SetColors4(Scheme: PredefinedColorScheme); dispid 4;
    procedure AddBreak(Value: Double; Color: OLE_COLOR); dispid 5;
    function Remove(Index: Integer): WordBool; dispid 6;
    procedure Clear; dispid 7;
    property NumBreaks: Integer readonly dispid 8;
    property RandomColor[Value: Double]: OLE_COLOR readonly dispid 9;
    property GraduatedColor[Value: Double]: OLE_COLOR readonly dispid 10;
    property BreakColor[Index: Integer]: OLE_COLOR dispid 11;
    property BreakValue[Index: Integer]: Double readonly dispid 12;
    property LastErrorCode: Integer readonly dispid 13;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 14;
    property GlobalCallback: ICallback dispid 15;
    property Key: WideString dispid 16;
  end;

// *********************************************************************//
// Interface: IPoint
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {74F07889-1380-43EE-837A-BBB268311005}
// *********************************************************************//
  IPoint = interface(IDispatch)
    ['{74F07889-1380-43EE-837A-BBB268311005}']
    function Get_x: Double; safecall;
    procedure Set_x(pVal: Double); safecall;
    function Get_y: Double; safecall;
    procedure Set_y(pVal: Double); safecall;
    function Get_Z: Double; safecall;
    procedure Set_Z(pVal: Double); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_M: Double; safecall;
    procedure Set_M(pVal: Double); safecall;
    function Clone: IPoint; safecall;
    property x: Double read Get_x write Set_x;
    property y: Double read Get_y write Set_y;
    property Z: Double read Get_Z write Set_Z;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property M: Double read Get_M write Set_M;
  end;

// *********************************************************************//
// DispIntf:  IPointDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {74F07889-1380-43EE-837A-BBB268311005}
// *********************************************************************//
  IPointDisp = dispinterface
    ['{74F07889-1380-43EE-837A-BBB268311005}']
    property x: Double dispid 1;
    property y: Double dispid 2;
    property Z: Double dispid 3;
    property LastErrorCode: Integer readonly dispid 4;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 5;
    property GlobalCallback: ICallback dispid 6;
    property Key: WideString dispid 7;
    property M: Double dispid 8;
    function Clone: IPoint; dispid 9;
  end;

// *********************************************************************//
// Interface: IShapefile
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5DC72405-C39C-4755-8CFC-9876A89225BC}
// *********************************************************************//
  IShapefile = interface(IDispatch)
    ['{5DC72405-C39C-4755-8CFC-9876A89225BC}']
    function Get_NumShapes: Integer; safecall;
    function Get_NumFields: Integer; safecall;
    function Get_Extents: IExtents; safecall;
    function Get_ShapefileType: ShpfileType; safecall;
    function Get_Shape(ShapeIndex: Integer): IShape; safecall;
    function Get_EditingShapes: WordBool; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_CdlgFilter: WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Open(const ShapefileName: WideString; const cBack: ICallback): WordBool; safecall;
    function CreateNew(const ShapefileName: WideString; ShapefileType: ShpfileType): WordBool; safecall;
    function SaveAs(const ShapefileName: WideString; const cBack: ICallback): WordBool; safecall;
    function Close: WordBool; safecall;
    function EditClear: WordBool; safecall;
    function EditInsertShape(const Shape: IShape; var ShapeIndex: Integer): WordBool; safecall;
    function EditDeleteShape(ShapeIndex: Integer): WordBool; safecall;
    function SelectShapes(const BoundBox: IExtents; Tolerance: Double; SelectMode: SelectMode; 
                          var Result: OleVariant): WordBool; safecall;
    function StartEditingShapes(StartEditTable: WordBool; const cBack: ICallback): WordBool; safecall;
    function StopEditingShapes(ApplyChanges: WordBool; StopEditTable: WordBool; 
                               const cBack: ICallback): WordBool; safecall;
    function EditInsertField(const NewField: IField; var FieldIndex: Integer; const cBack: ICallback): WordBool; safecall;
    function EditDeleteField(FieldIndex: Integer; const cBack: ICallback): WordBool; safecall;
    function EditCellValue(FieldIndex: Integer; ShapeIndex: Integer; newVal: OleVariant): WordBool; safecall;
    function StartEditingTable(const cBack: ICallback): WordBool; safecall;
    function StopEditingTable(ApplyChanges: WordBool; const cBack: ICallback): WordBool; safecall;
    function Get_Field(FieldIndex: Integer): IField; safecall;
    function Get_CellValue(FieldIndex: Integer; ShapeIndex: Integer): OleVariant; safecall;
    function Get_EditingTable: WordBool; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_FileHandle: Integer; safecall;
    function Get_Filename: WideString; safecall;
    function QuickPoint(ShapeIndex: Integer; PointIndex: Integer): IPoint; safecall;
    function QuickExtents(ShapeIndex: Integer): IExtents; safecall;
    function QuickPoints(ShapeIndex: Integer; var numPoints: Integer): PSafeArray; safecall;
    function PointInShape(ShapeIndex: Integer; x: Double; y: Double): WordBool; safecall;
    function PointInShapefile(x: Double; y: Double): Integer; safecall;
    function BeginPointInShapefile: WordBool; safecall;
    procedure EndPointInShapefile; safecall;
    function Get_Projection: WideString; safecall;
    procedure Set_Projection(const pVal: WideString); safecall;
    function Get_FieldByName(const Fieldname: WideString): IField; safecall;
    function Get_numPoints(ShapeIndex: Integer): Integer; safecall;
    function CreateNewWithShapeID(const ShapefileName: WideString; ShapefileType: ShpfileType): WordBool; safecall;
    function Get_UseSpatialIndex: WordBool; safecall;
    procedure Set_UseSpatialIndex(pVal: WordBool); safecall;
    function CreateSpatialIndex(const ShapefileName: WideString): WordBool; safecall;
    function Get_HasSpatialIndex: WordBool; safecall;
    procedure Set_HasSpatialIndex(pVal: WordBool); safecall;
    function Resource(const newShpPath: WideString): WordBool; safecall;
    function Get_CacheExtents: WordBool; safecall;
    procedure Set_CacheExtents(pVal: WordBool); safecall;
    function RefreshExtents: WordBool; safecall;
    function RefreshShapeExtents(ShapeId: Integer): WordBool; safecall;
    procedure QuickQueryInEditMode(const BoundBox: IExtents; var Result: PSYSINT1; 
                                   var ResultCount: SYSINT); safecall;
    function Get_UseQTree: WordBool; safecall;
    procedure Set_UseQTree(pVal: WordBool); safecall;
    function Save(const cBack: ICallback): WordBool; safecall;
    function IsSpatialIndexValid: WordBool; safecall;
    procedure Set_SpatialIndexMaxAreaPercent(pVal: Double); safecall;
    function Get_SpatialIndexMaxAreaPercent: Double; safecall;
    function Get_CanUseSpatialIndex(const pArea: IExtents): WordBool; safecall;
    function GetIntersection(SelectedOnlyOfThis: WordBool; const sf: IShapefile; 
                             SelectedOnly: WordBool; fileType: ShpfileType; const cBack: ICallback): IShapefile; safecall;
    function SelectByShapefile(const sf: IShapefile; Relation: tkSpatialRelation; 
                               SelectedOnly: WordBool; var Result: OleVariant; 
                               const cBack: ICallback): WordBool; safecall;
    function Get_NumSelected: Integer; safecall;
    function Get_ShapeSelected(ShapeIndex: Integer): WordBool; safecall;
    procedure Set_ShapeSelected(ShapeIndex: Integer; pVal: WordBool); safecall;
    function Get_SelectionDrawingOptions: IShapeDrawingOptions; safecall;
    procedure Set_SelectionDrawingOptions(const pVal: IShapeDrawingOptions); safecall;
    procedure SelectAll; safecall;
    procedure SelectNone; safecall;
    procedure InvertSelection; safecall;
    function Dissolve(FieldIndex: Integer; SelectedOnly: WordBool): IShapefile; safecall;
    function Get_Labels: ILabels; safecall;
    procedure Set_Labels(const pVal: ILabels); safecall;
    function GenerateLabels(FieldIndex: Integer; Method: tkLabelPositioning; 
                            LargestPartOnly: WordBool): Integer; safecall;
    function Clone: IShapefile; safecall;
    function Get_DefaultDrawingOptions: IShapeDrawingOptions; safecall;
    procedure Set_DefaultDrawingOptions(const pVal: IShapeDrawingOptions); safecall;
    function Get_Categories: IShapefileCategories; safecall;
    procedure Set_Categories(const pVal: IShapefileCategories); safecall;
    function Get_Charts: ICharts; safecall;
    procedure Set_Charts(const pVal: ICharts); safecall;
    function Get_ShapeCategory(ShapeIndex: Integer): Integer; safecall;
    procedure Set_ShapeCategory(ShapeIndex: Integer; pVal: Integer); safecall;
    function Get_Table: ITable; safecall;
    function Get_VisibilityExpression: WideString; safecall;
    procedure Set_VisibilityExpression(const pVal: WideString); safecall;
    function Get_FastMode: WordBool; safecall;
    procedure Set_FastMode(pVal: WordBool); safecall;
    function Get_MinDrawingSize: Integer; safecall;
    procedure Set_MinDrawingSize(pVal: Integer); safecall;
    function Get_SourceType: tkShapefileSourceType; safecall;
    function BufferByDistance(Distance: Double; nSegments: Integer; SelectedOnly: WordBool; 
                              MergeResults: WordBool): IShapefile; safecall;
    function Get_GeometryEngine: tkGeometryEngine; safecall;
    procedure Set_GeometryEngine(pVal: tkGeometryEngine); safecall;
    function Difference(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                        SelectedOnlyOverlay: WordBool): IShapefile; safecall;
    function Clip(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                  SelectedOnlyOverlay: WordBool): IShapefile; safecall;
    function SymmDifference(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                            SelectedOnlyOverlay: WordBool): IShapefile; safecall;
    function Union(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                   SelectedOnlyOverlay: WordBool): IShapefile; safecall;
    function ExplodeShapes(SelectedOnly: WordBool): IShapefile; safecall;
    function AggregateShapes(SelectedOnly: WordBool; FieldIndex: Integer): IShapefile; safecall;
    function ExportSelection: IShapefile; safecall;
    function Sort(FieldIndex: Integer; Ascending: WordBool): IShapefile; safecall;
    function Merge(SelectedOnlyThis: WordBool; const sf: IShapefile; SelectedOnly: WordBool): IShapefile; safecall;
    function Get_SelectionColor: OLE_COLOR; safecall;
    procedure Set_SelectionColor(retval: OLE_COLOR); safecall;
    function Get_SelectionAppearance: tkSelectionAppearance; safecall;
    procedure Set_SelectionAppearance(retval: tkSelectionAppearance); safecall;
    function Get_CollisionMode: tkCollisionMode; safecall;
    procedure Set_CollisionMode(retval: tkCollisionMode); safecall;
    function Get_SelectionTransparency: Byte; safecall;
    procedure Set_SelectionTransparency(retval: Byte); safecall;
    procedure Set_StopExecution(const Param1: IStopExecution); safecall;
    function Serialize(SaveSelection: WordBool): WideString; safecall;
    procedure Deserialize(LoadSelection: WordBool; const newVal: WideString); safecall;
    property NumShapes: Integer read Get_NumShapes;
    property NumFields: Integer read Get_NumFields;
    property Extents: IExtents read Get_Extents;
    property ShapefileType: ShpfileType read Get_ShapefileType;
    property Shape[ShapeIndex: Integer]: IShape read Get_Shape;
    property EditingShapes: WordBool read Get_EditingShapes;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property CdlgFilter: WideString read Get_CdlgFilter;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Field[FieldIndex: Integer]: IField read Get_Field;
    property CellValue[FieldIndex: Integer; ShapeIndex: Integer]: OleVariant read Get_CellValue;
    property EditingTable: WordBool read Get_EditingTable;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property FileHandle: Integer read Get_FileHandle;
    property Filename: WideString read Get_Filename;
    property Projection: WideString read Get_Projection write Set_Projection;
    property FieldByName[const Fieldname: WideString]: IField read Get_FieldByName;
    property numPoints[ShapeIndex: Integer]: Integer read Get_numPoints;
    property UseSpatialIndex: WordBool read Get_UseSpatialIndex write Set_UseSpatialIndex;
    property HasSpatialIndex: WordBool read Get_HasSpatialIndex write Set_HasSpatialIndex;
    property CacheExtents: WordBool read Get_CacheExtents write Set_CacheExtents;
    property UseQTree: WordBool read Get_UseQTree write Set_UseQTree;
    property SpatialIndexMaxAreaPercent: Double read Get_SpatialIndexMaxAreaPercent write Set_SpatialIndexMaxAreaPercent;
    property CanUseSpatialIndex[const pArea: IExtents]: WordBool read Get_CanUseSpatialIndex;
    property NumSelected: Integer read Get_NumSelected;
    property ShapeSelected[ShapeIndex: Integer]: WordBool read Get_ShapeSelected write Set_ShapeSelected;
    property SelectionDrawingOptions: IShapeDrawingOptions read Get_SelectionDrawingOptions write Set_SelectionDrawingOptions;
    property Labels: ILabels read Get_Labels write Set_Labels;
    property DefaultDrawingOptions: IShapeDrawingOptions read Get_DefaultDrawingOptions write Set_DefaultDrawingOptions;
    property Categories: IShapefileCategories read Get_Categories write Set_Categories;
    property Charts: ICharts read Get_Charts write Set_Charts;
    property ShapeCategory[ShapeIndex: Integer]: Integer read Get_ShapeCategory write Set_ShapeCategory;
    property Table: ITable read Get_Table;
    property VisibilityExpression: WideString read Get_VisibilityExpression write Set_VisibilityExpression;
    property FastMode: WordBool read Get_FastMode write Set_FastMode;
    property MinDrawingSize: Integer read Get_MinDrawingSize write Set_MinDrawingSize;
    property SourceType: tkShapefileSourceType read Get_SourceType;
    property GeometryEngine: tkGeometryEngine read Get_GeometryEngine write Set_GeometryEngine;
    property SelectionColor: OLE_COLOR read Get_SelectionColor write Set_SelectionColor;
    property SelectionAppearance: tkSelectionAppearance read Get_SelectionAppearance write Set_SelectionAppearance;
    property CollisionMode: tkCollisionMode read Get_CollisionMode write Set_CollisionMode;
    property SelectionTransparency: Byte read Get_SelectionTransparency write Set_SelectionTransparency;
    property StopExecution: IStopExecution write Set_StopExecution;
  end;

// *********************************************************************//
// DispIntf:  IShapefileDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5DC72405-C39C-4755-8CFC-9876A89225BC}
// *********************************************************************//
  IShapefileDisp = dispinterface
    ['{5DC72405-C39C-4755-8CFC-9876A89225BC}']
    property NumShapes: Integer readonly dispid 1;
    property NumFields: Integer readonly dispid 2;
    property Extents: IExtents readonly dispid 3;
    property ShapefileType: ShpfileType readonly dispid 4;
    property Shape[ShapeIndex: Integer]: IShape readonly dispid 5;
    property EditingShapes: WordBool readonly dispid 6;
    property LastErrorCode: Integer readonly dispid 7;
    property CdlgFilter: WideString readonly dispid 8;
    property GlobalCallback: ICallback dispid 9;
    property Key: WideString dispid 10;
    function Open(const ShapefileName: WideString; const cBack: ICallback): WordBool; dispid 11;
    function CreateNew(const ShapefileName: WideString; ShapefileType: ShpfileType): WordBool; dispid 12;
    function SaveAs(const ShapefileName: WideString; const cBack: ICallback): WordBool; dispid 13;
    function Close: WordBool; dispid 14;
    function EditClear: WordBool; dispid 15;
    function EditInsertShape(const Shape: IShape; var ShapeIndex: Integer): WordBool; dispid 16;
    function EditDeleteShape(ShapeIndex: Integer): WordBool; dispid 17;
    function SelectShapes(const BoundBox: IExtents; Tolerance: Double; SelectMode: SelectMode; 
                          var Result: OleVariant): WordBool; dispid 18;
    function StartEditingShapes(StartEditTable: WordBool; const cBack: ICallback): WordBool; dispid 19;
    function StopEditingShapes(ApplyChanges: WordBool; StopEditTable: WordBool; 
                               const cBack: ICallback): WordBool; dispid 20;
    function EditInsertField(const NewField: IField; var FieldIndex: Integer; const cBack: ICallback): WordBool; dispid 22;
    function EditDeleteField(FieldIndex: Integer; const cBack: ICallback): WordBool; dispid 23;
    function EditCellValue(FieldIndex: Integer; ShapeIndex: Integer; newVal: OleVariant): WordBool; dispid 24;
    function StartEditingTable(const cBack: ICallback): WordBool; dispid 25;
    function StopEditingTable(ApplyChanges: WordBool; const cBack: ICallback): WordBool; dispid 26;
    property Field[FieldIndex: Integer]: IField readonly dispid 27;
    property CellValue[FieldIndex: Integer; ShapeIndex: Integer]: OleVariant readonly dispid 28;
    property EditingTable: WordBool readonly dispid 29;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 21;
    property FileHandle: Integer readonly dispid 30;
    property Filename: WideString readonly dispid 31;
    function QuickPoint(ShapeIndex: Integer; PointIndex: Integer): IPoint; dispid 32;
    function QuickExtents(ShapeIndex: Integer): IExtents; dispid 33;
    function QuickPoints(ShapeIndex: Integer; var numPoints: Integer): {??PSafeArray}OleVariant; dispid 34;
    function PointInShape(ShapeIndex: Integer; x: Double; y: Double): WordBool; dispid 35;
    function PointInShapefile(x: Double; y: Double): Integer; dispid 36;
    function BeginPointInShapefile: WordBool; dispid 37;
    procedure EndPointInShapefile; dispid 38;
    property Projection: WideString dispid 39;
    property FieldByName[const Fieldname: WideString]: IField readonly dispid 40;
    property numPoints[ShapeIndex: Integer]: Integer readonly dispid 41;
    function CreateNewWithShapeID(const ShapefileName: WideString; ShapefileType: ShpfileType): WordBool; dispid 42;
    property UseSpatialIndex: WordBool dispid 43;
    function CreateSpatialIndex(const ShapefileName: WideString): WordBool; dispid 44;
    property HasSpatialIndex: WordBool dispid 45;
    function Resource(const newShpPath: WideString): WordBool; dispid 46;
    property CacheExtents: WordBool dispid 47;
    function RefreshExtents: WordBool; dispid 48;
    function RefreshShapeExtents(ShapeId: Integer): WordBool; dispid 49;
    procedure QuickQueryInEditMode(const BoundBox: IExtents; var Result: {??PSYSINT1}OleVariant; 
                                   var ResultCount: SYSINT); dispid 50;
    property UseQTree: WordBool dispid 51;
    function Save(const cBack: ICallback): WordBool; dispid 52;
    function IsSpatialIndexValid: WordBool; dispid 53;
    property SpatialIndexMaxAreaPercent: Double dispid 54;
    property CanUseSpatialIndex[const pArea: IExtents]: WordBool readonly dispid 55;
    function GetIntersection(SelectedOnlyOfThis: WordBool; const sf: IShapefile; 
                             SelectedOnly: WordBool; fileType: ShpfileType; const cBack: ICallback): IShapefile; dispid 56;
    function SelectByShapefile(const sf: IShapefile; Relation: tkSpatialRelation; 
                               SelectedOnly: WordBool; var Result: OleVariant; 
                               const cBack: ICallback): WordBool; dispid 57;
    property NumSelected: Integer readonly dispid 58;
    property ShapeSelected[ShapeIndex: Integer]: WordBool dispid 59;
    property SelectionDrawingOptions: IShapeDrawingOptions dispid 60;
    procedure SelectAll; dispid 62;
    procedure SelectNone; dispid 63;
    procedure InvertSelection; dispid 64;
    function Dissolve(FieldIndex: Integer; SelectedOnly: WordBool): IShapefile; dispid 65;
    property Labels: ILabels dispid 66;
    function GenerateLabels(FieldIndex: Integer; Method: tkLabelPositioning; 
                            LargestPartOnly: WordBool): Integer; dispid 67;
    function Clone: IShapefile; dispid 68;
    property DefaultDrawingOptions: IShapeDrawingOptions dispid 69;
    property Categories: IShapefileCategories dispid 70;
    property Charts: ICharts dispid 71;
    property ShapeCategory[ShapeIndex: Integer]: Integer dispid 72;
    property Table: ITable readonly dispid 73;
    property VisibilityExpression: WideString dispid 74;
    property FastMode: WordBool dispid 75;
    property MinDrawingSize: Integer dispid 76;
    property SourceType: tkShapefileSourceType readonly dispid 77;
    function BufferByDistance(Distance: Double; nSegments: Integer; SelectedOnly: WordBool; 
                              MergeResults: WordBool): IShapefile; dispid 78;
    property GeometryEngine: tkGeometryEngine dispid 79;
    function Difference(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                        SelectedOnlyOverlay: WordBool): IShapefile; dispid 80;
    function Clip(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                  SelectedOnlyOverlay: WordBool): IShapefile; dispid 81;
    function SymmDifference(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                            SelectedOnlyOverlay: WordBool): IShapefile; dispid 82;
    function Union(SelectedOnlySubject: WordBool; const sfOverlay: IShapefile; 
                   SelectedOnlyOverlay: WordBool): IShapefile; dispid 83;
    function ExplodeShapes(SelectedOnly: WordBool): IShapefile; dispid 84;
    function AggregateShapes(SelectedOnly: WordBool; FieldIndex: Integer): IShapefile; dispid 85;
    function ExportSelection: IShapefile; dispid 86;
    function Sort(FieldIndex: Integer; Ascending: WordBool): IShapefile; dispid 87;
    function Merge(SelectedOnlyThis: WordBool; const sf: IShapefile; SelectedOnly: WordBool): IShapefile; dispid 88;
    property SelectionColor: OLE_COLOR dispid 89;
    property SelectionAppearance: tkSelectionAppearance dispid 90;
    property CollisionMode: tkCollisionMode dispid 91;
    property SelectionTransparency: Byte dispid 92;
    property StopExecution: IStopExecution writeonly dispid 93;
    function Serialize(SaveSelection: WordBool): WideString; dispid 94;
    procedure Deserialize(LoadSelection: WordBool; const newVal: WideString); dispid 95;
  end;

// *********************************************************************//
// Interface: IShape
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5FA550E3-2044-4034-BAAA-B4CCE90A0C41}
// *********************************************************************//
  IShape = interface(IDispatch)
    ['{5FA550E3-2044-4034-BAAA-B4CCE90A0C41}']
    function Get_numPoints: Integer; safecall;
    function Get_NumParts: Integer; safecall;
    function Get_ShapeType: ShpfileType; safecall;
    procedure Set_ShapeType(pVal: ShpfileType); safecall;
    function Get_Point(PointIndex: Integer): IPoint; safecall;
    procedure Set_Point(PointIndex: Integer; const pVal: IPoint); safecall;
    function Get_Part(PartIndex: Integer): Integer; safecall;
    procedure Set_Part(PartIndex: Integer; pVal: Integer); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Create(ShpType: ShpfileType): WordBool; safecall;
    function InsertPoint(const NewPoint: IPoint; var PointIndex: Integer): WordBool; safecall;
    function DeletePoint(PointIndex: Integer): WordBool; safecall;
    function InsertPart(PointIndex: Integer; var PartIndex: Integer): WordBool; safecall;
    function DeletePart(PartIndex: Integer): WordBool; safecall;
    function Get_Extents: IExtents; safecall;
    function SerializeToString: WideString; safecall;
    function CreateFromString(const Serialized: WideString): WordBool; safecall;
    function PointInThisPoly(const pt: IPoint): WordBool; safecall;
    function Get_Centroid: IPoint; safecall;
    function Get_Length: Double; safecall;
    function Get_Perimeter: Double; safecall;
    function Get_Area: Double; safecall;
    function Relates(const Shape: IShape; Relation: tkSpatialRelation): WordBool; safecall;
    function Distance(const Shape: IShape): Double; safecall;
    function Buffer(Distance: Double; nQuadSegments: Integer): IShape; safecall;
    function Clip(const Shape: IShape; Operation: tkClipOperation): IShape; safecall;
    function Contains(const Shape: IShape): WordBool; safecall;
    function Crosses(const Shape: IShape): WordBool; safecall;
    function Disjoint(const Shape: IShape): WordBool; safecall;
    function Equals(const Shape: IShape): WordBool; safecall;
    function Intersects(const Shape: IShape): WordBool; safecall;
    function Overlaps(const Shape: IShape): WordBool; safecall;
    function Touches(const Shape: IShape): WordBool; safecall;
    function Within(const Shape: IShape): WordBool; safecall;
    function Boundry: IShape; safecall;
    function ConvexHull: IShape; safecall;
    function Get_IsValid: WordBool; safecall;
    function Get_XY(PointIndex: Integer; var x: Double; var y: Double): WordBool; safecall;
    function Get_PartIsClockWise(PartIndex: Integer): WordBool; safecall;
    function ReversePointsOrder(PartIndex: Integer): WordBool; safecall;
    function GetIntersection(const Shape: IShape; out Results: OleVariant): WordBool; safecall;
    function Get_Center: IPoint; safecall;
    function Get_EndOfPart(PartIndex: Integer): Integer; safecall;
    function Get_PartAsShape(PartIndex: Integer): IShape; safecall;
    function Get_IsValidReason: WideString; safecall;
    function Get_InteriorPoint: IPoint; safecall;
    function Clone: IShape; safecall;
    function Explode(var Results: OleVariant): WordBool; safecall;
    function put_XY(PointIndex: Integer; x: Double; y: Double): WordBool; safecall;
    property numPoints: Integer read Get_numPoints;
    property NumParts: Integer read Get_NumParts;
    property ShapeType: ShpfileType read Get_ShapeType write Set_ShapeType;
    property Point[PointIndex: Integer]: IPoint read Get_Point write Set_Point;
    property Part[PartIndex: Integer]: Integer read Get_Part write Set_Part;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Extents: IExtents read Get_Extents;
    property Centroid: IPoint read Get_Centroid;
    property Length: Double read Get_Length;
    property Perimeter: Double read Get_Perimeter;
    property Area: Double read Get_Area;
    property IsValid: WordBool read Get_IsValid;
    property XY[PointIndex: Integer; var x: Double; var y: Double]: WordBool read Get_XY;
    property PartIsClockWise[PartIndex: Integer]: WordBool read Get_PartIsClockWise;
    property Center: IPoint read Get_Center;
    property EndOfPart[PartIndex: Integer]: Integer read Get_EndOfPart;
    property PartAsShape[PartIndex: Integer]: IShape read Get_PartAsShape;
    property IsValidReason: WideString read Get_IsValidReason;
    property InteriorPoint: IPoint read Get_InteriorPoint;
  end;

// *********************************************************************//
// DispIntf:  IShapeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5FA550E3-2044-4034-BAAA-B4CCE90A0C41}
// *********************************************************************//
  IShapeDisp = dispinterface
    ['{5FA550E3-2044-4034-BAAA-B4CCE90A0C41}']
    property numPoints: Integer readonly dispid 1;
    property NumParts: Integer readonly dispid 2;
    property ShapeType: ShpfileType dispid 3;
    property Point[PointIndex: Integer]: IPoint dispid 4;
    property Part[PartIndex: Integer]: Integer dispid 5;
    property LastErrorCode: Integer readonly dispid 6;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 7;
    property GlobalCallback: ICallback dispid 8;
    property Key: WideString dispid 9;
    function Create(ShpType: ShpfileType): WordBool; dispid 10;
    function InsertPoint(const NewPoint: IPoint; var PointIndex: Integer): WordBool; dispid 11;
    function DeletePoint(PointIndex: Integer): WordBool; dispid 12;
    function InsertPart(PointIndex: Integer; var PartIndex: Integer): WordBool; dispid 13;
    function DeletePart(PartIndex: Integer): WordBool; dispid 14;
    property Extents: IExtents readonly dispid 15;
    function SerializeToString: WideString; dispid 16;
    function CreateFromString(const Serialized: WideString): WordBool; dispid 17;
    function PointInThisPoly(const pt: IPoint): WordBool; dispid 18;
    property Centroid: IPoint readonly dispid 19;
    property Length: Double readonly dispid 24;
    property Perimeter: Double readonly dispid 25;
    property Area: Double readonly dispid 26;
    function Relates(const Shape: IShape; Relation: tkSpatialRelation): WordBool; dispid 20;
    function Distance(const Shape: IShape): Double; dispid 21;
    function Buffer(Distance: Double; nQuadSegments: Integer): IShape; dispid 22;
    function Clip(const Shape: IShape; Operation: tkClipOperation): IShape; dispid 23;
    function Contains(const Shape: IShape): WordBool; dispid 27;
    function Crosses(const Shape: IShape): WordBool; dispid 28;
    function Disjoint(const Shape: IShape): WordBool; dispid 29;
    function Equals(const Shape: IShape): WordBool; dispid 30;
    function Intersects(const Shape: IShape): WordBool; dispid 31;
    function Overlaps(const Shape: IShape): WordBool; dispid 32;
    function Touches(const Shape: IShape): WordBool; dispid 33;
    function Within(const Shape: IShape): WordBool; dispid 34;
    function Boundry: IShape; dispid 35;
    function ConvexHull: IShape; dispid 36;
    property IsValid: WordBool readonly dispid 37;
    property XY[PointIndex: Integer; var x: Double; var y: Double]: WordBool readonly dispid 38;
    property PartIsClockWise[PartIndex: Integer]: WordBool readonly dispid 39;
    function ReversePointsOrder(PartIndex: Integer): WordBool; dispid 40;
    function GetIntersection(const Shape: IShape; out Results: OleVariant): WordBool; dispid 41;
    property Center: IPoint readonly dispid 42;
    property EndOfPart[PartIndex: Integer]: Integer readonly dispid 43;
    property PartAsShape[PartIndex: Integer]: IShape readonly dispid 44;
    property IsValidReason: WideString readonly dispid 45;
    property InteriorPoint: IPoint readonly dispid 46;
    function Clone: IShape; dispid 47;
    function Explode(var Results: OleVariant): WordBool; dispid 48;
    function put_XY(PointIndex: Integer; x: Double; y: Double): WordBool; dispid 49;
  end;

// *********************************************************************//
// Interface: IField
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F3751A5-4CF8-4AC3-AFC2-60DE8B90FC7B}
// *********************************************************************//
  IField = interface(IDispatch)
    ['{3F3751A5-4CF8-4AC3-AFC2-60DE8B90FC7B}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pVal: WideString); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pVal: Integer); safecall;
    function Get_Precision: Integer; safecall;
    procedure Set_Precision(pVal: Integer); safecall;
    function Get_type_: FieldType; safecall;
    procedure Set_type_(pVal: FieldType); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Clone: IField; safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Width: Integer read Get_Width write Set_Width;
    property Precision: Integer read Get_Precision write Set_Precision;
    property type_: FieldType read Get_type_ write Set_type_;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IFieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F3751A5-4CF8-4AC3-AFC2-60DE8B90FC7B}
// *********************************************************************//
  IFieldDisp = dispinterface
    ['{3F3751A5-4CF8-4AC3-AFC2-60DE8B90FC7B}']
    property Name: WideString dispid 1;
    property Width: Integer dispid 2;
    property Precision: Integer dispid 3;
    property type_: FieldType dispid 4;
    property LastErrorCode: Integer readonly dispid 5;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 6;
    property GlobalCallback: ICallback dispid 7;
    property Key: WideString dispid 8;
    function Clone: IField; dispid 9;
  end;

// *********************************************************************//
// Interface: IShapeDrawingOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7399B752-61D9-4A23-973F-1033431DD009}
// *********************************************************************//
  IShapeDrawingOptions = interface(IDispatch)
    ['{7399B752-61D9-4A23-973F-1033431DD009}']
    function Get_FillVisible: WordBool; safecall;
    procedure Set_FillVisible(pVal: WordBool); safecall;
    function Get_LineVisible: WordBool; safecall;
    procedure Set_LineVisible(pVal: WordBool); safecall;
    function Get_LineTransparency: Single; safecall;
    procedure Set_LineTransparency(pVal: Single); safecall;
    function Get_FillColor: OLE_COLOR; safecall;
    procedure Set_FillColor(pVal: OLE_COLOR); safecall;
    function Get_LineColor: OLE_COLOR; safecall;
    procedure Set_LineColor(pVal: OLE_COLOR); safecall;
    function Get_DrawingMode: tkVectorDrawingMode; safecall;
    procedure Set_DrawingMode(pVal: tkVectorDrawingMode); safecall;
    function Get_FillHatchStyle: tkGDIPlusHatchStyle; safecall;
    procedure Set_FillHatchStyle(pVal: tkGDIPlusHatchStyle); safecall;
    function Get_LineStipple: tkDashStyle; safecall;
    procedure Set_LineStipple(pVal: tkDashStyle); safecall;
    function Get_PointShape: tkPointShapeType; safecall;
    procedure Set_PointShape(pVal: tkPointShapeType); safecall;
    function Get_FillTransparency: Single; safecall;
    procedure Set_FillTransparency(pVal: Single); safecall;
    function Get_LineWidth: Single; safecall;
    procedure Set_LineWidth(pVal: Single); safecall;
    function Get_PointSize: Single; safecall;
    procedure Set_PointSize(pVal: Single); safecall;
    function Get_FillBgTransparent: WordBool; safecall;
    procedure Set_FillBgTransparent(pVal: WordBool); safecall;
    function Get_FillBgColor: OLE_COLOR; safecall;
    procedure Set_FillBgColor(pVal: OLE_COLOR); safecall;
    function Get_Picture: IImage; safecall;
    procedure Set_Picture(const pVal: IImage); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_FillType: tkFillType; safecall;
    procedure Set_FillType(pVal: tkFillType); safecall;
    function Get_FillGradientType: tkGradientType; safecall;
    procedure Set_FillGradientType(pVal: tkGradientType); safecall;
    function Get_PointType: tkPointSymbolType; safecall;
    procedure Set_PointType(pVal: tkPointSymbolType); safecall;
    function Get_FillColor2: OLE_COLOR; safecall;
    procedure Set_FillColor2(pVal: OLE_COLOR); safecall;
    function Get_PointRotation: Double; safecall;
    procedure Set_PointRotation(pVal: Double); safecall;
    function Get_PointSidesCount: Integer; safecall;
    procedure Set_PointSidesCount(pVal: Integer); safecall;
    function Get_PointSidesRatio: Single; safecall;
    procedure Set_PointSidesRatio(pVal: Single); safecall;
    function Get_FillRotation: Double; safecall;
    procedure Set_FillRotation(pVal: Double); safecall;
    function Get_FillGradientBounds: tkGradientBounds; safecall;
    procedure Set_FillGradientBounds(pVal: tkGradientBounds); safecall;
    function Get_PictureScaleX: Double; safecall;
    procedure Set_PictureScaleX(pVal: Double); safecall;
    function Get_PictureScaleY: Double; safecall;
    procedure Set_PictureScaleY(pVal: Double); safecall;
    function DrawShape(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                       ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; const Shape: IShape; 
                       drawVertices: WordBool): WordBool; safecall;
    function Get_PointCharacter: Smallint; safecall;
    procedure Set_PointCharacter(pVal: Smallint); safecall;
    function Get_FontName: WideString; safecall;
    procedure Set_FontName(const pVal: WideString); safecall;
    function Clone: IShapeDrawingOptions; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function DrawRectangle(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                           ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; 
                           rectWidth: SYSINT; rectHeight: SYSINT; drawVertices: WordBool): WordBool; safecall;
    function DrawPoint(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                       ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT): WordBool; safecall;
    function Get_VerticesVisible: WordBool; safecall;
    procedure Set_VerticesVisible(pVal: WordBool); safecall;
    function Get_VerticesType: tkVertexType; safecall;
    procedure Set_VerticesType(pVal: tkVertexType); safecall;
    function Get_VerticesColor: OLE_COLOR; safecall;
    procedure Set_VerticesColor(pVal: OLE_COLOR); safecall;
    function Get_VerticesSize: Integer; safecall;
    procedure Set_VerticesSize(pVal: Integer); safecall;
    function Get_VerticesFillVisible: WordBool; safecall;
    procedure Set_VerticesFillVisible(pVal: WordBool); safecall;
    function DrawLine(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                      ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; rectWidth: SYSINT; 
                      rectHeight: SYSINT; drawVertices: WordBool): WordBool; safecall;
    function Get_LinePattern: ILinePattern; safecall;
    procedure Set_LinePattern(const pVal: ILinePattern); safecall;
    function Get_Tag: WideString; safecall;
    procedure Set_Tag(const retval: WideString); safecall;
    procedure SetGradientFill(Color: OLE_COLOR; range: Smallint); safecall;
    procedure SetDefaultPointSymbol(symbol: tkDefaultPointSymbol); safecall;
    function Get_UseLinePattern: WordBool; safecall;
    procedure Set_UseLinePattern(retval: WordBool); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    property FillVisible: WordBool read Get_FillVisible write Set_FillVisible;
    property LineVisible: WordBool read Get_LineVisible write Set_LineVisible;
    property LineTransparency: Single read Get_LineTransparency write Set_LineTransparency;
    property FillColor: OLE_COLOR read Get_FillColor write Set_FillColor;
    property LineColor: OLE_COLOR read Get_LineColor write Set_LineColor;
    property DrawingMode: tkVectorDrawingMode read Get_DrawingMode write Set_DrawingMode;
    property FillHatchStyle: tkGDIPlusHatchStyle read Get_FillHatchStyle write Set_FillHatchStyle;
    property LineStipple: tkDashStyle read Get_LineStipple write Set_LineStipple;
    property PointShape: tkPointShapeType read Get_PointShape write Set_PointShape;
    property FillTransparency: Single read Get_FillTransparency write Set_FillTransparency;
    property LineWidth: Single read Get_LineWidth write Set_LineWidth;
    property PointSize: Single read Get_PointSize write Set_PointSize;
    property FillBgTransparent: WordBool read Get_FillBgTransparent write Set_FillBgTransparent;
    property FillBgColor: OLE_COLOR read Get_FillBgColor write Set_FillBgColor;
    property Picture: IImage read Get_Picture write Set_Picture;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property FillType: tkFillType read Get_FillType write Set_FillType;
    property FillGradientType: tkGradientType read Get_FillGradientType write Set_FillGradientType;
    property PointType: tkPointSymbolType read Get_PointType write Set_PointType;
    property FillColor2: OLE_COLOR read Get_FillColor2 write Set_FillColor2;
    property PointRotation: Double read Get_PointRotation write Set_PointRotation;
    property PointSidesCount: Integer read Get_PointSidesCount write Set_PointSidesCount;
    property PointSidesRatio: Single read Get_PointSidesRatio write Set_PointSidesRatio;
    property FillRotation: Double read Get_FillRotation write Set_FillRotation;
    property FillGradientBounds: tkGradientBounds read Get_FillGradientBounds write Set_FillGradientBounds;
    property PictureScaleX: Double read Get_PictureScaleX write Set_PictureScaleX;
    property PictureScaleY: Double read Get_PictureScaleY write Set_PictureScaleY;
    property PointCharacter: Smallint read Get_PointCharacter write Set_PointCharacter;
    property FontName: WideString read Get_FontName write Set_FontName;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property VerticesVisible: WordBool read Get_VerticesVisible write Set_VerticesVisible;
    property VerticesType: tkVertexType read Get_VerticesType write Set_VerticesType;
    property VerticesColor: OLE_COLOR read Get_VerticesColor write Set_VerticesColor;
    property VerticesSize: Integer read Get_VerticesSize write Set_VerticesSize;
    property VerticesFillVisible: WordBool read Get_VerticesFillVisible write Set_VerticesFillVisible;
    property LinePattern: ILinePattern read Get_LinePattern write Set_LinePattern;
    property Tag: WideString read Get_Tag write Set_Tag;
    property UseLinePattern: WordBool read Get_UseLinePattern write Set_UseLinePattern;
  end;

// *********************************************************************//
// DispIntf:  IShapeDrawingOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7399B752-61D9-4A23-973F-1033431DD009}
// *********************************************************************//
  IShapeDrawingOptionsDisp = dispinterface
    ['{7399B752-61D9-4A23-973F-1033431DD009}']
    property FillVisible: WordBool dispid 1;
    property LineVisible: WordBool dispid 2;
    property LineTransparency: Single dispid 3;
    property FillColor: OLE_COLOR dispid 4;
    property LineColor: OLE_COLOR dispid 5;
    property DrawingMode: tkVectorDrawingMode dispid 6;
    property FillHatchStyle: tkGDIPlusHatchStyle dispid 7;
    property LineStipple: tkDashStyle dispid 8;
    property PointShape: tkPointShapeType dispid 9;
    property FillTransparency: Single dispid 10;
    property LineWidth: Single dispid 11;
    property PointSize: Single dispid 12;
    property FillBgTransparent: WordBool dispid 13;
    property FillBgColor: OLE_COLOR dispid 14;
    property Picture: IImage dispid 15;
    property Visible: WordBool dispid 16;
    property FillType: tkFillType dispid 17;
    property FillGradientType: tkGradientType dispid 18;
    property PointType: tkPointSymbolType dispid 19;
    property FillColor2: OLE_COLOR dispid 20;
    property PointRotation: Double dispid 21;
    property PointSidesCount: Integer dispid 22;
    property PointSidesRatio: Single dispid 23;
    property FillRotation: Double dispid 24;
    property FillGradientBounds: tkGradientBounds dispid 25;
    property PictureScaleX: Double dispid 26;
    property PictureScaleY: Double dispid 27;
    function DrawShape(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                       ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; const Shape: IShape; 
                       drawVertices: WordBool): WordBool; dispid 28;
    property PointCharacter: Smallint dispid 29;
    property FontName: WideString dispid 30;
    function Clone: IShapeDrawingOptions; dispid 31;
    property LastErrorCode: Integer readonly dispid 32;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 33;
    function DrawRectangle(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                           ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; 
                           rectWidth: SYSINT; rectHeight: SYSINT; drawVertices: WordBool): WordBool; dispid 34;
    function DrawPoint(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                       ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT): WordBool; dispid 35;
    property VerticesVisible: WordBool dispid 36;
    property VerticesType: tkVertexType dispid 37;
    property VerticesColor: OLE_COLOR dispid 38;
    property VerticesSize: Integer dispid 39;
    property VerticesFillVisible: WordBool dispid 40;
    function DrawLine(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                      ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT; rectWidth: SYSINT; 
                      rectHeight: SYSINT; drawVertices: WordBool): WordBool; dispid 45;
    property LinePattern: ILinePattern dispid 46;
    property Tag: WideString dispid 47;
    procedure SetGradientFill(Color: OLE_COLOR; range: Smallint); dispid 48;
    procedure SetDefaultPointSymbol(symbol: tkDefaultPointSymbol); dispid 50;
    property UseLinePattern: WordBool dispid 51;
    function Serialize: WideString; dispid 52;
    procedure Deserialize(const newVal: WideString); dispid 53;
  end;

// *********************************************************************//
// Interface: IImage
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {79C5F83E-FB53-4189-9EC4-4AC25440D825}
// *********************************************************************//
  IImage = interface(IDispatch)
    ['{79C5F83E-FB53-4189-9EC4-4AC25440D825}']
    function Open(const ImageFileName: WideString; fileType: ImageType; InRam: WordBool; 
                  const cBack: ICallback): WordBool; safecall;
    function Save(const ImageFileName: WideString; WriteWorldFile: WordBool; fileType: ImageType; 
                  const cBack: ICallback): WordBool; safecall;
    function CreateNew(NewWidth: Integer; NewHeight: Integer): WordBool; safecall;
    function Close: WordBool; safecall;
    function Clear(CanvasColor: OLE_COLOR; const cBack: ICallback): WordBool; safecall;
    function GetRow(Row: Integer; var Vals: Integer): WordBool; safecall;
    function Get_Width: Integer; safecall;
    function Get_Height: Integer; safecall;
    function Get_YllCenter: Double; safecall;
    procedure Set_YllCenter(pVal: Double); safecall;
    function Get_XllCenter: Double; safecall;
    procedure Set_XllCenter(pVal: Double); safecall;
    function Get_dY: Double; safecall;
    procedure Set_dY(pVal: Double); safecall;
    function Get_dX: Double; safecall;
    procedure Set_dX(pVal: Double); safecall;
    function Get_Value(Row: Integer; col: Integer): Integer; safecall;
    procedure Set_Value(Row: Integer; col: Integer; pVal: Integer); safecall;
    function Get_IsInRam: WordBool; safecall;
    function Get_TransparencyColor: OLE_COLOR; safecall;
    procedure Set_TransparencyColor(pVal: OLE_COLOR); safecall;
    function Get_UseTransparencyColor: WordBool; safecall;
    procedure Set_UseTransparencyColor(pVal: WordBool); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_CdlgFilter: WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_FileHandle: Integer; safecall;
    function Get_ImageType: ImageType; safecall;
    function Get_Picture: IPictureDisp; safecall;
    procedure _Set_Picture(const pVal: IPictureDisp); safecall;
    function Get_Filename: WideString; safecall;
    function GetImageBitsDC(hdc: Integer): WordBool; safecall;
    function SetImageBitsDC(hdc: Integer): WordBool; safecall;
    procedure SetVisibleExtents(newMinX: Double; newMinY: Double; newMaxX: Double; newMaxY: Double; 
                                newPixelsInView: Integer; transPercent: Single); safecall;
    function SetProjection(const Proj4: WideString): WordBool; safecall;
    function GetProjection: WideString; safecall;
    function Get_OriginalWidth: Integer; safecall;
    function Get_OriginalHeight: Integer; safecall;
    function Resource(const newImgPath: WideString): WordBool; safecall;
    function _pushSchemetkRaster(const cScheme: IGridColorScheme): WordBool; safecall;
    function GetOriginalXllCenter: Double; safecall;
    function GetOriginalYllCenter: Double; safecall;
    function GetOriginal_dX: Double; safecall;
    function GetOriginal_dY: Double; safecall;
    function GetOriginalHeight: Integer; safecall;
    function GetOriginalWidth: Integer; safecall;
    function Get_AllowHillshade: WordBool; safecall;
    procedure Set_AllowHillshade(pVal: WordBool); safecall;
    function Get_SetToGrey: WordBool; safecall;
    procedure Set_SetToGrey(pVal: WordBool); safecall;
    function Get_UseHistogram: WordBool; safecall;
    procedure Set_UseHistogram(pVal: WordBool); safecall;
    function Get_HasColorTable: WordBool; safecall;
    function Get_PaletteInterpretation: WideString; safecall;
    function Get_BufferSize: SYSINT; safecall;
    procedure Set_BufferSize(pVal: SYSINT); safecall;
    function Get_NoBands: SYSINT; safecall;
    function Get_ImageColorScheme: PredefinedColorScheme; safecall;
    procedure Set_ImageColorScheme(pVal: PredefinedColorScheme); safecall;
    function Get_DrawingMethod: SYSINT; safecall;
    procedure Set_DrawingMethod(retval: SYSINT); safecall;
    function BuildOverviews(ResamplingMethod: tkGDALResamplingMethod; NumOverviews: SYSINT; 
                            OverviewList: PSafeArray): WordBool; safecall;
    function Get_ClearGDALCache: WordBool; safecall;
    procedure Set_ClearGDALCache(retval: WordBool); safecall;
    function Get_TransparencyPercent: Double; safecall;
    procedure Set_TransparencyPercent(retval: Double); safecall;
    function Get_TransparencyColor2: OLE_COLOR; safecall;
    procedure Set_TransparencyColor2(retval: OLE_COLOR); safecall;
    function Get_DownsamplingMode: tkInterpolationMode; safecall;
    procedure Set_DownsamplingMode(retval: tkInterpolationMode); safecall;
    function Get_UpsamplingMode: tkInterpolationMode; safecall;
    procedure Set_UpsamplingMode(retval: tkInterpolationMode); safecall;
    function Get_Labels: ILabels; safecall;
    procedure Set_Labels(const pVal: ILabels); safecall;
    function Get_Extents: IExtents; safecall;
    procedure ProjectionToImage(projX: Double; projY: Double; out ImageX: Integer; 
                                out ImageY: Integer); safecall;
    procedure ImageToProjection(ImageX: Integer; ImageY: Integer; out projX: Double; 
                                out projY: Double); safecall;
    procedure ProjectionToBuffer(projX: Double; projY: Double; out BufferX: Integer; 
                                 out BufferY: Integer); safecall;
    procedure BufferToProjection(BufferX: Integer; BufferY: Integer; out projX: Double; 
                                 out projY: Double); safecall;
    function Get_CanUseGrouping: WordBool; safecall;
    procedure Set_CanUseGrouping(pVal: WordBool); safecall;
    function Get_OriginalXllCenter: Double; safecall;
    procedure Set_OriginalXllCenter(pVal: Double); safecall;
    function Get_OriginalYllCenter: Double; safecall;
    procedure Set_OriginalYllCenter(pVal: Double); safecall;
    function Get_OriginalDX: Double; safecall;
    procedure Set_OriginalDX(pVal: Double); safecall;
    function Get_OriginalDY: Double; safecall;
    procedure Set_OriginalDY(pVal: Double); safecall;
    function GetUniqueColors(MaxBufferSizeMB: Double; out Colors: OleVariant; 
                             out Frequencies: OleVariant): Integer; safecall;
    procedure SetNoDataValue(Value: Double; var Result: WordBool); safecall;
    function Get_NumOverviews: SYSINT; safecall;
    function LoadBuffer(maxBufferSize: Double): WordBool; safecall;
    function Get_SourceType: tkImageSourceType; safecall;
    function Serialize(SerializePixels: WordBool): WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property YllCenter: Double read Get_YllCenter write Set_YllCenter;
    property XllCenter: Double read Get_XllCenter write Set_XllCenter;
    property dY: Double read Get_dY write Set_dY;
    property dX: Double read Get_dX write Set_dX;
    property Value[Row: Integer; col: Integer]: Integer read Get_Value write Set_Value;
    property IsInRam: WordBool read Get_IsInRam;
    property TransparencyColor: OLE_COLOR read Get_TransparencyColor write Set_TransparencyColor;
    property UseTransparencyColor: WordBool read Get_UseTransparencyColor write Set_UseTransparencyColor;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property CdlgFilter: WideString read Get_CdlgFilter;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property FileHandle: Integer read Get_FileHandle;
    property ImageType: ImageType read Get_ImageType;
    property Picture: IPictureDisp read Get_Picture write _Set_Picture;
    property Filename: WideString read Get_Filename;
    property OriginalWidth: Integer read Get_OriginalWidth;
    property OriginalHeight: Integer read Get_OriginalHeight;
    property AllowHillshade: WordBool read Get_AllowHillshade write Set_AllowHillshade;
    property SetToGrey: WordBool read Get_SetToGrey write Set_SetToGrey;
    property UseHistogram: WordBool read Get_UseHistogram write Set_UseHistogram;
    property HasColorTable: WordBool read Get_HasColorTable;
    property PaletteInterpretation: WideString read Get_PaletteInterpretation;
    property BufferSize: SYSINT read Get_BufferSize write Set_BufferSize;
    property NoBands: SYSINT read Get_NoBands;
    property ImageColorScheme: PredefinedColorScheme read Get_ImageColorScheme write Set_ImageColorScheme;
    property DrawingMethod: SYSINT read Get_DrawingMethod write Set_DrawingMethod;
    property ClearGDALCache: WordBool read Get_ClearGDALCache write Set_ClearGDALCache;
    property TransparencyPercent: Double read Get_TransparencyPercent write Set_TransparencyPercent;
    property TransparencyColor2: OLE_COLOR read Get_TransparencyColor2 write Set_TransparencyColor2;
    property DownsamplingMode: tkInterpolationMode read Get_DownsamplingMode write Set_DownsamplingMode;
    property UpsamplingMode: tkInterpolationMode read Get_UpsamplingMode write Set_UpsamplingMode;
    property Labels: ILabels read Get_Labels write Set_Labels;
    property Extents: IExtents read Get_Extents;
    property CanUseGrouping: WordBool read Get_CanUseGrouping write Set_CanUseGrouping;
    property OriginalXllCenter: Double read Get_OriginalXllCenter write Set_OriginalXllCenter;
    property OriginalYllCenter: Double read Get_OriginalYllCenter write Set_OriginalYllCenter;
    property OriginalDX: Double read Get_OriginalDX write Set_OriginalDX;
    property OriginalDY: Double read Get_OriginalDY write Set_OriginalDY;
    property NumOverviews: SYSINT read Get_NumOverviews;
    property SourceType: tkImageSourceType read Get_SourceType;
  end;

// *********************************************************************//
// DispIntf:  IImageDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {79C5F83E-FB53-4189-9EC4-4AC25440D825}
// *********************************************************************//
  IImageDisp = dispinterface
    ['{79C5F83E-FB53-4189-9EC4-4AC25440D825}']
    function Open(const ImageFileName: WideString; fileType: ImageType; InRam: WordBool; 
                  const cBack: ICallback): WordBool; dispid 1;
    function Save(const ImageFileName: WideString; WriteWorldFile: WordBool; fileType: ImageType; 
                  const cBack: ICallback): WordBool; dispid 2;
    function CreateNew(NewWidth: Integer; NewHeight: Integer): WordBool; dispid 3;
    function Close: WordBool; dispid 4;
    function Clear(CanvasColor: OLE_COLOR; const cBack: ICallback): WordBool; dispid 5;
    function GetRow(Row: Integer; var Vals: Integer): WordBool; dispid 6;
    property Width: Integer readonly dispid 7;
    property Height: Integer readonly dispid 8;
    property YllCenter: Double dispid 9;
    property XllCenter: Double dispid 10;
    property dY: Double dispid 11;
    property dX: Double dispid 12;
    property Value[Row: Integer; col: Integer]: Integer dispid 13;
    property IsInRam: WordBool readonly dispid 14;
    property TransparencyColor: OLE_COLOR dispid 15;
    property UseTransparencyColor: WordBool dispid 16;
    property LastErrorCode: Integer readonly dispid 17;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 18;
    property CdlgFilter: WideString readonly dispid 19;
    property GlobalCallback: ICallback dispid 20;
    property Key: WideString dispid 21;
    property FileHandle: Integer readonly dispid 22;
    property ImageType: ImageType readonly dispid 23;
    property Picture: IPictureDisp dispid 24;
    property Filename: WideString readonly dispid 25;
    function GetImageBitsDC(hdc: Integer): WordBool; dispid 26;
    function SetImageBitsDC(hdc: Integer): WordBool; dispid 27;
    procedure SetVisibleExtents(newMinX: Double; newMinY: Double; newMaxX: Double; newMaxY: Double; 
                                newPixelsInView: Integer; transPercent: Single); dispid 28;
    function SetProjection(const Proj4: WideString): WordBool; dispid 29;
    function GetProjection: WideString; dispid 30;
    property OriginalWidth: Integer readonly dispid 31;
    property OriginalHeight: Integer readonly dispid 32;
    function Resource(const newImgPath: WideString): WordBool; dispid 33;
    function _pushSchemetkRaster(const cScheme: IGridColorScheme): WordBool; dispid 34;
    function GetOriginalXllCenter: Double; dispid 35;
    function GetOriginalYllCenter: Double; dispid 36;
    function GetOriginal_dX: Double; dispid 37;
    function GetOriginal_dY: Double; dispid 38;
    function GetOriginalHeight: Integer; dispid 39;
    function GetOriginalWidth: Integer; dispid 40;
    property AllowHillshade: WordBool dispid 41;
    property SetToGrey: WordBool dispid 42;
    property UseHistogram: WordBool dispid 43;
    property HasColorTable: WordBool readonly dispid 44;
    property PaletteInterpretation: WideString readonly dispid 45;
    property BufferSize: SYSINT dispid 46;
    property NoBands: SYSINT readonly dispid 47;
    property ImageColorScheme: PredefinedColorScheme dispid 48;
    property DrawingMethod: SYSINT dispid 49;
    function BuildOverviews(ResamplingMethod: tkGDALResamplingMethod; NumOverviews: SYSINT; 
                            OverviewList: {??PSafeArray}OleVariant): WordBool; dispid 50;
    property ClearGDALCache: WordBool dispid 51;
    property TransparencyPercent: Double dispid 52;
    property TransparencyColor2: OLE_COLOR dispid 53;
    property DownsamplingMode: tkInterpolationMode dispid 54;
    property UpsamplingMode: tkInterpolationMode dispid 55;
    property Labels: ILabels dispid 56;
    property Extents: IExtents readonly dispid 57;
    procedure ProjectionToImage(projX: Double; projY: Double; out ImageX: Integer; 
                                out ImageY: Integer); dispid 58;
    procedure ImageToProjection(ImageX: Integer; ImageY: Integer; out projX: Double; 
                                out projY: Double); dispid 59;
    procedure ProjectionToBuffer(projX: Double; projY: Double; out BufferX: Integer; 
                                 out BufferY: Integer); dispid 60;
    procedure BufferToProjection(BufferX: Integer; BufferY: Integer; out projX: Double; 
                                 out projY: Double); dispid 61;
    property CanUseGrouping: WordBool dispid 62;
    property OriginalXllCenter: Double dispid 63;
    property OriginalYllCenter: Double dispid 64;
    property OriginalDX: Double dispid 65;
    property OriginalDY: Double dispid 66;
    function GetUniqueColors(MaxBufferSizeMB: Double; out Colors: OleVariant; 
                             out Frequencies: OleVariant): Integer; dispid 67;
    procedure SetNoDataValue(Value: Double; var Result: WordBool); dispid 68;
    property NumOverviews: SYSINT readonly dispid 69;
    function LoadBuffer(maxBufferSize: Double): WordBool; dispid 70;
    property SourceType: tkImageSourceType readonly dispid 71;
    function Serialize(SerializePixels: WordBool): WideString; dispid 72;
    procedure Deserialize(const newVal: WideString); dispid 73;
  end;

// *********************************************************************//
// Interface: IGridColorScheme
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1C43B56D-2065-4953-9138-31AFE8470FF5}
// *********************************************************************//
  IGridColorScheme = interface(IDispatch)
    ['{1C43B56D-2065-4953-9138-31AFE8470FF5}']
    function Get_NumBreaks: Integer; safecall;
    function Get_AmbientIntensity: Double; safecall;
    procedure Set_AmbientIntensity(pVal: Double); safecall;
    function Get_LightSourceIntensity: Double; safecall;
    procedure Set_LightSourceIntensity(pVal: Double); safecall;
    function Get_LightSourceAzimuth: Double; safecall;
    function Get_LightSourceElevation: Double; safecall;
    procedure SetLightSource(Azimuth: Double; Elevation: Double); safecall;
    procedure InsertBreak(const BrkInfo: IGridColorBreak); safecall;
    function Get_Break(Index: Integer): IGridColorBreak; safecall;
    procedure DeleteBreak(Index: Integer); safecall;
    procedure Clear; safecall;
    function Get_NoDataColor: OLE_COLOR; safecall;
    procedure Set_NoDataColor(pVal: OLE_COLOR); safecall;
    procedure UsePredefined(LowValue: Double; HighValue: Double; Preset: PredefinedColorScheme); safecall;
    function GetLightSource: IVector; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    procedure InsertAt(Position: SYSINT; const Break: IGridColorBreak); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    property NumBreaks: Integer read Get_NumBreaks;
    property AmbientIntensity: Double read Get_AmbientIntensity write Set_AmbientIntensity;
    property LightSourceIntensity: Double read Get_LightSourceIntensity write Set_LightSourceIntensity;
    property LightSourceAzimuth: Double read Get_LightSourceAzimuth;
    property LightSourceElevation: Double read Get_LightSourceElevation;
    property Break[Index: Integer]: IGridColorBreak read Get_Break;
    property NoDataColor: OLE_COLOR read Get_NoDataColor write Set_NoDataColor;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IGridColorSchemeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1C43B56D-2065-4953-9138-31AFE8470FF5}
// *********************************************************************//
  IGridColorSchemeDisp = dispinterface
    ['{1C43B56D-2065-4953-9138-31AFE8470FF5}']
    property NumBreaks: Integer readonly dispid 1;
    property AmbientIntensity: Double dispid 2;
    property LightSourceIntensity: Double dispid 3;
    property LightSourceAzimuth: Double readonly dispid 4;
    property LightSourceElevation: Double readonly dispid 5;
    procedure SetLightSource(Azimuth: Double; Elevation: Double); dispid 6;
    procedure InsertBreak(const BrkInfo: IGridColorBreak); dispid 7;
    property Break[Index: Integer]: IGridColorBreak readonly dispid 8;
    procedure DeleteBreak(Index: Integer); dispid 9;
    procedure Clear; dispid 10;
    property NoDataColor: OLE_COLOR dispid 11;
    procedure UsePredefined(LowValue: Double; HighValue: Double; Preset: PredefinedColorScheme); dispid 12;
    function GetLightSource: IVector; dispid 13;
    property LastErrorCode: Integer readonly dispid 14;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 15;
    property GlobalCallback: ICallback dispid 16;
    property Key: WideString dispid 17;
    procedure InsertAt(Position: SYSINT; const Break: IGridColorBreak); dispid 18;
    function Serialize: WideString; dispid 19;
    procedure Deserialize(const newVal: WideString); dispid 20;
  end;

// *********************************************************************//
// Interface: IGridColorBreak
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1C6ECF5D-04FA-43C4-97B1-22D5FFB55FBD}
// *********************************************************************//
  IGridColorBreak = interface(IDispatch)
    ['{1C6ECF5D-04FA-43C4-97B1-22D5FFB55FBD}']
    function Get_HighColor: OLE_COLOR; safecall;
    procedure Set_HighColor(pVal: OLE_COLOR); safecall;
    function Get_LowColor: OLE_COLOR; safecall;
    procedure Set_LowColor(pVal: OLE_COLOR); safecall;
    function Get_HighValue: Double; safecall;
    procedure Set_HighValue(pVal: Double); safecall;
    function Get_LowValue: Double; safecall;
    procedure Set_LowValue(pVal: Double); safecall;
    function Get_ColoringType: ColoringType; safecall;
    procedure Set_ColoringType(pVal: ColoringType); safecall;
    function Get_GradientModel: GradientModel; safecall;
    procedure Set_GradientModel(pVal: GradientModel); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    property HighColor: OLE_COLOR read Get_HighColor write Set_HighColor;
    property LowColor: OLE_COLOR read Get_LowColor write Set_LowColor;
    property HighValue: Double read Get_HighValue write Set_HighValue;
    property LowValue: Double read Get_LowValue write Set_LowValue;
    property ColoringType: ColoringType read Get_ColoringType write Set_ColoringType;
    property GradientModel: GradientModel read Get_GradientModel write Set_GradientModel;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

// *********************************************************************//
// DispIntf:  IGridColorBreakDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1C6ECF5D-04FA-43C4-97B1-22D5FFB55FBD}
// *********************************************************************//
  IGridColorBreakDisp = dispinterface
    ['{1C6ECF5D-04FA-43C4-97B1-22D5FFB55FBD}']
    property HighColor: OLE_COLOR dispid 1;
    property LowColor: OLE_COLOR dispid 2;
    property HighValue: Double dispid 3;
    property LowValue: Double dispid 4;
    property ColoringType: ColoringType dispid 5;
    property GradientModel: GradientModel dispid 6;
    property LastErrorCode: Integer readonly dispid 7;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 8;
    property GlobalCallback: ICallback dispid 9;
    property Key: WideString dispid 10;
    property Caption: WideString dispid 11;
  end;

// *********************************************************************//
// Interface: IVector
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C60625AB-AD4C-405E-8CA2-62E36E4B3F73}
// *********************************************************************//
  IVector = interface(IDispatch)
    ['{C60625AB-AD4C-405E-8CA2-62E36E4B3F73}']
    function Get_i: Double; safecall;
    procedure Set_i(pVal: Double); safecall;
    function Get_j: Double; safecall;
    procedure Set_j(pVal: Double); safecall;
    function Get_k: Double; safecall;
    procedure Set_k(pVal: Double); safecall;
    procedure Normalize; safecall;
    function Dot(const V: IVector): Double; safecall;
    function CrossProduct(const V: IVector): IVector; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    property i: Double read Get_i write Set_i;
    property j: Double read Get_j write Set_j;
    property k: Double read Get_k write Set_k;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IVectorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C60625AB-AD4C-405E-8CA2-62E36E4B3F73}
// *********************************************************************//
  IVectorDisp = dispinterface
    ['{C60625AB-AD4C-405E-8CA2-62E36E4B3F73}']
    property i: Double dispid 1;
    property j: Double dispid 2;
    property k: Double dispid 3;
    procedure Normalize; dispid 4;
    function Dot(const V: IVector): Double; dispid 5;
    function CrossProduct(const V: IVector): IVector; dispid 6;
    property LastErrorCode: Integer readonly dispid 7;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 8;
    property GlobalCallback: ICallback dispid 9;
    property Key: WideString dispid 10;
  end;

// *********************************************************************//
// Interface: ILinePattern
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {54EB7DD1-CEC2-4165-8DBA-13115B079DF1}
// *********************************************************************//
  ILinePattern = interface(IDispatch)
    ['{54EB7DD1-CEC2-4165-8DBA-13115B079DF1}']
    function Get_Key: WideString; safecall;
    procedure Set_Key(const retval: WideString); safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const retval: ICallback); safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_Line(Index: SYSINT): ILineSegment; safecall;
    procedure Set_Line(Index: SYSINT; const retval: ILineSegment); safecall;
    function Get_Count: SYSINT; safecall;
    procedure AddLine(Color: OLE_COLOR; Width: Single; style: tkDashStyle); safecall;
    function InsertLine(Index: SYSINT; Color: OLE_COLOR; Width: Single; style: tkDashStyle): WordBool; safecall;
    function AddMarker(Marker: tkDefaultPointSymbol): ILineSegment; safecall;
    function InsertMarker(Index: SYSINT; Marker: tkDefaultPointSymbol): ILineSegment; safecall;
    function RemoveItem(Index: SYSINT): WordBool; safecall;
    procedure Clear; safecall;
    function Draw(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; ImageHeight: SYSINT; 
                  xOrigin: SYSINT; yOrigin: SYSINT): WordBool; safecall;
    function Get_Transparency: Byte; safecall;
    procedure Set_Transparency(retval: Byte); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    property Key: WideString read Get_Key write Set_Key;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property Line[Index: SYSINT]: ILineSegment read Get_Line write Set_Line;
    property Count: SYSINT read Get_Count;
    property Transparency: Byte read Get_Transparency write Set_Transparency;
  end;

// *********************************************************************//
// DispIntf:  ILinePatternDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {54EB7DD1-CEC2-4165-8DBA-13115B079DF1}
// *********************************************************************//
  ILinePatternDisp = dispinterface
    ['{54EB7DD1-CEC2-4165-8DBA-13115B079DF1}']
    property Key: WideString dispid 1;
    property GlobalCallback: ICallback dispid 2;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 3;
    property LastErrorCode: Integer readonly dispid 4;
    property Line[Index: SYSINT]: ILineSegment dispid 5;
    property Count: SYSINT readonly dispid 6;
    procedure AddLine(Color: OLE_COLOR; Width: Single; style: tkDashStyle); dispid 7;
    function InsertLine(Index: SYSINT; Color: OLE_COLOR; Width: Single; style: tkDashStyle): WordBool; dispid 8;
    function AddMarker(Marker: tkDefaultPointSymbol): ILineSegment; dispid 9;
    function InsertMarker(Index: SYSINT; Marker: tkDefaultPointSymbol): ILineSegment; dispid 10;
    function RemoveItem(Index: SYSINT): WordBool; dispid 11;
    procedure Clear; dispid 12;
    function Draw(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                  ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT): WordBool; dispid 13;
    property Transparency: Byte dispid 14;
    function Serialize: WideString; dispid 15;
    procedure Deserialize(const newVal: WideString); dispid 16;
  end;

// *********************************************************************//
// Interface: ILineSegment
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {56A5439F-F550-434E-B6C5-0508A6461F47}
// *********************************************************************//
  ILineSegment = interface(IDispatch)
    ['{56A5439F-F550-434E-B6C5-0508A6461F47}']
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(retval: OLE_COLOR); safecall;
    function Get_LineWidth: Single; safecall;
    procedure Set_LineWidth(retval: Single); safecall;
    function Get_LineStyle: tkDashStyle; safecall;
    procedure Set_LineStyle(retval: tkDashStyle); safecall;
    function Get_LineType: tkLineType; safecall;
    procedure Set_LineType(retval: tkLineType); safecall;
    function Get_Marker: tkDefaultPointSymbol; safecall;
    procedure Set_Marker(retval: tkDefaultPointSymbol); safecall;
    function Get_MarkerSize: Single; safecall;
    procedure Set_MarkerSize(retval: Single); safecall;
    function Get_MarkerInterval: Single; safecall;
    procedure Set_MarkerInterval(retval: Single); safecall;
    function Get_MarkerOrientation: tkLineLabelOrientation; safecall;
    procedure Set_MarkerOrientation(retval: tkLineLabelOrientation); safecall;
    function Get_MarkerFlipFirst: WordBool; safecall;
    procedure Set_MarkerFlipFirst(retval: WordBool); safecall;
    function Get_MarkerOffset: Single; safecall;
    procedure Set_MarkerOffset(retval: Single); safecall;
    function Draw(hdc: PPSYSINT1; BackColor: OLE_COLOR; ImageWidth: SYSINT; ImageHeight: SYSINT; 
                  xOrigin: SYSINT; yOrigin: SYSINT): WordBool; safecall;
    function Get_MarkerOutlineColor: OLE_COLOR; safecall;
    procedure Set_MarkerOutlineColor(retval: OLE_COLOR); safecall;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property LineWidth: Single read Get_LineWidth write Set_LineWidth;
    property LineStyle: tkDashStyle read Get_LineStyle write Set_LineStyle;
    property LineType: tkLineType read Get_LineType write Set_LineType;
    property Marker: tkDefaultPointSymbol read Get_Marker write Set_Marker;
    property MarkerSize: Single read Get_MarkerSize write Set_MarkerSize;
    property MarkerInterval: Single read Get_MarkerInterval write Set_MarkerInterval;
    property MarkerOrientation: tkLineLabelOrientation read Get_MarkerOrientation write Set_MarkerOrientation;
    property MarkerFlipFirst: WordBool read Get_MarkerFlipFirst write Set_MarkerFlipFirst;
    property MarkerOffset: Single read Get_MarkerOffset write Set_MarkerOffset;
    property MarkerOutlineColor: OLE_COLOR read Get_MarkerOutlineColor write Set_MarkerOutlineColor;
  end;

// *********************************************************************//
// DispIntf:  ILineSegmentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {56A5439F-F550-434E-B6C5-0508A6461F47}
// *********************************************************************//
  ILineSegmentDisp = dispinterface
    ['{56A5439F-F550-434E-B6C5-0508A6461F47}']
    property Color: OLE_COLOR dispid 1;
    property LineWidth: Single dispid 2;
    property LineStyle: tkDashStyle dispid 3;
    property LineType: tkLineType dispid 4;
    property Marker: tkDefaultPointSymbol dispid 5;
    property MarkerSize: Single dispid 6;
    property MarkerInterval: Single dispid 7;
    property MarkerOrientation: tkLineLabelOrientation dispid 8;
    property MarkerFlipFirst: WordBool dispid 9;
    property MarkerOffset: Single dispid 10;
    function Draw(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; ImageWidth: SYSINT; 
                  ImageHeight: SYSINT; xOrigin: SYSINT; yOrigin: SYSINT): WordBool; dispid 11;
    property MarkerOutlineColor: OLE_COLOR dispid 12;
  end;

// *********************************************************************//
// Interface: IShapefileCategories
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EC594CB1-FA55-469C-B662-192F7A464C23}
// *********************************************************************//
  IShapefileCategories = interface(IDispatch)
    ['{EC594CB1-FA55-469C-B662-192F7A464C23}']
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Add(const Name: WideString): IShapefileCategory; safecall;
    function Insert(Index: Integer; const Name: WideString): IShapefileCategory; safecall;
    function Remove(Index: Integer): WordBool; safecall;
    procedure Clear; safecall;
    function Get_Item(Index: Integer): IShapefileCategory; safecall;
    procedure Set_Item(Index: Integer; const pVal: IShapefileCategory); safecall;
    function Generate(FieldIndex: Integer; ClassificationType: tkClassificationType; 
                      numClasses: Integer): WordBool; safecall;
    function Get_Count: Integer; safecall;
    function Get_Shapefile: IShapefile; safecall;
    procedure ApplyExpressions; safecall;
    procedure ApplyExpression(CategoryIndex: Integer); safecall;
    procedure ApplyColorScheme(Type_: tkColorSchemeType; const ColorScheme: IColorScheme); safecall;
    procedure ApplyColorScheme2(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                ShapeElement: tkShapeElements); safecall;
    procedure ApplyColorScheme3(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                ShapeElement: tkShapeElements; CategoryStartIndex: Integer; 
                                CategoryEndIndex: Integer); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    function MoveUp(Index: Integer): WordBool; safecall;
    function MoveDown(Index: Integer): WordBool; safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    function Sort(FieldIndex: Integer; Ascending: WordBool; Operation: tkGroupOperation): WordBool; safecall;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Item[Index: Integer]: IShapefileCategory read Get_Item write Set_Item;
    property Count: Integer read Get_Count;
    property Shapefile: IShapefile read Get_Shapefile;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

// *********************************************************************//
// DispIntf:  IShapefileCategoriesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EC594CB1-FA55-469C-B662-192F7A464C23}
// *********************************************************************//
  IShapefileCategoriesDisp = dispinterface
    ['{EC594CB1-FA55-469C-B662-192F7A464C23}']
    property LastErrorCode: Integer readonly dispid 1;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 2;
    property GlobalCallback: ICallback dispid 3;
    property Key: WideString dispid 4;
    function Add(const Name: WideString): IShapefileCategory; dispid 5;
    function Insert(Index: Integer; const Name: WideString): IShapefileCategory; dispid 6;
    function Remove(Index: Integer): WordBool; dispid 7;
    procedure Clear; dispid 8;
    property Item[Index: Integer]: IShapefileCategory dispid 9;
    function Generate(FieldIndex: Integer; ClassificationType: tkClassificationType; 
                      numClasses: Integer): WordBool; dispid 10;
    property Count: Integer readonly dispid 11;
    property Shapefile: IShapefile readonly dispid 12;
    procedure ApplyExpressions; dispid 13;
    procedure ApplyExpression(CategoryIndex: Integer); dispid 14;
    procedure ApplyColorScheme(Type_: tkColorSchemeType; const ColorScheme: IColorScheme); dispid 15;
    procedure ApplyColorScheme2(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                ShapeElement: tkShapeElements); dispid 16;
    procedure ApplyColorScheme3(Type_: tkColorSchemeType; const ColorScheme: IColorScheme; 
                                ShapeElement: tkShapeElements; CategoryStartIndex: Integer; 
                                CategoryEndIndex: Integer); dispid 17;
    property Caption: WideString dispid 18;
    function MoveUp(Index: Integer): WordBool; dispid 19;
    function MoveDown(Index: Integer): WordBool; dispid 20;
    function Serialize: WideString; dispid 21;
    procedure Deserialize(const newVal: WideString); dispid 22;
    function Sort(FieldIndex: Integer; Ascending: WordBool; Operation: tkGroupOperation): WordBool; dispid 23;
  end;

// *********************************************************************//
// Interface: IShapefileCategory
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {688EB3FF-CF7A-490C-9BC7-BE47CEB32C59}
// *********************************************************************//
  IShapefileCategory = interface(IDispatch)
    ['{688EB3FF-CF7A-490C-9BC7-BE47CEB32C59}']
    function Get_Name: WideString; safecall;
    procedure Set_Name(const retval: WideString); safecall;
    function Get_Expression: WideString; safecall;
    procedure Set_Expression(const retval: WideString); safecall;
    function Get_DrawingOptions: IShapeDrawingOptions; safecall;
    procedure Set_DrawingOptions(const retval: IShapeDrawingOptions); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Expression: WideString read Get_Expression write Set_Expression;
    property DrawingOptions: IShapeDrawingOptions read Get_DrawingOptions write Set_DrawingOptions;
  end;

// *********************************************************************//
// DispIntf:  IShapefileCategoryDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {688EB3FF-CF7A-490C-9BC7-BE47CEB32C59}
// *********************************************************************//
  IShapefileCategoryDisp = dispinterface
    ['{688EB3FF-CF7A-490C-9BC7-BE47CEB32C59}']
    property Name: WideString dispid 1;
    property Expression: WideString dispid 2;
    property DrawingOptions: IShapeDrawingOptions dispid 3;
  end;

// *********************************************************************//
// Interface: ICharts
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D98BB982-8D47-47BC-81CA-0EFA15D1B4F6}
// *********************************************************************//
  ICharts = interface(IDispatch)
    ['{D98BB982-8D47-47BC-81CA-0EFA15D1B4F6}']
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    function Get_AvoidCollisions: WordBool; safecall;
    procedure Set_AvoidCollisions(pVal: WordBool); safecall;
    function Get_ChartType: tkChartType; safecall;
    procedure Set_ChartType(pVal: tkChartType); safecall;
    function Get_BarWidth: Integer; safecall;
    procedure Set_BarWidth(pVal: Integer); safecall;
    function Get_BarHeight: Integer; safecall;
    procedure Set_BarHeight(pVal: Integer); safecall;
    function Get_PieRadius: Integer; safecall;
    procedure Set_PieRadius(pVal: Integer); safecall;
    function Get_PieRotation: Double; safecall;
    procedure Set_PieRotation(pVal: Double); safecall;
    function Get_NumFields: Integer; safecall;
    procedure AddField2(FieldIndex: Integer; Color: OLE_COLOR); safecall;
    function InsertField2(Index: Integer; FieldIndex: Integer; Color: OLE_COLOR): WordBool; safecall;
    function RemoveField(Index: Integer): WordBool; safecall;
    procedure ClearFields; safecall;
    function MoveField(OldIndex: Integer; NewIndex: Integer): WordBool; safecall;
    function Generate(Type_: tkLabelPositioning): WordBool; safecall;
    procedure Clear; safecall;
    function DrawChart(hdc: PPSYSINT1; BackColor: OLE_COLOR; xOrigin: SYSINT; yOrigin: SYSINT; 
                       hideLabels: WordBool): WordBool; safecall;
    function Get_Tilt: Double; safecall;
    procedure Set_Tilt(pVal: Double); safecall;
    function Get_Thickness: Double; safecall;
    procedure Set_Thickness(pVal: Double); safecall;
    function Get_PieRadius2: Integer; safecall;
    procedure Set_PieRadius2(pVal: Integer); safecall;
    function Get_SizeField: Integer; safecall;
    procedure Set_SizeField(pVal: Integer); safecall;
    function Get_NormalizationField: Integer; safecall;
    procedure Set_NormalizationField(pVal: Integer); safecall;
    function Get_UseVariableRadius: WordBool; safecall;
    procedure Set_UseVariableRadius(pVal: WordBool); safecall;
    function Get_Use3DMode: WordBool; safecall;
    procedure Set_Use3DMode(pVal: WordBool); safecall;
    function Get_Transparency: Smallint; safecall;
    procedure Set_Transparency(pVal: Smallint); safecall;
    function Get_LineColor: OLE_COLOR; safecall;
    procedure Set_LineColor(pVal: OLE_COLOR); safecall;
    function Get_VerticalPosition: tkVerticalPosition; safecall;
    procedure Set_VerticalPosition(pVal: tkVerticalPosition); safecall;
    function Get_Chart(Chart: Integer): IChart; safecall;
    function Get_Field(FieldIndex: Integer): IChartField; safecall;
    function AddField(const Field: IChartField): WordBool; safecall;
    function InsertField(Index: Integer; const Field: IChartField): WordBool; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Count: Integer; safecall;
    function Get_MaxVisibleScale: Double; safecall;
    procedure Set_MaxVisibleScale(retval: Double); safecall;
    function Get_MinVisibleScale: Double; safecall;
    procedure Set_MinVisibleScale(retval: Double); safecall;
    function Get_DynamicVisibility: WordBool; safecall;
    procedure Set_DynamicVisibility(retval: WordBool); safecall;
    function Get_IconWidth: Integer; safecall;
    function Get_IconHeight: Integer; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const retval: WideString); safecall;
    function Get_ValuesFontName: WideString; safecall;
    procedure Set_ValuesFontName(const retval: WideString); safecall;
    function Get_ValuesFontSize: Integer; safecall;
    procedure Set_ValuesFontSize(retval: Integer); safecall;
    function Get_ValuesFontItalic: WordBool; safecall;
    procedure Set_ValuesFontItalic(retval: WordBool); safecall;
    function Get_ValuesFontBold: WordBool; safecall;
    procedure Set_ValuesFontBold(retval: WordBool); safecall;
    function Get_ValuesFontColor: OLE_COLOR; safecall;
    procedure Set_ValuesFontColor(retval: OLE_COLOR); safecall;
    function Get_ValuesFrameVisible: WordBool; safecall;
    procedure Set_ValuesFrameVisible(retval: WordBool); safecall;
    function Get_ValuesFrameColor: OLE_COLOR; safecall;
    procedure Set_ValuesFrameColor(retval: OLE_COLOR); safecall;
    function Get_ValuesVisible: WordBool; safecall;
    procedure Set_ValuesVisible(retval: WordBool); safecall;
    function Get_ValuesStyle: tkChartValuesStyle; safecall;
    procedure Set_ValuesStyle(retval: tkChartValuesStyle); safecall;
    function Select(const BoundingBox: IExtents; Tolerance: Integer; SelectMode: SelectMode; 
                    var Indices: OleVariant): WordBool; safecall;
    function Get_VisibilityExpression: WideString; safecall;
    procedure Set_VisibilityExpression(const retval: WideString); safecall;
    function Get_CollisionBuffer: Integer; safecall;
    procedure Set_CollisionBuffer(retval: Integer); safecall;
    function Get_OffsetX: Integer; safecall;
    procedure Set_OffsetX(retval: Integer); safecall;
    function Get_OffsetY: Integer; safecall;
    procedure Set_OffsetY(retval: Integer); safecall;
    function Serialize: WideString; safecall;
    procedure Deserialize(const newVal: WideString); safecall;
    function SaveToXML(const Filename: WideString): WordBool; safecall;
    function LoadFromXML(const Filename: WideString): WordBool; safecall;
    function Get_SavingMode: tkSavingMode; safecall;
    procedure Set_SavingMode(retval: tkSavingMode); safecall;
    property Key: WideString read Get_Key write Set_Key;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AvoidCollisions: WordBool read Get_AvoidCollisions write Set_AvoidCollisions;
    property ChartType: tkChartType read Get_ChartType write Set_ChartType;
    property BarWidth: Integer read Get_BarWidth write Set_BarWidth;
    property BarHeight: Integer read Get_BarHeight write Set_BarHeight;
    property PieRadius: Integer read Get_PieRadius write Set_PieRadius;
    property PieRotation: Double read Get_PieRotation write Set_PieRotation;
    property NumFields: Integer read Get_NumFields;
    property Tilt: Double read Get_Tilt write Set_Tilt;
    property Thickness: Double read Get_Thickness write Set_Thickness;
    property PieRadius2: Integer read Get_PieRadius2 write Set_PieRadius2;
    property SizeField: Integer read Get_SizeField write Set_SizeField;
    property NormalizationField: Integer read Get_NormalizationField write Set_NormalizationField;
    property UseVariableRadius: WordBool read Get_UseVariableRadius write Set_UseVariableRadius;
    property Use3DMode: WordBool read Get_Use3DMode write Set_Use3DMode;
    property Transparency: Smallint read Get_Transparency write Set_Transparency;
    property LineColor: OLE_COLOR read Get_LineColor write Set_LineColor;
    property VerticalPosition: tkVerticalPosition read Get_VerticalPosition write Set_VerticalPosition;
    property Chart[Chart: Integer]: IChart read Get_Chart;
    property Field[FieldIndex: Integer]: IChartField read Get_Field;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Count: Integer read Get_Count;
    property MaxVisibleScale: Double read Get_MaxVisibleScale write Set_MaxVisibleScale;
    property MinVisibleScale: Double read Get_MinVisibleScale write Set_MinVisibleScale;
    property DynamicVisibility: WordBool read Get_DynamicVisibility write Set_DynamicVisibility;
    property IconWidth: Integer read Get_IconWidth;
    property IconHeight: Integer read Get_IconHeight;
    property Caption: WideString read Get_Caption write Set_Caption;
    property ValuesFontName: WideString read Get_ValuesFontName write Set_ValuesFontName;
    property ValuesFontSize: Integer read Get_ValuesFontSize write Set_ValuesFontSize;
    property ValuesFontItalic: WordBool read Get_ValuesFontItalic write Set_ValuesFontItalic;
    property ValuesFontBold: WordBool read Get_ValuesFontBold write Set_ValuesFontBold;
    property ValuesFontColor: OLE_COLOR read Get_ValuesFontColor write Set_ValuesFontColor;
    property ValuesFrameVisible: WordBool read Get_ValuesFrameVisible write Set_ValuesFrameVisible;
    property ValuesFrameColor: OLE_COLOR read Get_ValuesFrameColor write Set_ValuesFrameColor;
    property ValuesVisible: WordBool read Get_ValuesVisible write Set_ValuesVisible;
    property ValuesStyle: tkChartValuesStyle read Get_ValuesStyle write Set_ValuesStyle;
    property VisibilityExpression: WideString read Get_VisibilityExpression write Set_VisibilityExpression;
    property CollisionBuffer: Integer read Get_CollisionBuffer write Set_CollisionBuffer;
    property OffsetX: Integer read Get_OffsetX write Set_OffsetX;
    property OffsetY: Integer read Get_OffsetY write Set_OffsetY;
    property SavingMode: tkSavingMode read Get_SavingMode write Set_SavingMode;
  end;

// *********************************************************************//
// DispIntf:  IChartsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D98BB982-8D47-47BC-81CA-0EFA15D1B4F6}
// *********************************************************************//
  IChartsDisp = dispinterface
    ['{D98BB982-8D47-47BC-81CA-0EFA15D1B4F6}']
    property Key: WideString dispid 1;
    property Visible: WordBool dispid 2;
    property AvoidCollisions: WordBool dispid 3;
    property ChartType: tkChartType dispid 4;
    property BarWidth: Integer dispid 5;
    property BarHeight: Integer dispid 6;
    property PieRadius: Integer dispid 7;
    property PieRotation: Double dispid 8;
    property NumFields: Integer readonly dispid 9;
    procedure AddField2(FieldIndex: Integer; Color: OLE_COLOR); dispid 10;
    function InsertField2(Index: Integer; FieldIndex: Integer; Color: OLE_COLOR): WordBool; dispid 11;
    function RemoveField(Index: Integer): WordBool; dispid 12;
    procedure ClearFields; dispid 13;
    function MoveField(OldIndex: Integer; NewIndex: Integer): WordBool; dispid 14;
    function Generate(Type_: tkLabelPositioning): WordBool; dispid 15;
    procedure Clear; dispid 16;
    function DrawChart(hdc: {??PPSYSINT1}OleVariant; BackColor: OLE_COLOR; xOrigin: SYSINT; 
                       yOrigin: SYSINT; hideLabels: WordBool): WordBool; dispid 17;
    property Tilt: Double dispid 18;
    property Thickness: Double dispid 19;
    property PieRadius2: Integer dispid 20;
    property SizeField: Integer dispid 21;
    property NormalizationField: Integer dispid 22;
    property UseVariableRadius: WordBool dispid 23;
    property Use3DMode: WordBool dispid 24;
    property Transparency: Smallint dispid 25;
    property LineColor: OLE_COLOR dispid 26;
    property VerticalPosition: tkVerticalPosition dispid 27;
    property Chart[Chart: Integer]: IChart readonly dispid 28;
    property Field[FieldIndex: Integer]: IChartField readonly dispid 29;
    function AddField(const Field: IChartField): WordBool; dispid 30;
    function InsertField(Index: Integer; const Field: IChartField): WordBool; dispid 31;
    property LastErrorCode: Integer readonly dispid 32;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 33;
    property GlobalCallback: ICallback dispid 34;
    property Count: Integer readonly dispid 35;
    property MaxVisibleScale: Double dispid 36;
    property MinVisibleScale: Double dispid 37;
    property DynamicVisibility: WordBool dispid 38;
    property IconWidth: Integer readonly dispid 39;
    property IconHeight: Integer readonly dispid 40;
    property Caption: WideString dispid 41;
    property ValuesFontName: WideString dispid 42;
    property ValuesFontSize: Integer dispid 43;
    property ValuesFontItalic: WordBool dispid 44;
    property ValuesFontBold: WordBool dispid 45;
    property ValuesFontColor: OLE_COLOR dispid 46;
    property ValuesFrameVisible: WordBool dispid 47;
    property ValuesFrameColor: OLE_COLOR dispid 48;
    property ValuesVisible: WordBool dispid 49;
    property ValuesStyle: tkChartValuesStyle dispid 50;
    function Select(const BoundingBox: IExtents; Tolerance: Integer; SelectMode: SelectMode; 
                    var Indices: OleVariant): WordBool; dispid 51;
    property VisibilityExpression: WideString dispid 52;
    property CollisionBuffer: Integer dispid 53;
    property OffsetX: Integer dispid 54;
    property OffsetY: Integer dispid 55;
    function Serialize: WideString; dispid 56;
    procedure Deserialize(const newVal: WideString); dispid 57;
    function SaveToXML(const Filename: WideString): WordBool; dispid 58;
    function LoadFromXML(const Filename: WideString): WordBool; dispid 59;
    property SavingMode: tkSavingMode dispid 60;
  end;

// *********************************************************************//
// Interface: IChart
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34613D99-DDAB-48CA-AB5D-CAD805E7986C}
// *********************************************************************//
  IChart = interface(IDispatch)
    ['{34613D99-DDAB-48CA-AB5D-CAD805E7986C}']
    function Get_PositionX: Double; safecall;
    procedure Set_PositionX(retval: Double); safecall;
    function Get_PositionY: Double; safecall;
    procedure Set_PositionY(retval: Double); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(retval: WordBool); safecall;
    function Get_IsDrawn: WordBool; safecall;
    procedure Set_IsDrawn(retval: WordBool); safecall;
    function Get_ScreenExtents: IExtents; safecall;
    property PositionX: Double read Get_PositionX write Set_PositionX;
    property PositionY: Double read Get_PositionY write Set_PositionY;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property IsDrawn: WordBool read Get_IsDrawn write Set_IsDrawn;
    property ScreenExtents: IExtents read Get_ScreenExtents;
  end;

// *********************************************************************//
// DispIntf:  IChartDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34613D99-DDAB-48CA-AB5D-CAD805E7986C}
// *********************************************************************//
  IChartDisp = dispinterface
    ['{34613D99-DDAB-48CA-AB5D-CAD805E7986C}']
    property PositionX: Double dispid 1;
    property PositionY: Double dispid 2;
    property Visible: WordBool dispid 3;
    property IsDrawn: WordBool dispid 4;
    property ScreenExtents: IExtents readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IChartField
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A9C1AFEB-8CC6-4A36-8E41-E643C1302E6F}
// *********************************************************************//
  IChartField = interface(IDispatch)
    ['{A9C1AFEB-8CC6-4A36-8E41-E643C1302E6F}']
    function Get_Index: Integer; safecall;
    procedure Set_Index(retval: Integer); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(retval: OLE_COLOR); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const retval: WideString); safecall;
    property Index: Integer read Get_Index write Set_Index;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  IChartFieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A9C1AFEB-8CC6-4A36-8E41-E643C1302E6F}
// *********************************************************************//
  IChartFieldDisp = dispinterface
    ['{A9C1AFEB-8CC6-4A36-8E41-E643C1302E6F}']
    property Index: Integer dispid 1;
    property Color: OLE_COLOR dispid 2;
    property Name: WideString dispid 3;
  end;

// *********************************************************************//
// Interface: ITable
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4365A8A1-2E46-4223-B2DC-65764262D88B}
// *********************************************************************//
  ITable = interface(IDispatch)
    ['{4365A8A1-2E46-4223-B2DC-65764262D88B}']
    function Get_NumRows: Integer; safecall;
    function Get_NumFields: Integer; safecall;
    function Get_Field(FieldIndex: Integer): IField; safecall;
    function Get_CellValue(FieldIndex: Integer; RowIndex: Integer): OleVariant; safecall;
    function Get_EditingTable: WordBool; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_CdlgFilter: WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Open(const dbfFilename: WideString; const cBack: ICallback): WordBool; safecall;
    function CreateNew(const dbfFilename: WideString): WordBool; safecall;
    function SaveAs(const dbfFilename: WideString; const cBack: ICallback): WordBool; safecall;
    function Close: WordBool; safecall;
    function EditClear: WordBool; safecall;
    function EditInsertField(const Field: IField; var FieldIndex: Integer; const cBack: ICallback): WordBool; safecall;
    function EditReplaceField(FieldIndex: Integer; const NewField: IField; const cBack: ICallback): WordBool; safecall;
    function EditDeleteField(FieldIndex: Integer; const cBack: ICallback): WordBool; safecall;
    function EditInsertRow(var RowIndex: Integer): WordBool; safecall;
    function EditCellValue(FieldIndex: Integer; RowIndex: Integer; newVal: OleVariant): WordBool; safecall;
    function StartEditingTable(const cBack: ICallback): WordBool; safecall;
    function StopEditingTable(ApplyChanges: WordBool; const cBack: ICallback): WordBool; safecall;
    function EditDeleteRow(RowIndex: Integer): WordBool; safecall;
    function Save(const cBack: ICallback): WordBool; safecall;
    function Get_MinValue(FieldIndex: Integer): OleVariant; safecall;
    function Get_MaxValue(FieldIndex: Integer): OleVariant; safecall;
    function Get_MeanValue(FieldIndex: Integer): Double; safecall;
    function Get_StandardDeviation(FieldIndex: Integer): Double; safecall;
    function ParseExpression(const Expression: WideString; var ErrorString: WideString): WordBool; safecall;
    function Query(const Expression: WideString; var Result: OleVariant; var ErrorString: WideString): WordBool; safecall;
    function Get_FieldIndexByName(const Fieldname: WideString): Integer; safecall;
    function TestExpression(const Expression: WideString; ReturnType: tkValueType; 
                            var ErrorString: WideString): WordBool; safecall;
    function Calculate(const Expression: WideString; RowIndex: Integer; out Result: OleVariant; 
                       out ErrorString: WideString): WordBool; safecall;
    procedure CalculateStat(FieldIndex: Integer; Statistic: tkGroupOperation; 
                            const Expression: WideString; out Result: OleVariant; 
                            var retval: WordBool); safecall;
    property NumRows: Integer read Get_NumRows;
    property NumFields: Integer read Get_NumFields;
    property Field[FieldIndex: Integer]: IField read Get_Field;
    property CellValue[FieldIndex: Integer; RowIndex: Integer]: OleVariant read Get_CellValue;
    property EditingTable: WordBool read Get_EditingTable;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property CdlgFilter: WideString read Get_CdlgFilter;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property MinValue[FieldIndex: Integer]: OleVariant read Get_MinValue;
    property MaxValue[FieldIndex: Integer]: OleVariant read Get_MaxValue;
    property MeanValue[FieldIndex: Integer]: Double read Get_MeanValue;
    property StandardDeviation[FieldIndex: Integer]: Double read Get_StandardDeviation;
    property FieldIndexByName[const Fieldname: WideString]: Integer read Get_FieldIndexByName;
  end;

// *********************************************************************//
// DispIntf:  ITableDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4365A8A1-2E46-4223-B2DC-65764262D88B}
// *********************************************************************//
  ITableDisp = dispinterface
    ['{4365A8A1-2E46-4223-B2DC-65764262D88B}']
    property NumRows: Integer readonly dispid 1;
    property NumFields: Integer readonly dispid 2;
    property Field[FieldIndex: Integer]: IField readonly dispid 3;
    property CellValue[FieldIndex: Integer; RowIndex: Integer]: OleVariant readonly dispid 4;
    property EditingTable: WordBool readonly dispid 5;
    property LastErrorCode: Integer readonly dispid 6;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 7;
    property CdlgFilter: WideString readonly dispid 8;
    property GlobalCallback: ICallback dispid 9;
    property Key: WideString dispid 10;
    function Open(const dbfFilename: WideString; const cBack: ICallback): WordBool; dispid 11;
    function CreateNew(const dbfFilename: WideString): WordBool; dispid 12;
    function SaveAs(const dbfFilename: WideString; const cBack: ICallback): WordBool; dispid 13;
    function Close: WordBool; dispid 14;
    function EditClear: WordBool; dispid 15;
    function EditInsertField(const Field: IField; var FieldIndex: Integer; const cBack: ICallback): WordBool; dispid 16;
    function EditReplaceField(FieldIndex: Integer; const NewField: IField; const cBack: ICallback): WordBool; dispid 17;
    function EditDeleteField(FieldIndex: Integer; const cBack: ICallback): WordBool; dispid 18;
    function EditInsertRow(var RowIndex: Integer): WordBool; dispid 19;
    function EditCellValue(FieldIndex: Integer; RowIndex: Integer; newVal: OleVariant): WordBool; dispid 20;
    function StartEditingTable(const cBack: ICallback): WordBool; dispid 21;
    function StopEditingTable(ApplyChanges: WordBool; const cBack: ICallback): WordBool; dispid 22;
    function EditDeleteRow(RowIndex: Integer): WordBool; dispid 23;
    function Save(const cBack: ICallback): WordBool; dispid 24;
    property MinValue[FieldIndex: Integer]: OleVariant readonly dispid 25;
    property MaxValue[FieldIndex: Integer]: OleVariant readonly dispid 26;
    property MeanValue[FieldIndex: Integer]: Double readonly dispid 27;
    property StandardDeviation[FieldIndex: Integer]: Double readonly dispid 28;
    function ParseExpression(const Expression: WideString; var ErrorString: WideString): WordBool; dispid 29;
    function Query(const Expression: WideString; var Result: OleVariant; var ErrorString: WideString): WordBool; dispid 30;
    property FieldIndexByName[const Fieldname: WideString]: Integer readonly dispid 31;
    function TestExpression(const Expression: WideString; ReturnType: tkValueType; 
                            var ErrorString: WideString): WordBool; dispid 32;
    function Calculate(const Expression: WideString; RowIndex: Integer; out Result: OleVariant; 
                       out ErrorString: WideString): WordBool; dispid 33;
    procedure CalculateStat(FieldIndex: Integer; Statistic: tkGroupOperation; 
                            const Expression: WideString; out Result: OleVariant; 
                            var retval: WordBool); dispid 34;
  end;

// *********************************************************************//
// Interface: IStopExecution
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52A29829-BB46-4D76-8082-55551E538BDA}
// *********************************************************************//
  IStopExecution = interface(IDispatch)
    ['{52A29829-BB46-4D76-8082-55551E538BDA}']
    function StopFunction: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IStopExecutionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52A29829-BB46-4D76-8082-55551E538BDA}
// *********************************************************************//
  IStopExecutionDisp = dispinterface
    ['{52A29829-BB46-4D76-8082-55551E538BDA}']
    function StopFunction: WordBool; dispid 1;
  end;

// *********************************************************************//
// DispIntf:  _DMapEvents
// Flags:     (4096) Dispatchable
// GUID:      {ABEA1545-08AB-4D5C-A594-D3017211EA95}
// *********************************************************************//
  _DMapEvents = dispinterface
    ['{ABEA1545-08AB-4D5C-A594-D3017211EA95}']
    procedure MouseDown(Button: Smallint; Shift: Smallint; x: Integer; y: Integer); dispid 1;
    procedure MouseUp(Button: Smallint; Shift: Smallint; x: Integer; y: Integer); dispid 2;
    procedure MouseMove(Button: Smallint; Shift: Smallint; x: Integer; y: Integer); dispid 3;
    procedure FileDropped(const Filename: WideString); dispid 4;
    procedure SelectBoxFinal(left: Integer; right: Integer; bottom: Integer; top: Integer); dispid 5;
    procedure SelectBoxDrag(left: Integer; right: Integer; bottom: Integer; top: Integer); dispid 6;
    procedure ExtentsChanged; dispid 7;
    procedure MapState(LayerHandle: Integer); dispid 8;
    procedure OnDrawBackBuffer(BackBuffer: Integer); dispid 9;
    procedure DblClick; dispid -601;
  end;

// *********************************************************************//
// Interface: IShapefileColorScheme
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FAE1B21A-10C5-4C33-8DC2-931EDC9FBF82}
// *********************************************************************//
  IShapefileColorScheme = interface(IDispatch)
    ['{FAE1B21A-10C5-4C33-8DC2-931EDC9FBF82}']
    function NumBreaks: Integer; safecall;
    procedure Remove(Index: Integer); safecall;
    function Add(const Break: IShapefileColorBreak): Integer; safecall;
    function Get_ColorBreak(Index: Integer): IShapefileColorBreak; safecall;
    procedure Set_ColorBreak(Index: Integer; const pVal: IShapefileColorBreak); safecall;
    function Get_LayerHandle: Integer; safecall;
    procedure Set_LayerHandle(pVal: Integer); safecall;
    function Get_FieldIndex: Integer; safecall;
    procedure Set_FieldIndex(pVal: Integer); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function InsertAt(Position: SYSINT; const Break: IShapefileColorBreak): Integer; safecall;
    property ColorBreak[Index: Integer]: IShapefileColorBreak read Get_ColorBreak write Set_ColorBreak;
    property LayerHandle: Integer read Get_LayerHandle write Set_LayerHandle;
    property FieldIndex: Integer read Get_FieldIndex write Set_FieldIndex;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IShapefileColorSchemeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FAE1B21A-10C5-4C33-8DC2-931EDC9FBF82}
// *********************************************************************//
  IShapefileColorSchemeDisp = dispinterface
    ['{FAE1B21A-10C5-4C33-8DC2-931EDC9FBF82}']
    function NumBreaks: Integer; dispid 1;
    procedure Remove(Index: Integer); dispid 2;
    function Add(const Break: IShapefileColorBreak): Integer; dispid 3;
    property ColorBreak[Index: Integer]: IShapefileColorBreak dispid 4;
    property LayerHandle: Integer dispid 5;
    property FieldIndex: Integer dispid 6;
    property LastErrorCode: Integer readonly dispid 7;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 8;
    property GlobalCallback: ICallback dispid 9;
    property Key: WideString dispid 10;
    function InsertAt(Position: SYSINT; const Break: IShapefileColorBreak): Integer; dispid 11;
  end;

// *********************************************************************//
// Interface: IShapefileColorBreak
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E6D4EB7A-3E8F-45B2-A514-90EF7B2F5C0A}
// *********************************************************************//
  IShapefileColorBreak = interface(IDispatch)
    ['{E6D4EB7A-3E8F-45B2-A514-90EF7B2F5C0A}']
    function Get_StartValue: OleVariant; safecall;
    procedure Set_StartValue(pVal: OleVariant); safecall;
    function Get_EndValue: OleVariant; safecall;
    procedure Set_EndValue(pVal: OleVariant); safecall;
    function Get_StartColor: OLE_COLOR; safecall;
    procedure Set_StartColor(pVal: OLE_COLOR); safecall;
    function Get_EndColor: OLE_COLOR; safecall;
    procedure Set_EndColor(pVal: OLE_COLOR); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pVal: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pVal: WordBool); safecall;
    property StartValue: OleVariant read Get_StartValue write Set_StartValue;
    property EndValue: OleVariant read Get_EndValue write Set_EndValue;
    property StartColor: OLE_COLOR read Get_StartColor write Set_StartColor;
    property EndColor: OLE_COLOR read Get_EndColor write Set_EndColor;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  IShapefileColorBreakDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E6D4EB7A-3E8F-45B2-A514-90EF7B2F5C0A}
// *********************************************************************//
  IShapefileColorBreakDisp = dispinterface
    ['{E6D4EB7A-3E8F-45B2-A514-90EF7B2F5C0A}']
    property StartValue: OleVariant dispid 1;
    property EndValue: OleVariant dispid 2;
    property StartColor: OLE_COLOR dispid 3;
    property EndColor: OLE_COLOR dispid 4;
    property Caption: WideString dispid 5;
    property Visible: WordBool dispid 6;
  end;

// *********************************************************************//
// Interface: IGrid
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {18DFB64A-9E72-4CBE-AFD6-A5B7421DD0CB}
// *********************************************************************//
  IGrid = interface(IDispatch)
    ['{18DFB64A-9E72-4CBE-AFD6-A5B7421DD0CB}']
    function Get_Header: IGridHeader; safecall;
    function Get_Value(Column: Integer; Row: Integer): OleVariant; safecall;
    procedure Set_Value(Column: Integer; Row: Integer; pVal: OleVariant); safecall;
    function Get_InRam: WordBool; safecall;
    function Get_Maximum: OleVariant; safecall;
    function Get_Minimum: OleVariant; safecall;
    function Get_DataType: GridDataType; safecall;
    function Get_Filename: WideString; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Open(const Filename: WideString; DataType: GridDataType; InRam: WordBool; 
                  fileType: GridFileType; const cBack: ICallback): WordBool; safecall;
    function CreateNew(const Filename: WideString; const Header: IGridHeader; 
                       DataType: GridDataType; InitialValue: OleVariant; InRam: WordBool; 
                       fileType: GridFileType; const cBack: ICallback): WordBool; safecall;
    function Close: WordBool; safecall;
    function Save(const Filename: WideString; GridFileType: GridFileType; const cBack: ICallback): WordBool; safecall;
    function Clear(ClearValue: OleVariant): WordBool; safecall;
    procedure ProjToCell(x: Double; y: Double; out Column: Integer; out Row: Integer); safecall;
    procedure CellToProj(Column: Integer; Row: Integer; out x: Double; out y: Double); safecall;
    function Get_CdlgFilter: WideString; safecall;
    function AssignNewProjection(const Projection: WideString): WordBool; safecall;
    function Get_RasterColorTableColoringScheme: IGridColorScheme; safecall;
    function GetRow(Row: Integer; var Vals: Single): WordBool; safecall;
    function PutRow(Row: Integer; var Vals: Single): WordBool; safecall;
    function GetFloatWindow(StartRow: Integer; EndRow: Integer; StartCol: Integer; EndCol: Integer; 
                            var Vals: Single): WordBool; safecall;
    function PutFloatWindow(StartRow: Integer; EndRow: Integer; StartCol: Integer; EndCol: Integer; 
                            var Vals: Single): WordBool; safecall;
    function SetInvalidValuesToNodata(MinThresholdValue: Double; MaxThresholdValue: Double): WordBool; safecall;
    function Resource(const newSrcPath: WideString): WordBool; safecall;
    property Header: IGridHeader read Get_Header;
    property Value[Column: Integer; Row: Integer]: OleVariant read Get_Value write Set_Value;
    property InRam: WordBool read Get_InRam;
    property Maximum: OleVariant read Get_Maximum;
    property Minimum: OleVariant read Get_Minimum;
    property DataType: GridDataType read Get_DataType;
    property Filename: WideString read Get_Filename;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property CdlgFilter: WideString read Get_CdlgFilter;
    property RasterColorTableColoringScheme: IGridColorScheme read Get_RasterColorTableColoringScheme;
  end;

// *********************************************************************//
// DispIntf:  IGridDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {18DFB64A-9E72-4CBE-AFD6-A5B7421DD0CB}
// *********************************************************************//
  IGridDisp = dispinterface
    ['{18DFB64A-9E72-4CBE-AFD6-A5B7421DD0CB}']
    property Header: IGridHeader readonly dispid 1;
    property Value[Column: Integer; Row: Integer]: OleVariant dispid 2;
    property InRam: WordBool readonly dispid 3;
    property Maximum: OleVariant readonly dispid 4;
    property Minimum: OleVariant readonly dispid 5;
    property DataType: GridDataType readonly dispid 6;
    property Filename: WideString readonly dispid 7;
    property LastErrorCode: Integer readonly dispid 8;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 9;
    property GlobalCallback: ICallback dispid 10;
    property Key: WideString dispid 11;
    function Open(const Filename: WideString; DataType: GridDataType; InRam: WordBool; 
                  fileType: GridFileType; const cBack: ICallback): WordBool; dispid 12;
    function CreateNew(const Filename: WideString; const Header: IGridHeader; 
                       DataType: GridDataType; InitialValue: OleVariant; InRam: WordBool; 
                       fileType: GridFileType; const cBack: ICallback): WordBool; dispid 13;
    function Close: WordBool; dispid 14;
    function Save(const Filename: WideString; GridFileType: GridFileType; const cBack: ICallback): WordBool; dispid 15;
    function Clear(ClearValue: OleVariant): WordBool; dispid 16;
    procedure ProjToCell(x: Double; y: Double; out Column: Integer; out Row: Integer); dispid 17;
    procedure CellToProj(Column: Integer; Row: Integer; out x: Double; out y: Double); dispid 18;
    property CdlgFilter: WideString readonly dispid 19;
    function AssignNewProjection(const Projection: WideString): WordBool; dispid 20;
    property RasterColorTableColoringScheme: IGridColorScheme readonly dispid 21;
    function GetRow(Row: Integer; var Vals: Single): WordBool; dispid 22;
    function PutRow(Row: Integer; var Vals: Single): WordBool; dispid 23;
    function GetFloatWindow(StartRow: Integer; EndRow: Integer; StartCol: Integer; EndCol: Integer; 
                            var Vals: Single): WordBool; dispid 24;
    function PutFloatWindow(StartRow: Integer; EndRow: Integer; StartCol: Integer; EndCol: Integer; 
                            var Vals: Single): WordBool; dispid 25;
    function SetInvalidValuesToNodata(MinThresholdValue: Double; MaxThresholdValue: Double): WordBool; dispid 26;
    function Resource(const newSrcPath: WideString): WordBool; dispid 27;
  end;

// *********************************************************************//
// Interface: IGridHeader
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E42814D1-6269-41B1-93C2-AA848F00E459}
// *********************************************************************//
  IGridHeader = interface(IDispatch)
    ['{E42814D1-6269-41B1-93C2-AA848F00E459}']
    function Get_NumberCols: Integer; safecall;
    procedure Set_NumberCols(pVal: Integer); safecall;
    function Get_NumberRows: Integer; safecall;
    procedure Set_NumberRows(pVal: Integer); safecall;
    function Get_NodataValue: OleVariant; safecall;
    procedure Set_NodataValue(pVal: OleVariant); safecall;
    function Get_dX: Double; safecall;
    procedure Set_dX(pVal: Double); safecall;
    function Get_dY: Double; safecall;
    procedure Set_dY(pVal: Double); safecall;
    function Get_XllCenter: Double; safecall;
    procedure Set_XllCenter(pVal: Double); safecall;
    function Get_YllCenter: Double; safecall;
    procedure Set_YllCenter(pVal: Double); safecall;
    function Get_Projection: WideString; safecall;
    procedure Set_Projection(const pVal: WideString); safecall;
    function Get_Notes: WideString; safecall;
    procedure Set_Notes(const pVal: WideString); safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    procedure Set_Owner(var t: SYSINT; var d: SYSINT; var s: SYSINT; var l: SYSINT; Param5: PSYSINT1); safecall;
    procedure CopyFrom(const pVal: IGridHeader); safecall;
    function Get_ColorTable: WideString; safecall;
    procedure Set_ColorTable(const pVal: WideString); safecall;
    property NumberCols: Integer read Get_NumberCols write Set_NumberCols;
    property NumberRows: Integer read Get_NumberRows write Set_NumberRows;
    property NodataValue: OleVariant read Get_NodataValue write Set_NodataValue;
    property dX: Double read Get_dX write Set_dX;
    property dY: Double read Get_dY write Set_dY;
    property XllCenter: Double read Get_XllCenter write Set_XllCenter;
    property YllCenter: Double read Get_YllCenter write Set_YllCenter;
    property Projection: WideString read Get_Projection write Set_Projection;
    property Notes: WideString read Get_Notes write Set_Notes;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Owner[var t: SYSINT; var d: SYSINT; var s: SYSINT; var l: SYSINT]: PSYSINT1 write Set_Owner;
    property ColorTable: WideString read Get_ColorTable write Set_ColorTable;
  end;

// *********************************************************************//
// DispIntf:  IGridHeaderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E42814D1-6269-41B1-93C2-AA848F00E459}
// *********************************************************************//
  IGridHeaderDisp = dispinterface
    ['{E42814D1-6269-41B1-93C2-AA848F00E459}']
    property NumberCols: Integer dispid 1;
    property NumberRows: Integer dispid 2;
    property NodataValue: OleVariant dispid 3;
    property dX: Double dispid 4;
    property dY: Double dispid 5;
    property XllCenter: Double dispid 6;
    property YllCenter: Double dispid 7;
    property Projection: WideString dispid 8;
    property Notes: WideString dispid 9;
    property LastErrorCode: Integer readonly dispid 10;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 11;
    property GlobalCallback: ICallback dispid 12;
    property Key: WideString dispid 13;
    property Owner[var t: SYSINT; var d: SYSINT; var s: SYSINT; var l: SYSINT]: {??PSYSINT1}OleVariant writeonly dispid 14;
    procedure CopyFrom(const pVal: IGridHeader); dispid 15;
    property ColorTable: WideString dispid 16;
  end;

// *********************************************************************//
// Interface: IESRIGridManager
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {55B3F2DA-EB09-4FA9-B74B-9A1B3E457318}
// *********************************************************************//
  IESRIGridManager = interface(IDispatch)
    ['{55B3F2DA-EB09-4FA9-B74B-9A1B3E457318}']
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function CanUseESRIGrids: WordBool; safecall;
    function DeleteESRIGrids(const Filename: WideString): WordBool; safecall;
    function IsESRIGrid(const Filename: WideString): WordBool; safecall;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
  end;

// *********************************************************************//
// DispIntf:  IESRIGridManagerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {55B3F2DA-EB09-4FA9-B74B-9A1B3E457318}
// *********************************************************************//
  IESRIGridManagerDisp = dispinterface
    ['{55B3F2DA-EB09-4FA9-B74B-9A1B3E457318}']
    property LastErrorCode: Integer readonly dispid 1;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 2;
    property GlobalCallback: ICallback dispid 3;
    function CanUseESRIGrids: WordBool; dispid 4;
    function DeleteESRIGrids(const Filename: WideString): WordBool; dispid 5;
    function IsESRIGrid(const Filename: WideString): WordBool; dispid 6;
  end;

// *********************************************************************//
// Interface: IShapeNetwork
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2D4968F2-40D9-4F25-8BE6-B51B959CC1B0}
// *********************************************************************//
  IShapeNetwork = interface(IDispatch)
    ['{2D4968F2-40D9-4F25-8BE6-B51B959CC1B0}']
    function Build(const Shapefile: IShapefile; ShapeIndex: Integer; FinalPointIndex: Integer; 
                   Tolerance: Double; ar: AmbiguityResolution; const cBack: ICallback): Integer; safecall;
    function DeleteShape(ShapeIndex: Integer): WordBool; safecall;
    function RasterizeD8(UseNetworkBounds: WordBool; const Header: IGridHeader; Cellsize: Double; 
                         const cBack: ICallback): IGrid; safecall;
    function MoveUp(UpIndex: Integer): WordBool; safecall;
    function MoveDown: WordBool; safecall;
    function MoveTo(ShapeIndex: Integer): WordBool; safecall;
    function MoveToOutlet: WordBool; safecall;
    function Get_Shapefile: IShapefile; safecall;
    function Get_CurrentShape: IShape; safecall;
    function Get_CurrentShapeIndex: Integer; safecall;
    function Get_DistanceToOutlet(PointIndex: Integer): Double; safecall;
    function Get_NumDirectUps: Integer; safecall;
    function Get_NetworkSize: Integer; safecall;
    function Get_AmbigShapeIndex(Index: Integer): Integer; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function Get_ParentIndex: Integer; safecall;
    procedure Set_ParentIndex(pVal: Integer); safecall;
    function Open(const sf: IShapefile; const cBack: ICallback): WordBool; safecall;
    function Close: WordBool; safecall;
    property Shapefile: IShapefile read Get_Shapefile;
    property CurrentShape: IShape read Get_CurrentShape;
    property CurrentShapeIndex: Integer read Get_CurrentShapeIndex;
    property DistanceToOutlet[PointIndex: Integer]: Double read Get_DistanceToOutlet;
    property NumDirectUps: Integer read Get_NumDirectUps;
    property NetworkSize: Integer read Get_NetworkSize;
    property AmbigShapeIndex[Index: Integer]: Integer read Get_AmbigShapeIndex;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property ParentIndex: Integer read Get_ParentIndex write Set_ParentIndex;
  end;

// *********************************************************************//
// DispIntf:  IShapeNetworkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2D4968F2-40D9-4F25-8BE6-B51B959CC1B0}
// *********************************************************************//
  IShapeNetworkDisp = dispinterface
    ['{2D4968F2-40D9-4F25-8BE6-B51B959CC1B0}']
    function Build(const Shapefile: IShapefile; ShapeIndex: Integer; FinalPointIndex: Integer; 
                   Tolerance: Double; ar: AmbiguityResolution; const cBack: ICallback): Integer; dispid 1;
    function DeleteShape(ShapeIndex: Integer): WordBool; dispid 2;
    function RasterizeD8(UseNetworkBounds: WordBool; const Header: IGridHeader; Cellsize: Double; 
                         const cBack: ICallback): IGrid; dispid 3;
    function MoveUp(UpIndex: Integer): WordBool; dispid 4;
    function MoveDown: WordBool; dispid 5;
    function MoveTo(ShapeIndex: Integer): WordBool; dispid 6;
    function MoveToOutlet: WordBool; dispid 7;
    property Shapefile: IShapefile readonly dispid 8;
    property CurrentShape: IShape readonly dispid 9;
    property CurrentShapeIndex: Integer readonly dispid 10;
    property DistanceToOutlet[PointIndex: Integer]: Double readonly dispid 11;
    property NumDirectUps: Integer readonly dispid 12;
    property NetworkSize: Integer readonly dispid 13;
    property AmbigShapeIndex[Index: Integer]: Integer readonly dispid 14;
    property LastErrorCode: Integer readonly dispid 15;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 16;
    property GlobalCallback: ICallback dispid 17;
    property Key: WideString dispid 18;
    property ParentIndex: Integer dispid 19;
    function Open(const sf: IShapefile; const cBack: ICallback): WordBool; dispid 20;
    function Close: WordBool; dispid 21;
  end;

// *********************************************************************//
// Interface: IUtils
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {360BEC33-7703-4693-B6CA-90FEA22CF1B7}
// *********************************************************************//
  IUtils = interface(IDispatch)
    ['{360BEC33-7703-4693-B6CA-90FEA22CF1B7}']
    function PointInPolygon(const Shp: IShape; const TestPoint: IPoint): WordBool; safecall;
    function GridReplace(const Grd: IGrid; OldValue: OleVariant; newValue: OleVariant; 
                         const cBack: ICallback): WordBool; safecall;
    function GridInterpolateNoData(const Grd: IGrid; const cBack: ICallback): WordBool; safecall;
    function RemoveColinearPoints(const Shapes: IShapefile; LinearTolerance: Double; 
                                  const cBack: ICallback): WordBool; safecall;
    function Get_Length(const Shape: IShape): Double; safecall;
    function Get_Perimeter(const Shape: IShape): Double; safecall;
    function Get_Area(const Shape: IShape): Double; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    function ClipPolygon(op: PolygonOperation; const SubjectPolygon: IShape; 
                         const ClipPolygon: IShape): IShape; safecall;
    function GridMerge(Grids: OleVariant; const MergeFilename: WideString; InRam: WordBool; 
                       GrdFileType: GridFileType; const cBack: ICallback): IGrid; safecall;
    function ShapeMerge(const Shapes: IShapefile; IndexOne: Integer; IndexTwo: Integer; 
                        const cBack: ICallback): IShape; safecall;
    function GridToImage(const Grid: IGrid; const cScheme: IGridColorScheme; const cBack: ICallback): IImage; safecall;
    function GridToShapefile(const Grid: IGrid; const ConnectionGrid: IGrid; const cBack: ICallback): IShapefile; safecall;
    function GridToGrid(const Grid: IGrid; OutDataType: GridDataType; const cBack: ICallback): IGrid; safecall;
    function ShapeToShapeZ(const Shapefile: IShapefile; const Grid: IGrid; const cBack: ICallback): IShapefile; safecall;
    function TinToShapefile(const Tin: ITin; Type_: ShpfileType; const cBack: ICallback): IShapefile; safecall;
    function ShapefileToGrid(const Shpfile: IShapefile; UseShapefileBounds: WordBool; 
                             const GrdHeader: IGridHeader; Cellsize: Double; 
                             UseShapeNumber: WordBool; SingleValue: Smallint): IGrid; safecall;
    function hBitmapToPicture(hBitmap: Integer): IPictureDisp; safecall;
    function GenerateHillShade(const bstrGridFilename: WideString; 
                               const bstrShadeFilename: WideString; Z: Single; scale: Single; 
                               az: Single; alt: Single): WordBool; safecall;
    function GenerateContour(const pszSrcFilename: WideString; const pszDstFilename: WideString; 
                             dfInterval: Double; dfNoData: Double; Is3D: WordBool; 
                             dblFLArray: OleVariant; const cBack: ICallback): WordBool; safecall;
    function TranslateRaster(const bstrSrcFilename: WideString; const bstrDstFilename: WideString; 
                             const bstrOptions: WideString; const cBack: ICallback): WordBool; safecall;
    function OGRLayerToShapefile(const Filename: WideString; ShpType: ShpfileType; 
                                 const cBack: ICallback): IShapefile; safecall;
    function MergeImages(InputNames: PSafeArray; const OutputName: WideString): WordBool; safecall;
    function ReprojectShapefile(const sf: IShapefile; const source: IGeoProjection; 
                                const target: IGeoProjection): IShapefile; safecall;
    property Length[const Shape: IShape]: Double read Get_Length;
    property Perimeter[const Shape: IShape]: Double read Get_Perimeter;
    property Area[const Shape: IShape]: Double read Get_Area;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
  end;

// *********************************************************************//
// DispIntf:  IUtilsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {360BEC33-7703-4693-B6CA-90FEA22CF1B7}
// *********************************************************************//
  IUtilsDisp = dispinterface
    ['{360BEC33-7703-4693-B6CA-90FEA22CF1B7}']
    function PointInPolygon(const Shp: IShape; const TestPoint: IPoint): WordBool; dispid 1;
    function GridReplace(const Grd: IGrid; OldValue: OleVariant; newValue: OleVariant; 
                         const cBack: ICallback): WordBool; dispid 2;
    function GridInterpolateNoData(const Grd: IGrid; const cBack: ICallback): WordBool; dispid 3;
    function RemoveColinearPoints(const Shapes: IShapefile; LinearTolerance: Double; 
                                  const cBack: ICallback): WordBool; dispid 4;
    property Length[const Shape: IShape]: Double readonly dispid 5;
    property Perimeter[const Shape: IShape]: Double readonly dispid 6;
    property Area[const Shape: IShape]: Double readonly dispid 7;
    property LastErrorCode: Integer readonly dispid 8;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 9;
    property GlobalCallback: ICallback dispid 10;
    property Key: WideString dispid 11;
    function ClipPolygon(op: PolygonOperation; const SubjectPolygon: IShape; 
                         const ClipPolygon: IShape): IShape; dispid 12;
    function GridMerge(Grids: OleVariant; const MergeFilename: WideString; InRam: WordBool; 
                       GrdFileType: GridFileType; const cBack: ICallback): IGrid; dispid 13;
    function ShapeMerge(const Shapes: IShapefile; IndexOne: Integer; IndexTwo: Integer; 
                        const cBack: ICallback): IShape; dispid 14;
    function GridToImage(const Grid: IGrid; const cScheme: IGridColorScheme; const cBack: ICallback): IImage; dispid 15;
    function GridToShapefile(const Grid: IGrid; const ConnectionGrid: IGrid; const cBack: ICallback): IShapefile; dispid 16;
    function GridToGrid(const Grid: IGrid; OutDataType: GridDataType; const cBack: ICallback): IGrid; dispid 17;
    function ShapeToShapeZ(const Shapefile: IShapefile; const Grid: IGrid; const cBack: ICallback): IShapefile; dispid 18;
    function TinToShapefile(const Tin: ITin; Type_: ShpfileType; const cBack: ICallback): IShapefile; dispid 19;
    function ShapefileToGrid(const Shpfile: IShapefile; UseShapefileBounds: WordBool; 
                             const GrdHeader: IGridHeader; Cellsize: Double; 
                             UseShapeNumber: WordBool; SingleValue: Smallint): IGrid; dispid 20;
    function hBitmapToPicture(hBitmap: Integer): IPictureDisp; dispid 21;
    function GenerateHillShade(const bstrGridFilename: WideString; 
                               const bstrShadeFilename: WideString; Z: Single; scale: Single; 
                               az: Single; alt: Single): WordBool; dispid 22;
    function GenerateContour(const pszSrcFilename: WideString; const pszDstFilename: WideString; 
                             dfInterval: Double; dfNoData: Double; Is3D: WordBool; 
                             dblFLArray: OleVariant; const cBack: ICallback): WordBool; dispid 23;
    function TranslateRaster(const bstrSrcFilename: WideString; const bstrDstFilename: WideString; 
                             const bstrOptions: WideString; const cBack: ICallback): WordBool; dispid 24;
    function OGRLayerToShapefile(const Filename: WideString; ShpType: ShpfileType; 
                                 const cBack: ICallback): IShapefile; dispid 25;
    function MergeImages(InputNames: {??PSafeArray}OleVariant; const OutputName: WideString): WordBool; dispid 26;
    function ReprojectShapefile(const sf: IShapefile; const source: IGeoProjection; 
                                const target: IGeoProjection): IShapefile; dispid 27;
  end;

// *********************************************************************//
// Interface: ITin
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {55DD824E-332E-41CA-B40C-C8DC81EE209C}
// *********************************************************************//
  ITin = interface(IDispatch)
    ['{55DD824E-332E-41CA-B40C-C8DC81EE209C}']
    function Open(const TinFile: WideString; const cBack: ICallback): WordBool; safecall;
    function CreateNew(const Grid: IGrid; Deviation: Double; SplitTest: SplitMethod; 
                       STParam: Double; MeshDivisions: Integer; MaximumTriangles: Integer; 
                       const cBack: ICallback): WordBool; safecall;
    function Save(const TinFilename: WideString; const cBack: ICallback): WordBool; safecall;
    function Close: WordBool; safecall;
    function Select(var TriangleHint: Integer; x: Double; y: Double; out Z: Double): WordBool; safecall;
    function Get_NumTriangles: Integer; safecall;
    function Get_NumVertices: Integer; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_CdlgFilter: WideString; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const pVal: ICallback); safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const pVal: WideString); safecall;
    procedure Triangle(TriIndex: Integer; out vtx1Index: Integer; out vtx2Index: Integer; 
                       out vtx3Index: Integer); safecall;
    procedure Vertex(VtxIndex: Integer; out x: Double; out y: Double; out Z: Double); safecall;
    procedure Max(out x: Double; out y: Double; out Z: Double); safecall;
    procedure Min(out x: Double; out y: Double; out Z: Double); safecall;
    function Get_Filename: WideString; safecall;
    function Get_IsNDTriangle(TriIndex: Integer): WordBool; safecall;
    procedure TriangleNeighbors(TriIndex: Integer; var triIndex1: Integer; var triIndex2: Integer; 
                                var triIndex3: Integer); safecall;
    function CreateTinFromPoints(Points: PSafeArray): WordBool; safecall;
    property NumTriangles: Integer read Get_NumTriangles;
    property NumVertices: Integer read Get_NumVertices;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property CdlgFilter: WideString read Get_CdlgFilter;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property Key: WideString read Get_Key write Set_Key;
    property Filename: WideString read Get_Filename;
    property IsNDTriangle[TriIndex: Integer]: WordBool read Get_IsNDTriangle;
  end;

// *********************************************************************//
// DispIntf:  ITinDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {55DD824E-332E-41CA-B40C-C8DC81EE209C}
// *********************************************************************//
  ITinDisp = dispinterface
    ['{55DD824E-332E-41CA-B40C-C8DC81EE209C}']
    function Open(const TinFile: WideString; const cBack: ICallback): WordBool; dispid 1;
    function CreateNew(const Grid: IGrid; Deviation: Double; SplitTest: SplitMethod; 
                       STParam: Double; MeshDivisions: Integer; MaximumTriangles: Integer; 
                       const cBack: ICallback): WordBool; dispid 2;
    function Save(const TinFilename: WideString; const cBack: ICallback): WordBool; dispid 3;
    function Close: WordBool; dispid 4;
    function Select(var TriangleHint: Integer; x: Double; y: Double; out Z: Double): WordBool; dispid 5;
    property NumTriangles: Integer readonly dispid 6;
    property NumVertices: Integer readonly dispid 7;
    property LastErrorCode: Integer readonly dispid 8;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 9;
    property CdlgFilter: WideString readonly dispid 10;
    property GlobalCallback: ICallback dispid 11;
    property Key: WideString dispid 12;
    procedure Triangle(TriIndex: Integer; out vtx1Index: Integer; out vtx2Index: Integer; 
                       out vtx3Index: Integer); dispid 13;
    procedure Vertex(VtxIndex: Integer; out x: Double; out y: Double; out Z: Double); dispid 14;
    procedure Max(out x: Double; out y: Double; out Z: Double); dispid 15;
    procedure Min(out x: Double; out y: Double; out Z: Double); dispid 16;
    property Filename: WideString readonly dispid 17;
    property IsNDTriangle[TriIndex: Integer]: WordBool readonly dispid 18;
    procedure TriangleNeighbors(TriIndex: Integer; var triIndex1: Integer; var triIndex2: Integer; 
                                var triIndex3: Integer); dispid 19;
    function CreateTinFromPoints(Points: {??PSafeArray}OleVariant): WordBool; dispid 20;
  end;

// *********************************************************************//
// Interface: IGeoProjection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AED5318E-9E3D-4276-BE03-71EDFEDC0F1F}
// *********************************************************************//
  IGeoProjection = interface(IDispatch)
    ['{AED5318E-9E3D-4276-BE03-71EDFEDC0F1F}']
    function ExportToProj4: WideString; safecall;
    function ImportFromProj4(const proj: WideString): WordBool; safecall;
    function ImportFromESRI(const proj: WideString): WordBool; safecall;
    function ImportFromEPSG(projCode: Integer): WordBool; safecall;
    function ExportToWKT: WideString; safecall;
    function ImportFromWKT(const proj: WideString): WordBool; safecall;
    function Get_GlobalCallback: ICallback; safecall;
    procedure Set_GlobalCallback(const retval: ICallback); safecall;
    function Get_ErrorMsg(ErrorCode: Integer): WideString; safecall;
    function Get_LastErrorCode: Integer; safecall;
    function Get_Key: WideString; safecall;
    procedure Set_Key(const retval: WideString); safecall;
    procedure SetWellKnownGeogCS(newVal: tkCoordinateSystem); safecall;
    function Get_IsGeographic: WordBool; safecall;
    function Get_IsProjected: WordBool; safecall;
    function Get_IsLocal: WordBool; safecall;
    function Get_IsSame(const proj: IGeoProjection): WordBool; safecall;
    function Get_IsSameGeogCS(const proj: IGeoProjection): WordBool; safecall;
    function Get_InverseFlattening: Double; safecall;
    function Get_SemiMajor: Double; safecall;
    function Get_SemiMinor: Double; safecall;
    function Get_ProjectionParm(Name: tkProjectionParameter; var Value: Double): WordBool; safecall;
    property GlobalCallback: ICallback read Get_GlobalCallback write Set_GlobalCallback;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property LastErrorCode: Integer read Get_LastErrorCode;
    property Key: WideString read Get_Key write Set_Key;
    property IsGeographic: WordBool read Get_IsGeographic;
    property IsProjected: WordBool read Get_IsProjected;
    property IsLocal: WordBool read Get_IsLocal;
    property IsSame[const proj: IGeoProjection]: WordBool read Get_IsSame;
    property IsSameGeogCS[const proj: IGeoProjection]: WordBool read Get_IsSameGeogCS;
    property InverseFlattening: Double read Get_InverseFlattening;
    property SemiMajor: Double read Get_SemiMajor;
    property SemiMinor: Double read Get_SemiMinor;
    property ProjectionParm[Name: tkProjectionParameter; var Value: Double]: WordBool read Get_ProjectionParm;
  end;

// *********************************************************************//
// DispIntf:  IGeoProjectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AED5318E-9E3D-4276-BE03-71EDFEDC0F1F}
// *********************************************************************//
  IGeoProjectionDisp = dispinterface
    ['{AED5318E-9E3D-4276-BE03-71EDFEDC0F1F}']
    function ExportToProj4: WideString; dispid 1;
    function ImportFromProj4(const proj: WideString): WordBool; dispid 2;
    function ImportFromESRI(const proj: WideString): WordBool; dispid 3;
    function ImportFromEPSG(projCode: Integer): WordBool; dispid 4;
    function ExportToWKT: WideString; dispid 5;
    function ImportFromWKT(const proj: WideString): WordBool; dispid 6;
    property GlobalCallback: ICallback dispid 7;
    property ErrorMsg[ErrorCode: Integer]: WideString readonly dispid 8;
    property LastErrorCode: Integer readonly dispid 9;
    property Key: WideString dispid 10;
    procedure SetWellKnownGeogCS(newVal: tkCoordinateSystem); dispid 11;
    property IsGeographic: WordBool readonly dispid 12;
    property IsProjected: WordBool readonly dispid 13;
    property IsLocal: WordBool readonly dispid 14;
    property IsSame[const proj: IGeoProjection]: WordBool readonly dispid 15;
    property IsSameGeogCS[const proj: IGeoProjection]: WordBool readonly dispid 16;
    property InverseFlattening: Double readonly dispid 17;
    property SemiMajor: Double readonly dispid 18;
    property SemiMinor: Double readonly dispid 19;
    property ProjectionParm[Name: tkProjectionParameter; var Value: Double]: WordBool readonly dispid 20;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMap
// Help String      : Map Control
// Default Interface: _DMap
// Def. Intf. DISP? : Yes
// Event   Interface: _DMapEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMapMouseDown = procedure(ASender: TObject; Button: Smallint; Shift: Smallint; x: Integer; 
                                              y: Integer) of object;
  TMapMouseUp = procedure(ASender: TObject; Button: Smallint; Shift: Smallint; x: Integer; 
                                            y: Integer) of object;
  TMapMouseMove = procedure(ASender: TObject; Button: Smallint; Shift: Smallint; x: Integer; 
                                              y: Integer) of object;
  TMapFileDropped = procedure(ASender: TObject; const Filename: WideString) of object;
  TMapSelectBoxFinal = procedure(ASender: TObject; left: Integer; right: Integer; bottom: Integer; 
                                                   top: Integer) of object;
  TMapSelectBoxDrag = procedure(ASender: TObject; left: Integer; right: Integer; bottom: Integer; 
                                                  top: Integer) of object;
  TMapMapState = procedure(ASender: TObject; LayerHandle: Integer) of object;
  TMapOnDrawBackBuffer = procedure(ASender: TObject; BackBuffer: Integer) of object;

  TMap = class(TOleControl)
  private
    FOnMouseDown: TMapMouseDown;
    FOnMouseUp: TMapMouseUp;
    FOnMouseMove: TMapMouseMove;
    FOnFileDropped: TMapFileDropped;
    FOnSelectBoxFinal: TMapSelectBoxFinal;
    FOnSelectBoxDrag: TMapSelectBoxDrag;
    FOnExtentsChanged: TNotifyEvent;
    FOnMapState: TMapMapState;
    FOnDrawBackBuffer: TMapOnDrawBackBuffer;
    FIntf: _DMap;
    function  GetControlInterface: _DMap;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_ShapeLayerFillColor(LayerHandle: Integer): OLE_COLOR;
    function Get_LayerVisible(LayerHandle: Integer): WordBool;
    function Get_LayerPosition(LayerHandle: Integer): Integer;
    procedure Set_LayerVisible(LayerHandle: Integer; Param2: WordBool);
    function Get_LayerHandle(LayerPosition: Integer): Integer;
    function Get_ShapeLayerLineColor(LayerHandle: Integer): OLE_COLOR;
    function Get_ShapeFillColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
    procedure Set_ShapeFillColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
    procedure Set_ShapeLayerFillColor(LayerHandle: Integer; Param2: OLE_COLOR);
    procedure Set_ShapeLayerLineColor(LayerHandle: Integer; Param2: OLE_COLOR);
    function Get_ShapeLineColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
    procedure Set_LayerKey(LayerHandle: Integer; const Param2: WideString);
    procedure Set_ShapeLayerStippleTransparent(LayerHandle: Integer; Param2: WordBool);
    procedure Set_DrawingLabels(DrawingLayerIndex: Integer; const Param2: ILabels);
    procedure Set_ShapeStippleTransparent(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
    function Get_ShapeLayerStippleTransparent(LayerHandle: Integer): WordBool;
    function Get_ShapeStippleTransparent(LayerHandle: Integer; Shape: Integer): WordBool;
    function Get_DrawingLabels(DrawingLayerIndex: Integer): ILabels;
    function Get_LayerKey(LayerHandle: Integer): WideString;
    function Get_ShapeLayerDrawFill(LayerHandle: Integer): WordBool;
    function Get_ShapeLayerDrawLine(LayerHandle: Integer): WordBool;
    procedure Set_ShapeLayerDrawLine(LayerHandle: Integer; Param2: WordBool);
    procedure Set_ShapeLayerPointColor(LayerHandle: Integer; Param2: OLE_COLOR);
    procedure Set_ShapeLineColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
    function Get_ShapeLayerPointColor(LayerHandle: Integer): OLE_COLOR;
    procedure Set_ShapeDrawFill(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
    function Get_ImageLayerPercentTransparent(LayerHandle: Integer): Single;
    procedure Set_ImageLayerPercentTransparent(LayerHandle: Integer; Param2: Single);
    procedure Set_ShapeVisible(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
    procedure Set_ShapeLayerDrawFill(LayerHandle: Integer; Param2: WordBool);
    function Get_ShapeDrawFill(LayerHandle: Integer; Shape: Integer): WordBool;
    function Get_ShapePointSize(LayerHandle: Integer; Shape: Integer): Single;
    procedure Set_ShapePointColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
    procedure Set_ShapeDrawLine(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
    function Get_ShapeLayerDrawPoint(LayerHandle: Integer): WordBool;
    function Get_ShapeLayerLineWidth(LayerHandle: Integer): Single;
    function Get_ShapeDrawPoint(LayerHandle: Integer; Shape: Integer): WordBool;
    procedure Set_ShapeDrawPoint(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
    procedure Set_ShapeLayerDrawPoint(LayerHandle: Integer; Param2: WordBool);
    function Get_ShapeLayerPointSize(LayerHandle: Integer): Single;
    function Get_ShapeLineWidth(LayerHandle: Integer; Shape: Integer): Single;
    function Get_ShapeDrawLine(LayerHandle: Integer; Shape: Integer): WordBool;
    function Get_ShapePointColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
    procedure Set_ShapeLayerPointSize(LayerHandle: Integer; Param2: Single);
    procedure Set_ShapeLineWidth(LayerHandle: Integer; Shape: Integer; Param3: Single);
    procedure Set_ShapeLayerLineWidth(LayerHandle: Integer; Param2: Single);
    procedure Set_ShapeFillStipple(LayerHandle: Integer; Shape: Integer; Param3: tkFillStipple);
    procedure Set_ShapeLayerLineStipple(LayerHandle: Integer; Param2: tkLineStipple);
    function Get_ShapeLineStipple(LayerHandle: Integer; Shape: Integer): tkLineStipple;
    function Get_ShapeLayerFillStipple(LayerHandle: Integer): tkFillStipple;
    procedure Set_ShapeLayerFillStipple(LayerHandle: Integer; Param2: tkFillStipple);
    procedure Set_ShapeLineStipple(LayerHandle: Integer; Shape: Integer; Param3: tkLineStipple);
    function Get_ShapeLayerLineStipple(LayerHandle: Integer): tkLineStipple;
    function Get_ShapePointType(LayerHandle: Integer; Shape: Integer): tkPointType;
    function Get_ShapeLayerPointType(LayerHandle: Integer): tkPointType;
    function Get_DrawingKey(DrawHandle: Integer): WideString;
    function Get_ShapeVisible(LayerHandle: Integer; Shape: Integer): WordBool;
    function Get_ErrorMsg(ErrorCode: Integer): WideString;
    procedure Set_ShapeLayerPointType(LayerHandle: Integer; Param2: tkPointType);
    procedure Set_DrawingKey(DrawHandle: Integer; const Param2: WideString);
    procedure Set_ShapeLayerFillTransparency(LayerHandle: Integer; Param2: Single);
    procedure Set_ShapePointSize(LayerHandle: Integer; Shape: Integer; Param3: Single);
    function Get_ShapeLayerFillTransparency(LayerHandle: Integer): Single;
    function Get_ShapeFillStipple(LayerHandle: Integer; Shape: Integer): tkFillStipple;
    function Get_ShapeFillTransparency(LayerHandle: Integer; Shape: Integer): Single;
    procedure Set_ShapeFillTransparency(LayerHandle: Integer; Shape: Integer; Param3: Single);
    function Get_GridFileName(LayerHandle: Integer): WideString;
    procedure Set_GridFileName(LayerHandle: Integer; const Param2: WideString);
    procedure Set_LayerName(LayerHandle: Integer; const Param2: WideString);
    procedure Set_LayerLabelsVisible(LayerHandle: Integer; Param2: WordBool);
    function Get_UDPointType(LayerHandle: Integer): IDispatch;
    procedure _Set_UDPointType(LayerHandle: Integer; const Param2: IDispatch);
    function Get_DrawingLabelsScale(DrawHandle: Integer): WordBool;
    procedure Set_DrawingLabelsScale(DrawHandle: Integer; Param2: WordBool);
    function Get_DrawingLabelsShadow(DrawHandle: Integer): WordBool;
    function Get_GetObject(LayerHandle: Integer): IDispatch;
    function Get_LayerName(LayerHandle: Integer): WideString;
    function Get_LayerLabelsVisible(LayerHandle: Integer): WordBool;
    function Get_UseLabelCollision(LayerHandle: Integer): WordBool;
    procedure Set_LayerLabelsOffset(LayerHandle: Integer; Param2: Integer);
    function Get_LayerLabelsShadowColor(LayerHandle: Integer): OLE_COLOR;
    procedure Set_UseLabelCollision(LayerHandle: Integer; Param2: WordBool);
    procedure Set_LayerLabelsShadowColor(LayerHandle: Integer; Param2: OLE_COLOR);
    procedure Set_UDFillStipple(LayerHandle: Integer; StippleRow: Integer; Param3: Integer);
    function Get_UDLineStipple(LayerHandle: Integer): Integer;
    procedure Set_ShapePointType(LayerHandle: Integer; Shape: Integer; Param3: tkPointType);
    procedure Set_UDLineStipple(LayerHandle: Integer; Param2: Integer);
    function Get_UDFillStipple(LayerHandle: Integer; StippleRow: Integer): Integer;
    procedure Set_DrawingLabelsOffset(DrawHandle: Integer; Param2: Integer);
    procedure Set_ShapePointImageListID(LayerHandle: Integer; Shape: Integer; Param3: Integer);
    procedure Set_DrawingLabelsShadow(DrawHandle: Integer; Param2: WordBool);
    function Get_DrawingLabelsVisible(DrawHandle: Integer): WordBool;
    procedure Set_DrawingLabelsVisible(DrawHandle: Integer; Param2: WordBool);
    function Get_DrawingLabelsOffset(DrawHandle: Integer): Integer;
    function Get_UseDrawingLabelCollision(DrawHandle: Integer): WordBool;
    function Get_ShapePointImageListID(LayerHandle: Integer; Shape: Integer): Integer;
    procedure Set_UseDrawingLabelCollision(DrawHandle: Integer; Param2: WordBool);
    function Get_DrawingLabelsShadowColor(DrawHandle: Integer): OLE_COLOR;
    procedure Set_DrawingLabelsShadowColor(DrawHandle: Integer; Param2: OLE_COLOR);
    function Get_Image(LayerHandle: Integer): IImage;
    function Get_LayerSkipOnSaving(LayerHandle: Integer): WordBool;
    procedure Set_LayerSkipOnSaving(LayerHandle: Integer; Param2: WordBool);
    procedure Set_Image(LayerHandle: Integer; const Param2: IImage);
    procedure Set_ShapePointFontCharListID(LayerHandle: Integer; Shape: Integer; Param3: Integer);
    procedure Set_ShapeStippleColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
    function Get_ShapeLayerStippleColor(LayerHandle: Integer): OLE_COLOR;
    function Get_ShapePointFontCharListID(LayerHandle: Integer; Shape: Integer): Integer;
    procedure Set_ShapeLayerStippleColor(LayerHandle: Integer; Param2: OLE_COLOR);
    function Get_ShapeStippleColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
    function Get_LayerDynamicVisibility(LayerHandle: Integer): WordBool;
    procedure Set_LayerDynamicVisibility(LayerHandle: Integer; Param2: WordBool);
    function Get_Shapefile(LayerHandle: Integer): IShapefile;
    procedure Set_LayerMinVisibleScale(LayerHandle: Integer; Param2: Double);
    procedure Set_LayerLabelsShadow(LayerHandle: Integer; Param2: WordBool);
    function Get_LayerLabelsScale(LayerHandle: Integer): WordBool;
    function Get_LayerLabelsOffset(LayerHandle: Integer): Integer;
    procedure Set_LayerLabelsScale(LayerHandle: Integer; Param2: WordBool);
    function Get_LayerLabelsShadow(LayerHandle: Integer): WordBool;
    procedure Set_LayerLabels(LayerHandle: Integer; const Param2: ILabels);
    procedure Set_Shapefile(LayerHandle: Integer; const Param2: IShapefile);
    function Get_LayerMaxVisibleScale(LayerHandle: Integer): Double;
    function Get_LayerDescription(LayerHandle: Integer): WideString;
    procedure Set_LayerDescription(LayerHandle: Integer; const Param2: WideString);
    procedure Set_LayerMaxVisibleScale(LayerHandle: Integer; Param2: Double);
    function Get_LayerMinVisibleScale(LayerHandle: Integer): Double;
    function Get_LayerLabels(LayerHandle: Integer): ILabels;
    function Get_Extents: IDispatch;
    procedure Set_Extents(const Value: IDispatch);
    function Get_GlobalCallback: IDispatch;
    procedure Set_GlobalCallback(const Value: IDispatch);
  public
    function MoveLayer(InitialPosition: Integer; TargetPosition: Integer): WordBool;
    procedure Resize(Width: Integer; Height: Integer);
    function MoveLayerDown(InitialPosition: Integer): WordBool;
    procedure ZoomToLayer(LayerHandle: Integer);
    procedure RemoveLayerWithoutClosing(LayerHandle: Integer);
    procedure RemoveAllLayers;
    function SnapShot(const BoundBox: IDispatch): IDispatch;
    procedure ClearDrawing(DrawHandle: Integer);
    procedure ClearDrawings;
    procedure RemoveLayer(LayerHandle: Integer);
    function MoveLayerBottom(InitialPosition: Integer): WordBool;
    procedure ZoomToMaxExtents;
    function MoveLayerTop(InitialPosition: Integer): WordBool;
    procedure Redraw;
    function AddLayer(const Object_: IDispatch; Visible: WordBool): Integer;
    function MoveLayerUp(InitialPosition: Integer): WordBool;
    function AdjustLayerExtents(LayerHandle: Integer): WordBool;
    procedure DrawWideCircleEx(LayerHandle: Integer; x: Double; y: Double; radius: Double; 
                               Color: OLE_COLOR; fill: WordBool; OutlineWidth: Smallint);
    procedure DrawPolygonEx(LayerHandle: Integer; var xPoints: OleVariant; var yPoints: OleVariant; 
                            numPoints: Integer; Color: OLE_COLOR; fill: WordBool);
    function SnapShotToDC(var hdc: {??Pointer}OleVariant; const Extents: IExtents; Width: Integer): WordBool;
    procedure DrawWidePolygonEx(LayerHandle: Integer; var xPoints: OleVariant; 
                                var yPoints: OleVariant; numPoints: Integer; Color: OLE_COLOR; 
                                fill: WordBool; OutlineWidth: Smallint);
    function SnapShot3(left: Double; right: Double; top: Double; bottom: Double; Width: Integer): IDispatch;
    procedure ShowToolTip(const Text: WideString; Milliseconds: Integer);
    procedure AddLabel(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; x: Double; 
                       y: Double; hJustification: tkHJustification);
    function NewDrawing(Projection: tkDrawReferenceList): Integer;
    procedure LayerFont(LayerHandle: Integer; const FontName: WideString; FontSize: Integer);
    function GetColorScheme(LayerHandle: Integer): IDispatch;
    procedure ClearLabels(LayerHandle: Integer);
    procedure DrawPolygon(var xPoints: OleVariant; var yPoints: OleVariant; numPoints: Integer; 
                          Color: OLE_COLOR; fill: WordBool);
    procedure DrawLine(x1: Double; y1: Double; x2: Double; y2: Double; pixelWidth: Integer; 
                       Color: OLE_COLOR);
    procedure DrawCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; fill: WordBool);
    procedure DrawPoint(x: Double; y: Double; pixelSize: Integer; Color: OLE_COLOR);
    function ZoomToPrev: Integer;
    procedure ProjToPixel(projX: Double; projY: Double; var pixelX: Double; var pixelY: Double);
    procedure PixelToProj(pixelX: Double; pixelY: Double; var projX: Double; var projY: Double);
    function ApplyLegendColors(const Legend: IDispatch): WordBool;
    procedure LockWindow(LockMode: tkLockMode);
    procedure ZoomOut(Percent: Double);
    procedure ZoomToShape(LayerHandle: Integer; Shape: Integer);
    procedure ZoomIn(Percent: Double);
    function SetImageLayerColorScheme(LayerHandle: Integer; const ColorScheme: IDispatch): WordBool;
    procedure ZoomToMaxVisibleExtents;
    function IsTIFFGrid(const Filename: WideString): WordBool;
    function IsSameProjection(const proj4_a: WideString; const proj4_b: WideString): WordBool;
    procedure UpdateImage(LayerHandle: Integer);
    function HWnd: Integer;
    function get_UDPointImageListItem(LayerHandle: Integer; ImageIndex: Integer): IDispatch;
    function get_UDPointImageListCount(LayerHandle: Integer): Integer;
    function set_UDPointImageListAdd(LayerHandle: Integer; const newValue: IDispatch): Integer;
    procedure LabelColor(LayerHandle: Integer; LabelFontColor: OLE_COLOR);
    procedure ClearUDPointImageList(LayerHandle: Integer);
    procedure DrawLineEx(LayerHandle: Integer; x1: Double; y1: Double; x2: Double; y2: Double; 
                         pixelWidth: Integer; Color: OLE_COLOR);
    procedure DrawPointEx(LayerHandle: Integer; x: Double; y: Double; pixelSize: Integer; 
                          Color: OLE_COLOR);
    procedure SetDrawingLayerVisible(LayerHandle: Integer; Visiable: WordBool);
    procedure ClearDrawingLabels(DrawHandle: Integer);
    procedure DrawCircleEx(LayerHandle: Integer; x: Double; y: Double; pixelRadius: Double; 
                           Color: OLE_COLOR; fill: WordBool);
    procedure AddDrawingLabelEx(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                                x: Double; y: Double; hJustification: tkHJustification; 
                                Rotation: Double);
    procedure AddDrawingLabel(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                              x: Double; y: Double; hJustification: tkHJustification);
    procedure GetDrawingStandardViewWidth(DrawHandle: Integer; var Width: Double);
    procedure DrawingFont(DrawHandle: Integer; const FontName: WideString; FontSize: Integer);
    function LoadMapState(const Filename: WideString; const Callback: IDispatch): WordBool;
    function SaveLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                              Overwrite: WordBool; const Description: WideString): WordBool;
    function DeserializeLayer(LayerHandle: Integer; const newVal: WideString): WordBool;
    procedure ReSourceLayer(LayerHandle: Integer; const newSrcPath: WideString);
    function SaveMapState(const Filename: WideString; RelativePaths: WordBool; Overwrite: WordBool): WordBool;
    function RemoveLayerOptions(LayerHandle: Integer; const OptionsName: WideString): WordBool;
    function SerializeLayer(LayerHandle: Integer): WideString;
    function LoadLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                              var Description: WideString): WordBool;
    function SnapShot2(ClippingLayerNbr: Integer; Zoom: Double; pWidth: Integer): IDispatch;
    procedure SetDrawingStandardViewWidth(DrawHandle: Integer; Width: Double);
    procedure DrawWidePolygon(var xPoints: OleVariant; var yPoints: OleVariant; numPoints: Integer; 
                              Color: OLE_COLOR; fill: WordBool; Width: Smallint);
    procedure LayerFontEx(LayerHandle: Integer; const FontName: WideString; FontSize: Integer; 
                          isBold: WordBool; isItalic: WordBool; isUnderline: WordBool);
    procedure set_UDPointFontCharFont(LayerHandle: Integer; const FontName: WideString; 
                                      FontSize: Single; isBold: WordBool; isItalic: WordBool; 
                                      isUnderline: WordBool);
    function set_UDPointFontCharListAdd(LayerHandle: Integer; newValue: Integer; Color: OLE_COLOR): Integer;
    procedure DrawWideCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; 
                             fill: WordBool; Width: Smallint);
    procedure set_UDPointFontCharFontSize(LayerHandle: Integer; FontSize: Single);
    function SerializeMapState(RelativePaths: WordBool; const BasePath: WideString): WideString;
    procedure AddLabelEx(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; x: Double; 
                         y: Double; hJustification: tkHJustification; Rotation: Double);
    procedure DrawBackBuffer(hdc: {??PPSYSINT1}OleVariant; ImageWidth: SYSINT; ImageHeight: SYSINT);
    procedure GetLayerStandardViewWidth(LayerHandle: Integer; var Width: Double);
    procedure SetLayerStandardViewWidth(LayerHandle: Integer; Width: Double);
    function DeserializeMapState(const State: WideString; LoadLayers: WordBool; 
                                 const BasePath: WideString): WordBool;
    function GetBaseProjectionPoint(rotX: Double; rotY: Double): IPoint;
    function GetRotatedExtent: IExtents;
    property  ControlInterface: _DMap read GetControlInterface;
    property  DefaultInterface: _DMap read GetControlInterface;
    property ShapeLayerFillColor[LayerHandle: Integer]: OLE_COLOR read Get_ShapeLayerFillColor write Set_ShapeLayerFillColor;
    property LayerVisible[LayerHandle: Integer]: WordBool read Get_LayerVisible write Set_LayerVisible;
    property LayerPosition[LayerHandle: Integer]: Integer read Get_LayerPosition;
    property LayerHandle[LayerPosition: Integer]: Integer read Get_LayerHandle;
    property ShapeLayerLineColor[LayerHandle: Integer]: OLE_COLOR read Get_ShapeLayerLineColor write Set_ShapeLayerLineColor;
    property ShapeFillColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR read Get_ShapeFillColor write Set_ShapeFillColor;
    property ShapeLineColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR read Get_ShapeLineColor write Set_ShapeLineColor;
    property LayerKey[LayerHandle: Integer]: WideString read Get_LayerKey write Set_LayerKey;
    property ShapeLayerStippleTransparent[LayerHandle: Integer]: WordBool read Get_ShapeLayerStippleTransparent write Set_ShapeLayerStippleTransparent;
    property DrawingLabels[DrawingLayerIndex: Integer]: ILabels read Get_DrawingLabels write Set_DrawingLabels;
    property ShapeStippleTransparent[LayerHandle: Integer; Shape: Integer]: WordBool read Get_ShapeStippleTransparent write Set_ShapeStippleTransparent;
    property ShapeLayerDrawFill[LayerHandle: Integer]: WordBool read Get_ShapeLayerDrawFill write Set_ShapeLayerDrawFill;
    property ShapeLayerDrawLine[LayerHandle: Integer]: WordBool read Get_ShapeLayerDrawLine write Set_ShapeLayerDrawLine;
    property ShapeLayerPointColor[LayerHandle: Integer]: OLE_COLOR read Get_ShapeLayerPointColor write Set_ShapeLayerPointColor;
    property ShapeDrawFill[LayerHandle: Integer; Shape: Integer]: WordBool read Get_ShapeDrawFill write Set_ShapeDrawFill;
    property ImageLayerPercentTransparent[LayerHandle: Integer]: Single read Get_ImageLayerPercentTransparent write Set_ImageLayerPercentTransparent;
    property ShapeVisible[LayerHandle: Integer; Shape: Integer]: WordBool read Get_ShapeVisible write Set_ShapeVisible;
    property ShapePointSize[LayerHandle: Integer; Shape: Integer]: Single read Get_ShapePointSize write Set_ShapePointSize;
    property ShapePointColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR read Get_ShapePointColor write Set_ShapePointColor;
    property ShapeDrawLine[LayerHandle: Integer; Shape: Integer]: WordBool read Get_ShapeDrawLine write Set_ShapeDrawLine;
    property ShapeLayerDrawPoint[LayerHandle: Integer]: WordBool read Get_ShapeLayerDrawPoint write Set_ShapeLayerDrawPoint;
    property ShapeLayerLineWidth[LayerHandle: Integer]: Single read Get_ShapeLayerLineWidth write Set_ShapeLayerLineWidth;
    property ShapeDrawPoint[LayerHandle: Integer; Shape: Integer]: WordBool read Get_ShapeDrawPoint write Set_ShapeDrawPoint;
    property ShapeLayerPointSize[LayerHandle: Integer]: Single read Get_ShapeLayerPointSize write Set_ShapeLayerPointSize;
    property ShapeLineWidth[LayerHandle: Integer; Shape: Integer]: Single read Get_ShapeLineWidth write Set_ShapeLineWidth;
    property ShapeFillStipple[LayerHandle: Integer; Shape: Integer]: tkFillStipple read Get_ShapeFillStipple write Set_ShapeFillStipple;
    property ShapeLayerLineStipple[LayerHandle: Integer]: tkLineStipple read Get_ShapeLayerLineStipple write Set_ShapeLayerLineStipple;
    property ShapeLineStipple[LayerHandle: Integer; Shape: Integer]: tkLineStipple read Get_ShapeLineStipple write Set_ShapeLineStipple;
    property ShapeLayerFillStipple[LayerHandle: Integer]: tkFillStipple read Get_ShapeLayerFillStipple write Set_ShapeLayerFillStipple;
    property ShapePointType[LayerHandle: Integer; Shape: Integer]: tkPointType read Get_ShapePointType write Set_ShapePointType;
    property ShapeLayerPointType[LayerHandle: Integer]: tkPointType read Get_ShapeLayerPointType write Set_ShapeLayerPointType;
    property DrawingKey[DrawHandle: Integer]: WideString read Get_DrawingKey write Set_DrawingKey;
    property ErrorMsg[ErrorCode: Integer]: WideString read Get_ErrorMsg;
    property ShapeLayerFillTransparency[LayerHandle: Integer]: Single read Get_ShapeLayerFillTransparency write Set_ShapeLayerFillTransparency;
    property ShapeFillTransparency[LayerHandle: Integer; Shape: Integer]: Single read Get_ShapeFillTransparency write Set_ShapeFillTransparency;
    property GridFileName[LayerHandle: Integer]: WideString read Get_GridFileName write Set_GridFileName;
    property LayerName[LayerHandle: Integer]: WideString read Get_LayerName write Set_LayerName;
    property LayerLabelsVisible[LayerHandle: Integer]: WordBool read Get_LayerLabelsVisible write Set_LayerLabelsVisible;
    property UDPointType[LayerHandle: Integer]: IDispatch read Get_UDPointType;
    property DrawingLabelsScale[DrawHandle: Integer]: WordBool read Get_DrawingLabelsScale write Set_DrawingLabelsScale;
    property DrawingLabelsShadow[DrawHandle: Integer]: WordBool read Get_DrawingLabelsShadow write Set_DrawingLabelsShadow;
    property GetObject[LayerHandle: Integer]: IDispatch read Get_GetObject;
    property UseLabelCollision[LayerHandle: Integer]: WordBool read Get_UseLabelCollision write Set_UseLabelCollision;
    property LayerLabelsOffset[LayerHandle: Integer]: Integer read Get_LayerLabelsOffset write Set_LayerLabelsOffset;
    property LayerLabelsShadowColor[LayerHandle: Integer]: OLE_COLOR read Get_LayerLabelsShadowColor write Set_LayerLabelsShadowColor;
    property UDFillStipple[LayerHandle: Integer; StippleRow: Integer]: Integer read Get_UDFillStipple write Set_UDFillStipple;
    property UDLineStipple[LayerHandle: Integer]: Integer read Get_UDLineStipple write Set_UDLineStipple;
    property DrawingLabelsOffset[DrawHandle: Integer]: Integer read Get_DrawingLabelsOffset write Set_DrawingLabelsOffset;
    property ShapePointImageListID[LayerHandle: Integer; Shape: Integer]: Integer read Get_ShapePointImageListID write Set_ShapePointImageListID;
    property DrawingLabelsVisible[DrawHandle: Integer]: WordBool read Get_DrawingLabelsVisible write Set_DrawingLabelsVisible;
    property UseDrawingLabelCollision[DrawHandle: Integer]: WordBool read Get_UseDrawingLabelCollision write Set_UseDrawingLabelCollision;
    property DrawingLabelsShadowColor[DrawHandle: Integer]: OLE_COLOR read Get_DrawingLabelsShadowColor write Set_DrawingLabelsShadowColor;
    property Image[LayerHandle: Integer]: IImage read Get_Image write Set_Image;
    property LayerSkipOnSaving[LayerHandle: Integer]: WordBool read Get_LayerSkipOnSaving write Set_LayerSkipOnSaving;
    property ShapePointFontCharListID[LayerHandle: Integer; Shape: Integer]: Integer read Get_ShapePointFontCharListID write Set_ShapePointFontCharListID;
    property ShapeStippleColor[LayerHandle: Integer; Shape: Integer]: OLE_COLOR read Get_ShapeStippleColor write Set_ShapeStippleColor;
    property ShapeLayerStippleColor[LayerHandle: Integer]: OLE_COLOR read Get_ShapeLayerStippleColor write Set_ShapeLayerStippleColor;
    property LayerDynamicVisibility[LayerHandle: Integer]: WordBool read Get_LayerDynamicVisibility write Set_LayerDynamicVisibility;
    property Shapefile[LayerHandle: Integer]: IShapefile read Get_Shapefile write Set_Shapefile;
    property LayerMinVisibleScale[LayerHandle: Integer]: Double read Get_LayerMinVisibleScale write Set_LayerMinVisibleScale;
    property LayerLabelsShadow[LayerHandle: Integer]: WordBool read Get_LayerLabelsShadow write Set_LayerLabelsShadow;
    property LayerLabelsScale[LayerHandle: Integer]: WordBool read Get_LayerLabelsScale write Set_LayerLabelsScale;
    property LayerLabels[LayerHandle: Integer]: ILabels read Get_LayerLabels write Set_LayerLabels;
    property LayerMaxVisibleScale[LayerHandle: Integer]: Double read Get_LayerMaxVisibleScale write Set_LayerMaxVisibleScale;
    property LayerDescription[LayerHandle: Integer]: WideString read Get_LayerDescription write Set_LayerDescription;
    property MultilineLabels: WordBool index 133 read GetWordBoolProp write SetWordBoolProp;
    property LineSeparationFactor: Integer index 96 read GetIntegerProp write SetIntegerProp;
    property Extents: IDispatch index 17 read GetIDispatchProp write SetIDispatchProp;
    property GlobalCallback: IDispatch index 15 read GetIDispatchProp write SetIDispatchProp;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnDblClick;
    property TrapRMouseDown: WordBool index 148 read GetWordBoolProp write SetWordBoolProp stored False;
    property DisableWaitCursor: WordBool index 149 read GetWordBoolProp write SetWordBoolProp stored False;
    property MapResizeBehavior: TOleEnum index 108 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MapRotationAngle: Double index 162 read GetDoubleProp write SetDoubleProp stored False;
    property CanUseImageGrouping: WordBool index 165 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowVersionNumber: WordBool index 173 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowRedrawTime: WordBool index 172 read GetWordBoolProp write SetWordBoolProp stored False;
    property VersionNumber: Integer index 166 read GetIntegerProp write SetIntegerProp stored False;
    property MapUnits: TOleEnum index 158 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CurrentScale: Double index 156 read GetDoubleProp write SetDoubleProp stored False;
    property ShapeDrawingMethod: TOleEnum index 154 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property MouseWheelSpeed: Double index 152 read GetDoubleProp write SetDoubleProp stored False;
    property UseSeamlessPan: WordBool index 151 read GetWordBoolProp write SetWordBoolProp stored False;
    property SendOnDrawBackBuffer: WordBool index 118 read GetWordBoolProp write SetWordBoolProp stored False;
    property SerialNumber: WideString index 95 read GetWideStringProp write SetWideStringProp stored False;
    property MapState: WideString index 20 read GetWideStringProp write SetWideStringProp stored False;
    property IsLocked: TOleEnum index 19 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property LastErrorCode: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property NumLayers: Integer index 16 read GetIntegerProp write SetIntegerProp stored False;
    property DoubleBuffer: WordBool index 14 read GetWordBoolProp write SetWordBoolProp stored False;
    property Key: WideString index 13 read GetWideStringProp write SetWideStringProp stored False;
    property ExtentHistory: Integer index 12 read GetIntegerProp write SetIntegerProp stored False;
    property ExtentPad: Double index 11 read GetDoubleProp write SetDoubleProp stored False;
    property SendSelectBoxFinal: WordBool index 10 read GetWordBoolProp write SetWordBoolProp stored False;
    property SendSelectBoxDrag: WordBool index 9 read GetWordBoolProp write SetWordBoolProp stored False;
    property SendMouseMove: WordBool index 8 read GetWordBoolProp write SetWordBoolProp stored False;
    property SendMouseUp: WordBool index 7 read GetWordBoolProp write SetWordBoolProp stored False;
    property SendMouseDown: WordBool index 6 read GetWordBoolProp write SetWordBoolProp stored False;
    property UDCursorHandle: Integer index 5 read GetIntegerProp write SetIntegerProp stored False;
    property MapCursor: TOleEnum index 4 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property CursorMode: TOleEnum index 3 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property ZoomPercent: Double index 2 read GetDoubleProp write SetDoubleProp stored False;
    property BackColor: TColor index 1 read GetTColorProp write SetTColorProp stored False;
    property OnMouseDown: TMapMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TMapMouseUp read FOnMouseUp write FOnMouseUp;
    property OnMouseMove: TMapMouseMove read FOnMouseMove write FOnMouseMove;
    property OnFileDropped: TMapFileDropped read FOnFileDropped write FOnFileDropped;
    property OnSelectBoxFinal: TMapSelectBoxFinal read FOnSelectBoxFinal write FOnSelectBoxFinal;
    property OnSelectBoxDrag: TMapSelectBoxDrag read FOnSelectBoxDrag write FOnSelectBoxDrag;
    property OnExtentsChanged: TNotifyEvent read FOnExtentsChanged write FOnExtentsChanged;
    property OnMapState: TMapMapState read FOnMapState write FOnMapState;
    property OnDrawBackBuffer: TMapOnDrawBackBuffer read FOnDrawBackBuffer write FOnDrawBackBuffer;
  end;

// *********************************************************************//
// The Class CoShapefileColorScheme provides a Create and CreateRemote method to          
// create instances of the default interface IShapefileColorScheme exposed by              
// the CoClass ShapefileColorScheme. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapefileColorScheme = class
    class function Create: IShapefileColorScheme;
    class function CreateRemote(const MachineName: string): IShapefileColorScheme;
  end;

// *********************************************************************//
// The Class CoShapefileColorBreak provides a Create and CreateRemote method to          
// create instances of the default interface IShapefileColorBreak exposed by              
// the CoClass ShapefileColorBreak. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapefileColorBreak = class
    class function Create: IShapefileColorBreak;
    class function CreateRemote(const MachineName: string): IShapefileColorBreak;
  end;

// *********************************************************************//
// The Class CoGrid provides a Create and CreateRemote method to          
// create instances of the default interface IGrid exposed by              
// the CoClass Grid. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGrid = class
    class function Create: IGrid;
    class function CreateRemote(const MachineName: string): IGrid;
  end;

// *********************************************************************//
// The Class CoGridHeader provides a Create and CreateRemote method to          
// create instances of the default interface IGridHeader exposed by              
// the CoClass GridHeader. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGridHeader = class
    class function Create: IGridHeader;
    class function CreateRemote(const MachineName: string): IGridHeader;
  end;

// *********************************************************************//
// The Class CoESRIGridManager provides a Create and CreateRemote method to          
// create instances of the default interface IESRIGridManager exposed by              
// the CoClass ESRIGridManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoESRIGridManager = class
    class function Create: IESRIGridManager;
    class function CreateRemote(const MachineName: string): IESRIGridManager;
  end;

// *********************************************************************//
// The Class CoImage provides a Create and CreateRemote method to          
// create instances of the default interface IImage exposed by              
// the CoClass Image. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoImage = class
    class function Create: IImage;
    class function CreateRemote(const MachineName: string): IImage;
  end;

// *********************************************************************//
// The Class CoShapefile provides a Create and CreateRemote method to          
// create instances of the default interface IShapefile exposed by              
// the CoClass Shapefile. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapefile = class
    class function Create: IShapefile;
    class function CreateRemote(const MachineName: string): IShapefile;
  end;

// *********************************************************************//
// The Class CoShape provides a Create and CreateRemote method to          
// create instances of the default interface IShape exposed by              
// the CoClass Shape. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShape = class
    class function Create: IShape;
    class function CreateRemote(const MachineName: string): IShape;
  end;

// *********************************************************************//
// The Class CoExtents provides a Create and CreateRemote method to          
// create instances of the default interface IExtents exposed by              
// the CoClass Extents. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExtents = class
    class function Create: IExtents;
    class function CreateRemote(const MachineName: string): IExtents;
  end;

// *********************************************************************//
// The Class CoPoint provides a Create and CreateRemote method to          
// create instances of the default interface IPoint exposed by              
// the CoClass Point. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPoint = class
    class function Create: IPoint;
    class function CreateRemote(const MachineName: string): IPoint;
  end;

// *********************************************************************//
// The Class CoTable provides a Create and CreateRemote method to          
// create instances of the default interface ITable exposed by              
// the CoClass Table. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTable = class
    class function Create: ITable;
    class function CreateRemote(const MachineName: string): ITable;
  end;

// *********************************************************************//
// The Class CoField provides a Create and CreateRemote method to          
// create instances of the default interface IField exposed by              
// the CoClass Field. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoField = class
    class function Create: IField;
    class function CreateRemote(const MachineName: string): IField;
  end;

// *********************************************************************//
// The Class CoShapeNetwork provides a Create and CreateRemote method to          
// create instances of the default interface IShapeNetwork exposed by              
// the CoClass ShapeNetwork. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapeNetwork = class
    class function Create: IShapeNetwork;
    class function CreateRemote(const MachineName: string): IShapeNetwork;
  end;

// *********************************************************************//
// The Class CoUtils provides a Create and CreateRemote method to          
// create instances of the default interface IUtils exposed by              
// the CoClass Utils. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUtils = class
    class function Create: IUtils;
    class function CreateRemote(const MachineName: string): IUtils;
  end;

// *********************************************************************//
// The Class CoVector provides a Create and CreateRemote method to          
// create instances of the default interface IVector exposed by              
// the CoClass Vector. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVector = class
    class function Create: IVector;
    class function CreateRemote(const MachineName: string): IVector;
  end;

// *********************************************************************//
// The Class CoGridColorScheme provides a Create and CreateRemote method to          
// create instances of the default interface IGridColorScheme exposed by              
// the CoClass GridColorScheme. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGridColorScheme = class
    class function Create: IGridColorScheme;
    class function CreateRemote(const MachineName: string): IGridColorScheme;
  end;

// *********************************************************************//
// The Class CoGridColorBreak provides a Create and CreateRemote method to          
// create instances of the default interface IGridColorBreak exposed by              
// the CoClass GridColorBreak. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGridColorBreak = class
    class function Create: IGridColorBreak;
    class function CreateRemote(const MachineName: string): IGridColorBreak;
  end;

// *********************************************************************//
// The Class CoTin provides a Create and CreateRemote method to          
// create instances of the default interface ITin exposed by              
// the CoClass Tin. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTin = class
    class function Create: ITin;
    class function CreateRemote(const MachineName: string): ITin;
  end;

// *********************************************************************//
// The Class CoShapeDrawingOptions provides a Create and CreateRemote method to          
// create instances of the default interface IShapeDrawingOptions exposed by              
// the CoClass ShapeDrawingOptions. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapeDrawingOptions = class
    class function Create: IShapeDrawingOptions;
    class function CreateRemote(const MachineName: string): IShapeDrawingOptions;
  end;

// *********************************************************************//
// The Class CoLabels provides a Create and CreateRemote method to          
// create instances of the default interface ILabels exposed by              
// the CoClass Labels. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLabels = class
    class function Create: ILabels;
    class function CreateRemote(const MachineName: string): ILabels;
  end;

// *********************************************************************//
// The Class CoLabelCategory provides a Create and CreateRemote method to          
// create instances of the default interface ILabelCategory exposed by              
// the CoClass LabelCategory. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLabelCategory = class
    class function Create: ILabelCategory;
    class function CreateRemote(const MachineName: string): ILabelCategory;
  end;

// *********************************************************************//
// The Class CoLabel_ provides a Create and CreateRemote method to          
// create instances of the default interface ILabel exposed by              
// the CoClass Label_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLabel_ = class
    class function Create: ILabel;
    class function CreateRemote(const MachineName: string): ILabel;
  end;

// *********************************************************************//
// The Class CoShapefileCategories provides a Create and CreateRemote method to          
// create instances of the default interface IShapefileCategories exposed by              
// the CoClass ShapefileCategories. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapefileCategories = class
    class function Create: IShapefileCategories;
    class function CreateRemote(const MachineName: string): IShapefileCategories;
  end;

// *********************************************************************//
// The Class CoShapefileCategory provides a Create and CreateRemote method to          
// create instances of the default interface IShapefileCategory exposed by              
// the CoClass ShapefileCategory. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShapefileCategory = class
    class function Create: IShapefileCategory;
    class function CreateRemote(const MachineName: string): IShapefileCategory;
  end;

// *********************************************************************//
// The Class CoCharts provides a Create and CreateRemote method to          
// create instances of the default interface ICharts exposed by              
// the CoClass Charts. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCharts = class
    class function Create: ICharts;
    class function CreateRemote(const MachineName: string): ICharts;
  end;

// *********************************************************************//
// The Class CoChart provides a Create and CreateRemote method to          
// create instances of the default interface IChart exposed by              
// the CoClass Chart. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChart = class
    class function Create: IChart;
    class function CreateRemote(const MachineName: string): IChart;
  end;

// *********************************************************************//
// The Class CoColorScheme provides a Create and CreateRemote method to          
// create instances of the default interface IColorScheme exposed by              
// the CoClass ColorScheme. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoColorScheme = class
    class function Create: IColorScheme;
    class function CreateRemote(const MachineName: string): IColorScheme;
  end;

// *********************************************************************//
// The Class CoChartField provides a Create and CreateRemote method to          
// create instances of the default interface IChartField exposed by              
// the CoClass ChartField. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoChartField = class
    class function Create: IChartField;
    class function CreateRemote(const MachineName: string): IChartField;
  end;

// *********************************************************************//
// The Class CoLinePattern provides a Create and CreateRemote method to          
// create instances of the default interface ILinePattern exposed by              
// the CoClass LinePattern. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLinePattern = class
    class function Create: ILinePattern;
    class function CreateRemote(const MachineName: string): ILinePattern;
  end;

// *********************************************************************//
// The Class CoLineSegment provides a Create and CreateRemote method to          
// create instances of the default interface ILineSegment exposed by              
// the CoClass LineSegment. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLineSegment = class
    class function Create: ILineSegment;
    class function CreateRemote(const MachineName: string): ILineSegment;
  end;

// *********************************************************************//
// The Class CoGeoProjection provides a Create and CreateRemote method to          
// create instances of the default interface IGeoProjection exposed by              
// the CoClass GeoProjection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGeoProjection = class
    class function Create: IGeoProjection;
    class function CreateRemote(const MachineName: string): IGeoProjection;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TMap.InitControlData;
const
  CEventDispIDs: array [0..8] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $00000007, $00000008, $00000009);
  CControlData: TControlData2 = (
    ClassID: '{54F4C2F7-ED40-43B7-9D6F-E45965DF7F95}';
    EventIID: '{ABEA1545-08AB-4D5C-A594-D3017211EA95}';
    EventCount: 9;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnMouseDown) - Cardinal(Self);
end;

procedure TMap.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DMap;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMap.GetControlInterface: _DMap;
begin
  CreateControl;
  Result := FIntf;
end;

function TMap.Get_ShapeLayerFillColor(LayerHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeLayerFillColor[LayerHandle];
end;

function TMap.Get_LayerVisible(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerVisible[LayerHandle];
end;

function TMap.Get_LayerPosition(LayerHandle: Integer): Integer;
begin
    Result := DefaultInterface.LayerPosition[LayerHandle];
end;

procedure TMap.Set_LayerVisible(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerVisible[LayerHandle] := Param2;
end;

function TMap.Get_LayerHandle(LayerPosition: Integer): Integer;
begin
    Result := DefaultInterface.LayerHandle[LayerPosition];
end;

function TMap.Get_ShapeLayerLineColor(LayerHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeLayerLineColor[LayerHandle];
end;

function TMap.Get_ShapeFillColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeFillColor[LayerHandle, Shape];
end;

procedure TMap.Set_ShapeFillColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
begin
  DefaultInterface.ShapeFillColor[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeLayerFillColor(LayerHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.ShapeLayerFillColor[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeLayerLineColor(LayerHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.ShapeLayerLineColor[LayerHandle] := Param2;
end;

function TMap.Get_ShapeLineColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeLineColor[LayerHandle, Shape];
end;

procedure TMap.Set_LayerKey(LayerHandle: Integer; const Param2: WideString);
  { Warning: The property LayerKey has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LayerKey := Param2;
end;

procedure TMap.Set_ShapeLayerStippleTransparent(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.ShapeLayerStippleTransparent[LayerHandle] := Param2;
end;

procedure TMap.Set_DrawingLabels(DrawingLayerIndex: Integer; const Param2: ILabels);
begin
  DefaultInterface.DrawingLabels[DrawingLayerIndex] := Param2;
end;

procedure TMap.Set_ShapeStippleTransparent(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
begin
  DefaultInterface.ShapeStippleTransparent[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerStippleTransparent(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeLayerStippleTransparent[LayerHandle];
end;

function TMap.Get_ShapeStippleTransparent(LayerHandle: Integer; Shape: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeStippleTransparent[LayerHandle, Shape];
end;

function TMap.Get_DrawingLabels(DrawingLayerIndex: Integer): ILabels;
begin
    Result := DefaultInterface.DrawingLabels[DrawingLayerIndex];
end;

function TMap.Get_LayerKey(LayerHandle: Integer): WideString;
begin
    Result := DefaultInterface.LayerKey[LayerHandle];
end;

function TMap.Get_ShapeLayerDrawFill(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeLayerDrawFill[LayerHandle];
end;

function TMap.Get_ShapeLayerDrawLine(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeLayerDrawLine[LayerHandle];
end;

procedure TMap.Set_ShapeLayerDrawLine(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.ShapeLayerDrawLine[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeLayerPointColor(LayerHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.ShapeLayerPointColor[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeLineColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
begin
  DefaultInterface.ShapeLineColor[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerPointColor(LayerHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeLayerPointColor[LayerHandle];
end;

procedure TMap.Set_ShapeDrawFill(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
begin
  DefaultInterface.ShapeDrawFill[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ImageLayerPercentTransparent(LayerHandle: Integer): Single;
begin
    Result := DefaultInterface.ImageLayerPercentTransparent[LayerHandle];
end;

procedure TMap.Set_ImageLayerPercentTransparent(LayerHandle: Integer; Param2: Single);
begin
  DefaultInterface.ImageLayerPercentTransparent[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeVisible(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
begin
  DefaultInterface.ShapeVisible[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeLayerDrawFill(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.ShapeLayerDrawFill[LayerHandle] := Param2;
end;

function TMap.Get_ShapeDrawFill(LayerHandle: Integer; Shape: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeDrawFill[LayerHandle, Shape];
end;

function TMap.Get_ShapePointSize(LayerHandle: Integer; Shape: Integer): Single;
begin
    Result := DefaultInterface.ShapePointSize[LayerHandle, Shape];
end;

procedure TMap.Set_ShapePointColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
begin
  DefaultInterface.ShapePointColor[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeDrawLine(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
begin
  DefaultInterface.ShapeDrawLine[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerDrawPoint(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeLayerDrawPoint[LayerHandle];
end;

function TMap.Get_ShapeLayerLineWidth(LayerHandle: Integer): Single;
begin
    Result := DefaultInterface.ShapeLayerLineWidth[LayerHandle];
end;

function TMap.Get_ShapeDrawPoint(LayerHandle: Integer; Shape: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeDrawPoint[LayerHandle, Shape];
end;

procedure TMap.Set_ShapeDrawPoint(LayerHandle: Integer; Shape: Integer; Param3: WordBool);
begin
  DefaultInterface.ShapeDrawPoint[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeLayerDrawPoint(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.ShapeLayerDrawPoint[LayerHandle] := Param2;
end;

function TMap.Get_ShapeLayerPointSize(LayerHandle: Integer): Single;
begin
    Result := DefaultInterface.ShapeLayerPointSize[LayerHandle];
end;

function TMap.Get_ShapeLineWidth(LayerHandle: Integer; Shape: Integer): Single;
begin
    Result := DefaultInterface.ShapeLineWidth[LayerHandle, Shape];
end;

function TMap.Get_ShapeDrawLine(LayerHandle: Integer; Shape: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeDrawLine[LayerHandle, Shape];
end;

function TMap.Get_ShapePointColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapePointColor[LayerHandle, Shape];
end;

procedure TMap.Set_ShapeLayerPointSize(LayerHandle: Integer; Param2: Single);
begin
  DefaultInterface.ShapeLayerPointSize[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeLineWidth(LayerHandle: Integer; Shape: Integer; Param3: Single);
begin
  DefaultInterface.ShapeLineWidth[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeLayerLineWidth(LayerHandle: Integer; Param2: Single);
begin
  DefaultInterface.ShapeLayerLineWidth[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeFillStipple(LayerHandle: Integer; Shape: Integer; Param3: tkFillStipple);
begin
  DefaultInterface.ShapeFillStipple[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeLayerLineStipple(LayerHandle: Integer; Param2: tkLineStipple);
begin
  DefaultInterface.ShapeLayerLineStipple[LayerHandle] := Param2;
end;

function TMap.Get_ShapeLineStipple(LayerHandle: Integer; Shape: Integer): tkLineStipple;
begin
    Result := DefaultInterface.ShapeLineStipple[LayerHandle, Shape];
end;

function TMap.Get_ShapeLayerFillStipple(LayerHandle: Integer): tkFillStipple;
begin
    Result := DefaultInterface.ShapeLayerFillStipple[LayerHandle];
end;

procedure TMap.Set_ShapeLayerFillStipple(LayerHandle: Integer; Param2: tkFillStipple);
begin
  DefaultInterface.ShapeLayerFillStipple[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapeLineStipple(LayerHandle: Integer; Shape: Integer; Param3: tkLineStipple);
begin
  DefaultInterface.ShapeLineStipple[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerLineStipple(LayerHandle: Integer): tkLineStipple;
begin
    Result := DefaultInterface.ShapeLayerLineStipple[LayerHandle];
end;

function TMap.Get_ShapePointType(LayerHandle: Integer; Shape: Integer): tkPointType;
begin
    Result := DefaultInterface.ShapePointType[LayerHandle, Shape];
end;

function TMap.Get_ShapeLayerPointType(LayerHandle: Integer): tkPointType;
begin
    Result := DefaultInterface.ShapeLayerPointType[LayerHandle];
end;

function TMap.Get_DrawingKey(DrawHandle: Integer): WideString;
begin
    Result := DefaultInterface.DrawingKey[DrawHandle];
end;

function TMap.Get_ShapeVisible(LayerHandle: Integer; Shape: Integer): WordBool;
begin
    Result := DefaultInterface.ShapeVisible[LayerHandle, Shape];
end;

function TMap.Get_ErrorMsg(ErrorCode: Integer): WideString;
begin
    Result := DefaultInterface.ErrorMsg[ErrorCode];
end;

procedure TMap.Set_ShapeLayerPointType(LayerHandle: Integer; Param2: tkPointType);
begin
  DefaultInterface.ShapeLayerPointType[LayerHandle] := Param2;
end;

procedure TMap.Set_DrawingKey(DrawHandle: Integer; const Param2: WideString);
  { Warning: The property DrawingKey has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DrawingKey := Param2;
end;

procedure TMap.Set_ShapeLayerFillTransparency(LayerHandle: Integer; Param2: Single);
begin
  DefaultInterface.ShapeLayerFillTransparency[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapePointSize(LayerHandle: Integer; Shape: Integer; Param3: Single);
begin
  DefaultInterface.ShapePointSize[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerFillTransparency(LayerHandle: Integer): Single;
begin
    Result := DefaultInterface.ShapeLayerFillTransparency[LayerHandle];
end;

function TMap.Get_ShapeFillStipple(LayerHandle: Integer; Shape: Integer): tkFillStipple;
begin
    Result := DefaultInterface.ShapeFillStipple[LayerHandle, Shape];
end;

function TMap.Get_ShapeFillTransparency(LayerHandle: Integer; Shape: Integer): Single;
begin
    Result := DefaultInterface.ShapeFillTransparency[LayerHandle, Shape];
end;

procedure TMap.Set_ShapeFillTransparency(LayerHandle: Integer; Shape: Integer; Param3: Single);
begin
  DefaultInterface.ShapeFillTransparency[LayerHandle, Shape] := Param3;
end;

function TMap.Get_GridFileName(LayerHandle: Integer): WideString;
begin
    Result := DefaultInterface.GridFileName[LayerHandle];
end;

procedure TMap.Set_GridFileName(LayerHandle: Integer; const Param2: WideString);
  { Warning: The property GridFileName has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.GridFileName := Param2;
end;

procedure TMap.Set_LayerName(LayerHandle: Integer; const Param2: WideString);
  { Warning: The property LayerName has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LayerName := Param2;
end;

procedure TMap.Set_LayerLabelsVisible(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerLabelsVisible[LayerHandle] := Param2;
end;

function TMap.Get_UDPointType(LayerHandle: Integer): IDispatch;
begin
    Result := DefaultInterface.UDPointType[LayerHandle];
end;

procedure TMap._Set_UDPointType(LayerHandle: Integer; const Param2: IDispatch);
  { Warning: The property UDPointType has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UDPointType := Param2;
end;

function TMap.Get_DrawingLabelsScale(DrawHandle: Integer): WordBool;
begin
    Result := DefaultInterface.DrawingLabelsScale[DrawHandle];
end;

procedure TMap.Set_DrawingLabelsScale(DrawHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.DrawingLabelsScale[DrawHandle] := Param2;
end;

function TMap.Get_DrawingLabelsShadow(DrawHandle: Integer): WordBool;
begin
    Result := DefaultInterface.DrawingLabelsShadow[DrawHandle];
end;

function TMap.Get_GetObject(LayerHandle: Integer): IDispatch;
begin
    Result := DefaultInterface.GetObject[LayerHandle];
end;

function TMap.Get_LayerName(LayerHandle: Integer): WideString;
begin
    Result := DefaultInterface.LayerName[LayerHandle];
end;

function TMap.Get_LayerLabelsVisible(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerLabelsVisible[LayerHandle];
end;

function TMap.Get_UseLabelCollision(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.UseLabelCollision[LayerHandle];
end;

procedure TMap.Set_LayerLabelsOffset(LayerHandle: Integer; Param2: Integer);
begin
  DefaultInterface.LayerLabelsOffset[LayerHandle] := Param2;
end;

function TMap.Get_LayerLabelsShadowColor(LayerHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.LayerLabelsShadowColor[LayerHandle];
end;

procedure TMap.Set_UseLabelCollision(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.UseLabelCollision[LayerHandle] := Param2;
end;

procedure TMap.Set_LayerLabelsShadowColor(LayerHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.LayerLabelsShadowColor[LayerHandle] := Param2;
end;

procedure TMap.Set_UDFillStipple(LayerHandle: Integer; StippleRow: Integer; Param3: Integer);
begin
  DefaultInterface.UDFillStipple[LayerHandle, StippleRow] := Param3;
end;

function TMap.Get_UDLineStipple(LayerHandle: Integer): Integer;
begin
    Result := DefaultInterface.UDLineStipple[LayerHandle];
end;

procedure TMap.Set_ShapePointType(LayerHandle: Integer; Shape: Integer; Param3: tkPointType);
begin
  DefaultInterface.ShapePointType[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_UDLineStipple(LayerHandle: Integer; Param2: Integer);
begin
  DefaultInterface.UDLineStipple[LayerHandle] := Param2;
end;

function TMap.Get_UDFillStipple(LayerHandle: Integer; StippleRow: Integer): Integer;
begin
    Result := DefaultInterface.UDFillStipple[LayerHandle, StippleRow];
end;

procedure TMap.Set_DrawingLabelsOffset(DrawHandle: Integer; Param2: Integer);
begin
  DefaultInterface.DrawingLabelsOffset[DrawHandle] := Param2;
end;

procedure TMap.Set_ShapePointImageListID(LayerHandle: Integer; Shape: Integer; Param3: Integer);
begin
  DefaultInterface.ShapePointImageListID[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_DrawingLabelsShadow(DrawHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.DrawingLabelsShadow[DrawHandle] := Param2;
end;

function TMap.Get_DrawingLabelsVisible(DrawHandle: Integer): WordBool;
begin
    Result := DefaultInterface.DrawingLabelsVisible[DrawHandle];
end;

procedure TMap.Set_DrawingLabelsVisible(DrawHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.DrawingLabelsVisible[DrawHandle] := Param2;
end;

function TMap.Get_DrawingLabelsOffset(DrawHandle: Integer): Integer;
begin
    Result := DefaultInterface.DrawingLabelsOffset[DrawHandle];
end;

function TMap.Get_UseDrawingLabelCollision(DrawHandle: Integer): WordBool;
begin
    Result := DefaultInterface.UseDrawingLabelCollision[DrawHandle];
end;

function TMap.Get_ShapePointImageListID(LayerHandle: Integer; Shape: Integer): Integer;
begin
    Result := DefaultInterface.ShapePointImageListID[LayerHandle, Shape];
end;

procedure TMap.Set_UseDrawingLabelCollision(DrawHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.UseDrawingLabelCollision[DrawHandle] := Param2;
end;

function TMap.Get_DrawingLabelsShadowColor(DrawHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.DrawingLabelsShadowColor[DrawHandle];
end;

procedure TMap.Set_DrawingLabelsShadowColor(DrawHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.DrawingLabelsShadowColor[DrawHandle] := Param2;
end;

function TMap.Get_Image(LayerHandle: Integer): IImage;
begin
    Result := DefaultInterface.Image[LayerHandle];
end;

function TMap.Get_LayerSkipOnSaving(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerSkipOnSaving[LayerHandle];
end;

procedure TMap.Set_LayerSkipOnSaving(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerSkipOnSaving[LayerHandle] := Param2;
end;

procedure TMap.Set_Image(LayerHandle: Integer; const Param2: IImage);
begin
  DefaultInterface.Image[LayerHandle] := Param2;
end;

procedure TMap.Set_ShapePointFontCharListID(LayerHandle: Integer; Shape: Integer; Param3: Integer);
begin
  DefaultInterface.ShapePointFontCharListID[LayerHandle, Shape] := Param3;
end;

procedure TMap.Set_ShapeStippleColor(LayerHandle: Integer; Shape: Integer; Param3: OLE_COLOR);
begin
  DefaultInterface.ShapeStippleColor[LayerHandle, Shape] := Param3;
end;

function TMap.Get_ShapeLayerStippleColor(LayerHandle: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeLayerStippleColor[LayerHandle];
end;

function TMap.Get_ShapePointFontCharListID(LayerHandle: Integer; Shape: Integer): Integer;
begin
    Result := DefaultInterface.ShapePointFontCharListID[LayerHandle, Shape];
end;

procedure TMap.Set_ShapeLayerStippleColor(LayerHandle: Integer; Param2: OLE_COLOR);
begin
  DefaultInterface.ShapeLayerStippleColor[LayerHandle] := Param2;
end;

function TMap.Get_ShapeStippleColor(LayerHandle: Integer; Shape: Integer): OLE_COLOR;
begin
    Result := DefaultInterface.ShapeStippleColor[LayerHandle, Shape];
end;

function TMap.Get_LayerDynamicVisibility(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerDynamicVisibility[LayerHandle];
end;

procedure TMap.Set_LayerDynamicVisibility(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerDynamicVisibility[LayerHandle] := Param2;
end;

function TMap.Get_Shapefile(LayerHandle: Integer): IShapefile;
begin
    Result := DefaultInterface.Shapefile[LayerHandle];
end;

procedure TMap.Set_LayerMinVisibleScale(LayerHandle: Integer; Param2: Double);
begin
  DefaultInterface.LayerMinVisibleScale[LayerHandle] := Param2;
end;

procedure TMap.Set_LayerLabelsShadow(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerLabelsShadow[LayerHandle] := Param2;
end;

function TMap.Get_LayerLabelsScale(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerLabelsScale[LayerHandle];
end;

function TMap.Get_LayerLabelsOffset(LayerHandle: Integer): Integer;
begin
    Result := DefaultInterface.LayerLabelsOffset[LayerHandle];
end;

procedure TMap.Set_LayerLabelsScale(LayerHandle: Integer; Param2: WordBool);
begin
  DefaultInterface.LayerLabelsScale[LayerHandle] := Param2;
end;

function TMap.Get_LayerLabelsShadow(LayerHandle: Integer): WordBool;
begin
    Result := DefaultInterface.LayerLabelsShadow[LayerHandle];
end;

procedure TMap.Set_LayerLabels(LayerHandle: Integer; const Param2: ILabels);
begin
  DefaultInterface.LayerLabels[LayerHandle] := Param2;
end;

procedure TMap.Set_Shapefile(LayerHandle: Integer; const Param2: IShapefile);
begin
  DefaultInterface.Shapefile[LayerHandle] := Param2;
end;

function TMap.Get_LayerMaxVisibleScale(LayerHandle: Integer): Double;
begin
    Result := DefaultInterface.LayerMaxVisibleScale[LayerHandle];
end;

function TMap.Get_LayerDescription(LayerHandle: Integer): WideString;
begin
    Result := DefaultInterface.LayerDescription[LayerHandle];
end;

procedure TMap.Set_LayerDescription(LayerHandle: Integer; const Param2: WideString);
  { Warning: The property LayerDescription has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.LayerDescription := Param2;
end;

procedure TMap.Set_LayerMaxVisibleScale(LayerHandle: Integer; Param2: Double);
begin
  DefaultInterface.LayerMaxVisibleScale[LayerHandle] := Param2;
end;

function TMap.Get_LayerMinVisibleScale(LayerHandle: Integer): Double;
begin
    Result := DefaultInterface.LayerMinVisibleScale[LayerHandle];
end;

function TMap.Get_LayerLabels(LayerHandle: Integer): ILabels;
begin
    Result := DefaultInterface.LayerLabels[LayerHandle];
end;

function TMap.Get_Extents: IDispatch;
begin
  Result := DefaultInterface.Extents;
end;

procedure TMap.Set_Extents(const Value: IDispatch);
begin
  DefaultInterface.Extents := Value;
end;

function TMap.Get_GlobalCallback: IDispatch;
begin
  Result := DefaultInterface.GlobalCallback;
end;

procedure TMap.Set_GlobalCallback(const Value: IDispatch);
begin
  DefaultInterface.GlobalCallback := Value;
end;

function TMap.MoveLayer(InitialPosition: Integer; TargetPosition: Integer): WordBool;
begin
  Result := DefaultInterface.MoveLayer(InitialPosition, TargetPosition);
end;

procedure TMap.Resize(Width: Integer; Height: Integer);
begin
  DefaultInterface.Resize(Width, Height);
end;

function TMap.MoveLayerDown(InitialPosition: Integer): WordBool;
begin
  Result := DefaultInterface.MoveLayerDown(InitialPosition);
end;

procedure TMap.ZoomToLayer(LayerHandle: Integer);
begin
  DefaultInterface.ZoomToLayer(LayerHandle);
end;

procedure TMap.RemoveLayerWithoutClosing(LayerHandle: Integer);
begin
  DefaultInterface.RemoveLayerWithoutClosing(LayerHandle);
end;

procedure TMap.RemoveAllLayers;
begin
  DefaultInterface.RemoveAllLayers;
end;

function TMap.SnapShot(const BoundBox: IDispatch): IDispatch;
begin
  Result := DefaultInterface.SnapShot(BoundBox);
end;

procedure TMap.ClearDrawing(DrawHandle: Integer);
begin
  DefaultInterface.ClearDrawing(DrawHandle);
end;

procedure TMap.ClearDrawings;
begin
  DefaultInterface.ClearDrawings;
end;

procedure TMap.RemoveLayer(LayerHandle: Integer);
begin
  DefaultInterface.RemoveLayer(LayerHandle);
end;

function TMap.MoveLayerBottom(InitialPosition: Integer): WordBool;
begin
  Result := DefaultInterface.MoveLayerBottom(InitialPosition);
end;

procedure TMap.ZoomToMaxExtents;
begin
  DefaultInterface.ZoomToMaxExtents;
end;

function TMap.MoveLayerTop(InitialPosition: Integer): WordBool;
begin
  Result := DefaultInterface.MoveLayerTop(InitialPosition);
end;

procedure TMap.Redraw;
begin
  DefaultInterface.Redraw;
end;

function TMap.AddLayer(const Object_: IDispatch; Visible: WordBool): Integer;
begin
  Result := DefaultInterface.AddLayer(Object_, Visible);
end;

function TMap.MoveLayerUp(InitialPosition: Integer): WordBool;
begin
  Result := DefaultInterface.MoveLayerUp(InitialPosition);
end;

function TMap.AdjustLayerExtents(LayerHandle: Integer): WordBool;
begin
  Result := DefaultInterface.AdjustLayerExtents(LayerHandle);
end;

procedure TMap.DrawWideCircleEx(LayerHandle: Integer; x: Double; y: Double; radius: Double; 
                                Color: OLE_COLOR; fill: WordBool; OutlineWidth: Smallint);
begin
  DefaultInterface.DrawWideCircleEx(LayerHandle, x, y, radius, Color, fill, OutlineWidth);
end;

procedure TMap.DrawPolygonEx(LayerHandle: Integer; var xPoints: OleVariant; 
                             var yPoints: OleVariant; numPoints: Integer; Color: OLE_COLOR; 
                             fill: WordBool);
begin
  DefaultInterface.DrawPolygonEx(LayerHandle, xPoints, yPoints, numPoints, Color, fill);
end;

function TMap.SnapShotToDC(var hdc: {??Pointer}OleVariant; const Extents: IExtents; Width: Integer): WordBool;
begin
  Result := DefaultInterface.SnapShotToDC(hdc, Extents, Width);
end;

procedure TMap.DrawWidePolygonEx(LayerHandle: Integer; var xPoints: OleVariant; 
                                 var yPoints: OleVariant; numPoints: Integer; Color: OLE_COLOR; 
                                 fill: WordBool; OutlineWidth: Smallint);
begin
  DefaultInterface.DrawWidePolygonEx(LayerHandle, xPoints, yPoints, numPoints, Color, fill, 
                                     OutlineWidth);
end;

function TMap.SnapShot3(left: Double; right: Double; top: Double; bottom: Double; Width: Integer): IDispatch;
begin
  Result := DefaultInterface.SnapShot3(left, right, top, bottom, Width);
end;

procedure TMap.ShowToolTip(const Text: WideString; Milliseconds: Integer);
begin
  DefaultInterface.ShowToolTip(Text, Milliseconds);
end;

procedure TMap.AddLabel(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; x: Double; 
                        y: Double; hJustification: tkHJustification);
begin
  DefaultInterface.AddLabel(LayerHandle, Text, Color, x, y, hJustification);
end;

function TMap.NewDrawing(Projection: tkDrawReferenceList): Integer;
begin
  Result := DefaultInterface.NewDrawing(Projection);
end;

procedure TMap.LayerFont(LayerHandle: Integer; const FontName: WideString; FontSize: Integer);
begin
  DefaultInterface.LayerFont(LayerHandle, FontName, FontSize);
end;

function TMap.GetColorScheme(LayerHandle: Integer): IDispatch;
begin
  Result := DefaultInterface.GetColorScheme(LayerHandle);
end;

procedure TMap.ClearLabels(LayerHandle: Integer);
begin
  DefaultInterface.ClearLabels(LayerHandle);
end;

procedure TMap.DrawPolygon(var xPoints: OleVariant; var yPoints: OleVariant; numPoints: Integer; 
                           Color: OLE_COLOR; fill: WordBool);
begin
  DefaultInterface.DrawPolygon(xPoints, yPoints, numPoints, Color, fill);
end;

procedure TMap.DrawLine(x1: Double; y1: Double; x2: Double; y2: Double; pixelWidth: Integer; 
                        Color: OLE_COLOR);
begin
  DefaultInterface.DrawLine(x1, y1, x2, y2, pixelWidth, Color);
end;

procedure TMap.DrawCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; 
                          fill: WordBool);
begin
  DefaultInterface.DrawCircle(x, y, pixelRadius, Color, fill);
end;

procedure TMap.DrawPoint(x: Double; y: Double; pixelSize: Integer; Color: OLE_COLOR);
begin
  DefaultInterface.DrawPoint(x, y, pixelSize, Color);
end;

function TMap.ZoomToPrev: Integer;
begin
  Result := DefaultInterface.ZoomToPrev;
end;

procedure TMap.ProjToPixel(projX: Double; projY: Double; var pixelX: Double; var pixelY: Double);
begin
  DefaultInterface.ProjToPixel(projX, projY, pixelX, pixelY);
end;

procedure TMap.PixelToProj(pixelX: Double; pixelY: Double; var projX: Double; var projY: Double);
begin
  DefaultInterface.PixelToProj(pixelX, pixelY, projX, projY);
end;

function TMap.ApplyLegendColors(const Legend: IDispatch): WordBool;
begin
  Result := DefaultInterface.ApplyLegendColors(Legend);
end;

procedure TMap.LockWindow(LockMode: tkLockMode);
begin
  DefaultInterface.LockWindow(LockMode);
end;

procedure TMap.ZoomOut(Percent: Double);
begin
  DefaultInterface.ZoomOut(Percent);
end;

procedure TMap.ZoomToShape(LayerHandle: Integer; Shape: Integer);
begin
  DefaultInterface.ZoomToShape(LayerHandle, Shape);
end;

procedure TMap.ZoomIn(Percent: Double);
begin
  DefaultInterface.ZoomIn(Percent);
end;

function TMap.SetImageLayerColorScheme(LayerHandle: Integer; const ColorScheme: IDispatch): WordBool;
begin
  Result := DefaultInterface.SetImageLayerColorScheme(LayerHandle, ColorScheme);
end;

procedure TMap.ZoomToMaxVisibleExtents;
begin
  DefaultInterface.ZoomToMaxVisibleExtents;
end;

function TMap.IsTIFFGrid(const Filename: WideString): WordBool;
begin
  Result := DefaultInterface.IsTIFFGrid(Filename);
end;

function TMap.IsSameProjection(const proj4_a: WideString; const proj4_b: WideString): WordBool;
begin
  Result := DefaultInterface.IsSameProjection(proj4_a, proj4_b);
end;

procedure TMap.UpdateImage(LayerHandle: Integer);
begin
  DefaultInterface.UpdateImage(LayerHandle);
end;

function TMap.HWnd: Integer;
begin
  Result := DefaultInterface.HWnd;
end;

function TMap.get_UDPointImageListItem(LayerHandle: Integer; ImageIndex: Integer): IDispatch;
begin
  Result := DefaultInterface.get_UDPointImageListItem(LayerHandle, ImageIndex);
end;

function TMap.get_UDPointImageListCount(LayerHandle: Integer): Integer;
begin
  Result := DefaultInterface.get_UDPointImageListCount(LayerHandle);
end;

function TMap.set_UDPointImageListAdd(LayerHandle: Integer; const newValue: IDispatch): Integer;
begin
  Result := DefaultInterface.set_UDPointImageListAdd(LayerHandle, newValue);
end;

procedure TMap.LabelColor(LayerHandle: Integer; LabelFontColor: OLE_COLOR);
begin
  DefaultInterface.LabelColor(LayerHandle, LabelFontColor);
end;

procedure TMap.ClearUDPointImageList(LayerHandle: Integer);
begin
  DefaultInterface.ClearUDPointImageList(LayerHandle);
end;

procedure TMap.DrawLineEx(LayerHandle: Integer; x1: Double; y1: Double; x2: Double; y2: Double; 
                          pixelWidth: Integer; Color: OLE_COLOR);
begin
  DefaultInterface.DrawLineEx(LayerHandle, x1, y1, x2, y2, pixelWidth, Color);
end;

procedure TMap.DrawPointEx(LayerHandle: Integer; x: Double; y: Double; pixelSize: Integer; 
                           Color: OLE_COLOR);
begin
  DefaultInterface.DrawPointEx(LayerHandle, x, y, pixelSize, Color);
end;

procedure TMap.SetDrawingLayerVisible(LayerHandle: Integer; Visiable: WordBool);
begin
  DefaultInterface.SetDrawingLayerVisible(LayerHandle, Visiable);
end;

procedure TMap.ClearDrawingLabels(DrawHandle: Integer);
begin
  DefaultInterface.ClearDrawingLabels(DrawHandle);
end;

procedure TMap.DrawCircleEx(LayerHandle: Integer; x: Double; y: Double; pixelRadius: Double; 
                            Color: OLE_COLOR; fill: WordBool);
begin
  DefaultInterface.DrawCircleEx(LayerHandle, x, y, pixelRadius, Color, fill);
end;

procedure TMap.AddDrawingLabelEx(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                                 x: Double; y: Double; hJustification: tkHJustification; 
                                 Rotation: Double);
begin
  DefaultInterface.AddDrawingLabelEx(DrawHandle, Text, Color, x, y, hJustification, Rotation);
end;

procedure TMap.AddDrawingLabel(DrawHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                               x: Double; y: Double; hJustification: tkHJustification);
begin
  DefaultInterface.AddDrawingLabel(DrawHandle, Text, Color, x, y, hJustification);
end;

procedure TMap.GetDrawingStandardViewWidth(DrawHandle: Integer; var Width: Double);
begin
  DefaultInterface.GetDrawingStandardViewWidth(DrawHandle, Width);
end;

procedure TMap.DrawingFont(DrawHandle: Integer; const FontName: WideString; FontSize: Integer);
begin
  DefaultInterface.DrawingFont(DrawHandle, FontName, FontSize);
end;

function TMap.LoadMapState(const Filename: WideString; const Callback: IDispatch): WordBool;
begin
  Result := DefaultInterface.LoadMapState(Filename, Callback);
end;

function TMap.SaveLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                               Overwrite: WordBool; const Description: WideString): WordBool;
begin
  Result := DefaultInterface.SaveLayerOptions(LayerHandle, OptionsName, Overwrite, Description);
end;

function TMap.DeserializeLayer(LayerHandle: Integer; const newVal: WideString): WordBool;
begin
  Result := DefaultInterface.DeserializeLayer(LayerHandle, newVal);
end;

procedure TMap.ReSourceLayer(LayerHandle: Integer; const newSrcPath: WideString);
begin
  DefaultInterface.ReSourceLayer(LayerHandle, newSrcPath);
end;

function TMap.SaveMapState(const Filename: WideString; RelativePaths: WordBool; Overwrite: WordBool): WordBool;
begin
  Result := DefaultInterface.SaveMapState(Filename, RelativePaths, Overwrite);
end;

function TMap.RemoveLayerOptions(LayerHandle: Integer; const OptionsName: WideString): WordBool;
begin
  Result := DefaultInterface.RemoveLayerOptions(LayerHandle, OptionsName);
end;

function TMap.SerializeLayer(LayerHandle: Integer): WideString;
begin
  Result := DefaultInterface.SerializeLayer(LayerHandle);
end;

function TMap.LoadLayerOptions(LayerHandle: Integer; const OptionsName: WideString; 
                               var Description: WideString): WordBool;
begin
  Result := DefaultInterface.LoadLayerOptions(LayerHandle, OptionsName, Description);
end;

function TMap.SnapShot2(ClippingLayerNbr: Integer; Zoom: Double; pWidth: Integer): IDispatch;
begin
  Result := DefaultInterface.SnapShot2(ClippingLayerNbr, Zoom, pWidth);
end;

procedure TMap.SetDrawingStandardViewWidth(DrawHandle: Integer; Width: Double);
begin
  DefaultInterface.SetDrawingStandardViewWidth(DrawHandle, Width);
end;

procedure TMap.DrawWidePolygon(var xPoints: OleVariant; var yPoints: OleVariant; 
                               numPoints: Integer; Color: OLE_COLOR; fill: WordBool; Width: Smallint);
begin
  DefaultInterface.DrawWidePolygon(xPoints, yPoints, numPoints, Color, fill, Width);
end;

procedure TMap.LayerFontEx(LayerHandle: Integer; const FontName: WideString; FontSize: Integer; 
                           isBold: WordBool; isItalic: WordBool; isUnderline: WordBool);
begin
  DefaultInterface.LayerFontEx(LayerHandle, FontName, FontSize, isBold, isItalic, isUnderline);
end;

procedure TMap.set_UDPointFontCharFont(LayerHandle: Integer; const FontName: WideString; 
                                       FontSize: Single; isBold: WordBool; isItalic: WordBool; 
                                       isUnderline: WordBool);
begin
  DefaultInterface.set_UDPointFontCharFont(LayerHandle, FontName, FontSize, isBold, isItalic, 
                                           isUnderline);
end;

function TMap.set_UDPointFontCharListAdd(LayerHandle: Integer; newValue: Integer; Color: OLE_COLOR): Integer;
begin
  Result := DefaultInterface.set_UDPointFontCharListAdd(LayerHandle, newValue, Color);
end;

procedure TMap.DrawWideCircle(x: Double; y: Double; pixelRadius: Double; Color: OLE_COLOR; 
                              fill: WordBool; Width: Smallint);
begin
  DefaultInterface.DrawWideCircle(x, y, pixelRadius, Color, fill, Width);
end;

procedure TMap.set_UDPointFontCharFontSize(LayerHandle: Integer; FontSize: Single);
begin
  DefaultInterface.set_UDPointFontCharFontSize(LayerHandle, FontSize);
end;

function TMap.SerializeMapState(RelativePaths: WordBool; const BasePath: WideString): WideString;
begin
  Result := DefaultInterface.SerializeMapState(RelativePaths, BasePath);
end;

procedure TMap.AddLabelEx(LayerHandle: Integer; const Text: WideString; Color: OLE_COLOR; 
                          x: Double; y: Double; hJustification: tkHJustification; Rotation: Double);
begin
  DefaultInterface.AddLabelEx(LayerHandle, Text, Color, x, y, hJustification, Rotation);
end;

procedure TMap.DrawBackBuffer(hdc: {??PPSYSINT1}OleVariant; ImageWidth: SYSINT; ImageHeight: SYSINT);
begin
  DefaultInterface.DrawBackBuffer(hdc, ImageWidth, ImageHeight);
end;

procedure TMap.GetLayerStandardViewWidth(LayerHandle: Integer; var Width: Double);
begin
  DefaultInterface.GetLayerStandardViewWidth(LayerHandle, Width);
end;

procedure TMap.SetLayerStandardViewWidth(LayerHandle: Integer; Width: Double);
begin
  DefaultInterface.SetLayerStandardViewWidth(LayerHandle, Width);
end;

function TMap.DeserializeMapState(const State: WideString; LoadLayers: WordBool; 
                                  const BasePath: WideString): WordBool;
begin
  Result := DefaultInterface.DeserializeMapState(State, LoadLayers, BasePath);
end;

function TMap.GetBaseProjectionPoint(rotX: Double; rotY: Double): IPoint;
begin
  Result := DefaultInterface.GetBaseProjectionPoint(rotX, rotY);
end;

function TMap.GetRotatedExtent: IExtents;
begin
  Result := DefaultInterface.GetRotatedExtent;
end;

class function CoShapefileColorScheme.Create: IShapefileColorScheme;
begin
  Result := CreateComObject(CLASS_ShapefileColorScheme) as IShapefileColorScheme;
end;

class function CoShapefileColorScheme.CreateRemote(const MachineName: string): IShapefileColorScheme;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapefileColorScheme) as IShapefileColorScheme;
end;

class function CoShapefileColorBreak.Create: IShapefileColorBreak;
begin
  Result := CreateComObject(CLASS_ShapefileColorBreak) as IShapefileColorBreak;
end;

class function CoShapefileColorBreak.CreateRemote(const MachineName: string): IShapefileColorBreak;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapefileColorBreak) as IShapefileColorBreak;
end;

class function CoGrid.Create: IGrid;
begin
  Result := CreateComObject(CLASS_Grid) as IGrid;
end;

class function CoGrid.CreateRemote(const MachineName: string): IGrid;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Grid) as IGrid;
end;

class function CoGridHeader.Create: IGridHeader;
begin
  Result := CreateComObject(CLASS_GridHeader) as IGridHeader;
end;

class function CoGridHeader.CreateRemote(const MachineName: string): IGridHeader;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GridHeader) as IGridHeader;
end;

class function CoESRIGridManager.Create: IESRIGridManager;
begin
  Result := CreateComObject(CLASS_ESRIGridManager) as IESRIGridManager;
end;

class function CoESRIGridManager.CreateRemote(const MachineName: string): IESRIGridManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ESRIGridManager) as IESRIGridManager;
end;

class function CoImage.Create: IImage;
begin
  Result := CreateComObject(CLASS_Image) as IImage;
end;

class function CoImage.CreateRemote(const MachineName: string): IImage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Image) as IImage;
end;

class function CoShapefile.Create: IShapefile;
begin
  Result := CreateComObject(CLASS_Shapefile) as IShapefile;
end;

class function CoShapefile.CreateRemote(const MachineName: string): IShapefile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Shapefile) as IShapefile;
end;

class function CoShape.Create: IShape;
begin
  Result := CreateComObject(CLASS_Shape) as IShape;
end;

class function CoShape.CreateRemote(const MachineName: string): IShape;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Shape) as IShape;
end;

class function CoExtents.Create: IExtents;
begin
  Result := CreateComObject(CLASS_Extents) as IExtents;
end;

class function CoExtents.CreateRemote(const MachineName: string): IExtents;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Extents) as IExtents;
end;

class function CoPoint.Create: IPoint;
begin
  Result := CreateComObject(CLASS_Point) as IPoint;
end;

class function CoPoint.CreateRemote(const MachineName: string): IPoint;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Point) as IPoint;
end;

class function CoTable.Create: ITable;
begin
  Result := CreateComObject(CLASS_Table) as ITable;
end;

class function CoTable.CreateRemote(const MachineName: string): ITable;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Table) as ITable;
end;

class function CoField.Create: IField;
begin
  Result := CreateComObject(CLASS_Field) as IField;
end;

class function CoField.CreateRemote(const MachineName: string): IField;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Field) as IField;
end;

class function CoShapeNetwork.Create: IShapeNetwork;
begin
  Result := CreateComObject(CLASS_ShapeNetwork) as IShapeNetwork;
end;

class function CoShapeNetwork.CreateRemote(const MachineName: string): IShapeNetwork;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapeNetwork) as IShapeNetwork;
end;

class function CoUtils.Create: IUtils;
begin
  Result := CreateComObject(CLASS_Utils) as IUtils;
end;

class function CoUtils.CreateRemote(const MachineName: string): IUtils;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Utils) as IUtils;
end;

class function CoVector.Create: IVector;
begin
  Result := CreateComObject(CLASS_Vector) as IVector;
end;

class function CoVector.CreateRemote(const MachineName: string): IVector;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Vector) as IVector;
end;

class function CoGridColorScheme.Create: IGridColorScheme;
begin
  Result := CreateComObject(CLASS_GridColorScheme) as IGridColorScheme;
end;

class function CoGridColorScheme.CreateRemote(const MachineName: string): IGridColorScheme;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GridColorScheme) as IGridColorScheme;
end;

class function CoGridColorBreak.Create: IGridColorBreak;
begin
  Result := CreateComObject(CLASS_GridColorBreak) as IGridColorBreak;
end;

class function CoGridColorBreak.CreateRemote(const MachineName: string): IGridColorBreak;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GridColorBreak) as IGridColorBreak;
end;

class function CoTin.Create: ITin;
begin
  Result := CreateComObject(CLASS_Tin) as ITin;
end;

class function CoTin.CreateRemote(const MachineName: string): ITin;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Tin) as ITin;
end;

class function CoShapeDrawingOptions.Create: IShapeDrawingOptions;
begin
  Result := CreateComObject(CLASS_ShapeDrawingOptions) as IShapeDrawingOptions;
end;

class function CoShapeDrawingOptions.CreateRemote(const MachineName: string): IShapeDrawingOptions;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapeDrawingOptions) as IShapeDrawingOptions;
end;

class function CoLabels.Create: ILabels;
begin
  Result := CreateComObject(CLASS_Labels) as ILabels;
end;

class function CoLabels.CreateRemote(const MachineName: string): ILabels;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Labels) as ILabels;
end;

class function CoLabelCategory.Create: ILabelCategory;
begin
  Result := CreateComObject(CLASS_LabelCategory) as ILabelCategory;
end;

class function CoLabelCategory.CreateRemote(const MachineName: string): ILabelCategory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LabelCategory) as ILabelCategory;
end;

class function CoLabel_.Create: ILabel;
begin
  Result := CreateComObject(CLASS_Label_) as ILabel;
end;

class function CoLabel_.CreateRemote(const MachineName: string): ILabel;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Label_) as ILabel;
end;

class function CoShapefileCategories.Create: IShapefileCategories;
begin
  Result := CreateComObject(CLASS_ShapefileCategories) as IShapefileCategories;
end;

class function CoShapefileCategories.CreateRemote(const MachineName: string): IShapefileCategories;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapefileCategories) as IShapefileCategories;
end;

class function CoShapefileCategory.Create: IShapefileCategory;
begin
  Result := CreateComObject(CLASS_ShapefileCategory) as IShapefileCategory;
end;

class function CoShapefileCategory.CreateRemote(const MachineName: string): IShapefileCategory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShapefileCategory) as IShapefileCategory;
end;

class function CoCharts.Create: ICharts;
begin
  Result := CreateComObject(CLASS_Charts) as ICharts;
end;

class function CoCharts.CreateRemote(const MachineName: string): ICharts;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Charts) as ICharts;
end;

class function CoChart.Create: IChart;
begin
  Result := CreateComObject(CLASS_Chart) as IChart;
end;

class function CoChart.CreateRemote(const MachineName: string): IChart;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Chart) as IChart;
end;

class function CoColorScheme.Create: IColorScheme;
begin
  Result := CreateComObject(CLASS_ColorScheme) as IColorScheme;
end;

class function CoColorScheme.CreateRemote(const MachineName: string): IColorScheme;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ColorScheme) as IColorScheme;
end;

class function CoChartField.Create: IChartField;
begin
  Result := CreateComObject(CLASS_ChartField) as IChartField;
end;

class function CoChartField.CreateRemote(const MachineName: string): IChartField;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChartField) as IChartField;
end;

class function CoLinePattern.Create: ILinePattern;
begin
  Result := CreateComObject(CLASS_LinePattern) as ILinePattern;
end;

class function CoLinePattern.CreateRemote(const MachineName: string): ILinePattern;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LinePattern) as ILinePattern;
end;

class function CoLineSegment.Create: ILineSegment;
begin
  Result := CreateComObject(CLASS_LineSegment) as ILineSegment;
end;

class function CoLineSegment.CreateRemote(const MachineName: string): ILineSegment;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LineSegment) as ILineSegment;
end;

class function CoGeoProjection.Create: IGeoProjection;
begin
  Result := CreateComObject(CLASS_GeoProjection) as IGeoProjection;
end;

class function CoGeoProjection.CreateRemote(const MachineName: string): IGeoProjection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GeoProjection) as IGeoProjection;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TMap]);
end;

end.
