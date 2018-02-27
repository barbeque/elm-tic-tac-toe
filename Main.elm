import Html exposing (Html, div, text, table, tr, td, p)
import Html.Attributes exposing (class)
import List exposing (indexedMap)
import Utils exposing (..)

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

type Square
  = Blank -- " "
  | Nought -- "O"
  | Cross -- "X"

squareToString : Square -> String
squareToString sq =
  case sq of
    Blank -> " "
    Nought -> "O"
    Cross -> "X"

type alias Model =
  { isCrossTurn : Bool
  , squares : List Square
  }

type Msg
  = MarkSpot Int
  | NewGame

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
update msg model = model ! [] -- TODO: more shit

view : Model -> Html Msg
view model =
  div
    [ class "tictactoe-wrapper" ]
    [ viewBoard model.squares
    , viewFooter model ]

viewFooter : Model -> Html Msg
viewFooter m =
  div [ class
    (if m.isCrossTurn then "cross-turn" else "nought-turn" )
      ]
      [ text (
        if m.isCrossTurn then "It's X's turn" else "It's O's turn"
      )]

viewRow : List Square -> Html Msg
viewRow squares =
  Html.li
    []
    [ text (stringJoin ", " (List.map squareToString squares)) ]

viewBoard : List Square -> Html Msg
viewBoard squares =
  let
    rows = chunkify 3 squares
  in
    Html.ul
      []
      (List.map viewRow rows)

-- TODO: How to bind events to a click?
-- TODO: Update should do something
