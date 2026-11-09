# Taken – een takenlijst-app voor iPhone en iPad

Een eenvoudige to-do-app gemaakt met **SwiftUI** en **SwiftData**. Je hebt er geen Mac
voor nodig: de app is een **Swift Playgrounds**-project dat je op een iPad kunt bouwen en draaien.

## Functies

- Taken toevoegen met titel, notities, deadline en prioriteit (laag / normaal / hoog)
- Afvinken met een tik op het rondje, of door naar rechts te vegen
- Naar links vegen om te verwijderen
- Tik op een taak om hem te bewerken
- Filter op *Alles*, *Open* of *Afgerond*, en wis afgeronde taken in één keer
- Zoeken in titels en notities
- Taken die over de deadline zijn, krijgen een rode datum
- Alles wordt lokaal op het toestel opgeslagen

## Op je iPad zetten

Je hebt een iPad met iPadOS 17 of nieuwer nodig.

1. Installeer de gratis app **Swift Playgrounds** uit de App Store.
2. Open in Safari op je iPad deze repository op GitHub en kies de branch
   `claude/iphone17-app-504kt1`.
3. Tik op de groene knop **Code** › **Download ZIP**.
4. Open de app **Bestanden**, ga naar **Downloads** en tik op het zip-bestand om het uit te pakken.
5. Open de uitgepakte map en tik op **Taken.swiftpm**. Het project opent in Swift Playgrounds.
   (Opent het niet vanzelf? Kies in Swift Playgrounds dan zelf **Taken.swiftpm** via het bestandsoverzicht.)
6. Tik op de afspeelknop ▶︎ om de app te bouwen en te starten.

## Op je iPhone zetten

Een app die je in Swift Playgrounds bouwt, kun je niet rechtstreeks op je iPhone zetten.
Daarvoor heb je een betaald **Apple Developer-account** (€99 per jaar) nodig. Dan kun je in
Swift Playgrounds de app naar **App Store Connect** uploaden en hem via **TestFlight**
op je iPhone installeren.

## Met een Mac (optioneel)

Open de map `Taken.swiftpm` in Xcode, kies een simulator en druk op **⌘R**.

## Projectstructuur

```
Taken.swiftpm/
├── Package.swift            # Instellingen van de app (naam, icoon, apparaten)
├── TakenApp.swift           # Startpunt van de app
├── Models/
│   ├── TaskItem.swift       # Het SwiftData-model voor een taak
│   └── PreviewData.swift    # Voorbeelddata voor previews
├── Views/
│   ├── ContentView.swift    # Hoofdscherm met lijst, filter en zoeken
│   ├── TaskRow.swift        # Eén regel in de lijst
│   └── TaskEditorView.swift # Formulier voor nieuwe of bestaande taak
└── Assets.xcassets          # App-icoon en accentkleur
```
