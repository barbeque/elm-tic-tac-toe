module Views exposing(view)

import Html exposing (Html, div, span, text, table, tr, td, p)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)

import Utils exposing(..)
import Styles exposing(..)
import Types exposing(..)

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

viewRow : List (Square, Int) -> Html Msg
viewRow squares =
  div
    [ class "tictactoe-row" ]
    (List.map viewSquare squares ++ [Html.br [][]])

viewSquare : (Square, Int) -> Html Msg
viewSquare (sq, i) =
  squareHoverStyle div
    [
      class "tictactoe-square",
      squareStyle,
      onClick (MarkSpot i)
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
    rows =
      squares
        |> withIndex
        |> chunkify 3
  in
    Html.div
      []
      (List.map viewRow rows)
