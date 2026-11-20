# LeMansGTDash

Dashboard View for Lotus Elise GARW dash

###

Inspired by more "race" dashes in LeMans GT cars. This is an early dash that I developed, more of a proof of concept than an exceptional design.

###

TO DO:

- Full Screen takeover so we can use the qml warning icons instead of the new ones.
- Something Lotus related logo-y?
- Better animation in onLoad
- Something a little more monospaced for the numbers
- Better icons?
- Trip Odometer? (Do people use this on the Lotus?)

## Dev Notes:

When working with QML files for GAWR dash, try to make sure you're still running 5.15, as 6.0+ has gotten rid of the QTGraphicalEffects with no backwards import compatibility (Thanks guys!). If you want to do things like color overlays or glows, you will need this.

QTCreator crashes a lot when editing, and will burp when you try to use the designer quite often. Be one with the code, and size assets properly. Related to this, start a blank UI project _then_ open up a QML file as you will run into issues with design mode.

Update 12/5/2023: QT Design Studio is really the app you want to use when visually editing initially. It doesn't crash like QTCreator does, but unfortunately, their free model doesn't support 5.15, so you'll still have to have QTCreator or the GARW simulator to view glows. My suggested flow is Illustration program or Photoshop -> QT Designer -> GARW Preview -> Text editor tweaks -> Preview -> Actual Dashboard for testing.

## Design notes:

I'm trying to keep a general 16px padding around the screen, as on my Lotus Dash I have a lot of the stock plastic interfering on random parts of the screen, notably the center of the binnacle.

Try to use variable names instead of per item colors when developing.

Try to keep fonts uniform and clear. Don't go below 12px for font heights, as it gets illegible. Numbers should preferrably use monospaced fonts.

Utilize opacity filters for timers to get blink effects.

Blink effects should only be used on actual warning items, as they are extremely distracting on the track!

## Settings

Oil temperature and oil pressure are optional: turn each one on with its Show row in the settings menu. Temperatures can be shown in C or F and oil pressure in PSI or BAR. Limits are always set in Celsius / bar, and a High of 0 turns that warning off. Coolant Low is the warm-up threshold.

## Layout

- `LeMansGT.qml` - entry file: live data, config load/save, joystick handling, settings menu
- `LeMansGTDisplay.qml` - the dial itself
- `SettingsMenu.qml`, `SettingBox.qml`, `MonoText.qml`, `Theme.qml`, `GridBackground.qml` - settings menu (shared with AgeSolo)
- `SettingsPreview.qml` - standalone menu preview, not loaded by the dash
- `LeMansGT.qml.png` - preview shown in the dash picker
- `fonts/`, `img/` - assets

Settings are saved as JSON in `/opt/IC7/screen_configs/LeMansGT_config.json`. An existing `LeMansGT_config.txt` is imported once on first run.

# Installation notes:

1) Install via GARW Genie:  https://github.com/dustinsterk/GARWGenie

There are some prebuilt releases for the uploader, check with the Discord Channel here: https://discord.gg/bmKFrt8XP6
