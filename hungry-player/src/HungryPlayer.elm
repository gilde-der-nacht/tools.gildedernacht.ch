module HungryPlayer exposing (main)

import Browser exposing (sandbox)
import Debug
import Html exposing (..)
import Html.Attributes exposing (for, id, type_, value)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { id : Int
    , name : String
    , entries : List Entry
    }


type alias Entry =
    { id : Int
    , name : String
    , order : String
    , paymentOptions : List String
    }


initialModel : Model
initialModel =
    { id = 1
    , name = "OpenOrder"
    , entries = initialEntry
    }


initialEntry : List Entry
initialEntry =
    [ Entry 1 "Oliver" "Hawai" [ "Cash", "Revolut" ]
    , Entry 2 "Duals" "Döner" [ "Revolut" ]
    , Entry 3 "Threesly" "Vegi mit Ketchup" []
    ]



-- UPDATE


type Msg
    = Order


update : Msg -> Model -> Model
update msg model =
    case msg of
        Order ->
            { model | entries = model.entries ++ [ Entry 4 "Fourth" "Wasser und Brot" [ "Twint" ] ] }



-- VIEW


playerInfo : String -> String -> List String -> String
playerInfo name orders paymentOptions =
    name
        ++ " hat bestellt: "
        ++ orders
        ++ " und bezahlt mit "
        ++ String.join ", " paymentOptions


viewPlayerInfo : Entry -> Html Msg
viewPlayerInfo entry =
    playerInfo entry.name entry.order entry.paymentOptions
        |> text


viewHeader : Html Msg
viewHeader =
    header []
        [ h1 [] [ text "HungryPlayers" ]
        , aside []
            [ button [] [ text "Anmelden" ]
            , button [] [ text "Neue Bestellung" ]
            ]
        ]


viewFooter : String -> Html Msg
viewFooter input =
    footer []
        [ p []
            [ text input
            ]
        ]


viewEntryList : List Entry -> Html Msg
viewEntryList entries =
    let
        viewEntry entry =
            li [] [ viewPlayerInfo entry ]
    in
    ul [] (List.map viewEntry entries)


viewInputForm : Html Msg
viewInputForm =
    form []
        [ label [ for "name" ] [ text "Name" ]
        , input [ id "name" ] []
        , label [ for "order" ] [ text "Bestellung" ]
        , input [ id "order" ] []
        , label [ for "cash" ] [ text "Bargeld" ]
        , input [ type_ "checkbox", id "cash" ] []
        , label [ for "twint" ] [ text "Twint" ]
        , input [ type_ "checkbox", id "twint" ] []
        , label [ for "revolut" ] [ text "Revolut" ]
        , input [ type_ "checkbox", id "revolut" ] []
        , input [ type_ "button", value "Bestellen", onClick Order ] []
        ]


view : Model -> Html Msg
view model =
    main_ []
        [ viewHeader
        , viewEntryList model.entries
        , viewInputForm
        , div []
            [ text (Debug.toString model)
            ]
        , viewFooter "Created by Oliver"
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
