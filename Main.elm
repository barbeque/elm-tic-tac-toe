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
