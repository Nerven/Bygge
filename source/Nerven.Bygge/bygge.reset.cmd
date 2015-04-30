@echo off
setlocal

if not defined NERVENMSBUILDCMD (for /D %%D in ("%ProgramFiles(x86)%\MSBuild\14.0\Bin\") do set NERVENMSBUILDCMD=%%~dpD\MSBuild.exe)
if not defined NERVENMSBUILDCMD (set NERVENMSBUILDCMD=MSBuild.exe)
echo Using MSBuild executable: %NERVENMSBUILDCMD%

if not defined NERVENSOLUTIONDIR (for /D %%D in (..\..\..\) do set NERVENSOLUTIONDIR=%%~dpD)
echo Using solution dir: %NERVENSOLUTIONDIR%

if not defined NERVENSOLUTIONFILE (for %%F in (%NERVENSOLUTIONDIR%*.sln) do set NERVENSOLUTIONFILE=%%~nxF)
echo Using solution file: %NERVENSOLUTIONFILE%

"%NERVENMSBUILDCMD%" bygge.proj /target:Reset
