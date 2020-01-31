### Animated ripples decal

See the example map in example/ to see the effect

Animation frames were sourced from:
https://opengameart.org/content/seamless-animated-raindrop-ripples-texture

Then merged into a sprite sheet via;

`montage ripples_* -tile 5x6 -geometry 256x256+0+0 ripples.png`

Followed by a quick alpha-to-color adjustment to remove the black background

Decal can be loaded with:

```
setshader stddecal
texture decal "<anim:25,5,6>ripples_a_h"
```
