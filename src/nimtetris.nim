import os, threadpool, locks
from terminal import eraseScreen
import illwill
import nimtetrispkg/game

var
  thr: array[2, Thread[int]]
  L: Lock

proc exitProc() {.noconv.} =
  ## 終了処理
  eraseScreen()
  illwillDeinit()
  showCursor()

var gameobj = newGame()

proc waitKeyInput(n: int) {.thread.} =
  while true:
    acquire(L)
    {.gcsafe.}:
      var key = getKey()
      case key
      of Key.None: discard
      of Key.Escape:
        gameobj.stop()
        release(L)
        break
      of Key.U, Key.Q:
        gameobj.rotateLeft()
      of Key.O, Key.E:
        gameobj.rotateRight()
      of Key.J, Key.S:
        gameobj.moveDown()
      of Key.H, Key.A:
        gameobj.moveLeft()
      of Key.L, Key.D:
        gameobj.moveRight()
      of Key.Space, Key.Enter:
        gameobj.moveDownToBottom()
      else: discard
    release(L)
    sleep 10

proc startMinoDownClock(n: int) {.thread.} =
  while true:
    acquire(L)
    {.gcsafe.}:
      if gameobj.isStopped:
        release(L)
        break
      if gameobj.canMoveDown():
        gameobj.moveDown()
      else:
        gameobj.setCurrentMino()
        gameobj.setRandomMino()
      gameobj.deleteFilledRows()
    release(L)
    sleep 1000

proc main(): int =
  illwillInit(fullscreen=true)
  setControlCHook(exitProc)
  hideCursor()

  initLock(L)

  createThread(thr[0], waitKeyInput, 0)
  createThread(thr[1], startMinoDownClock, 0)
  while not gameobj.isStopped:
    gameobj.redraw()
    sleep(100)
  joinThreads(thr)
  sync()
  exitProc()

when isMainModule and not defined modeTest:
  quit main()
