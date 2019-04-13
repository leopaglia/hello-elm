import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

main = Browser.sandbox { init = init, update = update, view = view }

type alias Model = { name : String, password : String, passwordAgain : String, submitted : Bool }

init : Model
init = Model "" "" "" False

type Msg 
  = Name String
  | Password String
  | PasswordAgain String
  | Submit

update : Msg -> Model -> Model
update msg model = 
  case msg of 
    Name name -> { model | name = name, submitted = False }
    Password password -> { model | password = password, submitted = False }
    PasswordAgain passwordAgain -> { model | passwordAgain = passwordAgain, submitted = False }  
    Submit -> { model | submitted = True }

view : Model -> Html Msg
view model = 
  div [] [
    viewInput "text" "Name" model.name Name,
    viewInput "password" "Password" model.password Password,
    viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain,
    if model.submitted then viewValidation model else div [] [],
    submitBtn
  ]    

viewInput : String -> String -> String -> (String -> Msg) -> Html Msg
viewInput t p v toMsg = input [ type_ t, placeholder p, value v, onInput toMsg ] [] 

viewValidation : Model -> Html Msg
viewValidation model =
  if String.length model.name == 0 then
    errorDiv "You need a name!"
  else if String.length model.password == 0 then
    errorDiv "You need a password!"
  else if String.length model.password < 8 then
    errorDiv "Password is too short!"
  else if model.password /= model.passwordAgain then
    errorDiv "Passwords do not match!"
  else 
    successDiv "OK"

successDiv : String -> Html Msg
successDiv t = div [ style "color" "green" ] [ text t ]

errorDiv : String -> Html Msg
errorDiv e = div [ style "color" "red" ] [ text e ]

submitBtn : Html Msg
submitBtn = button [ onClick Submit ] [ text "Submit" ]