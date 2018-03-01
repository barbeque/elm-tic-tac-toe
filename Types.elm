module Types exposing(..)

type Square
  = Blank -- " "
  | Nought -- "O"
  | Cross -- "X"

type alias Model =
  { isCrossTurn : Bool
  , squares : List Square
  }

type alias IndexedSquare = Square Int

type Msg
  = MarkSpot Int
  | NewGame
