module Types exposing(..)

type Square
  = Blank -- " "
  | Nought -- "O"
  | Cross -- "X"

type alias Model =
  { isCrossTurn : Bool
  , squares : List Square
  , winner : Winner
  }

type Winner
  = NotYet -- Game not over yet
  | Draw   -- Game is a draw, nobody wins
  | NoughtWon
  | CrossWon

type alias IndexedSquare = Square Int

type Msg
  = MarkSpot Int
  | NewGame
