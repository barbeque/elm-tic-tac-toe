import Html exposing (Html, div, text, table, tr, td, p)
import Html.Attributes exposing (class)
import List exposing (indexedMap)

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
    squares = [ Blank, Blank, Blank, Blank, Blank, Blank, Blank, Blank, Blank ]
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
    [ viewBoard model.squares ]

squareToHtml : Square -> Html Msg
squareToHtml sq =
  Html.li [] [ text (squareToString sq ) ]

viewBoard : List Square -> Html Msg
viewBoard squares =
  Html.ul
    []
    (List.map squareToHtml squares)
