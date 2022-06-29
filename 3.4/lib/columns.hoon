::
::  A library for turning delimited text into columns of text.
::
/+  titling
::
=<
::
|%
::  +columnify: produce a list of lines where buc-delimited text from the input
::  lines has been transformed to spaced columns with contents aligned by the
::  given mode
::
::    Trailing whitespace is trimmed.
::
++  columnify
  |=  [mode=?(%left %center %right) lines=wall]
  ^-  wall
  ::
  =/  rows=(list wall)  (turn lines parse-row)
  =/  max-widths=(list @ud)  (roll (turn rows |=([r=wall] (turn r lent))) pairwise-max)
  %+  turn
    rows
  |=  [columns=wall]
  ^-  tape
  %-  zing
  ::  Align contents, interleave with aces, and remove trailing whitespace from
  ::  the last column.
  ::  ex: ~["Given" " " "a" " " "text"]
  ::
  |-
  ?~  max-widths  !!
  ?~  columns  !!
  =/  contents=tape  (align:titling mode i.max-widths i.columns)
  ?~  t.columns  
    ~[(chomp-aces contents)]
  :+  contents
    " "
  $(columns t.columns, max-widths t.max-widths)
--
::
|%
::  +parse-row: split tape into a list of tapes on the delimiter buc
::
::    Trailing empty columns are discarded.
::
++  parse-row
  |=  [row=tape]
  ^-  wall
  ::
  =/  columns=wall  ~
  |-
  =/  column=tape  ~
  |-
  ?~  row
    (flop (pop-empties (turn [column columns] flop)))
  ?:  =('$' i.row)
    ^$(columns [column columns], row t.row)
  $(column [i.row column], row t.row)
::  +pop-empties: remove all ~ from the front of a list
::
::    Useful to remove empty columns from the end of a row.
::
++  pop-empties
  |=  [columns=wall]
  ^-  wall
  ::
  |-
  ?~  columns
    ~
  ?~  i.columns
    $(columns t.columns)
  columns
::  +chomp-aces: remove all aces from the end of a tape
::
++  chomp-aces
  |=  [text=tape]
  ^-  tape
  ::
  =/  text  (flop text)
  |-
  ?~  text
    ~
  ?:  =(' ' i.text)
    $(text t.text)
  (flop text)
::  +pairwise-max: produce a list of the max value of corresponding elements
::  of two lists
::
::    When the lists have uneven lengths, values from the longer list are
::    taken as the max where the shorter list has no values.
::    ex: (pairwise-max ~[1 2 3] ~[4 1]) -> ~[4 2 3]
::
++  pairwise-max
  |=  [l1=(list @) l2=(list @)]
  ^-  (list @)
  ::
  |-
  ?:  &(=(~ l1) =(~ l2))
    ~
  ?~  l1
    ?~  l2  !!
    [i.l2 $(l2 t.l2)]
  ?~  l2
    ?~  l1  !!
    [i.l1 $(l1 t.l1)]
  [(max i.l1 i.l2) $(l1 t.l1, l2 t.l2)]
--
