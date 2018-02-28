import Html exposing (Html, div, text, table, tr, td, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
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
update msg model =
  case msg of
    NewGame -> init
    MarkSpot n ->
      -- TODO: Detect winning/conclusion
      {
        squares = marked model.isCrossTurn n model.squares,
        isCrossTurn = not model.isCrossTurn
      } ! []

marked : Bool -> Int -> List Square -> List Square
marked isCrossTurn whichSquare squares =
  let newSquare =
    if isCrossTurn then Cross else Nought
  in
    List.indexedMap
      (\i sq -> if whichSquare == i then newSquare else sq)
      squares

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
    [
      div
        [ class "tictactoe-row" ]
        (List.map viewSquare squares ++ [Html.br [][]])
    ]

viewSquare : Square -> Html Msg
viewSquare sq =
  div
    [
      class "tictactoe-square"
    ]
    [
      text (
        case sq of
          Blank -> " "
          Nought -> "O"
          Cross -> "X"
      )
    ]

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
