This a server-side cubescript module to allow easier custom map lists.

To use it, simply add `exec amap.cfg` to your servinit.cfg.

Example:
```
amap.disallow = [canals]
amap.main = [customdmmap1]
amap.duel = [customduelmap1]
amap.capture = [customctfmap1 customctfmap2]
amap.race = [
    customracemap1 customracemap2
    customracemap3
]
exec amap.cfg
//sv_*maps will be updated to include the custom maps in their appropriate modes and exclude canals
```
