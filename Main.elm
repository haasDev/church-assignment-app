module Main exposing (..)

import Date exposing (..)
import Html exposing (beginnerProgram, div, Html, node, text)
import Html.Attributes exposing (..)
import Material.Table exposing (..)


-- TYPES


type alias Row =
    { name : String
    , assignment : String
    , followUpDate : String
    }



-- MODEL


model : List Row
model =
    [ { name = "Reckia, Jackson", assignment = "Write your plans to have meaningful prayer and scripture study", followUpDate = "05/01/2017" }
    , { name = "Reckia, Jackson", assignment = "Write your plans to have meaningful prayer and scripture study", followUpDate = "05/01/2017" }
    , { name = "Reckia, Jackson", assignment = "Write your plans to have meaningful prayer and scripture study", followUpDate = "05/01/2017" }
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
                    [ th [] [ text "Name" ]
                    , th [] [ text "Assignment" ]
                    , th [] [ text "Follow-up Date" ]
                    ]
                ]
            , tbody []
                (model
                    |> List.map
                        (\item ->
                            tr []
                                [ td [] [ text item.name ]
                                , td [] [ text item.assignment ]
                                , td [] [ text item.followUpDate ]
                                ]
                        )
                )
            ]
        ]



-- UPDATE


main : Html msg
main =
    view
