module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src)
import Json.Decode as D exposing (Decoder(..), field, list, string)


type alias Resume =
    { name : String
    , title : String
    , profile : String
    , goal : String
    , offering : String
    , skills : String
    , employment : Employment
    }


resume : Decoder Resume
resume =
    D.map7 Resume
        (field "name" string)
        (field "title" string)
        (field "profile" string)
        (field "goal" string)
        (field "offering" string)
        (field "skills" string)
        (field "employment" <| list employer)


type alias Employment =
    List Employer


type alias Employer =
    { employer : String
    , jobs : List Job
    }


employer : Decoder Employer
employer =
    D.map2 Employer
        (field "employer" string)
        (field "jobs" <| list job)


type alias Job =
    { job_title : String
    , dates : String
    , department : String
    , story : String
    , tech : List String
    , testing : List String
    }


job : Decoder Job
job =
    D.map6 Job
        (field "job_title" string)
        (field "dates" string)
        (field "department" string)
        (field "story" string)
        (field "tech" <| list string)
        (field "testing" <| list string)



---- MODEL ----


type alias Model =
    Result D.Error Resume


init : String -> ( Model, Cmd Msg )
init flags =
    ( D.decodeString resume flags, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        Err e ->
            h1 [] [ text "configuration error" ]

        Ok res ->
            div []
                [ img [ src "/logo.svg" ] []
                , h1 [] [ text res.name ]
                , h2 [] [ text res.title ]
                , p [] [ text res.profile ]
                , h2 [] [ text "What I am looking for" ]
                , p [] [ text res.goal ]
                , h2 [] [ text "What you are looking for" ]
                , p [] [ text res.offering ]
                , h2 [] [ text "Skills" ]
                , p [] [ text res.skills ]
                , h2 [] [ text "Employment" ]
                , div [] (employment res.employment)
                ]


employment : Employment -> List (Html Msg)
employment emp =
    let
        viewJobs j =
            div []
                [ h4 [] [ text j.job_title ]
                , p [] [ text j.dates ]
                , p [] [ text j.department ]
                , p [] [ text j.story ]
                , div []
                    [ h5 [] [ text "Technology" ]
                    , ul [] (List.map (\i -> li [] [ text i ]) j.tech)
                    ]
                , div []
                    [ h5 [] [ text "Test Framework" ]
                    , ul [] (List.map (\i -> li [] [ text i ]) j.testing)
                    ]
                ]

        viewEmployer e =
            div []
                [ h3 [] [ text e.employer ]
                , div [] (List.map viewJobs e.jobs)
                ]
    in
    List.map viewEmployer emp



---- PROGRAM ----


main : Program String Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
