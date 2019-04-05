module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src)
import Json.Decode as D exposing (Decoder(..), field, int, list, string)


type alias Resume =
    { name : String
    , title : String
    , profile : String
    , goal : String
    , offering : String
    , skills : String
    , employment : Employment
    , education : List Course
    }


resume : Decoder Resume
resume =
    D.map8 Resume
        (field "name" string)
        (field "title" string)
        (field "profile" string)
        (field "goal" string)
        (field "offering" string)
        (field "skills" string)
        (field "employment" <| list employer)
        (field "education" <| list course)


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


type alias Education =
    List Course


type alias Course =
    { dates : List Int
    , title : String
    , institution : String
    }


course : Decoder Course
course =
    D.map3 Course
        (field "dates" <| list int)
        (field "title" string)
        (field "institution" string)



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
                [ img [ src "/favicon.svg" ] []
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
                , div [] (education res.education)
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


education : Education -> List (Html Msg)
education edu =
    let
        viewEducation e =
            div []
                [ div [] (List.map (\d -> p [] [ text <| String.fromInt d ]) e.dates)
                , h3 [] [ text e.title ]

                -- , p [] [ e.institution ]
                ]
    in
    List.map viewEducation edu



---- PROGRAM ----


main : Program String Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
