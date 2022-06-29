::  titling: tui title generation library
::
=<
::  public core
|%
::  +align: align given text to left, right, or center of a character window
::
::    > (align %left 6 "abc")
::    "abc   "
::    > (align %right 6 "abc")
::    "   abc"
::    > (align %center 6 "abc")
::    " abc  "
::
++  align  ^align
::  +box-single: render given text in padded single-bar-wreathed title
::
::    > (box-single "Welcome to Mars!" 1)
::    <<
::      "┌──────────────────┐"
::      "│                  │"
::      "│ Welcome to Mars! │"
::      "│                  │"
::      "└──────────────────┘"
::    >>
::
++  box-single
  |=  [padding=@ud text=tape]
  ^-  wall
  =+  single-joints=["│" "─" "└" "┘" "┌" "┐"]
  (box-joints single-joints padding text)
::  +box-double: render given text in padded double-bar-wreathed title
::
::    > (box-double "Welcome to Mars!" 1)
::    <<
::      "╔══════════════════╗"
::      "║                  ║"
::      "║ Welcome to Mars! ║"
::      "║                  ║"
::      "╚══════════════════╝"
::    >>
::
++  box-double
  |=  [padding=@ud text=tape]
  ^-  wall
  =+  double-joints=["║" "═" "╚" "╝" "╔" "╗"]
  (box-joints double-joints padding text)
::  +box-symbol: render given text in padded symbol-bar-wreathed title
::
::    > (box-symbol '*' 1 "Welcome to Mars!")
::    <<
::      "********************"
::      "*                  *"
::      "* Welcome to Mars! *"
::      "*                  *"
::      "********************"
::    >>
::
++  box-symbol
  |=  [symbol=@t padding=@ud text=tape]
  ^-  wall
  =+  =>((trip symbol) symbol-joints=[. . . . . .])
  (box-joints symbol-joints padding text)
--
::  private core
|%
::  $joints: sequence of tapes encoding the joints of a tui-like box
::
::    All tui-like boxes consist of 3 major character classes: verticals,
::    horizontals, and corners. Corners can be divided into 4 subcategories,
::    one for each unique box corner.
::
::    This structure uses fully-expanded tapes instead of cords to force
::    up-front type coercion for non-ASCII characters (e.g. '└'), which
::    greatly simplifies all subsequent tape operations.
::
+$  joints  $:  vertical=tape
                horizontal=tape
                bot-left=tape
                bot-right=tape
                top-left=tape
                top-right=tape
            ==
::  +align: align text to left, right, or center of a given padding window
::
::    See the public core's `+align` for more information.
::
++  align
  |=  [type=?(%left %center %right) align-width=@ud text=tape]
  ^-  tape
  =+  text-width=(lent text)
  ?>  (gte align-width text-width)
  =+  space-count=(sub align-width text-width)
  ?-  type
    %left    (weld text (reap space-count ' '))
    %right   (weld (reap space-count ' ') text)
    %center  =+  left-count=(div space-count 2)
             =+  right-count=(add left-count (mod space-count 2))
             ;:(weld (reap left-count ' ') text (reap right-count ' '))
  ==
::  +box-joints: render given text in padded box constructed from joints
::
::    > (box-joints ["|" "-" "a" "b" "c" "d"] 1 "Welcome to Mars!")
::    <<
::      "c------------------d"
::      "|                  |"
::      "| Welcome to Mars! |"
::      "|                  |"
::      "a------------------b"
::    >>
::
++  box-joints
  |=  [=joints padding=@ud text=tape]
  ^-  wall
  ::  box characteristics and components
  ::
  =+  box-width=(add (lent text) (mul 2 padding))
  =+  horizontal-bar=`tape`(zing (reap box-width horizontal.joints))
  =+  vertical-row=;:(weld vertical.joints (reap box-width ' ') vertical.joints)
  =+  vertical-rows=(reap padding vertical-row)
  ::  box construction
  ::
  ;:  weld
    ~[;:(weld top-left.joints horizontal-bar top-right.joints)]
    vertical-rows
    ~[;:(weld vertical.joints (align %center box-width text) vertical.joints)]
    vertical-rows
    ~[;:(weld bot-left.joints horizontal-bar bot-right.joints)]
  ==
--
