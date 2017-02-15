import Html exposing (..)
import Html.Attributes exposing (name, style, type_)
import Html.Events exposing (onClick)
import Markdown


main =
  Html.beginnerProgram
    { model = model
    , update = update
    , view = view
    }


type alias Model =
  { fontSize : FontSize
  , content : String
  }


type FontSize
  = Small
  | Medium
  | Large


intro : String
intro = """

# What is the output ?

- __Code__

```javascript
      const func = () => {
        setTimeout(() => console.log('task queue'), 0)
        Promise.resolve()
          .then(_ => console.log('job queue'))
      }

      func()
```

"""


model : Model
model = Model Medium intro


type Msg = SwitchTo FontSize


update : Msg -> Model -> Model
update msg model_ =
  case msg of
    SwitchTo newFontSize ->
      { model_ | fontSize = newFontSize }


view : Model -> Html Msg
view model_ =
  div []
    [ fieldset []
        [ radio "Small" (SwitchTo Small)
        , radio "Medium" (SwitchTo Medium)
        , radio "Large" (SwitchTo Large)
        ]
    , Markdown.toHtml [ getStyle model_.fontSize ] model_.content
    ]


radio : String -> msg -> Html msg
radio txt msg =
  label [ style [ ("padding", "20px") ] ]
    [ input [ type_ "radio", name "font-size", onClick msg ] []
    , text txt
    ]


getStyle : FontSize -> Attribute msg
getStyle fontSize_ =
  let
    size =
      case fontSize_ of
        Small ->
          "0.8em"

        Medium ->
          "1em"

        Large ->
          "1.2em"
  in
    style [ ("font-size", size) ]