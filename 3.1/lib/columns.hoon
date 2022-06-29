/+  *titling
|%
++  columnify
  |=  [just=?(%left %center %right) w=wall]  ^-  wall
  =/  lines=(list wall)  (turn w split)
  =/  lengths  (turn lines |=(words=wall (turn words lent)))
  =/  max-lengths  (roll lengths zip-max)
  =/  justified-lines  (turn lines |=(words=wall (justify-line just max-lengths words)))
  (turn justified-lines |=(words=wall (strip-right (zing (join " " words)))))
++  split
  |=  [t=tape]  ^-  wall
  =/  ix  (find "$" t)
  ?~  ix
    ~[t]
  :- 
    (scag (need ix) t)
  $(t (slag +((need ix)) t))
++  zip-max
  |=  [t=(list @) u=(list @)]  ^-  (list @)
  ?~  t
    ?~  u
      ~
    [i.u $(u t.u)]
  ?~  u
    [i.t $(t t.t)]
  [(max i.u i.t) $(t t.t, u t.u)]
++  justify-line
  |=  [just=?(%left %center %right) lengths=(list @) w=wall]  ^-  wall
  ?~  w
    ~
  [(align just -.lengths i.w) $(lengths +.lengths, w t.w)]
++  strip-right
  |=  [t=tape]
  ?.  =(' ' (snag (sub (lent t) 1) t))
    t
  $(t (scag (sub (lent t) 1) t))
--
