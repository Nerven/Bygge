@echo off
setlocal

if not defined NERVENMSBUILDCMD (for /D %%D in ("%ProgramFiles(x86)%\MSBuild\14.0\Bin\") do set NERVENMSBUILDCMD=%%~dpD\MSBuild.exe)
if not defined NERVENMSBUILDCMD (set NERVENMSBUILDCMD=MSBuild.exe)
echo Using MSBuild executable: %NERVENMSBUILDCMD%

::
:: Logic somewhat explained:
::
:: 1) If NERVENSOLUTIONFILE is defined, verify that file exists, fail if not.
::    Skip to X).
:: 2) Else if NERVENSOLUTIONDIR is defined, try to find a .sln file in
::    NERVENSOLUTIONDIR. If found, skip to X), fail otherwise.
:: 3) Else, look in current directory for a .sln file. If found, skip to X),
::    otherwise repeat 3) with directory above, unless the root directory is
::    reached, then fail.
:: X)
::    Calculate and set NERVENSOLUTIONDIR from NERVENSOLUTIONFILE.
::    Remove path info from NERVENSOLUTIONFILE.
::    Execute MSBuild command.
::    Done.
::

set dir=%NERVENSOLUTIONDIR%
if not defined dir (set dir=.\)
call :fix_dir %dir%
:try_find_solution_file
if not defined NERVENSOLUTIONFILE (for %%F in (%dir%*.sln) do set NERVENSOLUTIONFILE=%%~dpnxF)
if not defined NERVENSOLUTIONFILE (
  if defined NERVENSOLUTIONDIR (echo No solution file matching %NERVENSOLUTIONDIR%*.sln & echo Aborted. & goto :eof)
  call :fix_dir %dir%..\
  if not defined dir (echo No solution file matching %NERVENSOLUTIONDIR%*.sln & echo Aborted. & goto :eof)
  goto :try_find_solution_file
)
if not exist %NERVENSOLUTIONFILE% (echo Solution file %NERVENSOLUTIONFILE% not found. & echo Aborted. & goto :eof)
call :set_dir_from_file %NERVENSOLUTIONFILE%
call :set_file %NERVENSOLUTIONFILE%

echo Using solution dir: %NERVENSOLUTIONDIR%
echo Using solution file: %NERVENSOLUTIONFILE%

"%NERVENMSBUILDCMD%" bygge.proj /target:Reset

goto :eof

:fix_dir
setlocal
set newdir=%~dp1
if [%newdir%]==[%dir%] (set newdir=)
rem if defined newdir (echo Trying %newdir%) else (echo Giving up)
endlocal & set dir=%newdir%
goto :eof

:set_dir_from_file
set NERVENSOLUTIONDIR=%~dp1
goto :eof

:set_file
set NERVENSOLUTIONFILE=%~nx1
goto :eof
