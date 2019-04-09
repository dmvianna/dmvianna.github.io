{ name =
    "Daniel Vianna"
, title =
    "Functional Software Engineer"
, profile =
    "I am a Python developer with a strong Test Driven Development discipline. I write unit tests for pure functions and keep logic, data and I/O strictly segregated. In plain English: my code is easy to alter, easy to bugfix, and is provably built according to specification."
, goal =
    "You have code written in Python. You need to refactor or move some of its functionality. You know you won't be able to tackle a refactor without testing. You are open to move your codebase to a more functional programming style. Your domain experts are busy doing other things, so you need a new developer to do that work under their guidance."
, offering =
    "I am a self taught developer with training in functional programming, mainly in Haskell and related languages. I am most comfortable writing Python. I use objects mainly as data structures, and keep business logic separate from it. I use mypy to emulate static checking. I learn programming languages and translate their core concepts into my daily job as a habit."
, skills =
    "Seasoned analyst programmer with experience writing SQL, R, Python, and JavaScript. Experienced user of Oracle, SQL Server and PostgreSQL databases. Linux and emacs are my choice of desktop. I version control my work with git. I have an active interest in Elm, Haskell, Rust, and Nix."
, employment =
    [ { employer =
          "AusNet Services"
      , jobs =
          [ { job_title =
                "Operations and Analytics Engineer"
            , dates =
                "July 2018 - present"
            , department =
                "Network Intelligence and Analytics"
            , story =
                ''
                AusNet Services owns one of the five electricity distribution networks in Victoria. It is its job to deliver electricity safely, reliably and within the voltage range mandated by the Australian Energy Regulator. The health of its grid is measured by data collected from energy meters within most households and businesses in the network.
                Working within a team of network engineers, we create algorithms that are smart enough to identify problems in the network while being lean enough to run on a dataset of about a million rows every 5 minutes. We then expose the results to our internal customers through web interfaces and visualisation tools.''
            , tech =
                [ "Oracle", "Python", "R" ]
            , testing =
                [ "Pytest" ]
            }
          ]
      }
    , { employer =
          "Department of Premier and Cabinet (VIC)"
      , jobs =
          [ { job_title =
                "Senior Data Analyst"
            , dates =
                "July 2017 - June 2018"
            , department =
                "Victorian Centre for Data Insights (VCDI)"
            , story =
                ''
                The VCDI was created in 2017 to assist the Victorian government to make data-driven decisions. It contains a policy and an analytics team. I helped establish the latter. Analytics is responsible for delivering data products and services, including performance dashboards for the Department of Premier and Cabinet, design sprints and long term projects in collaboration with other departments and government bodies.
                                      I helped the Victorian Cladding Taskforce to identify buildings in Victoria that may have been built with external flammable cladding. This project had a tight deadline and involved standardising street address data in order to remove duplicates and use it as foreign keys for joining multiple datasets. This involved fairly complex regular expressions and working with database administrators to create indexes and optimise queries, as we were dealing with complex million row joins. The resulting estimate of 1,400 buildings was published in their November 2017 interim report and featured in ABC News and The Age headlines.
                ''
            , tech =
                [ "SQL Server", "Python", "R" ]
            , testing =
                [ "Behave" ]
            }
          ]
      }
    , { employer =
          "Bunnings Pty Ltd"
      , jobs =
          [ { job_title =
                "Data Analyst"
            , dates =
                "December 2016 - July 2017"
            , department =
                "Business Intelligence"
            , story =
                ''
                At Bunnings Human Resources data was held in siloed databases. These systems did not interoperate, and end users were not allowed to run custom SQL queries on them. In the best scenario data was accessible through an OLAP frontend. In other cases the only functionality provided were full table downloads. As the downloads became bigger than Excel, I was assigned to create a short term solution.
                I created a system where I would routinely download the source tables, and then upload them to a PostgreSQL database. Each required report was produced by running custom SQL queries from a Jupyter notebook and then creating fully formatted Excel files using Python libraries, sometimes also including Excel plots and accompanying text. Using this workflow I was able to run all external workforce reporting to Wesfarmers, Australian Bureau of Statistics and Workplace Gender Equality Agency. I also was responsible for most of the Learning & Development (training) reporting, monthly payroll audits, and safety reporting.
                ''
            , tech =
                [ "Oracle", "PostgreSQL", "RedHat Linux", "Python", "Excel" ]
            , testing =
                [] : List Text
            }
          , { job_title =
                "Data Analyst"
            , dates =
                "August 2015 -November 2016"
            , department =
                "Human Resources - Team Information Services"
            , story =
                ''
                Bunnings invests heavily in team member training. This is why customers rely on Bunnings staff to solve their questions and help them find the products they need. Bunnings team members are knowledgeable, and are trained to help, not to sell. As a data analyst working for Human Resources, it was my responsibility to assign team members to courses according to theirs skills and store departments they worked at. The volume of work was challenging, but I identified the commonalities between reporting tasks and created a simple workflow and reusable libraries that could be quickly put together to optimise developer time. As explained below, this relied on Jupyter notebooks containing SQL queries and Python code that created fully formatted Excel output files. 
                I also continued to be responsible for safety reporting. It was vital for injury management to quickly have access to incident information and be confident on the numbers reported. Moreover, they had to feel the pulse of the business at all times, and not just after monthly reporting. So I built a Node/Angular web dashboard that displayed incident counts month-to-date, and compared it to last-month-to-date and the previous three months totals, live, and drilled by business division and incident type. A key feature was that every number could be clicked to pop up a dialog window with the details of every incident being represented by that number. That made it easy for managers and safety advisors to know at all times what was happening and where to focus their attention. 
                                      ''
            , tech =
                [ "Angular", "Node", "PostgreSQL", "RedHat Linux", "Python" ]
            , testing =
                [ "Karma" ]
            }
          , { job_title =
                "Data Analyst"
            , dates =
                "July 2013 - July 2015"
            , department =
                "Human Resources - Health and Safety"
            , story =
                ''
                Bunnings took safety seriously. The whole leadership team attended regular safety meetings to continuously improve safety in the business. Reporting to this team was divided in two streams: regular and ‘deep-dive’ reports. The latter, while still being created at regular times of the year, were focused on ad hoc questions they constantly raised.
                I had a very productive relationship with Chris Wilks and Nicci Horton, who represented the safety team at these meetings. Chris kept me busy with interesting research questions that had real value for the business, and Nicci worked the communication channels to make sure that our insights had a lasting impact on established practices and drove organisational change. They would give me the organisational context, we would brainstorm potential sources of information and data, and once I had results, we would discuss its meaning and find yet more gaps in our knowledge that needed to be filled. This would lead to a new iteration, until we were able to present a convincing case to the leadership team.
                The workflow I used to accomplish that was based on Jupyter notebooks. I scripted all my workflows with Python, which made them quick, reproducible, and auditable. The scripts would include SQL queries, data transformations, investigative plots, and would output fully formatted Excel files that were either used for reporting or further data collection. 
                                                      ''
            , tech =
                [ "Python", "Oracle", "RedHat Linux" ]
            , testing =
                [] : List Text
            }
          ]
      }
    , { employer =
          "Royal Australian College of General Practitioners"
      , jobs =
          [ { job_title =
                "Data Analyst"
            , dates =
                "September 2017 - June 2013"
            , department =
                "Member Services - Marketing and Membership Unit"
            , story =
                ''
                The RACGP certifies general practitioners (GPs) in Australia. Without participating in RACGP continuing professional development program, a GP cannot legally practice. Annual membership gives access to discounted training, so there is an obvious incentive for doctors to become members. As the data analyst working for the Marketing and Membership unit, it was my responsibility to create insights into ways in which we could better serve Australian GPs.
                I worked closely with Sharon Lapkin, the Supervising Editor for RACGP publications, to identify and segment our member base. This knowledge was used to keep our content relevant and interesting to our target consumers. However, perhaps the most interesting outcome of my work was a visualisation representing all career paths of all members and non-members using the RACGP professional development program. That analysis revealed a population of GPs that did not appear in our regular reports and seemed to be impervious to our marketing up to that point. 
                During my tenure at the RACGP I experimented heavily with visualisation tools, creating population pyramids in R, GIS location maps with MapInfo, and expressing multidimensional data graphically. 
                                ''
            , tech =
                [ "Oracle", "Python", "R" ]
            , testing =
                [] : List Text
            }
          ]
      }
    ]
, education =
    [ { dates =
          [ 1999, 2003 ]
      , title =
          "Doctor of Philosophy in Neuroscience"
      , institution =
          "University of S\u00E3o Paulo, Brazil"
      }
    , { dates =
          [ 1997, 1999 ]
      , title =
          "Master of Science in Neuroscience"
      , institution =
          "University of S\u00E3o Paulo, Brazil"
      }
    , { dates =
          [ 1991, 1995 ]
      , title =
          "Bachelor of Psychology"
      , institution =
          "Pontifical Catholic University of Rio de Janeiro, Brazil"
      }
    ]
}
