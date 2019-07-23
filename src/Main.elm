module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


type alias Flags =
    ()


type alias Model =
    { name : String
    , age : Int
    }


type Msg
    = UpdateAge String
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
init _ =
    ( Model "Alexa" 13, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( case msg of
        UpdateAge ageStr ->
            case String.toInt ageStr of
                Just age -> 
                    { model | age = age }
                Nothing -> 
                    model

        UpdateName name ->
            { model | name = name }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text model.name ]
        , h2 [] [ text (String.fromInt model.age) ]
        , input [ onInput UpdateName, value model.name ] []
        , input [ onInput UpdateAge, value (String.fromInt model.age), type_ "number" ] []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
