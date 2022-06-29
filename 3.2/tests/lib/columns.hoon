/+  *test, *columns
|%
++  sample-1  ~["Given$a$text$file$of$many$lines,$where$fields$within$a$line$"]
++  sample-2  ~["Given$a$text$file$of$many$lines,$where$fields$within$a$line$" "are$delineated$by$a$single$'dollar'$character,$write$a$program"]
++  sample-3  ~["'Twas$brillig$and$the$slithy$toves" "Did$gyre$and$gimble$in$the$wabe;" "All$mimsy$were$the$borogoves," "And$the$mome$raths$outgrabe."]
++  sample-4  ~["Given$a$text$file$of$many$lines,$where$fields$within$a$line$" "are$delineated$by$a$single$'dollar'$character,$write$a$program" "that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$" "column$are$separated$by$at$least$one$space." "Further,$allow$for$each$word$in$a$column$to$be$either$left$" "justified,$right$justified,$or$center$justified$within$its$column."]
++  test-align-left
  ;:  weld
  %+  expect-eq
    !>  ~["Given a text file of many lines, where fields within a line"]
    !>  (columnify %left sample-1)
  %+  expect-eq
    !>  ~["Given a          text file of     many     lines,     where fields within  a line" "are   delineated by   a    single 'dollar' character, write a      program"]
    !>  (columnify %left sample-2)
  %+  expect-eq
    !>  ~["'Twas brillig and  the    slithy     toves" "Did   gyre    and  gimble in         the   wabe;" "All   mimsy   were the    borogoves," "And   the     mome raths  outgrabe."]
    !>  (columnify %left sample-3)
  %+  expect-eq
    !>  ~["Given      a          text       file   of     many      lines,     where    fields  within  a      line" "are        delineated by         a      single 'dollar'  character, write    a       program" "that       aligns     each       column of     fields    by         ensuring that    words   in     each" "column     are        separated  by     at     least     one        space." "Further,   allow      for        each   word   in        a          column   to      be      either left" "justified, right      justified, or     center justified within     its      column."]
    !>  (columnify %left sample-4)
  ==
++  test-align-center
  ;:  weld
  %+  expect-eq
    !>  ~["Given a text file of many lines, where fields within a line"]
    !>  (columnify %center sample-1)
  %+  expect-eq
    !>  ~["Given     a      text file   of     many     lines,   where fields within  a line" " are  delineated  by   a   single 'dollar' character, write   a    program"]
    !>  (columnify %center sample-2)
  %+  expect-eq
    !>  ~["'Twas brillig and   the     slithy   toves" " Did   gyre   and  gimble     in      the  wabe;" " All   mimsy  were  the   borogoves," " And    the   mome raths  outgrabe."]
    !>  (columnify %center sample-3)
  %+  expect-eq
    !>  ~["  Given        a         text     file    of     many      lines,    where   fields  within    a    line" "   are     delineated     by       a    single 'dollar'  character,  write      a    program" "   that      aligns      each    column   of    fields       by     ensuring  that    words    in   each" "  column      are     separated    by     at     least      one      space." " Further,    allow       for      each   word     in         a       column    to      be    either left" "justified,   right    justified,   or   center justified   within     its    column."]
    !>  (columnify %center sample-4)
  ==
++  test-align-right
  ;:  weld
  %+  expect-eq
    !>  ~["Given a text file of many lines, where fields within a line"]
    !>  (columnify %right sample-1)
  %+  expect-eq
    !>  ~["Given          a text file     of     many     lines, where fields  within a line" "  are delineated   by    a single 'dollar' character, write      a program"]
    !>  (columnify %right sample-2)
  %+  expect-eq
    !>  ~["'Twas brillig  and    the     slithy toves" "  Did    gyre  and gimble         in   the wabe;" "  All   mimsy were    the borogoves," "  And     the mome  raths  outgrabe."]
    !>  (columnify %right sample-3)
  %+  expect-eq
    !>  ~["     Given          a       text   file     of      many     lines,    where  fields  within      a line" "       are delineated         by      a single  'dollar' character,    write       a program" "      that     aligns       each column     of    fields         by ensuring    that   words     in each" "    column        are  separated     by     at     least        one   space." "  Further,      allow        for   each   word        in          a   column      to      be either left" "justified,      right justified,     or center justified     within      its column."]
    !>  (columnify %right sample-4)
  ==
--

