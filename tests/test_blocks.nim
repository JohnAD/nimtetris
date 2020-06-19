import unittest

include nimtetrispkg/[blocks, mino]

suite "proc isOverlap":
  test "overlap returns false":
    let a = [
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
    ]
    let b = [
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
    ]
    check not a.isOverlap(b)
  test "overlap returns true":
    let a = [
      [FILLED_MINO1, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
    ]
    let b = [
      [FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, FILLED_MINO1, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
      [EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, EMPTY_MINO, ],
    ]
    check a.isOverlap(b)