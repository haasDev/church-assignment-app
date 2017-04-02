module Main exposing (..)

import Html exposing (beginnerProgram, Html, text)
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
    [ { material = "Acrylic (Transparent)", quantity = "25", unitPrice = "$2.90" }
    , { material = "Plywood (Birch)", quantity = "50", unitPrice = "$1.25" }
    , { material = "Laminate (Gold on Blue)", quantity = "10", unitPrice = "$2.35" }
    ]



-- VIEW


view : Html msg
view =
    table []
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



-- UPDATE


main : Html msg
main =
    view
