delete objects
Teapot name:"Teapot001"
Teapot name:"Teapot002"
Teapot name:"Teapot003"
Teapot name:"Teapot004"


dict = mxs_dict()
dict.add "background" #($Teapot001, $Teapot002)
dict.add $Teapot001 (Standard())
dict.get "background"
-->>> #($Teapot:Teapot001 @ [0.000000,0.000000,0.000000], $Teapot:Teapot002 @ [0.000000,0.000000,0.000000])
dict.get $Teapot001
-->>> Standardmaterial:Standard


fn list = #()
dd = mxs_defaultdict list
append (dd.get "uncolored") $Teapot003
append (dd.get "uncolored") $Teapot004
dd.get "uncolored"
-->>> #($Teapot:Teapot003 @ [0.000000,0.000000,0.000000], $Teapot:Teapot004 @ [0.000000,0.000000,0.000000])

struct Counter (
    n = 0,
    fn iterate = this.n += 1
)
dd = mxs_defaultdict Counter
(dd.get "foobar").iterate()
(dd.get "foobar").iterate()
(dd.get "bazding").iterate()
(dd.get "foobar").n
-->>> 2
(dd.get "bazding").n
-->>> 1


some_set = mxs_set #($Teapot001, $Teapot002)
other_set = mxs_set #($Teapot002, $Teapot003)
diff = some_set.difference other_set
-->>> (mxs_set _elements:#($Teapot:Teapot001 @ [0.000000,0.000000,0.000000]))
union = some_set.union other_set
-->>> #($Teapot:Teapot001 @ [0.000000,0.000000,0.000000], $Teapot:Teapot002 @ [0.000000,0.000000,0.000000], $Teapot:Teapot003 @ [0.000000,0.000000,0.000000])
intersection = some_set.intersection other_set
-->>> (mxs_set _elements:#($Teapot:Teapot002 @ [0.000000,0.000000,0.000000]))