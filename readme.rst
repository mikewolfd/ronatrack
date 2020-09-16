RonaTrack
=========

Our goal is to answer the question “Can we hang out and how?”; it will define a range of social ‘Risk Profiles’ (Rp) and have users answer a progressive tiered survey to find where they land. RonaTrack will facilitate social bubble management, give people context to what's going on, and offer suggestions to modify their behavior.

We're not here to calculate a possible fatality rate, instead we're trying to give people a benchmark when trying to plan their future social behavior. 



:License: MIT



Dev Deployment
----------
* Requires docker-ce and docker-compose installed.

  
* To build the docker enviroment use ::

    $ docker-compose -f local.yml build


* To run the docker enviroment use ::

    $ docker-compose -f local.yml up

* Notebook access port default  :: 8888
* Django access port default  :: 8000
* React access port default  :: 3000
