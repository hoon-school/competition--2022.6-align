::  columns: tui text alignment library
::
/+  *titling
|%
::  +columnify: render given $-delimited text rows as adjusted columns
::
::    > (columnify %left ~["1$11$111" "222$22$2" "3$3"])
::    <<
::      "1   11 111"
::      "222 22 2  "
::      "3   3 "
::    >>
::    > (columnify %right ~["1$11$111" "222$22$2" "3$3"])
::    <<
::      "  1 11 111"
::      "222 22   2"
::      "  3  3"
::    >>
::    > (columnify %center ~["1$11$111" "222$22$2" "3$3"])
::    <<
::      " 1  11 111"
::      "222 22  2 "
::      " 3  3 "
::    >>
::
++  columnify
  |=  [type=?(%left %center %right) rows=wall]
  ^-  wall
  |^  =+  split-rows=(turn rows (symbol-split '$'))
      =+  split-widths=(column-widths split-rows)
      %+  turn  split-rows
      |=  row=(list tape)
      %-  zing
      %+  join  " "
      %+  turn  (inner-zip split-widths row)
      |=(i=[@ud tape] (align type i))
  ::  +symbol-split: create gate that parses tape into symbol-split list
  ::
  ++  symbol-split
    |=  symbol=@t
    ^-  $-(tape (list tape))
    |=  text=tape
    ^-  (list tape)
    %-  skim  :_  |=(i=tape !=(i ~))
    %+  scan  text
    %+  more  (just symbol)
    %-  star
    %-  sear  :_  next
    |=(i=@t ?:(!=(i symbol) (some i) ~))
  ::  +column-widths: given a table of tapes, calculate per-column widths
  ::
  ++  column-widths
    |=  table=(list (list tape))
    ^-  (list @ud)
    %-  roll
    :-  (turn table |=(row=(list tape) (turn row lent)))
    |=  [curr=(list @ud) best=(list @ud)]
    (turn (outer-zip curr best 0) max)
  ::  +inner-zip: make list of pairs between parallel lists, dropping excess
  ::
  ::    > (inner-zip ~['a' 'b' 'c'] ~[1 2 3])
  ::    ~[['a' 1] ['b' 2] ['c' 3]]
  ::    > (inner-zip ~['a' 'b'] ~[1 2 3 4])
  ::    ~[['a' 1] ['b' 2]]
  ::    > (inner-zip ~['a' 'b' 'c' 'd'] ~[1])
  ::    ~[['a' 1]]
  ::
  ++  inner-zip
    |*  [a=(list *) b=(list *)]
    ?~  a  ~
    ?~  b  ~
    [[i.a i.b] $(a t.a, b t.b)]
  ::  +outer-zip: make list of pairs between parallel lists, defaulting absent
  ::
  ::    > (outer-zip ~[1 2 3] ~[4 5 6] 0)
  ::    ~[[1 4] [2 5] [3 6]]
  ::    > (outer-zip ~[1 2] ~[3 4 5 6] 0)
  ::    ~[[1 3] [2 4] [0 5] [0 6]]
  ::    > (outer-zip ~[1 2 3 4] ~[5] 0)
  ::    ~[[1 5] [2 0] [3 0] [4 0]]
  ::
  ++  outer-zip
    |*  [a=(list *) b=(list *) default=*]
    =>  .(a ^.(homo a), b ^.(homo b))
    |-
    ?~  a
      ?~  b
        ~
      [[default i.b] $(b t.b)]
    ?~  b
      [[i.a default] $(a t.a)]
    [[i.a i.b] $(a t.a, b t.b)]
  --
--
