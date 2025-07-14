* Build

```
zig build-exe .\src\dungeon.zig
```

* Run

```
./dungeon.exe
```

* Test

```
zig test .\src\dungeon.zig
```

* Output
```
Dungeon:
[-2 -3 3 ]
[-5 -10 1 ]
[10 30 -5 ]

Start new board:
[0 0 0 ]
[0 0 0 ]
[0 0 0 ]

Fill last cell:
[0 0 0 ]
[0 0 0 ]
[0 0 6 ]

Fill last column:
[0 0 2 ]
[0 0 5 ]
[0 0 6 ]

Fill last row:
[0 0 2 ]
[0 0 5 ]
[1 1 6 ]

Remaining board:
[7 5 2 ]
[6 11 5 ]
[1 1 6 ]

Minimum initial health: 7
```
