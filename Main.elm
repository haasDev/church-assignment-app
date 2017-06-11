module Main exposing (..)

import Date exposing (..)
import DateTimePicker exposing (..)
import Html exposing (program, div, Html, node, text)
import Html.Attributes exposing (..)
import Material.Table exposing (..)


-- TYPES


type alias Row =
    { name : String
    , assignment : String
    , followUpDate : { value : Maybe Date, state : State }
    }


type alias State =
    DateTimePicker.State



-- MSG


type Msg
    = DateChanged State (Maybe Date)



-- MODEL


initialFollowUpDate : { state : State, value : Maybe Date }
initialFollowUpDate =
    { value = Nothing, state = DateTimePicker.initialState }


init : ( List Row, Cmd Msg )
init =
    ( [ { name = "Reckia, Jackson"
        , assignment =
            "Write your plans to have meaningful prayer and scripture study"
        , followUpDate = initialFollowUpDate
        }
      , { name = "Shepherd, Jacob"
        , assignment = "Shadow someone in your desired occupation"
        , followUpDate = initialFollowUpDate
        }
      ]
    , DateTimePicker.initialCmd DateChanged DateTimePicker.initialState
    )


displayRow : State -> Maybe Date -> Row -> Row
displayRow state date row =
    { row
        | followUpDate =
            { value = date
            , state = state
            }
    }


update : Msg -> List Row -> ( List Row, Cmd Msg )
update msg rows =
    case msg of
        DateChanged state date ->
            let
                newRows =
                    List.map (displayRow state date) rows
            in
                ( newRows, Cmd.none )



-- VIEW


view : List Row -> Html Msg
view rows =
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
        , DateTimePicker.datePicker
            DateChanged
            []
            (case List.head rows of
                Nothing ->
                    initialFollowUpDate.state

                Just val ->
                    val.followUpDate.state
            )
            (case List.head rows of
                Nothing ->
                    initialFollowUpDate.value

                Just val ->
                    val.followUpDate.value
            )
        , table []
            [ thead []
                [ tr []
                    [ th [] [ text "Name" ]
                    , th [] [ text "Assignment" ]
                    , th [] [ text "Follow-up Date" ]
                    ]
                ]
            , tbody []
                (List.map
                    (\row ->
                        tr
                            []
                            [ td [] [ text row.name ]
                            , td [] [ text row.assignment ]
                            , td [] [ text (toString row.followUpDate.value) ]
                            ]
                    )
                    rows
                )
            ]
        ]



-- UPDATE


main : Program Never (List Row) Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
