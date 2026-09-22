# QuestLog – Projektübersicht

## Zweck

QuestLog ist eine mobile Flutter-App für die Planung des Tages und die Auswertung von Routinen. Aufgaben werden als Quests organisiert und mit spielerischen Elementen wie Main Quests, Side Quests, Streaks und Achievements verbunden.

Die App arbeitet lokal auf dem Gerät. Aufgaben, Tagesplanung, Fortschritt und freigeschaltete Achievements werden in einer lokalen Isar-Datenbank gespeichert.

## Technischer Aufbau

| Bereich | Umsetzung |
| --- | --- |
| UI | Flutter mit Material Widgets |
| Programmiersprache | Dart |
| State Management | Riverpod (`flutter_riverpod`) |
| Persistenz | Isar (`isar`, `isar_flutter_libs`) |
| Statistiken | `fl_chart` |
| Typografie | `google_fonts`, unter anderem JetBrains Mono |
| Icons und Assets | Material Icons und SVGs in `assets/icons/` |

## Einstiegspunkt und App-Lifecycle

1. `lib/main.dart` stellt sicher, dass Flutter initialisiert ist.
2. `IsarDataStore.init()` öffnet die lokale Datenbank und registriert die Isar-Schemas.
3. `ProviderScope` stellt Riverpod für den Widget-Baum bereit.
4. `App` erzeugt das dunkle Material-Theme und öffnet `MainHomeScreen`.
5. `MainHomeScreen` verwaltet die Hauptnavigation und hält die vier Hauptbereiche in einem `IndexedStack`.

## Benutzeroberfläche

### Hauptnavigation

- **Dashboard:** Tagesansicht mit Datumsauswahl, täglichem Fortschritt, geplanten Main Quests und Side Quests.
- **Assembler:** Visuelle Tagesplanung über Zeitblöcke. Main Quests können einem Zeitfenster zugeordnet, bearbeitet oder entfernt werden. Überschneidungen werden erkannt.
- **Analytics:** Auswertungen für einen wählbaren Zeitraum mit Kennzahlen und Diagrammen.
- **Backlog:** Sammlung nicht archivierter Quests, gruppiert nach Kategorien und filterbar nach Quest-Typ, Priorität und Fälligkeit.

### Weitere Screens und UI-Bausteine

- **Quest-Formular:** Erstellen von Main Quests und Side Quests mit Titel, Notizen, Kategorie, Priorität, Dauer, Fälligkeit, Wiederholung und Unteraufgaben.
- **Achievements:** Übersicht der Badges, Fortschrittsanzeige und Streak-Darstellung.
- **Auswahl bestehender Main Quests:** Auswahl eines bestehenden Quest-Eintrags für die Tagesplanung.
- **Settings:** Vorbereiteter Einstellungs-Screen.
- Wiederverwendbare Komponenten für App-Bar, Navigation, Buttons, Dropdowns, Choice Chips, Badges, Ladezustände und Screen-Container.

## Domänenmodell

### Persistente Isar-Collections

- `MainQuest`: größere oder priorisierte Aufgaben mit Status, Kategorie, Priorität, Fälligkeit, Dauer, Notizen und Archivstatus.
- `SideQuest`: kleinere oder wiederkehrende Aufgaben mit Kategorie, Wiederholung und Archivstatus.
- `AssemblerMainQuest`: geplante Main Quest mit Start- und Endzeit sowie Tagesbezug.
- `AssemblerSideQuest`: Tageszuordnung und Fortschritt einer Side Quest.
- `AchievementUnlock`: bereits angekündigte oder freigeschaltete Achievements mit Zeitstempel.

### Unterstützende Typen und Metriken

- Kategorien, Quest-Typen, Prioritäten, Statuswerte, Tage und Filteroptionen.
- Unteraufgaben für Main Quests.
- Tagesfortschritt, Analytics-Metriken und Gamification-Metriken.
- Achievement-Katalog mit Definitionen der verfügbaren Badges.

Die zugehörigen `*.g.dart`-Dateien werden aus den Isar-Annotationsklassen generiert und sollten nicht manuell bearbeitet werden.

## State Management und Datenfluss

Die Provider liegen in `lib/providers/` und bilden die fachlichen Bereiche ab:

- Quest-Streams für Main Quests, Side Quests und geplante Quests.
- Dashboard- und Assembler-Zustand einschließlich ausgewähltem Tag und Zeitfenster.
- Backlog-Zustand und Quest-Filter.
- Analytics-Zeitraum und berechnete Statistiken.
- Achievement- und Gamification-Zustand.
- Navigation sowie Formularzustand.

Die Isar-Watcher liefern Änderungen reaktiv an Riverpod. Nicht archivierte Main Quests und Side Quests werden standardmäßig über die jeweiligen Streams geladen.

## Analytics und Gamification

Die Analytics-Ansicht enthält unter anderem:

- Übersichtskennzahlen zum Fortschritt.
- tägliche Abschlusszahlen.
- Leistungsvergleich nach Wochentagen.
- Aufschlüsselung nach Quest-Kategorien.
- Konsistenz von Gewohnheiten.
- Verteilung des Zeitplans.

Die Gamification-Auswertung berechnet Streaks, Badge-Fortschritt und freigeschaltete Achievements. Neue Unlocks werden lokal gespeichert, damit sie nicht wiederholt angekündigt werden.

## Verzeichnisstruktur

```text
.
├── assets/icons/          SVG-Icons für die Navigation
├── android/               Android-Plattformprojekt
├── ios/                   iOS-Plattformprojekt
├── lib/
│   ├── data/              Isar-Modelle, Enums und Metriken
│   ├── providers/         Riverpod-Provider und Controller
│   ├── screens/           Vollständige Screens
│   ├── theme/             QuestLog-Farben und Theme-Konstanten
│   ├── utils/             Datums- und Zeit-Hilfsfunktionen
│   ├── widgets/           Wiederverwendbare UI-Komponenten
│   ├── app.dart           Material-App und Root-Theme
│   └── main.dart          Initialisierung und App-Start
├── analysis_options.yaml  Dart- und Flutter-Linting
├── pubspec.yaml           Abhängigkeiten und Asset-Konfiguration
├── README.md              Ausführliche Projekt- und Setup-Dokumentation
└── SUMMARY.md             Diese technische Kurzreferenz
```

## Entwicklungsstatus

Die Kernfunktionen für Quest-Verwaltung, Tagesplanung, Backlog, Analytics und Achievements sind im Quellcode vorhanden. Die Anwendung ist als lokale, mobile Flutter-App ausgelegt. Im Repository ist aktuell kein `test/`-Verzeichnis vorhanden; automatisierte Unit- oder Widget-Tests sind daher noch nicht dokumentiert.

## Relevante Dateien

- `lib/main.dart` – App-Initialisierung.
- `lib/app.dart` – Material-App und globales Theme.
- `lib/data/isar_data_store.dart` – Öffnen der Datenbank und Persistenzoperationen.
- `lib/screens/main_home_screen.dart` – Hauptnavigation.
- `lib/providers/` – reaktiver Anwendungszustand.
- `pubspec.yaml` – Flutter-Version, Abhängigkeiten und Assets.
