/+  *test, *titling
|%
++  test-align-left
  ;:  weld
  %+  expect-eq
    !>  "h   "
    !>  (align %left 4 "h")
  %+  expect-eq
    !>  "hello     "
    !>  (align %left 10 "hello")
  %+  expect-eq
    !>  "Hello Mars! "
    !>  (align %left 12 "Hello Mars!")
  %+  expect-eq
    !>  "Hello Mars!                                                                     "
    !>  (align %left 80 "Hello Mars!")
  %-  expect-fail
    |.  (align %left 4 "hello")
  ==
++  test-align-center
  ;:  weld
  %+  expect-eq
    !>  " h  "
    !>  (align %center 4 "h")
  %+  expect-eq
    !>  "  hello   "
    !>  (align %center 10 "hello")
  %+  expect-eq
    !>  "Hello Mars! "
    !>  (align %center 12 "Hello Mars!")
  %+  expect-eq
    !>  " Hello Mars! "
    !>  (align %center 13 "Hello Mars!")
  %+  expect-eq
    !>  "                                  Hello Mars!                                   "
    !>  (align %center 80 "Hello Mars!")
  %-  expect-fail
    |.  (align %center 3 "hello")
  ==
++  test-align-right
  ;:  weld
  %+  expect-eq
    !>  "   h"
    !>  (align %right 4 "h")
  %+  expect-eq
    !>  "     hello"
    !>  (align %right 10 "hello")
  %+  expect-eq
    !>  " Hello Mars!"
    !>  (align %right 12 "Hello Mars!")
  %+  expect-eq
    !>  "  Hello Mars!"
    !>  (align %right 13 "Hello Mars!")
  %+  expect-eq
    !>  "                                                                     Hello Mars!"
    !>  (align %right 80 "Hello Mars!")
  %-  expect-fail
    |.  (align %right 3 "hello")
  ==
++  test-box-single
  ;:  weld
  %+  expect-eq
    !>  `wall`~["┌─────────┐" "│U R B I T│" "└─────────┘"]
    !>  (box-single 0 "U R B I T")
  %+  expect-eq
    !>  `wall`~["┌────────────────┐" "│Welcome to Mars!│" "└────────────────┘"]
    !>  (box-single 0 "Welcome to Mars!")
  %+  expect-eq
    !>  `wall`~["┌───────────┐" "│           │" "│ U R B I T │" "│           │" "└───────────┘"]
    !>  (box-single 1 "U R B I T")
  %+  expect-eq
    !>  `wall`~["┌────────┐" "│        │" "│        │" "│  Mars  │" "│        │" "│        │" "└────────┘"]
    !>  (box-single 2 "Mars")
  %+  expect-eq
    !>  `wall`~["┌────────────────┐" "│                │" "│                │" "│      Mars      │" "│                │" "│                │" "└────────────────┘"]
    !>  (box-single 2 (align %center 12 "Mars"))
  ==
++  test-box-double
  ;:  weld
  %+  expect-eq
    !>  `wall`~["╔═════════╗" "║U R B I T║" "╚═════════╝"]
    !>  (box-double 0 "U R B I T")
  %+  expect-eq
    !>  `wall`~["╔════════════════╗" "║Welcome to Mars!║" "╚════════════════╝"]
    !>  (box-double 0 "Welcome to Mars!")
  %+  expect-eq
    !>  `wall`~["╔═══════════╗" "║           ║" "║ U R B I T ║" "║           ║" "╚═══════════╝"]
    !>  (box-double 1 "U R B I T")
  %+  expect-eq
    !>  `wall`~["╔════════╗" "║        ║" "║        ║" "║  Mars  ║" "║        ║" "║        ║" "╚════════╝"]
    !>  (box-double 2 "Mars")
  %+  expect-eq
    !>  `wall`~["╔════════════════╗" "║                ║" "║                ║" "║      Mars      ║" "║                ║" "║                ║" "╚════════════════╝"]
    !>  (box-double 2 (align %center 12 "Mars"))
  ==
++  test-box-symbol
  ;:  weld
  %+  expect-eq
    !>  `wall`~["***********" "*U R B I T*" "***********"]
    !>  (box-symbol '*' 0 "U R B I T")
  %+  expect-eq
    !>  `wall`~["******************" "*Welcome to Mars!*" "******************"]
    !>  (box-symbol '*' 0 "Welcome to Mars!")
  %+  expect-eq
    !>  `wall`~["*************" "*           *" "* U R B I T *" "*           *" "*************"]
    !>  (box-symbol '*' 1 "U R B I T")
  %+  expect-eq
    !>  `wall`~["**********" "*        *" "*        *" "*  Mars  *" "*        *" "*        *" "**********"]
    !>  (box-symbol '*' 2 "Mars")
  %+  expect-eq
    !>  `wall`~["******************" "*                *" "*                *" "*      Mars      *" "*                *" "*                *" "******************"]
    !>  (box-symbol '*' 2 (align %center 12 "Mars"))
  ==
--

