module Main exposing (Model, Msg(..), init, main, update, view)

-- import Html.Attributes exposing (src)

import Browser
import Element exposing (..)
import Element.Font as Font
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


type alias WindowSize =
    { width : Int, height : Int }


type Model
    = Model (Result D.Error Resume) WindowSize


type alias Flags =
    { initJson : String, width : Int, height : Int }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { initJson, width, height } =
            flags
    in
    ( Model
        (D.decodeString resume initJson)
        (WindowSize width height)
    , Cmd.none
    )



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
        Model (Err e) _ ->
            el [] (text "configuration error")

        Model (Ok res) size ->
            column
                [ padding 20
                , width <| px (size.width - 20)
                ]
                [ textColumn
                    []
                    [ image [ alignLeft, padding 20 ]
                        { src = "/favicon.svg"
                        , description = "A red circle"
                        }
                    , column [ padding 20 ]
                        [ el [ Font.bold, padding 5, centerX ] (text res.name)
                        , el [ padding 5, centerX ] (text res.title)
                        ]
                    , paragraph [ Font.justify ] [ text res.profile ]
                    , el [] (text "What I am looking for")
                    , paragraph [ Font.justify ] [ text res.goal ]
                    , el [] (text "What you are looking for")
                    , paragraph [ Font.justify ] [ text res.offering ]
                    , el [] (text "Skills")
                    , paragraph [ Font.justify ] [ text res.skills ]
                    , el [] (text "Employment")
                    , column [] (employment res.employment)
                    , column [] (education res.education)
                    ]
                ]


employment : Employment -> List (Element Msg)
employment emp =
    let
        viewJobs j =
            column []
                [ el [] (text j.job_title)
                , paragraph [] [ text j.dates ]
                , paragraph [] [ text j.department ]
                , paragraph [ Font.justify ] [ text j.story ]
                , column []
                    [ el [] (text "Technology")
                    , row [ padding 10, spacing 10 ]
                        (List.map (\i -> el [] (text i)) j.tech)
                    ]
                , column []
                    [ el [] (text "Test Framework")
                    , row [ padding 10, spacing 10 ]
                        (List.map (\i -> el [] (text i)) j.testing)
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


main : Program Flags Model Msg
main =
    Browser.element
        { view = \model -> layout [] <| view model
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
