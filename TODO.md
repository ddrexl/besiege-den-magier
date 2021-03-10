world
    forrest
    old man
    ne props
    (tower)
    (waving flag)
enemies
    magician
effects
    hit effect sound for fire
    key item pickup sound
    secret uncovered sound
    water sounds for fountain
controls
    enable buttons for tablet or browser only
people
    talk
    speech
combat
    magic cooldown
    casting ring?
debug
    remove ui_accept to give player all abilities
tileset
    https://opengameart.org/content/lpc-16x16-tiles-extended

- [O] game script
    - [✓] home
        - [✓] start
        - [✓] lern to collect coins
    - [✓] garden
        - [✓] find sword
        - [✓] lern to cut grass
        - [✓] destroy pots to enter town
        - [✓] remove fire ball magic
        - [✓] remove fire wave magic
        - [✓] remove heart container
        - [✓] vines cover hidden fire wave
    - [O] town
        - [✓] hidden garden behind house
            - [✓] coins
            - [✓] heart container
        - [ ] people to talk to?
            - [ ] old man
        - [✓] healing fountain
        - [✓] vines cover shortcut to fire cave
    - [o] path
        - [ ] first encounter with magician
        - [✓] fight summoned spider
        - [✓] can't beat with sword
        - [ ] fight ends by event
            - [ ] old man tells that spider only die by fire
            - [ ] old man tells that fire is in cave
            - [ ] old man ignites spider
            - [ ] spider drops heart container
    - [O] cave
        - [✓] bat enemies
        - [o] bat boss
            - [✓] drops heart container
            - [ ] opens path to magic cave
    - [✓] fire cave
        - [✓] fire ball magic
        - [✓] vines cover shortcut to town
    - [ ] forest
        - [ ] spider enemies
        - [ ] spider boss
            - [ ] drops heart container
    - [✓] dark cave
        - [✓] bat enemies
        - [✓] labyrinth
        - [✓] fire lightens path
        - [✓] fire lights torches
    - [✓] magic fountain
        - [✓] full heal
    - [ ] boss arena
        - [ ] magician boss fight
        - [ ] spawns spiders
        - [ ] casts fire magic

layout:
         boss arena
           |
         magic fountian
           |
         dark cave
           |
         forrest
           |
         fire cave - cave
           |          |
         <vines>      |
           |          |
         town north   |
           |          |
garden -- town ----- path
