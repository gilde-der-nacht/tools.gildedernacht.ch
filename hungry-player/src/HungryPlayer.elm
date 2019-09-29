module HungryPlayer exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


playerInfo : String -> String -> String -> String
playerInfo name orders paymentoptions =
    name
        ++ " hat bestellt: "
        ++ orders
        ++ " und bezahlt mit "
        ++ paymentoptions


viewPlayerInfo : Html msg
viewPlayerInfo =
    let
        playerText =
            playerInfo "Oliver" "Hawaii" "Resolut"
                |> text
    in
    h2 [] [ playerText ]


viewHeader : Html msg
viewHeader =
    h1 [] [ text "HungryPlayers" ]


viewFooter : String -> Html msg
viewFooter input =
    footer [] [ text input ]


view : Html msg
view =
    main_ []
        [ viewHeader
        , viewPlayerInfo
        , viewFooter "Footerly"
        ]


main : Html msg
main =
    view
