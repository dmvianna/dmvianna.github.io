module Main exposing (Model, Msg(..), init, main, update, view)

-- import Html.Attributes exposing (src)

import Browser
import Element exposing (..)
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


view : Model -> Element Msg
view model =
    case model of
        Err e ->
            el [] (text "configuration error")

        Ok res ->
            column []
                [ image []
                    { src = "/favicon.svg"
                    , description = "A red circle"
                    }
                , el [] (text res.name)
                , el [] (text res.title)
                , paragraph [] [ text res.profile ]
                , el [] (text "What I am looking for")
                , paragraph [] [ text res.goal ]
                , el [] (text "What you are looking for")
                , paragraph [] [ text res.offering ]
                , el [] (text "Skills")
                , el [] (text res.skills)
                , el [] (text "Employment")
                , column [] (employment res.employment)
                , column [] (education res.education)
                ]


employment : Employment -> List (Element Msg)
employment emp =
    let
        viewJobs j =
            column []
                [ el [] (text j.job_title)
                , paragraph [] [ text j.dates ]
                , paragraph [] [ text j.department ]
                , paragraph [] [ text j.story ]
                , column []
                    [ el [] (text "Technology")
                    , row [] (List.map (\i -> el [] (text i)) j.tech)
                    ]
                , column []
                    [ el [] (text "Test Framework")
                    , row [] (List.map (\i -> el [] (text i)) j.testing)
                    ]
                ]

        viewEmployer e =
            column []
                [ el [] (text e.employer)
                , column [] (List.map viewJobs e.jobs)
                ]
    in
    List.map viewEmployer emp


education : Education -> List (Element Msg)
education edu =
    let
        viewEducation e =
            column []
                [ row [] (List.map (\d -> paragraph [] [ text <| String.fromInt d ]) e.dates)
                , el [] (text e.title)
                , paragraph [] [ text e.institution ]
                ]
    in
    List.map viewEducation edu



---- PROGRAM ----


main : Program String Model Msg
main =
    Browser.element
        { view = \model -> layout [] <| view model
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
