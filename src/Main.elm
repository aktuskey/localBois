module Main exposing (main)

import Browser
import Html exposing (..)


type alias Flags =
    ()


type alias Model =
    { name : String
    , age : Int
    }


type Msg
    = UpdateAge Int
    | UpdateName String


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model "Alexa" 13, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        UpdateAge age ->
            { model | age = age }

        UpdateName name ->
            { model | name = name }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.name ]
        , h2 [] [ text (String.fromInt model.age) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
