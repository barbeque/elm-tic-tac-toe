module UtilsTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Utils exposing (all, any)

suite : Test
suite =
  describe "Utils module"
    [ describe "all"
      [ test "works properly for all true" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x >= 5)
                in
                  Expect.equal True (all f input)
      , test "works properly for some false" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x > 5)
                in
                  Expect.equal False (all f input)
      , test "works properly for all false" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x < 5)
                in
                  Expect.equal False (all f input)
      ]
    , describe "any"
      [ test "works properly for all true" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x >= 5)
                in
                  Expect.equal True (any f input)
      , test "works properly for all false" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x < 5)
                in
                  Expect.equal False (any f input)
      , test "works properly for any true" <|
          \_ -> let
                  input = [5, 10, 15]
                  f = (\x -> x == 10)
                in
                  Expect.equal True (any f input)
      ]
    ]