module Main exposing (..)

import Html exposing (..)


-- MODEL
-- VIEW
view =
  Table.table []
[ Table.thead []
  [ Table.tr []
    [ Table.th [] [ text "Material" ]
    , Table.th [ ] [ text "Quantity" ]
    , Table.th [ ] [ text "Unit Price" ]
    ]
  ]
, Table.tbody []
    (data |> List.map (\item ->
       Table.tr []
         [ Table.td [] [ text item.material ]
         , Table.td [ Table.numeric ] [ text item.quantity ]
         , Table.td [ Table.numeric ] [ text item.unitPrice ]
         ]
       )
    )
]
-- UPDATE


main : Html msg
main =
    beginnerProgram
        { model = model
        , view = view
        , update = update
        }
