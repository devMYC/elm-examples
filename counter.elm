import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram
    { model = model
    , update = update
    , view = view
    }



-- MODEL

type alias Model = Int

model : Model
model = 0

type Msg
  = Increment
  | Decrement
  | IncrementIfOdd
  | Reset



-- UPDATE

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    IncrementIfOdd ->
      if model % 2 == 0 then
        model
      else
        model + 1

    Reset -> 0



-- VIEW

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
            , button [ onClick Reset ] [ text "reset" ]
            ]
      ]
