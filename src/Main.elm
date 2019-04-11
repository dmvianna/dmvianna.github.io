module Main exposing (Model, Msg(..), init, main, update, view)

-- import Html.Attributes exposing (src)

import Browser
import Element exposing (..)
import Element.Border as Border
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
                [ column
                    []
                    [ wrappedRow [ width fill ]
                        [ image [ padding 20 ]
                            { src = "/favicon.svg"
                            , description = "A red circle"
                            }
                        , column [ padding 20, spacing 20, centerX ]
                            [ el
                                [ Font.size 30
                                , centerX
                                ]
                                (text res.name)
                            , el [ Font.size 18, centerX ]
                                (text res.title)
                            ]
                        ]
                    , paragraph
                        [ Font.justify
                        , paddingXY 0 30
                        ]
                        [ text res.profile ]
                    , paragraph []
                        [ titleBox
                            (text "What I am looking for")
                        , paragraph [ Font.justify ] [ text res.goal ]
                        ]
                    , paragraph [ paddingXY 0 10 ]
                        [ titleBox
                            (text "What you are looking for")
                        ]
                    , paragraph [ Font.justify ] [ text res.offering ]
                    , paragraph [ paddingXY 0 10 ]
                        [ titleBox (text "Skills") ]
                    , paragraph [ Font.justify ] [ text res.skills ]
                    , el
                        [ paddingEach { edges | top = 40, bottom = 10 }
                        , Font.bold
                        , Font.alignLeft
                        , width fill
                        , bottomLine
                        ]
                        (text "Employment")
                    , column [ paddingXY 0 10 ] (employment res.employment)
                    , el
                        [ paddingXY 0 10
                        , Font.bold
                        , Font.alignLeft
                        , width fill
                        , bottomLine
                        ]
                        (text "Education")
                    , column [ paddingXY 0 10 ] (education res.education)
                    ]
                ]


edges =
    { top = 0
    , right = 0
    , bottom = 0
    , left = 0
    }


bottomLine : Attribute Msg
bottomLine =
    Border.widthEach
        { edges | bottom = 2 }


jobBox : Job -> Element Msg
jobBox j =
    column
        [ alignLeft
        , width <| px 250
        , padding 10
        ]
        [ paragraph
            [ Font.bold
            , paddingEach { edges | bottom = 10 }
            , bottomLine
            ]
            [ text j.job_title ]
        , column
            [ Font.size 15
            , Font.alignLeft
            , padding 5
            ]
            [ text j.dates ]
        , paragraph
            [ Font.size 18
            , Font.alignLeft
            , padding 5
            ]
            [ text j.department ]
        ]


employment : Employment -> List (Element Msg)
employment emp =
    let
        viewJobs j =
            column [ paddingXY 0 25 ]
                [ paragraph
                    []
                    [ jobBox j
                    , story j.story
                    , column
                        [ alignLeft
                        , alignBottom
                        ]
                        [ keywords "Technology" j.tech 150
                        , keywords "Test Framework" j.testing 150
                        ]
                    ]
                ]

        viewEmployer e =
            column []
                [ paragraph [ Font.size 25, padding 20, centerX ] [ text e.employer ]
                , textColumn [] (List.map viewJobs e.jobs)
                ]
    in
    List.map viewEmployer emp


story : String -> Element Msg
story description =
    textColumn [ spacing 10 ]
        (List.map
            (\i -> paragraph [ Font.justify ] [ text i ])
         <|
            String.split "\n" description
        )


education : Education -> List (Element Msg)
education edu =
    let
        viewEducation e =
            column [ paddingXY 0 10 ]
                [ wrappedRow [ spacing 10 ]
                    (List.map
                        (\d ->
                            paragraph
                                [ Font.size 15 ]
                                [ text <| String.fromInt d ]
                        )
                        e.dates
                    )
                , el [ paddingXY 0 5 ] (text e.title)
                , el [ Font.size 15 ] (text e.institution)
                ]
    in
    List.map viewEducation edu


titleBox : Element Msg -> Element Msg
titleBox =
    el
        [ alignLeft
        , padding 10
        , width <| px 100
        , Font.bold
        ]


keywords : String -> List String -> Int -> Element Msg
keywords header list width_ =
    if List.length list == 0 then
        none

    else
        wrappedRow []
            [ el
                [ Font.size 15
                , Font.bold
                , alignTop
                , paddingEach { edges | top = 10 }
                ]
                (text header)
            , wrappedRow
                [ padding 10
                , width fill
                , spacing 10
                ]
                (List.map
                    (\i -> el [ Font.size 15 ] (text i))
                    (List.sort list)
                )
            ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = \model -> layout [] <| view model
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
