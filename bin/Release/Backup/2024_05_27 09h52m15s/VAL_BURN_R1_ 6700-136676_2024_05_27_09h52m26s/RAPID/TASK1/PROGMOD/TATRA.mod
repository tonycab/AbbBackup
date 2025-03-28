MODULE TATRA
    !
    !Vitesse premier essai automatique,
    !
    LOCAL CONST speeddata V_Rapide:=[2000,500,0,0];
    LOCAL CONST speeddata V_Moyen:=[1000,500,0,0];
    LOCAL CONST speeddata V_Lent:=[200,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_OP1_FRAME_2:=[20,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_OP1_FRAME_4:=[20,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_OP2_FRAME_1:=[5,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_OP2_FRAME_3:=[3,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_OP3_FRAME_5:=[5,50,0,0];
    LOCAL CONST speeddata V_Tronconnage_JET:=[5,50,0,0];


    !----------------------<<<<     LASER    >>>>----------------------
    LOCAL PERS num TOLERANCE_P1:=20;

    !============== FRAME 1
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_1:=[20,249.47,245.54,248.69,244.86,1,1,[[189.121,-301.331,651.645],[0.662838,-0.661891,0.24889,0.246173],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[-49.437,-302.691,678.042],[0.662838,-0.661882,0.248903,0.246181],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[189.113,-300.545,651.635],[0.0551085,0.00298876,-0.998476,-0.000344177]],[[189.121,-301.331,651.645],[0.0550732,0.00281975,-0.998478,-0.000334183]],"RECALAGE"];
    !============== FRAME 2
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_2:=[20,246.56,245.67,246.28,245.28,1,1,[[-197.318,-331.296,560.13],[0.67985,-0.189018,0.681476,-0.194076],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[-241.255,112.411,568.306],[0.679081,-0.189149,0.682077,-0.194532],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[-197.045,-331.326,560.126],[0.00624226,-0.67147,-0.740975,-0.00679003]],[[-197.319,-331.296,560.13],[0.00623105,-0.671341,-0.741091,-0.00677633]],"RECALAGE"];
    !============== FRAME 3
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_3:=[20,253.1,256.23,253.17,256.22,1,1,[[-181.983,300.218,656.661],[0.250273,0.232167,0.659356,-0.669859],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[60.5248,302.051,668.377],[0.250277,0.232187,0.659349,-0.669857],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[-181.99,300.282,656.638],[0.0109618,0.999639,0.00332221,0.0242867]],[[-181.983,300.218,656.661],[0.0109655,0.999641,0.00351036,0.0241746]],"RECALAGE"];
    !============== FRAME 4
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_4:=[20,249.48,242.88,249.75,243.78,1,1,[[198.682,326.932,553.668],[0.175113,-0.682478,-0.136998,0.696269],[0,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[242.813,-126.34,560.815],[0.175133,-0.682481,-0.137005,0.69626],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[198.919,326.869,553.641],[0.0177296,0.740836,-0.67143,-0.00543273]],[[198.682,326.932,553.668],[0.0176878,0.74036,-0.671956,-0.00545746]],"RECALAGE"];
    !============== FRAME 5
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_5:=[20,251,253.47,250.61,253.42,1,1,[[123.945,52.6976,755.634],[0.0320808,-0.931681,-0.361804,-0.00619214],[0,-2,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[-121.14,52.6672,755.655],[0.0320908,-0.931679,-0.361808,-0.00620131],[0,-2,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[123.957,52.7534,755.245],[0.000457695,0.0006256,-0.729467,0.684015]],[[123.945,52.6976,755.634],[1.1451E-05,-7.44335E-05,0.729474,-0.684009]],"RECALAGE"];
    !============== FRAME 6
    LOCAL PERS RECALAGEDATA2PT P1_FRAME_6:=[20,0,0,0,0,0,0,[[0,0,0],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[0,0,0],[1,0,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]],""];

    ! Measurement Target for FRAME 1
    LOCAL CONST robtarget P1_FRAME_1_X1:=[[188.97,-336.02,651.63],[0.662841,-0.661891,0.248882,0.24617],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_1_X2:=[[-49.60,-333.53,678.03],[0.66284,-0.661888,0.24889,0.246171],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Measurement Target for FRAME 2
    LOCAL CONST robtarget P1_FRAME_2_X1:=[[-229.59,-331.08,560.17],[0.679847,-0.189014,0.681483,-0.194069],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_2_X2:=[[-272.53,112.74,568.34],[0.67908,-0.189163,0.682069,-0.19455],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Measurement Target for FRAME 3
    LOCAL CONST robtarget P1_FRAME_3_X1:=[[-182.72,339.36,655.79],[0.250271,0.232181,0.659353,-0.669859],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_3_X2:=[[59.74,344.24,667.41],[0.250273,0.232184,0.659351,-0.669859],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Measurement Target for FRAME 4
    LOCAL CONST robtarget P1_FRAME_4_X1:=[[234.34,325.16,552.57],[0.175129,-0.682477,-0.13702,0.696262],[0,0,2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_4_X2:=[[272.57,-127.77,559.88],[0.175131,-0.682474,-0.137017,0.696265],[0,0,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Measurement Target for FRAME 5
    LOCAL CONST robtarget P1_FRAME_5_X1:=[[124.38,50.36,792.18],[0.0320777,-0.931681,-0.361806,-0.00618881],[0,-2,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_5_X2:=[[-120.66,50.17,795.02],[0.0320811,-0.931678,-0.361813,-0.00619178],[0,-2,3,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Measurement Target for FRAME 6
    LOCAL CONST robtarget P1_FRAME_6_X1:=[[168.84,-43.34,789.53],[0.0230584,0.703825,-0.709854,0.0143412],[0,-2,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P1_FRAME_6_X2:=[[-73.46,-38.39,792.31],[0.023062,0.703821,-0.709858,0.0143393],[0,-2,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    !Point D'approche,
    LOCAL CONST robtarget P_TATRA_APP1:=[[-204.99,-973.53,1639.67],[0.323356,-0.656119,0.628875,-0.263562],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP2:=[[-727.98,193.87,1043.54],[0.492756,-0.492755,0.507141,-0.50714],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP3:=[[749.48,-213.17,622.11],[0.708759,-0.705439,0.00287132,-0.00287817],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP4:=[[-576.48,415.27,719.46],[8.62845E-05,0.00200084,-0.70235,0.711829],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP5:=[[205.22,673.33,1004.82],[0.503407,-0.496605,-0.496517,0.503424],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP6:=[[115.31,597.39,999.03],[0.0110898,-0.0146608,0.698827,-0.715054],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP7:=[[-582.03,-638.75,563.10],[0.00425587,-0.0187547,-0.999784,-0.00790538],[-1,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP8:=[[-727.98,193.87,1043.54],[0.492756,-0.492755,0.507141,-0.50714],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP9:=[[749.48,-213.17,622.11],[0.708759,-0.705439,0.00287132,-0.00287817],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP10:=[[-576.48,415.27,719.46],[8.62845E-05,0.00200084,-0.70235,0.711829],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP11:=[[205.22,673.33,1004.82],[0.503407,-0.496605,-0.496517,0.503424],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_APP12:=[[118.43,383.53,999.20],[0.0110677,-0.0146914,0.698852,-0.71503],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    !Point De Découpe,
    LOCAL CONST robtarget P_TATRA_Decoupe1:=[[-267.14,180.56,536.16],[5.28561E-06,0.999897,-0.014384,-1.27876E-05],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe2:=[[-265.89,-167.65,542.92],[0.000448844,0.999994,0.003503,1.94731E-05],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe3:=[[117.45,-303.82,632.15],[0.496794,-0.503214,-0.496663,0.503287],[-1,0,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe4:=[[-63.40,-308.17,722.16],[0.497242,0.502362,0.496088,0.504262],[-1,-1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe5:=[[75.21,309.88,717.72],[0.503355,0.496678,-0.503329,-0.496593],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe6:=[[-76.66,303.39,713.64],[0.496678,-0.503355,0.49657,-0.503353],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe7:=[[269.60,173.17,552.31],[0.00682815,-1.12802E-05,-0.999977,2.77613E-05],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe8:=[[269.97,-125.64,550.56],[0.0148652,-1.81931E-05,-0.999889,1.37679E-05],[-1,-1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe9:=[[70.39,-268.97,756.09],[0.65694,-0.251144,0.642391,0.304451],[-1,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe10:=[[-100.17,-111.02,756.15],[0.704972,-0.00778087,0.709147,0.00801029],[-1,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe11:=[[72.38,-109.68,787.00],[0.704966,-0.00776367,0.709153,0.00802718],[-1,1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe12:=[[-92.15,181.14,765.26],[0.512031,0.485528,0.475038,-0.525761],[-1,1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Decoupe13:=[[112.38,87.55,752.73],[0.0102038,-0.715829,0.00859195,0.698148],[-1,1,1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


    !Point De Découpe jet,
    LOCAL CONST robtarget P_TATRA_Jet1:=[[-98.42,-351.15,623.50],[0.70701,-0.707097,0.0068393,-0.0102122],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Jet2:=[[88.67,-343.42,623.54],[0.707039,-0.707068,0.00685749,-0.0101797],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Jet3:=[[-271.11,180.69,548.58],[7.23929E-06,0.999897,-0.0143819,-5.08969E-06],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget P_TATRA_Jet4:=[[-267.40,-105.72,600.75],[0.38262,-0.923824,0.0102586,-0.00676491],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


    !---------------------<<<<       WOBJ      >>>>---------------------
    !Repère pièce Théorique
    !Theorical frame of the part
    PERS wobjdata P1_PART:=[TRUE,TRUE,"P1",[[0,0,0],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    !Point de prise et de dépose
    LOCAL CONST robtarget P_PRISE_DEPOSE_TATRA:=[[283.64,1623.31,1941.29],[0.00129443,-0.717607,0.696447,0.000503432],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];



    PROC TATRA_PRISE_PIECE()

        !Robot au PEO
        GO_To_PEO;

        !Approche
        MoveJ RelTool(P_PRISE_DEPOSE_TATRA,700,0,-200),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-200),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-100),V_MOYEN,z0,Tool_Prehenseur_1\WObj:=wobj0;

        !Point de prise
        MoveL P_PRISE_DEPOSE_TATRA,V_LENT,fine,Tool_Prehenseur_1\WObj:=wobj0;
        waitrob\InPos;

        !Fermeture pince
        Gripper_Close\Time:=2;

        !Dégagement
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-100),V_MOYEN,z0,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-300),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,400,0,-300\Rx:=0\Ry:=-30\Rz:=0),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,700,0,-300\Rx:=0\Ry:=-30\Rz:=0),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;

        !Robot au PEO
        GO_To_PEO;

    ENDPROC

    PROC TATRA_MESURE_LASER()


        !Robot au PEO
        GO_To_PEO;

        ! EN: Tolerance de mesure pour les pieces
        ! EN: Measurement Tolerance for the part
        TOLERANCE_P1:=20;
        P1_FRAME_1.Tolerance:=TOLERANCE_P1;
        P1_FRAME_2.Tolerance:=TOLERANCE_P1;
        P1_FRAME_3.Tolerance:=TOLERANCE_P1;
        P1_FRAME_4.Tolerance:=TOLERANCE_P1;
        P1_FRAME_5.Tolerance:=TOLERANCE_P1;
        P1_FRAME_6.Tolerance:=TOLERANCE_P1;

        ! FR: Initialisation du repere piece
        ! EN: Initialisation of part frame
        Wobj_Part_0:=InitWobjPart("P1"\wobjRef:=P1_PART);

        !Gripper Measurement
        MoveJ RelTool(P1_FRAME_1_X1,0,0,-500),V_Fast,z200,Tool_Laser\WObj:=Wobj_Part_0;
        MoveL RelTool(P1_FRAME_1_X1,0,0,-100),V_Fast,z200,Tool_Laser\WObj:=Wobj_Part_0;
        ! Measurement position Frame 1 [X1]
        MoveL P1_FRAME_1_X1,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_1\X1;

        ! Measurement position Frame 1 [X2]
        MoveL P1_FRAME_1_X2,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_1\X2;

        ! Measurement position Frame 2 [X1]
        MoveL P1_FRAME_2_X1,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_2\X1;

        ! Measurement position Frame 2 [X2]
        MoveL P1_FRAME_2_X2,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_2\X2;

        ! Measurement position Frame 3 [X1]
        MoveL P1_FRAME_3_X1,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_3\X1;

        ! Measurement position Frame 3 [X2]
        MoveL P1_FRAME_3_X2,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_3\X2;

        ! Measurement position Frame 4 [X1]
        MoveL P1_FRAME_4_X1,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_4\X1;

        ! Measurement position Frame 4 [X2]
        MoveL P1_FRAME_4_X2,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_4\X2;
        MoveL RelTool(P1_FRAME_4_X2,0,0,-200),V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;

        ! Measurement position Frame 5 [X1]
        MoveL RelTool(P1_FRAME_5_X1,0,0,-200),V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        MoveL P1_FRAME_5_X1,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_5\X1;

        ! Measurement position Frame 3 [X2]
        MoveL P1_FRAME_5_X2,V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;
        !Calcul
        Measure2Pts P1_FRAME_5\X2;
        MoveL RelTool(P1_FRAME_5_X2,0,-200,-200),V_Fast,fine,Tool_Laser\WObj:=Wobj_Part_0;

        !--------------------------------------------------------------------------------------------
        !Calcul des frames
        Wobj_Part_1:=GetResultMeasure2pts(P1_FRAME_1,Wobj_Part_0);
        Wobj_Part_2:=GetResultMeasure2pts(P1_FRAME_2,Wobj_Part_0);
        Wobj_Part_3:=GetResultMeasure2pts(P1_FRAME_3,Wobj_Part_0);
        Wobj_Part_4:=GetResultMeasure2pts(P1_FRAME_4,Wobj_Part_0);
        Wobj_Part_5:=GetResultMeasure2pts(P1_FRAME_5,Wobj_Part_0);

        !--------------------------------------------------------------------------------------------

        ! FR: Aller au PEO
        ! EN: Go To PEO
        GO_To_PEO;

    ENDPROC

    PROC TATRA_TRONCONNAGE_PIECE()

        !Robot au PEO
        GO_To_PEO;
        !
        !Approche OP1 Frame 2,
        !
        MoveJ P_TATRA_APP1,V_Fast,z100,Tool_M2\WObj:=Wobj_Part_0;
        MoveJ P_TATRA_APP2,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        !
        !Découpe OP1 Frame 2
        !
        MoveL RelTool(P_TATRA_Decoupe1,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe1,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL P_TATRA_Decoupe1,V_Tronconnage_OP1_FRAME_2,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe1,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe1,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe2,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe2,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL P_TATRA_Decoupe2,V_Tronconnage_OP1_FRAME_2,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe2,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe2,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        MoveL RelTool(P_TATRA_Decoupe2,0,500,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_2;
        !
        !Séparation Du Jet,
        !
        MoveL RelTool(P_TATRA_Jet1,0,-250,-150),V_LENT,z20,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Jet1,0,0,-150),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL P_TATRA_Jet1,V_Tronconnage_JET,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Jet1,0,0,-150),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Jet2,0,0,-160),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL P_TATRA_Jet2,V_Tronconnage_JET,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Jet2,0,0,-160),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Jet2,-500,0,-160),V_Fast,z100,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        !
        !Fin Séparation Jet,
        !
        !Approche OP2 Frame 1,
        !
        MoveJ P_TATRA_APP3,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        !
        !Découpe OP2 Frame 1,
        !
        MoveL RelTool(P_TATRA_Decoupe3,0,0,-250),V_Fast,z15,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe3,0,0,-100),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL P_TATRA_Decoupe3,V_Tronconnage_OP2_FRAME_1,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe3,0,0,-100),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe3,0,0,-160),V_Fast,z15,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe3,-300,0,-160),V_Fast,z15,Tool_M2_D500_S180\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe4,-300,0,-220),V_Fast,z15,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe4,0,0,-220),V_Fast,z15,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe4,0,0,-100),V_LENT,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        MoveL P_TATRA_Decoupe4,V_Tronconnage_OP2_FRAME_1,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe4,0,0,-100),V_LENT,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        MoveL RelTool(P_TATRA_Decoupe4,-300,0,-100),V_Moyen,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_1;
        !
        !Fin De Decoupe OP2 Frame 1,
        !
        !
        !Approche OP2 Frame 3,
        !
        MoveJ P_TATRA_APP4,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        !
        !
        !Découpe OP2 Frame 3,
        !
        MoveL RelTool(P_TATRA_Decoupe5,-300,0,-220),V_Fast,z15,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe5,0,0,-220),V_Fast,z15,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe5,0,0,-100),V_LENT,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL P_TATRA_Decoupe5,V_Tronconnage_OP2_FRAME_3,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe5,0,0,-100),V_LENT,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe5,-300,0,-100),V_LENT,z0,Tool_M2_D500_S0\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe6,-300,0,-220),V_Fast,z15,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe6,0,0,-220),V_Fast,z15,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe6,0,0,-100),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        MoveL P_TATRA_Decoupe6,V_Tronconnage_OP2_FRAME_3,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe6,0,0,-100),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        MoveL RelTool(P_TATRA_Decoupe6,-300,0,-100),V_LENT,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_3;
        !
        !Fin De Decoupe OP2 Frame 3,
        !
        !
        !Approche OP1 Frame 4,
        !
        MoveJ P_TATRA_APP5,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        !
        !Découpe OP1 Frame 4,
        !
        MoveL RelTool(P_TATRA_Decoupe7,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe7,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL P_TATRA_Decoupe7,V_Tronconnage_OP1_FRAME_4,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe7,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe7,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe8,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe8,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL P_TATRA_Decoupe8,V_Tronconnage_OP1_FRAME_4,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe8,0,0,-60),V_LENT,z0,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe8,0,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        MoveL RelTool(P_TATRA_Decoupe8,-300,0,-200),V_Fast,z20,Tool_M2_D500_S90\WObj:=Wobj_Part_4;
        !
        !Fin De Decoupe OP1 Frame 4,
        !
        !Approche OP3 Frame 5,
        !
        MoveJ P_TATRA_APP6,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        MoveJ P_TATRA_APP7,V_Fast,z50,Tool_M2\WObj:=Wobj_Part_0;
        !
        !
        !Découpe OP3 Frame 5,
        !
        !
        MoveL RelTool(P_TATRA_Decoupe9,0,0,-200),V_Fast,z20,Tool_M2_D500_S135\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe9,0,0,-100),V_LENT,z0,Tool_M2_D500_S135\WObj:=Wobj_Part_5;
        MoveL P_TATRA_Decoupe9,V_Tronconnage_OP3_FRAME_5,z0,Tool_M2_D500_S135\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe9,0,0,-200),V_Fast,z20,Tool_M2_D500_S135\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe10,0,0,-200),V_Fast,z20,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe10,0,0,-120),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL P_TATRA_Decoupe10,V_Tronconnage_OP3_FRAME_5,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe10,0,0,-120),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe10,-50,0,-150),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe11,0,0,-100),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL P_TATRA_Decoupe11,V_Tronconnage_OP3_FRAME_5,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe11,0,0,-100),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe11,0,0,-400),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveJ RelTool(P_TATRA_Decoupe12,0,0,-200),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe12,0,0,-100),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL P_TATRA_Decoupe12,V_Tronconnage_OP3_FRAME_5,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe12,0,0,-200),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveJ RelTool(P_TATRA_Decoupe13,0,0,-200),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe13,0,0,-100),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL P_TATRA_Decoupe13,V_Tronconnage_OP3_FRAME_5,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe13,0,0,-100),V_Lent,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe13,0,0,-250),V_Fast,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        MoveL RelTool(P_TATRA_Decoupe13,0,-200,-250),V_Fast,z0,Tool_M2_D500_S180\WObj:=Wobj_Part_5;
        !Robot au PEO
        GO_To_PEO;

    ENDPROC

    PROC TATRA_DEPOSE_PIECE()

        !Robot au PEO
        GO_To_PEO;

        !Approche
        MoveJ RelTool(P_PRISE_DEPOSE_TATRA,700,0,-300\Rx:=0\Ry:=-30\Rz:=0),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,400,0,-300\Rx:=0\Ry:=-30\Rz:=0),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-300),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-100),V_MOYEN,z0,Tool_Prehenseur_1\WObj:=wobj0;

        !Point de dépose
        MoveL P_PRISE_DEPOSE_TATRA,V_LENT,fine,Tool_Prehenseur_1\WObj:=wobj0;
        waitrob\InPos;

        !Ouverture pince
        Gripper_Open\Time:=2;

        !Dégagement
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-100),V_MOYEN,z0,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,0,0,-200),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;
        MoveL RelTool(P_PRISE_DEPOSE_TATRA,700,0,-200),V_RAPIDE,z50,Tool_Prehenseur_1\WObj:=wobj0;

        !Robot au PEO
        GO_To_PEO;

        Zone_table\OutSide;
        Zone_satellite\OutSide;

    ENDPROC

    PROC CYCLE_TATRA()
        TATRA_PRISE_PIECE;
        TATRA_MESURE_LASER;
        TATRA_TRONCONNAGE_PIECE;
        TATRA_DEPOSE_PIECE;
    ENDPROC
ENDMODULE