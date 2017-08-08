module Main exposing (..)

import Date exposing (..)
import DateTimePicker exposing (..)
import Html exposing (Html, div, node, program, text)
import Html.Attributes exposing (..)
import Material.Table exposing (..)


-- TYPES


type alias Row =
    { assignment : String
    , followUpDate : { value : Maybe Date, state : State }
    , name : String
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
            "Jacksons first assignment"
        , followUpDate = initialFollowUpDate
        }
      , { name = "Shepherd, Jacob"
        , assignment = "Jacob's first assignment"
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



-- UPDATE


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
        [ table []
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
                            , td []
                                [ DateTimePicker.datePicker DateChanged
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
                                ]
                            ]
                    )
                    rows
                )
            ]
        ]


main : Program Never (List Row) Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
