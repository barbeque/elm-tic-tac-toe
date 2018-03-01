import List exposing (indexedMap)
import Array exposing (fromList, get)

import Html exposing(program)
import Utils exposing (..)
import Views exposing(..)
import Types exposing(..)

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

squareToString : Square -> String
squareToString sq =
  case sq of
    Blank -> " "
    Nought -> "O"
    Cross -> "X"

newModel =
  { isCrossTurn = True,
    squares = [
      Blank, Blank, Blank,
      Blank, Blank, Blank,
      Blank, Blank, Blank ]
  }

init : ( Model, Cmd Msg )
init =
  newModel ! []

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NewGame -> init
    MarkSpot n ->
      if wasAlreadyMarked n model.squares then
        model ! []
      else
        -- TODO: Detect winning/conclusion
        {
          squares = marked model.isCrossTurn n model.squares,
          isCrossTurn = not model.isCrossTurn
        } ! []

whoWon : List Square -> Square
whoWon squares =
  -- case 0: top row all same (0, 1, 2)
  -- case 1: mid row all same (3, 4, 5)
  -- case 2: btm row all same (6, 7, 8)
  -- case 3: diagonal top left -> bottom right (0, 4, 8)
  -- case 4: diagonal top right -> bottom left (2, 4, 6)
  -- case 5: left column all same (0, 3, 6)
  -- case 6: mid column all same (1, 4, 7)
  -- case 7: right column all same (2, 5, 8)
  let
    a0 = forceGet 0 squares
    a1 = forceGet 1 squares
    a2 = forceGet 2 squares
    a3 = forceGet 3 squares
    a4 = forceGet 4 squares
    a5 = forceGet 5 squares
    a6 = forceGet 6 squares
    a7 = forceGet 7 squares
    a8 = forceGet 8 squares
    -- FIXME: wow this is ugly, there HAS to be a shorter way
  in
    if (threeInARow a0 a1 a2) then a0
    else if (threeInARow a3 a4 a5) then a3
    else if (threeInARow a6 a7 a8) then a3
    else
      Blank -- Not handled yet

threeInARow : Square -> Square -> Square -> Bool
threeInARow a b c =
  (a /= Blank) && (a == b) && (b == c)

wasAlreadyMarked : Int -> List Square -> Bool
wasAlreadyMarked target squares =
  let
    this =
      Array.fromList squares |> Array.get target
  in
    case this of
      Just Blank -> False
      _ -> True

marked : Bool -> Int -> List Square -> List Square
marked isCrossTurn whichSquare squares =
  let newSquare =
    if isCrossTurn then Cross else Nought
  in
    List.indexedMap
      (\i sq -> if whichSquare == i then newSquare else sq)
      squares
