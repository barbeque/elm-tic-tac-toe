module Utils exposing (..)
import Array exposing (fromList, get)

chunkify : Int -> List a -> List (List a)
chunkify size list =
  case List.take size list of
    [] -> []
    listHead -> listHead :: chunkify size (List.drop size list)

stringJoin : String -> List String -> String
stringJoin separator list =
  List.foldr
    (\left right ->
      left ++ if right == "" then right else (separator ++ right)
    ) "" list

any : (a -> Bool) -> List a -> Bool
any f stuff =
  let results =
    List.map f stuff
  in
    List.foldr
      (\left right -> if left then left else right )
      False results

-- TODO: This MUST exist in the stdlib somewhere
withIndex : List a -> List (a, Int)
withIndex stuff =
  List.indexedMap (\i e -> (e, i)) stuff

forceGet : Int -> List a -> a
forceGet i stuff =
  let maybeValue =
    stuff
      |> fromList
      |> get i
  in
    case maybeValue of
      Just y -> y
      -- Since the array is fixed-size this should never
      -- ever happen...
      Nothing -> Debug.crash "error: fromJust nothing!"
