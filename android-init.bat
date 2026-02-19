@echo off
setlocal EnableDelayedExpansion

REM Pega o pacote como primeiro argumento
set PACKAGE=%1

if "%PACKAGE%"=="" (
    echo Erro: Informe o pacote ^(ex: com.exemplo.app^)
    exit /b 1
)

REM Extrai APPNAME (segunda parte do pacote)
for /f "tokens=1,2 delims=." %%a in ("%PACKAGE%") do (
    set PART1=%%a
    set PART2=%%b
)

set APPNAME=%PART2%

if "%APPNAME%"=="" (
    set APPNAME=%PART1%
)

echo Iniciando projeto: %APPNAME%
echo Package: %PACKAGE%

if exist "%APPNAME%" (
    echo.
    echo Diretorio ja existe
    exit /b 1
)

REM Converte pacote em caminho
set "PKG_PATH=%PACKAGE%"
set "PKG_PATH=%PACKAGE:.=\%"
set "PKG_PATH=!PKG_PATH!"

REM Criando diretórios
mkdir "%APPNAME%\src\%PKG_PATH%\core"
mkdir "%APPNAME%\src\%PKG_PATH%\android"
mkdir "%APPNAME%\res\drawable"
mkdir "%APPNAME%\res\layout"
mkdir "%APPNAME%\res\values"
mkdir "%APPNAME%\res\mipmap-xxxhdpi"
mkdir "%APPNAME%\assets"
mkdir "%APPNAME%\libs"

REM AndroidManifest.xml
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<manifest xmlns:android="http://schemas.android.com/apk/res/android"
echo     package="%PACKAGE%"
echo     android:versionCode="1"
echo     android:versionName="1.0"^>
echo     ^<uses-sdk
echo         android:minSdkVersion="31"
echo         android:targetSdkVersion="31"/^>
echo     ^<!-- para adiciona icon no apk do app vai na pasta res/mipmap-xxxhdpi/ e adicione
echo      o icon como o tamanho minimo 96x96 para cima e adiciona a dentro da tag 
echo      ^<application^ android:icon="@mipmap/image"^>...^</application^> --^>
echo     ^<application
echo         android:label="@string/app_name"
echo         android:debuggable="true"
echo         android:allowBackup="true"
echo         android:theme="@android:style/Theme.Material.Light.NoActionBar"^>
echo         ^<activity android:name=".android.MainActivity"
echo                  android:exported="true"^>
echo             ^<intent-filter^>
echo                 ^<action android:name="android.intent.action.MAIN"/^>
echo                 ^<category android:name="android.intent.category.LAUNCHER"/^>
echo             ^</intent-filter^>
echo         ^</activity^>
echo     ^</application^>
echo ^</manifest^>
) > "%APPNAME%\AndroidManifest.xml"

REM AppCore.java
(
echo package %PACKAGE%.core;
echo.
echo public class AppCore  ^{
echo     private int counter = 0;
echo.
echo     public String click^(^) ^{
echo         counter++;
echo         return "Cliques: " + counter;
echo     ^}
echo ^}
) > "%APPNAME%\src\%PKG_PATH%\core\AppCore.java"

REM MainActivity.java
(
echo package %PACKAGE%.android;
echo.
echo import %PACKAGE%.R;
echo import android.app.Activity;
echo import android.os.Bundle;
echo import android.view.View;
echo import android.widget.Button;
echo import android.widget.TextView;
echo.
echo import %PACKAGE%.core.AppCore;
echo.
echo public class MainActivity extends Activity  ^{
echo     private AppCore core = new AppCore^(^);
echo.
echo     @Override
echo     protected void onCreate^(Bundle b^) ^{
echo         super.onCreate^(b^);
echo         setContentView^(R.layout.activity_main^);
echo         Button btn = findViewById^(R.id.button_click^);
echo         TextView txt = findViewById^(R.id.text_counter^);
echo         btn.setOnClickListener(new View.OnClickListener^(^) ^{
echo             @Override
echo             public void onClick^(View v^) ^{
echo                 txt.setText^(core.click^(^)^);
echo             ^}
echo         ^}^);
echo     ^}
echo ^}
) > "%APPNAME%\src\%PKG_PATH%\android\MainActivity.java"

REM strings.xml
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<resources^>
echo     ^<string name="app_name"%^>%APPNAME%^</string^>
echo ^</resources^>
) > "%APPNAME%\res\values\strings.xml"

REM colors.xml
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<resources^>
echo     ^<color name="black"^>#FF000000^</color^>
echo     ^<color name="white"^>#FFFFFFFF^</color^>
echo ^</resources^>
) > "%APPNAME%\res\values\colors.xml"

REM styles.xml
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<resources^>
echo     ^<style name="button"^>
echo         ^<item name="android:layout_width"^>match_parent^</item^>
echo         ^<item name="android:layout_height"^>100dp^</item^>
echo         ^<item name="android:textColor"^>@color/black^</item^>
echo         ^<item name="android:gravity"^>center^</item^>
echo         ^<item name="android:textSize"^>20sp^</item^>
echo     ^</style^>
echo ^</resources^>
) > "%APPNAME%\res\values\styles.xml"

REM activity_main.xml
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
echo     xmlns:tools="http://schemas.android.com/tools"
echo     android:layout_width="match_parent"
echo     android:layout_height="match_parent"
echo     android:orientation="vertical"
echo     android:background="@color/white"
echo     android:gravity="center"
echo     tools:context=".android.MainActivity"^>
echo     ^<Button
echo         android:id="@+id/button_click"
echo         style="@style/button"
echo         android:text="Clique em mim" /^>
echo     ^<TextView
echo         android:id="@+id/text_counter"
echo         style="@style/button"
echo         android:text="Cliques: 0" /^>
echo ^</LinearLayout^>
) > "%APPNAME%\res\layout\activity_main.xml"

echo Projeto %APPNAME% criado com core multiplataforma
endlocal
