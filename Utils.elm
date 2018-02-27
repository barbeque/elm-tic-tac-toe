module Utils exposing (..)

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
