port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


port outgoing : Model -> Cmd msg


type alias Flags =
    Maybe Model


type alias Model =
    { firstName : String
    , lastName : String
    , age : Int
    }


type Msg
    = UpdateAge String
    | UpdateFirstName String
    | UpdateLastName String


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = wrapperUpdate
        , view = view
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        initialModel =
            case flags of
                Just model ->
                    model

                Nothing ->
                    Model "Alexa" "Tuskey" 13
    in
    ( initialModel
    , outgoing initialModel
    )


wrapperUpdate : Msg -> Model -> ( Model, Cmd Msg )
wrapperUpdate msg model =
    let
        newModel =
            update msg model
    in
    ( newModel
    , outgoing newModel
    )


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateAge ageStr ->
            case String.toInt ageStr of
                Just age ->
                    { model | age = age }

                Nothing ->
                    model

        UpdateFirstName name ->
            { model | firstName = name }

        UpdateLastName name ->
            { model | lastName = name }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.firstName ]
        , h3 [] [ text model.lastName ]
        , h2 [] [ text (String.fromInt model.age) ]
        , input [ onInput UpdateFirstName, value model.firstName ] []
        , input [ onInput UpdateLastName, value model.lastName ] []
        , input [ onInput UpdateAge, value (String.fromInt model.age), type_ "number" ] []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
