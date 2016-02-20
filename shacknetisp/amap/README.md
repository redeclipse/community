This a server-side cubescript module to allow easier custom map lists.

To use it, simply add `exec amap.cfg` to your servinit.cfg.

Example:
```
amap.disallow = [canals]
amap.main = [customdmmap1]
exec ../amap.cfg
//sv_*maps will be updated to include customdmmap1 and exclude canals
```
