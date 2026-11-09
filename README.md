# Taken – een takenlijst-app voor iPhone

Een eenvoudige to-do-app voor de iPhone 17 (iOS 26), gemaakt met **SwiftUI** en **SwiftData**.

## Functies

- Taken toevoegen met titel, notities, deadline en prioriteit (laag / normaal / hoog)
- Afvinken met een tik op het rondje (met trilfeedback), of door naar rechts te vegen
- Naar links vegen om te verwijderen
- Tik op een taak om hem te bewerken
- Filter op *Alles*, *Open* of *Afgerond*, en wis afgeronde taken in één keer
- Zoeken in titels en notities
- Taken die over de deadline zijn, krijgen een rode datum
- Alles wordt lokaal op het toestel opgeslagen

## Vereisten

- Een Mac met **Xcode 26** of nieuwer
- Een iPhone met iOS 26 (bijv. iPhone 17), of de simulator

## Starten

1. Clone deze repository op je Mac.
2. Open `Taken.xcodeproj` in Xcode.
3. Kies bovenaan een simulator (bijv. *iPhone 17*) en druk op **⌘R**.

### Op je eigen iPhone

1. Sluit je iPhone aan en zet op de iPhone **Ontwikkelaarsmodus** aan
   (Instellingen › Privacy en beveiliging › Ontwikkelaarsmodus).
2. Klik in Xcode op het project **Taken** › target **Taken** › tab **Signing & Capabilities**.
3. Kies bij *Team* je Apple ID (een gratis account werkt ook). Pas zo nodig de
   *Bundle Identifier* aan naar iets unieks, bijv. `com.jouwnaam.Taken`.
4. Kies je iPhone als doel en druk op **⌘R**.

## Projectstructuur

```
Taken/
├── TakenApp.swift          # Startpunt van de app
├── Models/
│   ├── TaskItem.swift      # Het SwiftData-model voor een taak
│   └── PreviewData.swift   # Voorbeelddata voor Xcode-previews
├── Views/
│   ├── ContentView.swift   # Hoofdscherm met lijst, filter en zoeken
│   ├── TaskRow.swift       # Eén regel in de lijst
│   └── TaskEditorView.swift# Formulier voor nieuwe of bestaande taak
└── Assets.xcassets         # App-icoon en accentkleur
```

Het project gebruikt de map-synchronisatie van Xcode: nieuwe bestanden die je in de
map `Taken/` zet, worden automatisch meegenomen.
