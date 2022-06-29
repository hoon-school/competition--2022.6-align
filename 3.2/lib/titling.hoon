|%
::
::
++  align
  |=  [align=?(%left %center %right) fwidth=@ud string=tape]
  =/  width  (sub fwidth (lent string))
  ?:  =(align %right)
    `tape`(weld (reap width ' ') string)
  ?:  =(align %left)
    `tape`(weld string (reap width ' '))
  ?:  =(align %center)
    =/  right  (add (div width 2) (mod width 2))
    =/  left  (div width 2)
    `tape`(weld `tape`(weld (reap left ' ') string) (reap right ' '))
  ~
::
::
++  box-single
  |=  [gap=@ud string=tape]
  
  =/  workingtext  `tape`(weld (weld (reap gap ' ') string) (reap gap ' '))
  =/  inner-width  (lent workingtext)
  =/  text  `tape`(weld (weld "│" workingtext) "│")
  =/  top  `tape`(weld (weld "┌" (reap inner-width '─')) "┐")
  =/  border  `tape`(weld (weld "│" (reap inner-width ' ')) "│")
  =/  bottom  `tape`(weld (weld "└" (reap inner-width '─')) "┘")
  =/  i  0

  :: print top, inner-width across
  :: for i < gap, do sides, inner-width across
  :: print string with sides <gap> away
  :: for i < gap, do sides, inner-width across
  :: print bottom, inner-width across

  =/  title  `wall`~[top text bottom]
  |-
  ?:  =(i gap)
    title
  %=  $
    i  +(i)
    title  `wall`(into (into title (add 1 (div (lent title) 2)) border) (div (lent title) 2) border)
  ==
::
::
++  box-double
  |=  [gap=@ud string=tape]

  =/  workingtext  `tape`(weld (weld (reap gap ' ') string) (reap gap ' '))
  =/  inner-width  (lent workingtext)
  =/  text  `tape`(weld (weld "║" workingtext) "║")
  =/  top  `tape`(weld (weld "╔" (reap inner-width '═')) "╗")
  =/  border  `tape`(weld (weld "║" (reap inner-width ' ')) "║")
  =/  bottom  `tape`(weld (weld "╚" (reap inner-width '═')) "╝")
  =/  i  0

  :: print top, inner-width across
  :: for i < gap, do sides, inner-width across
  :: print string with sides <gap> away
  :: for i < gap, do sides, inner-width across
  :: print bottom, inner-width across

  =/  title  `wall`~[top text bottom]
  |-
  ?:  =(i gap)
    title
  %=  $
    i  +(i)
    title  `wall`(into (into title (add 1 (div (lent title) 2)) border) (div (lent title) 2) border)
  ==
::
::
++  box-symbol
  |=  [symbol=@t gap=@ud string=tape]

  =/  sym  (trip symbol)
  =/  workingtext  `tape`(weld (weld (reap gap ' ') string) (reap gap ' '))
  =/  inner-width  (lent workingtext)
  =/  text  `tape`(weld (weld sym workingtext) sym)
  =/  top  `tape`(weld (weld sym (reap inner-width symbol)) sym)
  =/  border  `tape`(weld (weld sym (reap inner-width ' ')) sym)
  =/  bottom  `tape`(weld (weld sym (reap inner-width symbol)) sym)
  =/  i  0

  :: print top, inner-width across
  :: for i < gap, do sides, inner-width across
  :: print string with sides <gap> away
  :: for i < gap, do sides, inner-width across
  :: print bottom, inner-width across

  =/  title  `wall`~[top text bottom]
  |-
  ?:  =(i gap)
    title
  %=  $
    i  +(i)
    title  `wall`(into (into title (add 1 (div (lent title) 2)) border) (div (lent title) 2) border)
  ==
--

