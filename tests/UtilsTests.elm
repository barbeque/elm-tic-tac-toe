module UtilsTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Utils exposing (all, any, stringJoin, chunkify)

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
    , describe "stringJoin"
      [ test "works reasonably for a simple case" <|
          \_ -> let
                  input = ["hello", "world"]
                  separator = ", "
                in
                  Expect.equal "hello, world"
                    (stringJoin separator input)
      , test "works ok for a single word case" <|
          \_ -> let
                  input = ["hello"]
                  separator = ", "
                in
                  Expect.equal "hello"
                    (stringJoin separator input)
      , test "works on an empty list" <|
          \_ -> let
                  input = []
                  separator = ", "
                in
                  Expect.equal ""
                    (stringJoin separator input)
      , test "honours custom separators" <|
          \_ -> let
                  input = ["goodbye", "world"]
                  separator = "!!"
                in
                  Expect.equal "goodbye!!world"
                    (stringJoin separator input)
      ]
    , describe "chunkify"
      [ test "works for the 9-square case (Tic Tac Toe)" <|
          \_ -> let
                  input = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                in
                  Expect.equal [[1,2,3],[4,5,6],[7,8,9]]
                    (chunkify 3 input)
      ]
    ]
