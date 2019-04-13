import Browser
import Html exposing (Html, div, button, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main = Browser.sandbox { init = init, update = update, view = view }

type alias Model = { text: String}

init : Model
init = { text = "" }

type Msg = Change String

update : Msg -> Model -> Model  
update msg model =
  case msg of 
    Change newContent ->
      { model | text = newContent }

view : Model -> Html Msg
view model = 
  div [] [
    input [ placeholder "Text to reverse", value model.text, onInput Change ] [], 
    div [] [ text (String.reverse model.text)]
  ]      