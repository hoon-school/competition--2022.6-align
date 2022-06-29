/+  *titling
|%
++  columnify
  |=  [kind=?(%left %center %right) table=wall]
  ^-  wall
  ::
  :: accepts a `?(%left %center %right)` tag indicating the kind of alignment
  :: and a `wall` of strings containing the text to be aligned.  It reformats the
  :: text into a `wall` with the appropriate behavior.
  ::
  ?:  =(0 (lent table))  table
  =/  column-widths  (get-column-widths table)
  =/  res  `wall`~[(columnify-row kind column-widths (snag 0 table))]
  =/  i  1
  |-
  ?:  =(i (lent table))  res
  %=  $
    res  (weld res ~[(columnify-row kind column-widths (snag i table))])
    i  (add 1 i)
  ==
++  columnify-row
  |=  [kind=?(%left %center %right) width=(list @ud) row=tape]
  ^-  tape
  =/  res  `tape`""
  =/  col  `tape`""
  =/  i  0
  =/  ic  0
  |-
  ?:  =(i (lent row))  (weld res (align kind (snag ic width) col))
  ?:  =('$' (snag i row))
  %=  $
    res  (weld (weld res (align kind (snag ic width) col)) " ")
    col  `tape`""
    i  (add 1 i)
    ic  (add 1 ic)
  ==
  %=  $
    col  (weld col (trip (snag i row)))
    i  (add 1 i)
  ==
++  get-max-number-of-columns
  |=  [table=wall]
  ^-  @ud
  =/  nc  0
  =/  i  0
  |-
  ?:  =(i (lent table))  nc
  %=  $
    nc  (max nc (get-number-of-columns (snag i table)))
    i  (add 1 i)
  ==
++  get-number-of-columns
  |=  [row=tape]
  ^-  @ud
  ?:  =(0 (lent row))  !!
  =/  nc  1
  =/  i  0
  |-
  ?:  =(i (lent row))  nc
  ?:  =('$' (snag i row))
  %=  $
    nc  (add 1 nc)
    i  (add 1 i)
  ==
  %=  $
    i  (add 1 i)
  ==
++  get-column-widths
  |=  [table=wall]
  ^-  (list @ud)
  =/  nc  (get-max-number-of-columns table)
  =/  cw  `(list @ud)`(reap nc 0)
  =/  ic  0
  =/  i  0
  =/  j  0
  =/  k  0
  |-
  ?:  =(i (lent table))  cw
  ?:  =(j (lent (snag i table)))
  %=  $
    i  (add 1 i)
    j  0
    k  0
    ic  0
    cw  (snap cw ic (max k (snag ic cw)))
  ==
  ?:  =('$' (snag j (snag i table)))
  %=  $
    j  (add 1 j)
    k  0
    ic  (add 1 ic)
    cw  (snap cw ic (max k (snag ic cw)))
  ==
  %=  $
    j  (add 1 j)
    k  (add 1 k)
  ==
--
