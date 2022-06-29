::
::  A library for producing aligned text and boxed text.
::
=<
::
|%
::  +align: produce a tape padded with aces to width characters where
::  the given text is aligned within according to mode
::
++  align
  |=  [mode=?(%left %center %right) width=@ud text=tape]
  ^-  tape
  ?>  (gte width (lent text))
  ::
  =/  aces-n=@ud  (sub width (lent text))
  =/  ace=@t  ' '
  ?-  mode
    %left  (weld text (reap aces-n ace))
    ::
    %center
      =/  [quot=@ud rem=@ud]  (dvr aces-n 2)
      =/  left-n  quot
      =/  right-n  (add quot rem)
      (weld (runt [left-n ace] text) (reap right-n ace))
    ::
    %right  (runt [aces-n ace] text)
  ==
::  +box-single: surround text with single-width box-drawing characters
::
++  box-single
  |=  [gap=@ud text=tape]
  ^-  wall
  ::
  =/  symbols  ['│' '─' '┌' '┐' '└' '┘']
  (~(box boxer symbols) gap text)
::  +box-double: surround text with double-width box-drawing characters
::
++  box-double
  |=  [gap=@ud text=tape]
  ^-  wall
  ::
  =/  symbols  ['║' '═' '╔' '╗' '╚' '╝']
  (~(box boxer symbols) gap text)
::  +box-symbol: surround text with the given symbol
::  
::    symbol must represent a single character or the box will be malformed.
::
++  box-symbol
  |=  [symbol=@t gap=@ud text=tape]
  ^-  wall
  ::
  =/  symbols  [symbol symbol symbol symbol symbol symbol]
  (~(box boxer symbols) gap text)
--
::
|%
::
++  boxer
  |_  [vertical=@t horizontal=@t upper-left=@t upper-right=@t lower-left=@t lower-right=@t]
  ::
  ++  box
    |=  [gap=@ud text=tape]
    ^-  wall
    ::  Base all text inputs on @c so that box-drawing characters can be
    ::  represented as the tests expect (ex: need "╔" as ~[226 149 148]
    ::  not as ~[9.737.698]) and to keep the list operations below as
    ::  simple as possible (converting to tape would add an extra layer
    ::  of lists to deal with).
    ::
    =/  vertical=@c     (taft vertical)
    =/  horizontal=@c   (taft horizontal)
    =/  upper-left=@c   (taft upper-left)
    =/  upper-right=@c  (taft upper-right)
    =/  lower-left=@c   (taft lower-left)
    =/  lower-right=@c  (taft lower-right)
    =/  text=(list @c)  (tuba text)
    ::
    =/  ace=@c  (taft ' ')
    =/  inner-n=@ud  (add (mul 2 gap) (lent text))
    =/  body  |=(content=(list @c) (snoc [vertical content] vertical))
    ::
    =/  top=(list @c)     (snoc [upper-left (reap inner-n horizontal)] upper-right)
    =/  bottom=(list @c)  (snoc [lower-left (reap inner-n horizontal)] lower-right)
    =/  empty=(list @c)   (body (reap inner-n ace))
    =/  main=(list @c)    (body ;:(weld (reap gap ace) text (reap gap ace)))
    ::
    %+  turn
      ;:(weld ~[top] (reap gap empty) ~[main] (reap gap empty) ~[bottom])
    tufa
  --
--
