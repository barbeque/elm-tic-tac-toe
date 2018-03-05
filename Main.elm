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

init : ( Model, Cmd Msg )
init =
  let newModel =
    { isCrossTurn = True,
      squares = [
        Blank, Blank, Blank,
        Blank, Blank, Blank,
        Blank, Blank, Blank ],
      winner = NotYet
    }
  in
    newModel ! []

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    NewGame -> init
    MarkSpot n ->
      if model.winner /= NotYet then
        model ! [] -- can't move if we're done playing
      else if wasAlreadyMarked n model.squares then
        model ! []
      else
        let result =
          {
            squares = marked model.isCrossTurn n model.squares,
            isCrossTurn = not model.isCrossTurn,
            winner = model.winner -- there must be a shorthand for this
          }
        in
          if whoWon result.squares /= NotYet then
            -- this move won/tied the game!
            let theWinner = whoWon result.squares
            in { result | winner = theWinner } ! []
          else
            result ! [] -- the game continues

whoWon : List Square -> Winner
whoWon squares =
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
    -- case 0: top row all same (0, 1, 2)
    (if (threeInARow a0 a1 a2) then a0
    -- case 1: mid row all same (3, 4, 5)
    else if (threeInARow a3 a4 a5) then a3
    -- case 2: btm row all same (6, 7, 8)
    else if (threeInARow a6 a7 a8) then a6
    -- case 3: diagonal top left -> bottom right (0, 4, 8)
    else if (threeInARow a0 a4 a8) then a0
    -- case 4: diagonal top right -> bottom left (2, 4, 6)
    else if (threeInARow a2 a4 a6) then a2
    -- case 5: left column all same (0, 3, 6)
    else if (threeInARow a0 a3 a6) then a0
    -- case 6: mid column all same (1, 4, 7)
    else if (threeInARow a1 a4 a7) then a1
    -- case 7: right column all same (2, 5, 8)
    else if (threeInARow a2 a5 a8) then a2
    else
      Blank -- Either nobody won yet, or nobody won period
    )
      |> (\winner ->
            case winner of
              Nought -> NoughtWon
              Cross -> CrossWon
              _ ->
                if (all (\x -> x /= Blank) squares) then
                  Draw
                else
                  NotYet
         )

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
