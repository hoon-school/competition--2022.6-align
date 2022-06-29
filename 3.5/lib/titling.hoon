|%
++  align
  |=  [kind=?(%left %center %right) width=@ud text=tape]
  ^-  tape
  ::
  :: Accepts a `?(%left %center %right)` tag indicating the kind of alignment;
  :: a total width which should be checked to make sure it is greater than the
  :: input string; and a `tape` string containing the text to be aligned. It
  :: returns the appropriately aligned text.
  ::
  ?:  (gth (lent text) width)  !!
  =/  gap  (sub width (lent text))
  ?-  kind
    %left  (append text " " gap)
    %right  (prepend text " " gap)
    %center  (append (prepend text " " (div gap 2)) " " (add (div gap 2) (mod gap 2)))
  ==
++  box-text
  |=  [gap=@ud text=tape]
  ^-  wall
  ::
  :: Accepts a `@ud` gap distance and a string, and returns the corresponding
  :: `wall` text string with single-line box-drawing characters surrounding the
  :: given text.
  ::
  (inhomogeneous-box-text '┌' '─' '┐' '│' '│' '└' '─' '┘' gap text)
++  double-box-text
  |=  [gap=@ud text=tape]
  ^-  wall
  ::
  :: accepts a `@ud` gap distance and a string, and returns the corresponding
  :: `wall` text string with double-line box-drawing characters surrounding the
  :: given text.
  ::
  (inhomogeneous-box-text '╔' '═' '╗' '║' '║' '╚' '═' '╝' gap text)
++  symbol-box-text
  |=  [symbol=@t gap=@ud text=tape]
  ^-  wall
  ::
  :: accepts a `@t` single character symbol, a `@ud` gap distance, and a string,
  :: and returns the corresponding `wall` text string with the given symbol
  :: surrounding the given text at the correct gap distance.
  ::
  =/  s  symbol
  (inhomogeneous-box-text s s s s s s s s gap text)
++  box-single
  |=  [gap=@ud text=tape]
  ^-  wall
  (box-text gap text)
++  box-double
  |=  [gap=@ud text=tape]
  ^-  wall
  (double-box-text gap text)
++  box-symbol
  |=  [symbol=@t gap=@ud text=tape]
  ^-  wall
  (symbol-box-text symbol gap text)
++  inhomogeneous-box-text
  |=  [sym7=@t sym8=@t sym9=@t sym4=@t sym6=@t sym1=@t sym2=@t sym3=@t gap=@ud text=tape]
  ^-  wall
  ::
  :: accepts eight `@t` single characters, a `@ud` gap distance, and a string,
  :: and returns the corresponding `wall` text string with the given symbols
  :: surrounding the given text at the correct gap distance, with symbols numbered
  :: as relative positions on keyboard's number pad:
  ::                                                 7 8 9
  ::                                                 4   6
  ::                                                 1 2 3
  ::
  =/  lw  (add (add (lent text) (mul 2 gap)) 2)
  =/  header  (prepend (append (prepend "" (trip sym8) (sub lw 2)) (trip sym9) 1) (trip sym7) 1)
  =/  pdunit  (prepend (append (prepend "" (trip ' ') (sub lw 2)) (trip sym6) 1) (trip sym4) 1)
  =/  footer  (prepend (append (prepend "" (trip sym2) (sub lw 2)) (trip sym3) 1) (trip sym1) 1)
  =/  body  (prepend (append (append (prepend text " " gap) " " gap) (trip sym6) 1) (trip sym4) 1)
  ?:  =(0 gap)  ~[header body footer]
    =/  padder  (wall-multiply ~[pdunit] gap)
    (weld (weld (weld (weld ~[header] padder) ~[body]) padder) ~[footer])
++  append
  |=  [text=tape fix=tape rep=@ud]
  ^-  tape
  :: append `fix` to `text` for `rep` times
  ?:  =(rep 0)
    text
  (weld $(rep (dec rep)) fix)
++  prepend
  |=  [text=tape fix=tape rep=@ud]
  ^-  tape
  :: prepend `fix` to `text` for `rep` times (like runt but with tapes)
  ?:  =(rep 0)
    text
  (weld fix $(rep (dec rep)))
++  wall-multiply
  |=  [l=wall rep=@ud]
  ^-  wall
  :: wall-integer multiplication, forming a new wall by repeating its input
  ?:  =(rep 0)  !!
  ?:  =(rep 1)
    l
  (weld l $(rep (dec rep)))
--
