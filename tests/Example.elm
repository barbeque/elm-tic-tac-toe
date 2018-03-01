module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Types exposing (..)
import Main exposing (threeInARow)

suite : Test
suite =
  describe "threeInARow"
    [ test "returns true for X, X, X" <|
        \_ -> threeInARow Cross Cross Cross
                |> Expect.equal True
    , test "returns true for O, O, O" <|
        \_ -> threeInARow Nought Nought Nought
                |> Expect.equal True
    , test "returns false for X, O, X" <|
        \_ -> threeInARow Cross Nought Cross
                |> Expect.equal False
    , test "returns false for Blank, Blank, Blank" <|
        \_ -> threeInARow Blank Blank Blank
                |> Expect.equal False
    ]
