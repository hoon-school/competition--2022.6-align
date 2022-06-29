::
::  A library for taking text and breaking it into a number of aligned columns
::
::    Text can be aligned either %left %center or %right. Text input must be a wall for which
::    each element is a tape with spaces represented by a $ buc character. There may or may not
::    be a $ buc at the end of a line, which should not be parsed as a space. Whitespace is 
::    appended to the end of each line to allow line sizes to match up and therefore columns
::    to be aligned. The tests have been modified to accomodate this whitespace.
::
/+  *titling
|%
::  columnify: the main column-making function
::
++  columnify
  |=  [tag=?(%left %center %right) input=wall]
  ^-  wall
  ::  'process' the input which turns each text line into a list of words along with possible
  ::  empty words to make the column numbers match
  ::
  =+  processed-input=(process input)
  ::  get a list of the maximum length of word in each column
  ::
  =+  max-lengths-list=(max-lengths processed-input)
  |-
    ::  if the input is empty, end recursion
    ::
    ?~  processed-input
      ~
    ::  several steps are occuring here:
    ::
    ::    The head of the processed input (which is a list of words in a line) is mapped 
    ::    against max-lengths-list, which contains the information of how wide each column
    ::    should be. The durn gate takes corresponding pairs in two lists and maps them with
    ::    a gate that takes two arguments to create an output list. In this case the gate is
    ::    our align function from the titling library, which correctly aligns the text in its
    ::    column. Then spaces are added and the list is welded together. The result is one 
    ::    line of correctly aligned text.
    ::
    [i=(reel (join " " (durn max-lengths-list i.processed-input (cury align tag))) |:([a="" b=""] (weld a b))) t=$(processed-input t.processed-input)]
::  process: takes the raw input and turns it into a list of words, with possible empty words to balance columns
::
++  process
  |=  input=wall
  ^-  (list wall)
  ::  mid-process is lists of words, but no empty words (so possibly non-matching numbers of columns)
  ::
  =+  mid-process=(turn input process-row)
  ::  maxwidth stores the length of the line with most words
  ::
  =+  maxwidth=(roll (turn mid-process lent) max)
  ::  add the empty words to balance columns
  ::
  (turn mid-process (curr extend-line maxwidth))
::  process-row: processes one row of text separated by $ buc and turns it into a list of words
::
++  process-row
  |=  input=tape
  ^-  (list tape)
  :: face to store the words we parse and add to the list
  ::
  =/  word  *tape
  |-
    ::  if input is null, output the current word and end recursion
    ::
    ?~  input
      [i=(flop word) t=~]
    ::  if we are parsing a $ buc
    ::
    ?:  =(i.input '$')
      ::  check if we are at the end of the line
      ::
      ?~  t.input
        ::  if so output the current word and end recursion
        ::
        [i=(flop word) t=~]
      ::  otherwise add the current word to the list, reset the word to empty,
      ::  and keep parsing
      ::
      [i=(flop word) t=$(word *tape, input t.input)]
    ::  otherwise add the current character to the word and keep parsing
    ::
    $(word [i.input word], input t.input)
::  extend-line:  adds a number of empty words to a list of words to make the length match a desired length
::
++  extend-line
  ::  input is a list of tapes and a desired length
  ::
  |=  [input=(list tape) length=@ud]
  ^-  (list tape)
  ::  the desired length cannot be shorter than the list's length
  ::
  ?:  (gth (lent input) length)
    !!
  ::  add appropriate number of empty words
  ::
  (weld input (reap (sub length (lent input)) ""))
::  max-lengths:  given a list of lists of words (list wall), we return a list which
::  contains in each corresponding entry the greatest length of a word over all lists.
::  this gate makes it easy to normalize each column.
::
++  max-lengths
  |=  input=(list wall)
  ^-  (list @ud)
  ::  rowlength stores how long each list is (they should all be the same length)
  ::
  =+  rowlength=(lent (snag 0 input))
  ::  initialize the result to all 0s
  ::
  =/  max-lengths-list  (reap rowlength 0)
  |-
    ::  if the input is null, return result
    ::
    ?~  input
      max-lengths-list
    ::  for each line of the input, we use turn to transform it into a list of lengths.
    ::  then we use durn to element-wise compare the list of lengths to our max-lengths-list,
    ::  and update the entry of max-lengths-list if we have found a larger one.
    ::
    $(max-lengths-list (durn max-lengths-list (turn i.input lent) max), input t.input)
::  duo version of turn
::
::    Takes two lists of equal size and a gate, returns the list of the gate called on each pair of elements.
::    Code is copied and modified from ++turn in hoon.hoon
::
++  durn
  |*  [a=(list) b=(list) c=gate]
  ::  homogenize the types in both lists
  ::
  =>  .(a (homo a))
  =>  .(b (homo b))
  ::  enforce the output type. we compute the type of the result of calling
  ::  gate c on the first element of a and b, a list of that is our output type.
  ::
  ^-  (list _?>(&(?=(^ a) ?=(^ b)) (c i.a i.b)))
  |-
    ::  end recursion if either list is empty
    ::
    ?~  a  
      ~
    ?~  b
      ~
    :: otherwise compute the result of the gate on the element of a and of b, then recurse
    ::
    [i=(c i.a i.b) t=$(a t.a, b t.b)]
--
