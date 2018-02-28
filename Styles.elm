module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing(style)

squareStyle : Html.Attribute msg
squareStyle =
  style
    [ ("border", "1px solid black")
    , ("width", "75px")
    , ("height", "75px")
    , ("display", "inline-block")
    , ("vertical-align", "top")
    , ("text-align", "center")
    , ("margin", "1px")
    , ("font-size", "70px"  )
    ]
