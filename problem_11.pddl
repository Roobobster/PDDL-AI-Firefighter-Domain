(define
    (problem house_problem)
    (:domain firefighting)
    (:objects 
        f1 f2 -firefighter
        front_garden hallway living_room kitchen bathroom landing bedroom_south bedroom_east bedroom_north loft -room
        mother father daughter1 daughter2 son dog -civilian
        fh1 -firehose

    )
    (:init
        ;Assign exits and oxygen refills
        (outside front_garden)
        (= (oxygen-refill-size front_garden) 350)
 
        ;Place firehoses for firefighters to use
        (firehose-at fh1 front_garden)
  

        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)
        (= (oxygen-level f2) 0)

        ;Set firefighter location
        (firefighter-at f1 front_garden)
        (firefighter-at f2 front_garden)

        ;Make sure firefighters able to do something at start
        (has-action f1)
        (has-action f2)



        ;Give firefighers free hands
        (= (hands-free f1) 2)
        (= (hands-free f2) 2)


        ;Place civilians
        (civilian-at mother bedroom_east)
        (civilian-at father kitchen)
        (civilian-at son living_room)
        (civilian-at dog bathroom)
        (civilian-at daughter1 bedroom_north)
        (civilian-at daughter2 loft)


        ;Give Civilians weight
        (= (civilian-weight mother) 2)
        (= (civilian-weight father) 2)
        (= (civilian-weight dog) 1)
        (= (civilian-weight son) 1)
        (= (civilian-weight daughter1) 1)
        (= (civilian-weight daughter2) 1)

        

        ;Set minimum escape distance for each room (need to calculate manually) assume all fire cleared.
        (= (escape-distance front_garden) 0)
        (= (escape-distance hallway) 10)
        (= (escape-distance living_room) 20)
        (= (escape-distance kitchen) 20)
        (= (escape-distance bathroom) 20)
        (= (escape-distance landing) 35)
        (= (escape-distance bedroom_south) 45)
        (= (escape-distance bedroom_east) 45)
        (= (escape-distance bedroom_north) 45)
        (= (escape-distance loft) 60) 


        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected front_garden hallway)
        (connected hallway front_garden)
        (= (fire-level front_garden hallway) 1)
        (= (fire-level hallway front_garden) 1)
        (= (move-distance front_garden hallway) 10)
        (= (move-distance hallway front_garden) 10)

        (connected hallway living_room)
        (connected living_room hallway)
        (= (fire-level hallway living_room) 3)
        (= (fire-level living_room hallway) 3)
        (= (move-distance hallway living_room) 10)
        (= (move-distance living_room hallway) 10)

        (connected hallway kitchen)
        (connected kitchen hallway)
        (= (fire-level hallway kitchen) 5)
        (= (fire-level kitchen hallway) 5)
        (= (move-distance hallway kitchen) 10)
        (= (move-distance kitchen hallway) 10)

        (connected hallway bathroom)
        (connected bathroom hallway)
        (= (fire-level hallway bathroom) 2)
        (= (fire-level bathroom hallway) 2)
        (= (move-distance hallway bathroom) 10)
        (= (move-distance bathroom hallway) 10)

        (connected hallway landing)
        (connected landing hallway)
        (= (fire-level hallway landing) 3)
        (= (fire-level landing hallway) 3)
        (= (move-distance hallway landing) 15) ; 15 to go up/down stairs as it's difficult
        (= (move-distance landing hallway) 15)

        (connected landing bedroom_south)
        (connected bedroom_south landing)
        (= (fire-level landing bedroom_south) 0)
        (= (fire-level bedroom_south landing) 0)
        (= (move-distance landing bedroom_south) 10)
        (= (move-distance bedroom_south landing) 10)

        (connected landing bedroom_east)
        (connected bedroom_east landing)
        (= (fire-level landing bedroom_east) 2)
        (= (fire-level bedroom_east landing) 2)
        (= (move-distance landing bedroom_east) 10)
        (= (move-distance bedroom_east landing) 10)

        (connected landing bedroom_north)
        (connected bedroom_north landing)
        (= (fire-level landing bedroom_north) 1)
        (= (fire-level bedroom_north landing) 1)
        (= (move-distance landing bedroom_north) 10)
        (= (move-distance bedroom_north landing) 10)

        (connected landing loft)
        (connected loft landing)
        (= (fire-level landing loft) 1)
        (= (fire-level loft landing) 1)
        (= (move-distance landing loft) 15) ; 15 to go up/down ladder as it's difficult

        (= (move-distance loft landing) 15)
        


    );Make sure everyone gets outside
    (:goal (and
        (civilian-at mother front_garden)
        (civilian-at father front_garden)
        (civilian-at dog front_garden)
        (civilian-at daughter1 front_garden)
        (civilian-at daughter2 front_garden)
        (civilian-at son front_garden)
    
        (firefighter-at f1 front_garden)
        (firefighter-at f2 front_garden)

        )
    )
    (:metric minimize (total-time))
)