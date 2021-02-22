# spacetrucks

the goal of this project is to create a "truck simulator meets a visual novel somewhere in a cyberpunk dystopia in space" developed with [libretro-lutro](https://github.com/libretro/libretro-lutro)
for the [raspberry pi zero w with the retroflag gpi case](http://retroflag.com/GPi-CASE.html)
running [recalbox](https://www.recalbox.com/de/)


## vision

spacetrucks will be a story and text based game, in which you play as a truck
driver (m/f/d) in space, trying to avoid obstacles (asteroids), gangsters and
the police along the way, meet fantastic people, and customize your truck engine
and interior.

the look and feel (vibe) of the game should be  cowboy bebop episode 7 as a pc98
game, with the dialogue (and bits of customization) of va-11 ha11 a, a rick and
morty-style universe, need for speed like-customization, and the dialogue and
radio-feauture of cyberpunk 2077.

the gameplay takes form in several different states:

- state: cutscene
  - a cutscene plays, like in an jrpg or dating sim. this means most of the
  screen is covered with an image of the scene and action currently happening,
  with a text box below in which dialogue and storytelling are displayed. the
  player can choose between different dialogue options like in cyberpunk but it actually changes the run of the game.

- state: driving
  - the player sits in his truck with a pov camera, driving the truck in space.
  gameplay consists of steering to stay on track and avoiding obsicles, police,
  and gangsters.
  - controls are
    - turn_up
    - turn_down(for_what)
    - turn_left
    - turn_right
    - accelerate
    - break
    - interact (with interior)
      - smoke
      - change radio
  - the player can choose a radio station. the radio stations are either
  streamed from the internet, or custom made, 15-30 minute long themed
  "radio-like" soundtracks.
  - a bit like the all in one japan train simulator

- state: customizing
  - the player customizes the truck (and interior) in a need-for-speed like
  fashion. TODO determine customizable features of truck

- featue: mini-map
  - sprite based planet to planet view with edges

## other notes

- sims/pokemon like baba like talking in dialogues
- many good quotes in radio (like the dude in the radio in cyberpunk) and from
interviews/dialogues -> radio-like transmissions with fellow truckers
- pre-render backrounds for space / planets / spaceship-states and make sprites
- take a look at scott pilgrim vs the world sprites for inspiration -> own art style
- parallax effect
- https://www.google.com/search?q=space+pixel+art&sxsrf=ALeKk01eAbnsWAmPSgEHhc8O60_wTUOGew:1613870643154&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjU6JfT6PnuAhVB6aQKHbbVDC0Q_AUoAXoECBEQAw&biw=792&bih=739

## technical realization
developed with [libretro-lutro](https://github.com/libretro/libretro-lutro)
for the [raspberry pi zero w with the retroflag gpi case](http://retroflag.com/GPi-CASE.html)
running [recalbox](https://www.recalbox.com/de/)

## lore ideas

- at the start: the player has debts
- earn money through deliveries (smuggling / weapons transprotection)
- avoid the space police

- story gets cut in to missions (maybe even a "relatively" open world with choose your own path, depending on which missions you take)

### in flight encounters

- in one or some trips the player gets a choice to pick up a hitchhiker -> the hitchhiker sits and talks to the player -> from there on out everything can happen (good/bad/etc)

- in one or some trips the player gets pulled over by police or gangsters, the player then needs to handle the situation per dialogue   

- the engine could break down -> maybe repair it or call a repair service or sth -> maybe the hitchhiker can fix it and the player saves money if he chose to pick up the hitchhiker
