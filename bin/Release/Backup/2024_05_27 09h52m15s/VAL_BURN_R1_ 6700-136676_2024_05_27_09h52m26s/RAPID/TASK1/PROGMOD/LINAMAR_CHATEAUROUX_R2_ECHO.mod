MODULE LINAMAR_CHATEAUROUX_R2_ECHO

    !Local Speed
    LOCAL PERS speeddata v_Very_slow:=[50,50,500,50];
    LOCAL PERS speeddata V_Slow:=[150,300,500,50];
    LOCAL PERS speeddata V_Average:=[800,500,500,50];
    LOCAL PERS speeddata V_Fast:=[1500,800,500,50];
    LOCAL PERS speeddata v_Very_Fast:=[2500,1200,500,50];

    !Sawing speed
    LOCAL PERS speeddata v_Sawing_Slow:=[10,2,500,50];
    LOCAL PERS speeddata v_Sawing_Average:=[20,100,500,50];
    LOCAL PERS speeddata v_Sawing_Fast:=[25,150,500,50];

    !Milling Speed
    LOCAL PERS speeddata v_Finishing_Slow:=[20,50,500,50];
    LOCAL PERS speeddata v_Finishing_Average:=[40,70,500,50];
    LOCAL PERS speeddata v_Finishing_Fast:=[50,80,500,50];

    !===================================================================
    !               Déclaration des tools calculés
    !===================================================================

    !---------------------<<<< MOTOR 1 >>>>---------------------
    ! >>> Sawing - D300x4
    TASK PERS tooldata Tool_M1_1_Center  :=[TRUE,[[-425.792833573,283.453652734,163.973],[0.270598051,0.270597979,-0.653281512,-0.653281482]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];
    
    TASK PERS tooldata Tool_M1_2_D136_0  :=[TRUE,[[-42.347705886,-118.067952707,621.386],[0.923880074,-0.000000163,-0.000000432,-0.382682126]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];
    TASK PERS tooldata Tool_M1_2_D136_90 :=[TRUE,[[-90.430754875,-166.15142596,553.386],[0.653282024,0.653281482,-0.27059805,-0.270596744]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];
    TASK PERS tooldata Tool_M1_2_D136_180:=[TRUE,[[-42.347635176,-118.068023418,485.386],[0.000000421,0.923880074,-0.382682126,0.00000019]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];
    TASK PERS tooldata Tool_M1_2_D136_270:=[TRUE,[[5.735484524,-69.984620876,553.386],[0.653281482,-0.653282024,0.270596744,-0.27059805]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];

    !---------------------<<<< MOTOR 2 >>>>---------------------
    ! >>> Sawing - D150x4
    TASK PERS tooldata Tool_M2_Center  :=[TRUE,[[408.511709526,-267.253270691,148.881],[0.270598147,-0.270598102,0.653281461,-0.653281442]],[161.6,[-20.5,5.1,291.2],[1,0,0,0],13.421,13.365,6.098]];
    
    !PERS wobjdata Wobj_Table_LINAMAR:=[FALSE,TRUE,"Table_B",[[-165.000272934,1524.683505056,1238.032236462],[0.922601335,0.385750885,-0.000934795,-0.001468661]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata Wobj_Table_LINAMAR:=[FALSE,TRUE,"Table_B",[[-163.378185387,1426.144845939,1138.032652156],[0.922601335,0.385750885,-0.000934795,-0.001468661]],[[0,0,0],[1,0,0,0]]];
    

    
    !CONST robtarget ECHO_OP5_10:=[[213.34,45.33,8.59],[0.00934486,0.397748,-0.917194,0.0215457],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_10:=[[216.67,181.00,19.34],[0.00934781,0.397751,-0.917193,0.0215473],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_20:=[[264.07,148.35,19.66],[0.0331072,0.554307,-0.831605,-0.00901503],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_30:=[[398.519826941,151.585468618,35.304743663],[0.016616684,0.707325805,-0.706497437,0.016597057],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_40:=[[470.425243357,151.669745392,35.301183953],[0.016616679,0.707325836,-0.706497407,0.016597041],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_60:=[[558.87,167.01,31.28],[0.0197695,0.841582,-0.539618,0.0126771],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_50:=[[589.360712799,188.415734848,15.355312691],[0.02095851,0.8921451,-0.451138054,0.010598024],[0,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_70:=[[667.81,321.62,30.21],[0.0234416,0.997884,-0.0606307,0.00142441],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    !CONST robtarget ECHO_OP5_80:=[[687.974574043,474.808418512,49.068429756],[0.023486102,0.99972411,-0.000326888,0.000007111],[0,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_80:=[[678.95,474.81,49.08],[0.0234856,0.999724,-0.000317873,8.33872E-06],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_90:=[[140.86,297.41,36.80],[0.0155971,0.190017,-0.980296,-0.0516777],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_100:=[[132.57,395.16,60.72],[0.00134958,0.0572706,0.998082,-0.0234493],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP5_110:=[[153.649423872,395.085761255,57.585197172],[0.002312248,0.098441248,-0.994865679,0.023372086],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    CONST robtarget ECHO_OP6_10:=[[583.39,223.40,78.18],[0.0186294,0.0288931,0.998989,0.0289591],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_20:=[[524.54,190.23,73.97],[0.0186404,0.0288902,0.99899,0.0289354],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_30:=[[495.43,189.54,72.73],[0.0176656,0.0294823,0.999399,-0.00445109],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_40:=[[440.60,192.04,70.79],[0.0176585,0.0294907,0.999399,-0.004447],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_50:=[[412.23,192.31,69.79],[0.0176635,0.0294867,0.999399,-0.00443736],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_60:=[[364.83,191.70,76.51],[0.0176681,0.0294811,0.999399,-0.00444331],[0,-1,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_70:=[[279.93,175.11,68.47],[0.0121089,0.154106,0.987975,-0.00309124],[0,0,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_80:=[[220.23,209.94,71.52],[0.0121054,0.154107,0.987975,-0.00308518],[0,0,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_90:=[[169.87,281.77,76.55],[0.0123678,0.259806,0.96558,-0.00176378],[1,0,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP6_100:=[[167.17,332.15,75.99],[0.0124619,0.331746,0.943286,-0.000836011],[1,0,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    CONST robtarget ECHO_OP7_10:=[[661.88,351.96,86.78],[0.0319089,-0.976288,0.21372,-0.0129358],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP7_20:=[[655.85,297.42,83.44],[0.0319017,-0.976293,0.213698,-0.0129433],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP7_30:=[[126.468209124,401.171511661,85.73944031],[0.029469718,-0.997803872,0.05657945,-0.017825103],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget ECHO_OP7_40:=[[134.027456197,444.78239638,88.516660866],[0.029469747,-0.997803869,0.056579498,-0.017825103],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    CONST jointtarget P_TABLE:=  [[ 90,-30,10,0,90,-45],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    PROC GO_To_TABLE()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ P_TABLE\NoEOffs,V_Fast,z100,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    PROC ECHO_OP5()
        IF FALSE THEN
            GO_To_Table;
        ENDIF
        MoveJ RelTool(ECHO_OP5_10,0,0,-300),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_10,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_10,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_10,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_10,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_20,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_20,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_20,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_20,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_20,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_30,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_30,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_30,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_30,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_30,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_40,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_40,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_40,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_40,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_40,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_50,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_50,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_50,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_50,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_50,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_60,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_60,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_60,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_60,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_60,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_70,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_70,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_70,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_70,0,-5,10),v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_70,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_70,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_80,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_80,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_80,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_80,0,15,0),v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_80,0,15,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_80,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_90,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_90,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_90,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_90,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_90,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
STOP;
        MoveJ RelTool(ECHO_OP5_100,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_100,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP5_100,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP5_100,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_100,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        !stop;
        !MoveJ RelTool(ECHO_OP5_110,0,0,-150),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        !MoveL RelTool(ECHO_OP5_110,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        !MoveL ECHO_OP5_110,v_Sawing_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        !MoveL RelTool(ECHO_OP5_110,0,0,-80),V_Average,z0,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP5_110,0,0,-200),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP5_110,0,-300,-500),V_Fast,z50,Tool_M1_2_D136_0\WObj:=Wobj_Table_LINAMAR;
        
        
    ENDPROC
    
    PROC ECHO_OP6()
        IF FALSE THEN
            GO_To_TABLE;
        ENDIF
        
        MoveJ RelTool(ECHO_OP6_10,50,50,-500),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_10,20,20,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_10,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_20,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_20,20,20,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP6_20,50,50,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        
        !MoveJ RelTool(ECHO_OP6_30,0,100,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_30,0,50,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_30,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_40,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_40,0,50,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP6_40,0,100,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        
        !MoveJ RelTool(ECHO_OP6_50,0,100,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_50,0,50,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_50,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_60,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_60,0,50,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP6_60,0,100,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        
        !MoveJ RelTool(ECHO_OP6_70,-50,50,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_70,-20,20,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_70,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_80,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_80,-20,20,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP6_80,-50,50,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        
        !MoveJ RelTool(ECHO_OP6_90,-100,0,-50),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_90,-50,0,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_90,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP6_100,v_Finishing_Slow,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP6_100,-50,0,0),V_Average,z0,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP6_100,-100,0,-300),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP6_100,-200,-200,-500),V_Fast,z50,Tool_M1_1_Center\WObj:=Wobj_Table_LINAMAR;
        
        
    ENDPROC
    
    PROC ECHO_OP7()
        IF FALSE THEN
            GO_To_TABLE;
        ENDIF
        
        MoveJ RelTool(ECHO_OP7_10,-50,-50,-500),V_Fast,z50,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP7_10,-20,-20,0),V_Average,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP7_10,v_Finishing_Slow,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL ECHO_OP7_20,v_Finishing_Slow,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveL RelTool(ECHO_OP7_20,-20,20,0),V_Average,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP7_20,-50,50,-50),V_Fast,z50,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        MoveJ RelTool(ECHO_OP7_20,-50,50,-400),V_Fast,z50,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        
        !MoveJ RelTool(ECHO_OP7_30,50,50,-50),V_Fast,z50,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveL RelTool(ECHO_OP7_30,20,20,0),V_Average,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveL ECHO_OP7_30,v_Finishing_Slow,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveL ECHO_OP7_40,v_Finishing_Slow,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveL RelTool(ECHO_OP7_40,50,0,0),V_Average,z0,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        !MoveJ RelTool(ECHO_OP7_40,200,-200,-500),V_Fast,z50,Tool_M2_Center\WObj:=Wobj_Table_LINAMAR;
        
        
    ENDPROC

    PROC ECHO_OP_TEST()
        waittime 5;
        GO_To_TABLE;
        ECHO_OP5;
        ECHO_OP6;
        ECHO_OP7;
        GO_To_TABLE;
    ENDPROC
ENDMODULE