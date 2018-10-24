::Author: Sandbird
@echo off
echo JOINING MISSION SERVER .....
timeout 1

::===============================================================================================================================================
::Configuration| Edit these to the proper file paths ==============================================================================================================================================
::---> ===============================================================================================================================================
:: YOUR Arma 2 Operation Arrowhead Directory
set arma2oapath=C:\Program Files (x86)\Steam\steamapps\common\Arma 2 Operation Arrowhead
:: YOUR Arma 2 Directory
set arma2path=C:\Program Files (x86)\Steam\steamapps\common\Arma 2
:: YOUR @extDB and @DayZ_Epoch Map location
set MODS=@extDB;C:\Users\blahblah\Documents\mods\@DayZ_Epoch;
::---> ===============================================================================================================================================


::===============================================================================================================================================
:: DO NOT EDIT ANYTHING BELLOW THIS LINE OR YOU WILL BREAK THIS FILE ==============================================================================================================================================
::===============================================================================================================================================

start ""  "%arma2oapath%\ArmA2OA_BE.exe" 0 0 -nosplash -skipintro -noPause -world=empty -mod=%MODS% "-mod=%_ARMA2PATH%;EXPANSION;ca"

::Wait 7 seconds then disable Battleye, so extDB can work
timeout 7
sc config "BEService" start= disabled
sc stop "BEService"

@exit

