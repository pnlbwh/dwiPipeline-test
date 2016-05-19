splitgrad=: ({. ,&< }.)~ I.@:('DWMRI_gradient_0000'&E.)
grad2num=: __&".@(21&}.);._2
readaff=: (__&".;._2)@:fread
readaffines=: > @: (__&".;._2@fread each) @:  (1&dir) @: ('Diffusion*.txt' ,~ ])

NB. v ;:'moving output xfm'
warpaff=: 3 : 0
    cmd=.'/data/pnl/soft/bin/WarpImageMultiTransform 3 ', ' '&joinstring y
    smoutput cmd
    shell cmd
)

grad=: grad2num@:>@:{:@:splitgrad
gradf=: grad@fread

affine=: 4 : 0
    affines=.x
    grads=.y
    (grads,.1) (+/ . *)"_1 |: items affines
)

 rx=: 3 : '3 3 $ 1 0 0  0 ,(cos y) ,(sin y),  0, (-sin y), (cos y)'
 ry=: 3 : '3 3 $ (cos y), 0, (-sin y), 0 1 0, (sin y), 0, (cos y)'
 rz=: 3 : '3 3 $  (cos y), (sin y), 0,  (-sin y), (cos y), 0,  0 0 1'

 shear=. 4 : 'y (<x)} (= i.3)'
