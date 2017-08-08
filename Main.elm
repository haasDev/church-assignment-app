module Main exposing (..)

import Css
import Date exposing (..)
import DateTimePicker exposing (..)
import DateTimePicker.Css
import Html exposing (Html, div, node, program, text)
import Html.Attributes exposing (..)
import Material.Table exposing (..)


-- TYPES


type alias Row =
    { assignment : String
    , id : Int
    , followUpDate : { value : Maybe Date, state : State }
    , name : String
    }


type alias State =
    DateTimePicker.State



-- MSG


type Msg
    = DateChanged Int State (Maybe Date)



-- MODEL


initialFollowUpDate : { state : State, value : Maybe Date }
initialFollowUpDate =
    { value = Nothing, state = DateTimePicker.initialState }


init : ( List Row, Cmd Msg )
init =
    ( [ { id = 1
        , name = "Reckia, Jackson"
        , assignment =
            "Jacksons first assignment"
        , followUpDate = initialFollowUpDate
        }
      , { id = 2
        , name = "Shepherd, Jacob"
        , assignment = "Jacob's first assignment"
        , followUpDate = initialFollowUpDate
        }
      ]
    , Cmd.batch
        [ DateTimePicker.initialCmd (DateChanged 1) DateTimePicker.initialState
        , DateTimePicker.initialCmd (DateChanged 2) DateTimePicker.initialState
        ]
    )


displayRow : Int -> State -> Maybe Date -> Row -> Row
displayRow id state date row =
    if row.id == id then
        { row
            | followUpDate =
                { value = date
                , state = state
                }
        }
    else
        row



-- UPDATE


update : Msg -> List Row -> ( List Row, Cmd Msg )
update msg rows =
    case msg of
        DateChanged id state date ->
            let
                newRows =
                    List.map (displayRow id state date) rows
            in
            ( newRows, Cmd.none )



-- VIEW


view : List Row -> Html Msg
view rows =
    let
        { css } =
            Css.compile [ DateTimePicker.Css.css ]
    in
    div []
        [ Html.node "style" [] [ Html.text css ]
        , div
            [ style [ ( "margin", "50px auto" ), ( "max-width", "50%" ) ] ]
            [ table []
                [ thead []
                    [ tr []
                        [ th [] [ text "Name" ]
                        , th [] [ text "Assignment" ]
                        , th [] [ text "Follow-up Date" ]
                        ]
                    ]
                , tbody [] (List.map getRow rows)
                ]
            ]
        ]


getRow : Row -> Html Msg
getRow row =
    tr
        []
        [ td [] [ text row.name ]
        , td [] [ text row.assignment ]
        , td []
            [ DateTimePicker.datePicker (DateChanged row.id)
                []
                row.followUpDate.state
                row.followUpDate.value
            ]
        ]



-- MAIN


main : Program Never (List Row) Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
