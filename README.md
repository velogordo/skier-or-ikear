# Skier or IKEA-r?

A seven-question phone game: is the name on screen a cross-country ski racer or an IKEA product?

- `index.html` holds the title screen and the untimed modes: **Daily** (the same 7 names for everyone each day, with streaks kept in the browser), **7 km** (7 names) and the **Loppet** (50 names, one per km, with feed stations and saved progress).
- `sprint.html` is Sprint mode: qualification, quarterfinals, semifinals and a final against the World Cup sprint field, with lucky losers.
- Wrong answers draw FIS-style reprimands (verbal, then written "yellow cards"); in Sprint and the Loppet they cost time.
- `data.js` holds the shared name lists and World Cup standings.
- `docs/` is what GitHub Pages serves. Regenerate it with `./build.sh` after editing anything.

Skier names come from the FIS Cross-Country World Cup 2025/26 standings, FIS World Cup fields and the FIS registers of active Swedish, Norwegian and Finnish racers. IKEA names come from IKEA Canada's series list, Lars Petrus's IKEA Dictionary (lar5.com/ikea) and namingschemes.com's IKEA list (product types). Just for fun; not affiliated with FIS or IKEA.
