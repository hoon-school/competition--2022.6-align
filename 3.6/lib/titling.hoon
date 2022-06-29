::
::  A library for aligning and boxing text
::    
::    Please note that there are still type issues with the tests due to how the special box
::    characters are stored (as discussed in the Hooniverse group). However, when run from 
::    the dojo all boxes output correctly.
::
|%
::  align: aligns a string within a strip of text to the left, center or right
::
::    Takes as input a @tas tag of %left, %center, or %right, a @ud to represent
::    the width, and finally the input string.
::
++  align
  |=  [tag=?(%left %center %right) width=@ud string=tape]
  ^-  tape
  ::  we store the string's length to avoid repeated calls to lent
  ::
  =+  length=(lent string)
  ::  crash if the input string's length is less than the desired text length, that wouldn't make sense
  ::
  ?:  (lth width length)
    !!
  ::  store how much whitespace we need to add
  ::
  =+  space=(sub width length)
  ?-  tag
    ::  in the %left case we simply weld the space to the right
    :: 
    %left  (weld string (reap space ' '))
    ::  in the %center case we divide the whitespace size by 2, using dvr to keep track of the remainder.
    ::  since we wish to shift to the left in the odd case, we add the smaller half of whitespace to the
    ::  left and the larger half to the right.
    ::
    %center  =+(half=(dvr space 2) (runt [p.half ' '] (weld string (reap (add p.half q.half) ' '))))
    ::  in the %right case we simply append the required whitespace
    ::
    %right  (runt [space ' '] string)
  ==
::  box-single: boxes your text with a single-lined box with variable gap
::
::    This arm functions by calling our generic-box-generator arm and supplying the characters for
::    the walls and the corners of the box to that arm.
::
++  box-single
  |=  [gap=@ud string=tape]
  ^-  wall
  (generic-box-constructor [gap string '─' '│' '┌' '┐' '└' '┘'])
::  box-double: boxes your text with a double-lined box with variable gap
::
::    This arm functions by calling our generic-box-generator arm and supplying the characters for
::    the walls and the corners of the box to that arm.
::
++  box-double
  |=  [gap=@ud string=tape]
  ^-  wall
  (generic-box-constructor [gap string '═' '║' '╔' '╗' '╚' '╝'])
::  box-symbol: boxes your text with a box made of an arbitrary symbol, with variable gap
::
::    This arm functions by calling our generic-box-generator arm and supplying the characters for
::    the walls and the corners of the box (which are all the same supplied symbol) to that arm.
::
++  box-symbol
  |=  [symbol=cord gap=@ud string=tape]
  ^-  wall
  (generic-box-constructor [gap string symbol symbol symbol symbol symbol symbol])
::  generic-box-constructor: a general box-constructor function
::
::    Can generate any text box so long as you supply the gap size, the text to be boxed, and 
::    characters for the horizontal wall, vertical wall, topleft corner, topright corner, botleft 
::    corner, and botright corner.
::
++  generic-box-constructor
  |=  [gap=@ud string=tape horizontal=cord vertical=cord topleft=cord topright=cord botleft=cord botright=cord]
  ^-  wall
  ::  store the length of the string to avoid repeated calls to lent
  ::
  =+  length=(lent string)
  ::  the gap size times two is a useful value since it tells us how much whitespace to add,
  ::  store it to avoid repeated calculation
  ::
  =+  doublegap=(mul 2 gap)
  ::  construct the top line with top corners and horizontal walls
  ::
  =+  topline=`tape`[topleft (runt [(add doublegap length) horizontal] (trip topright))]
  ::  construct middle lines (non-text) with vertical walls sandwiching empty space
  ::
  =+  midline=`tape`[vertical (runt [(add doublegap length) ' '] (trip vertical))]
  ::  construct the bottom line with the bottom corners and horizontal walls
  ::
  =+  bottomline=`tape`[botleft (runt [(add doublegap length) horizontal] (trip botright))]
  ::  construct the line with text by appending gap size of whitespace to the ends plus vertical walls
  ::
  =+  textline=`tape`[vertical (runt [gap ' '] (weld string (runt [gap ' '] (trip vertical))))]
  ::  with all the pieces ready we now construct the box. keep a counter to tell us how many midlines to add
  ::  the result starts with just the top line.
  ::
  =+  count=0
  =+  result=`wall`[topline ~]
  |-
    ::  if we have added enough midlines
    ::
    ?:  =(count doublegap)
      ::  finally add the bottomline, reverse and insert the textline into the middle, we are done
      ::
      `wall`(into (flop [bottomline result]) (add gap 1) textline)
    ::  otherwise keep inserting midlines
    ::
    $(result [midline result], count +(count))
--
