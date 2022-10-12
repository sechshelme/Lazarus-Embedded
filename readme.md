# Lazarus Embedded GUI 
## GERMAN:

Mit dieser GUI für Lazarus hat man den Vorteil, das man sehr einfach Projekte für Embedded Systeme entwickeln kann.
Der Vorteil der Package, es werden einem fast alle Einstellung für Compiler und Programmer abgenommen.
Ein Serial Monitor, ähnlich wie bei der Arduino-IDE ist auch eingebaut.

### Stand der Entwicklung 21.09.2022
Die AVRs werden schon sehr gut unterstützt, vor allem die gewöhnlichen Arduinos.
Für den Arduino UNO hat es schon recht viele Beispiele.
Es werden immer mehr, auch für nicht Arduino.
STM-32, Arduino DUO, ESPxxx und Rasberry Pico gehen auch, nur fehlen (noch) die Beispiele.

### Download:
[Lazarus Embedded GUI](https://github.com/sechshelme/Lazarus-Embedded)

### Installation:
Bei Lazarus bei "Package/Package Datei (.lpi) offnen .../"
Anschliessend diese Datei öffnen, kompilieren und installieren. `./Lazarus_Embedded_GUI_Package/embedded_gui_package.lpk`

### Beispiel für einen Arduino:
Über "`Datei` --> `Neu...` --> `Project` --> `[Embedded] Embedded-Project` --> `Vorlagen`... --> `Arduino UNO` --> `Blink Pin 13` --> `Ok` --> `Ok`"
kann dann ein Arduino UNO Project erstellt werden.
Wen man zu Laufzeit noch was ändern will, kann man über "Project --> [Embedded] Optionen" die Werte editieren.

### Schlusswort:
Die Package wird unter Linux entwickelt, daher kann es unter Windows noch Fehler haben.
Voraussetzung ist ein funktionstüchtige Embedded-Cross-Compiler.
Für Feedbacks bin ich immer dankbar, egal, ob sie direkt ins Forum [Lazarus Forum Englisch](https://forum.lazarus.freepascal.org/index.php?topic=60667.msg454548#msg454548) oder bei den Issus gepostet werden ;)

### Was kann das Tool und was ist noch geplant:

#### In Package:
- [x] Unterstüzung von mehreren Mikrokontroller
  - [x] Neues Projekt
  - [x] Projekt Parameter modifizieren
  - [x] Beispiel Projekte
  - [x] AVR
  - [x] ARM
    - [x] STM32
    - [x] SAM3x7E Arduino Due 
    - [ ] Noch andere ARMs
  - [x] ESPxxx
    - [x] ESP32
    - [x] ESP8266
  - [ ] PIC
- [ ] User definierte Parameter
- [x] CPU Info
- [x] Serial Monitor
- [ ] Fuse Editor für AVR

#### Als Extra Tool:

- [x] CPU Info
- [x] Serial Monitor
- [x] Fuse Editor
- [x] Diverse fremd Flashtool 
  - [x] AVRDude
  - [x] ST-Link
  - [x] Bossac
  - [x] ESPTools


## ENGLISH:

With this GUI for Lazarus you have the advantage that you can easily develop projects for embedded systems.
The advantage of the package, almost all settings for compilers and programmers are taken care of.
A serial monitor similar to the Arduino IDE is also built in.

### State of development 09/21/2022
The AVRs are already very well supported, especially the ordinary Arduinos.
There are quite a few examples for the Arduino UNO.
There are more and more, even for non-Arduino.
STM-32, Arduino DUO, ESPxxx and Rasberry Pico also work, only the examples are (still) missing.

### Downloads:
[Lazarus Embedded GUI](https://github.com/sechshelme/Lazarus-Embedded)

### Installation:
At Lazarus at "Open Package/Package File (.lpi) .../"
Then open this file, compile and install it. `./Lazarus_Embedded_GUI_Package/embedded_gui_package.lpk`

### Example for an Arduino:
Via "`File` --> `New...` --> `Project` --> `[Embedded] Embedded-Project` --> `Templates`... --> `Arduino UNO` --> `Blink pin 13` --> `Ok` --> `Ok`"
an Arduino UNO Project can then be created.
If you want to change something at runtime, you can edit the values ​​via "Project --> [Embedded] Options".

### Closing words:
The package is developed under Linux, so it may still have bugs under Windows.
A functional embedded cross compiler is required.
I'm always grateful for feedback, whether it's posted directly in the forum [Lazarus Forum Englisch](https://forum.lazarus.freepascal.org/index.php?topic=60667.msg454548#msg454548) or in the Issus ;)

### What can the tool do and what else is planned:

#### Inside Package:
- [x] Multiple microcontroller support
  - [x] New project
  - [x] Modify project parameters
  - [x] example projects
  - [x] AVR
  - [x] ARM
    - [x]STM32
    - [x] SAM3x7E Arduino Due
    - [ ] Still other ARMs
  - [x] ESPxxx
    - [x]ESP32
    - [x]ESP8266
  - [ ] PIC
- [ ] User defined parameters
- [x] CPU Info
- [x] Serial Monitor
- [ ] Fuse Editor for AVR

#### As an extra tool:

- [x] CPU Info
- [x] Serial Monitor
- [x] Fuse Editor
- [x] Various foreign flash tools
  - [x] AVRDude
  - [x] ST link
  - [x] Bossac
  - [x] ESPTools

## Images:
<img src="Embedded_Project_Option.png">
<img src="Embedded_Examples.png">
<img src="avr_fuse.png">

