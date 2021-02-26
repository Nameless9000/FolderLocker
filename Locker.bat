@ECHO OFF

:INIT
    SETLOCAL EnableDelayedExpansion
    SET "FOLDER="
    TITLE Folder Control Panel
    CLS
GOTO START

:START
    :OPTIONS

        CLS
        ECHO #=========#
        ECHO  [Options]:
        ECHO  1.   Lock
        ECHO  2. Unlock
        ECHO  3.   Exit
        ECHO #=========#

        ECHO.

        SET/P "opt=$ "

        ECHO.

        IF %opt%==1 GOTO LOCK
        IF %opt%==2 GOTO UNLOCK
        IF %opt%==3 GOTO END

        ECHO Invalid Option.
        PAUSE

    GOTO OPTIONS

    :LOCK
        SET/P "file=Folder Name: "
        SET FOLDER=%file%

        IF NOT EXIST %FOLDER% GOTO MDFolder

        SET "string=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        SET "result="

        FOR /L %%i IN (1,1,4) DO CALL :ADD
        SET result=%result%2021-
        FOR /L %%i IN (1,1,4) DO CALL :ADD
        SET result=%result%-
        FOR /L %%i IN (1,1,4) DO CALL :ADD
        SET result=%result%-
        FOR /L %%i IN (1,1,4) DO CALL :ADD
        SET result=%result%-
        FOR /L %%i IN (1,1,12) DO CALL :ADD

        REN %FOLDER% "Locked.{%result%}"
        ATTRIB +h +s "Locked.{%result%}"
            
        :SAVEKEY
            CLS
            ECHO Save Key: %result%
            ECHO.
            ECHO Have You Saved The Key?
            SET/P "chou=(Y): "
            IF %chou%==y GOTO END
            IF %chou%==Y GOTO END
        GOTO SAVEKEY

        :ADD
            SET /a x=%random% %% 36
            SET result=%result%!string:~%x%,1!
        GOTO END
    GOTO END

    :UNLOCK
        ECHO Enter Key
        SET/P "key=: "
        IF NOT EXIST "Locked.{%key%}" GOTO FAIL

        ECHO.

        SET/P "file=New Folder Name: "
        SET FOLDER=%file%

        ATTRIB -h -s Locked.{%key%}
        REN Locked.{%key%} %FOLDER%

        ECHO.

        ECHO Folder Unlocked!

        SET/P ""

    GOTO END

    :FAIL
        ECHO Invalid Key!
    GOTO UNLOCK

    :MDFolder
        MD %FOLDER%
    GOTO LOCK

GOTO END

:END
