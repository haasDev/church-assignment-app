module Main exposing (..)

import Html exposing (beginnerProgram, div, Html, node, text)
import Html.Attributes exposing (..)
import Material.Table exposing (..)


-- TYPES


type alias Row =
    { material : String
    , quantity : String
    , unitPrice : String
    }



-- MODEL


model : List Row
model =
    [ { material = "Acrylic (Transparent)", quantity = "26", unitPrice = "$2.90" }
    , { material = "Plywood (Birch)", quantity = "50", unitPrice = "$1.25" }
    , { material = "Laminate (Gold on Blue)", quantity = "10", unitPrice = "$2.35" }
    ]



-- VIEW


view : Html msg
view =
    div [ style [ ( "margin", "50px auto" ), ( "max-width", "50%" ) ] ]
        [ node "link"
            [ rel "stylesheet"
            , href
                "https://fonts.googleapis.com/icon?family=Material+Icons"
            ]
            []
        , node "link"
            [ rel "stylesheet"
            , href
                "https://code.getmdl.io/1.3.0/material.indigo-pink.min.css"
            ]
            []
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Material" ]
                    , th [] [ text "Quantity" ]
                    , th [] [ text "Unit Price" ]
                    ]
                ]
            , tbody []
                (model
                    |> List.map
                        (\item ->
                            tr []
                                [ td [] [ text item.material ]
                                , td [ numeric ] [ text item.quantity ]
                                , td [ numeric ] [ text item.unitPrice ]
                                ]
                        )
                )
            ]
        ]



-- UPDATE


main : Html msg
main =
    view
