import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Task exposing (..)
import Time exposing (..)


main =
  program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }


type alias Model = Time


init : ( Model, Cmd Msg )
init = ( 0, perform Tick now )


type Msg
  = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Tick timeNow ->
      ( timeNow, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
  every second Tick


view : Model -> Html Msg
view model =
  let
    angle
      = turns ( model |> inMinutes )

    secHandX = toString ( 50 + 40 * cos angle )
    secHandY = toString ( 50 + 40 * sin angle )

  in
    svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 secHandX, y2 secHandY, stroke "#000000" ] []
      ]