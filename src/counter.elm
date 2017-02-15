import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Process exposing (..)
import Task exposing (..)
import Time exposing (..)

main =
  program
    { init = init
    , update = update
    , view = view
    , subscriptions = always Sub.none
    }


type alias Model = Int

initialModel : Model
initialModel = 0

type Msg
  = Increment
  | Decrement
  | IncrementIfOdd
  | Reset
  | IncrementAsync


init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )


asyncIncrement : Cmd Msg
asyncIncrement =
  sleep second
  |> perform (\_ -> Increment)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Increment ->
      ( model + 1, Cmd.none )

    Decrement ->
      ( model - 1, Cmd.none )

    IncrementIfOdd ->
      if model % 2 == 0 then
        ( model, Cmd.none )
      else
        ( model + 1, Cmd.none )

    Reset -> ( 0, Cmd.none )

    IncrementAsync -> ( model, asyncIncrement )


containerStyle : Attribute Msg
containerStyle =
  style
    [ ("margin-left", "20px") ]

headerStyle : Attribute Msg
headerStyle =
  style
    [ ("color", "red")
    , ("font-family", "Consolas")
    , ("font-size", "10em")
    , ("font-weight", "bold")
    ]



view : Model -> Html Msg
view model =
  div [ containerStyle ]
    [ h1 [ headerStyle ] [ text (toString model) ]
    , div [ containerStyle ]
        [ button [ onClick Increment ] [ text "+" ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick IncrementIfOdd ] [ text "+ if odd" ]
        , button [ onClick IncrementAsync ] [ text "+ async" ]
        , button [ onClick Reset ] [ text "reset" ]
        ]
    ]