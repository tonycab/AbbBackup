MODULE MAINMODULE

    PERS num model:=5;
    PERS num program:=5;

    !******************************************************************************************************************
    !    FUNC tooldata ToolOffset(tooldata T\switch X\switch Y\switch Z,\num Xvalue,\num Yvalue,\num ZValue)
    !        VAR tooldata tool;
    !        VAR pose p:=[[0,0,0],[1,0,0,0]];
    !        VAR num decalage;
    !        VAR num decalageX:=0;
    !        VAR num decalageY:=0;
    !        VAR num decalageZ:=0;
    !        tool:=T;

    !        IF Present(Xvalue) decalageX:=Xvalue;
    !        IF Present(Yvalue) decalageX:=Yvalue;
    !        IF Present(ZValue) decalageX:=ZValue;

    !        IF Present(X) THEN
    !            !Decalage en Z
    !            IF OpMode()=OP_MAN_PROG THEN
    !                decalage:=UINumEntry(\Message:="Decalage en X de l'outil");
    !            ELSE
    !                decalage:=decalageX;
    !            ENDIF

    !            p.trans.X:=decalage;
    !        ENDIF

    !        IF Present(Y) THEN
    !            !Decalage en Z

    !            IF OpMode()=OP_MAN_PROG THEN
    !                decalage:=UINumEntry(\Message:="Decalage en Y de l'outil");
    !            ELSE
    !                decalage:=decalageY;
    !            ENDIF

    !            p.trans.Y:=decalage;
    !        ENDIF

    !        IF Present(Z) OR (Present(X) AND Present(Y) AND Present(Z))=FALSE THEN

    !            !Decalage en Z
    !            IF OpMode()=OP_MAN_PROG THEN
    !                decalage:=UINumEntry(\Message:="Decalage en Z de l'outil");
    !            ELSE
    !                decalage:=decalageZ;
    !            ENDIF

    !            p.trans.z:=decalage;
    !        ENDIF

    !        tool.tframe:=PoseMult(tool.tframe,p);


    !        RETURN tool;

    !    ENDFUNC

    !    !******************************************************************************************************************
    !    PROC RoutineTestCom()

    !        TPWrite "Routine en cours"+ValToStr(model)+"-"+ValToStr(program);
    !        WaitTime 5;
    !        TPWrite "Routine en terminée";

    !    ENDPROC

    !******************************************************************************************************************
    PROC main()
        CYCLE_TATRA;
        GO_To_PEO;
        stop;
    ENDPROC

    !******************************************************************************************************************
    PROC Init_process()

        Zone_table\OutSide;
        Zone_satellite\OutSide;
        
        !Init des outils
        InitDeftool;

    ENDPROC

    !***************************************************************************************************
    PROC PEO()
        TPErase;
        TPWrite "Go to position PEO";

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;

        MoveAbsJ P_PEO\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

        Init_process;
        TPWrite "Robot at position PEO";
        TPWrite "Init Process";

    ENDPROC

    !***************************************************************************************************
    PROC REPLI()
        TPErase;
        TPWrite "Go to position REPLI";

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ P_REPLI\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

        Init_process;
        TPWrite "Robot at position REPLI";
        TPWrite "Init Process";

    ENDPROC

    !***************************************************************************************************
    PROC GO_To_PEO()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ P_PEO\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    !***************************************************************************************************
    PROC GO_To_REPLI()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ P_REPLI\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    !******************************************************************************************************************
    PROC Zones()

        !procedure call on "power on" event
        !Repli
        WZHomeJointDef\Inside,zone_REPLI,P_REPLI,DeltaWz;
        WZDOSet\Stat,wz_REPLI\Inside,zone_REPLI,DO_REPLI,1;

        !PEO
        WZHomeJointDef\Inside,zone_PEO,P_PEO,DeltaWz;
        WZDOSet\Stat,wz_PEO\Inside,zone_PEO,DO_PEO,1;

    ENDPROC




    PROC GO_To_TRONCONNAGE_PLAN()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[0,-40,40,0,90,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    PROC GO_To_TRONCONNAGE_DESSOUS()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[-10,-58,69,0,-14,58],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;
        !

    ENDPROC

    PROC GO_To_TRONCONNAGE_DESSUS()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[-10,-58,69,0,-14,58],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC


    PROC GO_To_MEULAGE_PLAN()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[0,-40,40,0,90,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    PROC GO_To_MEULAGE_DESSOUS()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[0,-40,40,0,90,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC

    PROC GO_To_MEULAGE_DESSUS()

        GetSysData ToolCurrent;
        GetSysData WobjCurrent;
        MoveAbsJ [[0,-40,40,0,90,0],[9E9,9E9,9E9,9E9,9E9,9E9]]\NoEOffs,V_Fast,fine,ToolCurrent\WObj:=WobjCurrent;

    ENDPROC
ENDMODULE