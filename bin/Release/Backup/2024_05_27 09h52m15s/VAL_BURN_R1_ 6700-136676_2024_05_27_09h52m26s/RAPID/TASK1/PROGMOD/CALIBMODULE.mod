MODULE CALIBMODULE

    !Données de vitesse déplacement robot
    LOCAL CONST speeddata V_Very_Slow:=[10,5,500,50];
    LOCAL CONST speeddata V_Slow:=[20,40,500,50];
    LOCAL CONST speeddata V_Average:=[700,200,500,50];
    LOCAL CONST speeddata V_Fast:=[1000,500,500,50];
    LOCAL CONST speeddata V_very_fast:=[1500,400,500,50];


    !Données pour définition pointe robot
    LOCAL CONST robtarget Tool_Pointe_P1:=[[-58.79,-1400.24,1036.90],[0.371976,-0.126053,-0.917638,0.0607052],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_Pointe_P2:=[[3.10,-1654.37,1038.58],[0.41078,0.27738,-0.866901,-0.0529335],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_Pointe_P3:=[[310.04,-1655.72,1001.38],[0.581713,0.626086,-0.519008,0.0160317],[-1,-2,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_Pointe_P4:=[[127.23,-1439.72,1105.84],[0.48428,0.520105,-0.484983,0.509662],[-1,-2,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_Pointe_PElongZ:=[[127.76,-1440.87,1205.99],[0.484252,0.520152,-0.485004,0.50962],[-1,-2,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    !Données pour définition moteur 1
    LOCAL CONST robtarget Tool_M1_Z1:=[[1475.20,610.01,1043.84],[0.0142852,0.721617,0.0124333,0.692034],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_M1_Z2:=[[1375.68,606.87,1043.24],[0.0142887,0.72162,0.0124333,0.69203],[0,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Données pour définition moteur 2
    LOCAL CONST robtarget Tool_M2_Z2:=[[1364.46,-816.07,1036.34],[0.698717,0.00366311,0.715378,-0.00380299],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_M2_Z1:=[[1564.30,-813.60,1036.54],[0.6987,0.00368173,0.715395,-0.00383371],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Données pour définition moteur 3
    LOCAL CONST robtarget Tool_M3_Z1:=[[1684.22,1216.41,1923.97],[0.506489,0.493438,0.506546,0.493356],[0,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_M3_Z2:=[[1584.37,1214.39,1923.32],[0.506488,0.493447,0.506555,0.493338],[0,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Données pour définition moteur 4
    LOCAL CONST robtarget Tool_M4_Z1:=[[1692.30,-1525.57,1929.32],[0.506435,0.493479,0.506542,0.493373],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_M4_Z2:=[[1592.46,-1529.98,1929.73],[0.506427,0.49346,0.506554,0.493389],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Données pour définition table A
    LOCAL CONST robtarget Wobj_Table_A_X1:=[[20.87,2042.78,502.87],[1.40524E-05,0.707143,0.707071,-8.60346E-05],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Wobj_Table_A_X2:=[[500.76,2034.87,501.76],[2.32439E-05,0.707127,0.707087,-3.38501E-06],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Wobj_Table_A_Y1:=[[27.61,2442.60,503.15],[5.34253E-06,0.707122,0.707092,2.61301E-06],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    !Données pour définition table B
    LOCAL CONST robtarget Wobj_Table_B_X1:=[[21.16,2041.93,502.92],[1.44017E-05,0.707144,0.70707,-8.66045E-05],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Wobj_Table_B_X2:=[[500.65,2034.21,501.63],[2.41643E-05,0.707126,0.707087,-2.62813E-06],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Wobj_Table_B_Y1:=[[27.77,2441.93,503.03],[1.32914E-05,0.707121,0.707092,-1.03943E-07],[0,-1,-2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    !Donnée pour définition outil fixe laser Fixe
    LOCAL CONST robtarget Tool_Laser_TCP:=[[1832.28,1303.46,1523.26],[0.707845,0.0123179,0.706176,-0.0109317],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Tool_Laser_ElongZ:=[[1731.83,1303.16,1523.44],[0.707834,0.0123137,0.706186,-0.0109386],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    PROC MoveABSJ0_0_0_0_0_0()
        MoveAbsJ [[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs,V_Average,fine,tool0\WObj:=wobj0;
        Stop;
    ENDPROC

      PROC Calib_Tool_Pointe()
        !Fait le 04/05/2022

        !Go to PEO
        PEO;

        !FR:-------------Apprendre le point P1--------------------
        MoveJ Offs(Tool_Pointe_P1,0,150,150),V_Average,z0,tool0\WObj:=wobj0;
        MoveL Offs(Tool_Pointe_P1,0,0,10),V_Average,z0,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Pointe_P1,V_Slow,fine,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Offs(Tool_Pointe_P1,0,0,100),V_Average,z0,tool0\WObj:=wobj0;

        !FR:-------------Apprendre le point P2--------------------
        MoveL Offs(Tool_Pointe_P2,0,0,100),V_Average,z0,tool0\WObj:=wobj0;
        MoveL Offs(Tool_Pointe_P2,0,0,10),V_Average,z0,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Pointe_P2,V_Slow,fine,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Offs(Tool_Pointe_P2,0,0,100),V_Average,z0,tool0\WObj:=wobj0;

        !FR:-------------Apprendre le point P3--------------------
        MoveL Offs(Tool_Pointe_P3,0,0,100),V_Average,z0,tool0\WObj:=wobj0;
        MoveL Offs(Tool_Pointe_P3,0,0,10),V_Average,z0,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Pointe_P3,V_Slow,fine,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Offs(Tool_Pointe_P3,0,0,100),V_Average,z0,tool0\WObj:=wobj0;

        !FR:-------------Apprendre le point P4--------------------
        MoveL Offs(Tool_Pointe_P4,0,0,100),V_Average,z0,tool0\WObj:=wobj0;
        MoveL Offs(Tool_Pointe_P4,0,0,10),V_Average,z0,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Pointe_P4,V_Slow,fine,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Offs(Tool_Pointe_P4,0,0,200),V_Average,z0,tool0\WObj:=wobj0;

        !FR:-------------Apprendre le point PElongZ--------------------
        MoveL Offs(Tool_Pointe_PElongZ,0,0,100),V_Average,z0,tool0\WObj:=wobj0;
        MoveL Offs(Tool_Pointe_PElongZ,0,0,10),V_Average,z0,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Pointe_PElongZ,V_Slow,fine,tool0\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Offs(Tool_Pointe_PElongZ,0,0,200),V_Average,z0,tool0\WObj:=wobj0;

        !FR:-------------  Calcul du Tool  --------------------
        Calib_Tool_Mobile_TCP_XZ Tool_Pointe,Tool_Pointe_P1,Tool_Pointe_P2,Tool_Pointe_P3,Tool_Pointe_P4\PelongZ:=Tool_Pointe_PElongZ;

        !Go to PEO
        PEO;

        Stop\NoRegain;

    ENDPROC
    
    
    PROC Calib_Tool_Motor_1()

        !Go to PEO
        PEO;

        !FR:-------------Apprendre le point Z1--------------------
        MoveJ RelTool(Tool_M1_Z1,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M1_Z1,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M1_Z1,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M1_Z1,0,0,-200),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------Apprendre le point Z2--------------------
        MoveJ RelTool(Tool_M1_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M1_Z2,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M1_Z2,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M1_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------  Calcul du Tool  --------------------
        Calib_Tool_Motor_Fixe Tool_M1,Tool_M1_Z1,Tool_M1_Z2,Offs(Tool_M1_Z1,0,0,-300);

        !Go to PEO
        PEO;

        Stop;

    ENDPROC

    PROC Calib_Tool_Motor_2()

        !Go to PEO
        PEO;

        !FR:-------------Apprendre le point Z1--------------------
        MoveJ RelTool(Tool_M2_Z1,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M2_Z1,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M2_Z1,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M2_Z1,0,0,-200),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------Apprendre le point Z2--------------------
        MoveJ RelTool(Tool_M2_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M2_Z2,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M2_Z2,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M2_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------  Calcul du Tool  --------------------
        Calib_Tool_Motor_Fixe Tool_M2,Tool_M2_Z1,Tool_M2_Z2,Offs(Tool_M2_Z1,0,0,-300);

        !Go to PEO
        PEO;

        Stop;

    ENDPROC

    PROC Calib_Tool_Motor_3()

        !Go to PEO
        PEO;

        !FR:-------------Apprendre le point Z1--------------------
        MoveJ RelTool(Tool_M3_Z1,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M3_Z1,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M3_Z1,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M3_Z1,0,0,-200),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------Apprendre le point Z2--------------------
        MoveJ RelTool(Tool_M3_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M3_Z2,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M2_Z2,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M3_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------  Calcul du Tool  --------------------
        Calib_Tool_Motor_Fixe Tool_M3,Tool_M3_Z1,Tool_M3_Z2,Offs(Tool_M3_Z1,0,0,-300);

        !Go to PEO
        PEO;

        Stop;

    ENDPROC

    PROC Calib_Tool_Motor_4()

        !Go to PEO
        PEO;

        !FR:-------------Apprendre le point Z1--------------------
        MoveJ RelTool(Tool_M4_Z1,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M4_Z1,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M4_Z1,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M4_Z1,0,0,-200),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------Apprendre le point Z2--------------------
        MoveJ RelTool(Tool_M4_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_M4_Z2,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_M4_Z2,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL RelTool(Tool_M4_Z2,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------  Calcul du Tool  --------------------
        Calib_Tool_Motor_Fixe Tool_M4,Tool_M4_Z1,Tool_M4_Z2,Offs(Tool_M4_Z1,0,0,-300);

        !Go to PEO
        PEO;

        Stop;

    ENDPROC
    
       PROC Calib_Table_A()
        
        !-------------Apprendre le point X1--------------------
        MoveJ RelTool(Wobj_Table_A_X1,0,0,-250),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_A_X1,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_A_X1,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_A_X1,0,0,-250),V_Average,z0,tool_pointe;

        !-------------Apprendre le point X2--------------------
        MoveJ RelTool(Wobj_Table_A_X2,0,0,-250),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_A_X2,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_A_X2,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_A_X2,0,0,-250),V_Average,z0,tool_pointe;

        !-------------Apprendre le point Y1--------------------
        MoveL RelTool(Wobj_Table_A_Y1,-50,0,-200),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_A_Y1,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_A_Y1,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_A_Y1,-50,0,-100),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_A_Y1,-100,0,-250),V_Average,z0,tool_pointe;

        !-------------  Calcule du nouveau repere  --------------------
        !-------------Calculation of the new frame--------------------
        Wobj_Table_A.uframe:=DefFrame(Wobj_Table_A_X1,Wobj_Table_A_X2,Wobj_Table_A_Y1\Origin:=3);
        Wobj_Table_A.oframe:=[[0,0,0],[1,0,0,0]];
        Wobj_Table_A.ufmec:="Table_A";

        PEO;

        Stop;

    ENDPROC

    PROC Calib_Table_B()
        
        !-------------Apprendre le point X1--------------------
        MoveJ RelTool(Wobj_Table_B_X1,0,0,-250),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_B_X1,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_B_X1,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_B_X1,0,0,-250),V_Average,z0,tool_pointe;

        !-------------Apprendre le point X2--------------------
        MoveJ RelTool(Wobj_Table_B_X2,0,0,-250),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_B_X2,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_B_X2,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_B_X2,0,0,-250),V_Average,z0,tool_pointe;

        !-------------Apprendre le point Y1--------------------
        MoveL RelTool(Wobj_Table_B_Y1,-50,0,-100),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_B_Y1,0,0,-20),V_Slow,z0,tool_pointe;
        Stop\NoRegain;
        MoveL Wobj_Table_B_Y1,V_Very_Slow,fine,tool_pointe;
        Stop\NoRegain;
        MoveL RelTool(Wobj_Table_B_Y1,-50,0,-100),V_Average,z0,tool_pointe;
        MoveL RelTool(Wobj_Table_B_Y1,-100,0,-250),V_Average,z0,tool_pointe;

        !-------------  Calcule du nouveau repere  --------------------
        !-------------Calculation of the new frame--------------------
        Wobj_Table_B.uframe:=DefFrame(Wobj_Table_B_X1,Wobj_Table_B_X2,Wobj_Table_B_Y1\Origin:=3);
        Wobj_Table_B.oframe:=[[0,0,0],[1,0,0,0]];
        Wobj_Table_B.ufmec:="Table_B";

        PEO;

        Stop;

    ENDPROC
    PROC Calib_Tool_laser_Fixe()
        
        !Go to PEO
        PEO;
        
        !FR:-------------Apprendre le point Tool_Laser_TCP--------------------
        MoveJ RelTool(Tool_Laser_TCP,0,0,-200),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_Laser_TCP,0,0,-10),V_Slow,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Laser_TCP,V_Slow,fine,Tool_Pointe\WObj:=wobj0;

        !FR:------------- Décalage d'étalonnage KM0 -----------------
        CalibOffsetLaser;
        Stop\NoRegain;

        !Degagement/Clearance
        MoveL RelTool(Tool_Laser_TCP,0,0,-250),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        Stop\NoRegain;
        
        !FR:-------------Apprendre le point Tool_Laser_ElongZ--------------------
        MoveL RelTool(Tool_Laser_ElongZ,0,0,-100),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        MoveL RelTool(Tool_Laser_ElongZ,0,0,-10),V_Average,z0,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        MoveL Tool_Laser_ElongZ,V_Slow,fine,Tool_Pointe\WObj:=wobj0;
        Stop\NoRegain;
        !Degagement/Clearance
        MoveL RelTool(Tool_Laser_ElongZ,0,0,-250),V_Average,z0,Tool_Pointe\WObj:=wobj0;

        !FR:-------------  Calcule du Tool  --------------------
        Tool_Laser.tframe:=DefFrame(Tool_Laser_TCP,Tool_Laser_ElongZ,Offs(Tool_Laser_TCP,0,0,100));
        Tool_Laser.tframe:=PoseMult(Tool_Laser.tframe,[[0,0,0],[0.7071,0,0.7071,0]]);

        !Go to PEO
        PEO;

        Stop\NoRegain;

    ENDPROC

    PROC Calib_Load_Unit_1()
        !Fait le 

        VAR num load_accuracy;
        CONST jointtarget P1:=[[0,-45,45,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        !Unit_Change 1;

        MoveAbsJ P1\NoEOffs,v200,fine,tool0\WObj:=wobj0;

        ! Load modules into the system
        Load\Dynamic,"RELEASE:/system/mockit.sys";
        Load\Dynamic,"RELEASE:/system/mockit1.sys";

        ! Do measurement and update all payload data except mass in piece5
        %"LoadId"%TOOL_LOAD_ID,MASS_WITH_AX3,Tool_Pointe\Accuracy:=load_accuracy;

        !TPWrite "Charge "+valtostr(tool_Defaut.tload);

        TPWrite " Load accuracy for Tool_Motor_Fixe_1(%) = "\num:=load_accuracy;

        ! Unload modules
        UnLoad "RELEASE:/system/mockit.sys";
        UnLoad "RELEASE:/system/mockit1.sys";

        !Mise à jour des charges équivalentes
        Tool_Pointe.tload:=Tool_Pointe.tload;
        Tool_M1.tload := Tool_Pointe.tload;
        Tool_M2.tload := Tool_Pointe.tload;
        Tool_M3.tload := Tool_Pointe.tload;
        Tool_M4.tload := Tool_Pointe.tload;
        Tool_Gripper.tload := Tool_Pointe.tload;

        Stop;

    ENDPROC

    PROC Calib_Load_Part(inout loaddata LoadPart)
        !Fait le 

        VAR num load_accuracy;
        CONST jointtarget P1:=[[0,-45,45,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        !Unit_Change 1;

        MoveAbsJ P1\NoEOffs,v200,fine,tool0\WObj:=wobj0;

        ! Load modules into the system
        Load\Dynamic,"RELEASE:/system/mockit.sys";
        Load\Dynamic,"RELEASE:/system/mockit1.sys";

        ! Do measurement and update all payload data except mass in piece5
        %"LoadId"% PAY_LOAD_ID,MASS_WITH_AX3, Tool_Gripper \PayLoad:=LoadPart \Accuracy:=load_accuracy;

        !TPWrite "Charge "+valtostr(tool_Defaut.tload);

        TPWrite " Load accuracy for Tool_Motor_Fixe_1(%) = "\num:=load_accuracy;

        ! Unload modules
        UnLoad "RELEASE:/system/mockit.sys";
        UnLoad "RELEASE:/system/mockit1.sys";

        Stop;

    ENDPROC



ENDMODULE