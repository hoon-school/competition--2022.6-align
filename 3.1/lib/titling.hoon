|%
++  align
  |=  [alignment=?(%left %center %right) width=@ud t=tape]  ^-  tape
  ?:  (lth width (lent t))
    ~|  'width too short'
    !!
  ?-    alignment
      %left
    =/  padding  (reap (sub width (lent t)) ' ')
    "{t}{padding}"
  ::
      %center
    =+  (dvr (sub width (lent t)) 2)
    =/  padding-left  (reap p ' ')
    =/  padding-right  (reap (add p q) ' ')
    "{padding-left}{t}{padding-right}"
  ::
      %right  
    =/  padding  (reap (sub width (lent t)) ' ')
    "{padding}{t}"
  ==
++  box-single
  |=  [gap=@ud t=tape]  ^-  wall
  (box gap t '│' '─' '┐' '┌' '└' '┘')
++  box-double
  |=  [gap=@ud t=tape]  ^-  wall
  (box gap t '║' '═' '╗' '╔' '╚' '╝')
++  box-symbol
  |=  [c=@t gap=@ud t=tape]
  (box gap t c c c c c c)
++  box
  |=  [gap=@ud t=tape v=@t h=@t tr=@t tl=@t bl=@t br=@t]
  =/  len  :(add (lent t) 2 (mul gap 2))
  =/  top  (trip (crip "{(trip tl)}{(reap (sub len 2) h)}{(trip tr)}"))
  =/  middle  (trip (crip "{(trip v)}{(reap gap ' ')}{t}{(reap gap ' ')}{(trip v)}"))
  =/  bottom  (trip (crip "{(trip bl)}{(reap (sub len 2) h)}{(trip br)}"))
  =/  else  (trip (crip "{(trip v)}{(reap (sub len 2) ' ')}{(trip v)}"))
  :(weld ~[top] (reap gap else) ~[middle] (reap gap else) ~[bottom])
--
