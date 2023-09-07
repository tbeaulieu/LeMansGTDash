# LeMansGTDash

Dashboard View for Lotus Elise GARW dash

###

Inspired by more "race" dashes in LeMans GT cars.

###

Dev Notes:

When working with QML files for GAWR dash, try to make sure you're still running 5.15, as 6.0+ has gotten rid of the QTGraphicalEffects with no backwards import compatibility (Thanks guys!). If you want to do things like color overlays or glows, you will need this.

QTCreator crashes a lot when editing, and will burp when you try to use the designer quite often. Be one with the code, and size assets properly. Related to this, start a blank UI project _then_ open up a QML file as you will run into issues with design mode.

Design notes:

I'm trying to keep a general 16px padding around the screen, as on my Lotus Dash I have a lot of the stock plastic interfering on random parts.

Try to use variable names instead of per item colors

Try to keep fonts uniform and clear. Don't go below 12px for font heights, as it gets illegible.
