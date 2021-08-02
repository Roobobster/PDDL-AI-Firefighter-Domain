(define
    (problem firefighting_problem)
    (:domain firefighting)
    (:objects 
        f1 -firefighter
        r0 r1 r2 r3 r4 -room
        c1 c2 c3 -civilian
        fh1 - firehose

    )
    (:init
        ;Assign exits and oxygen refills
        (outside r0)
        (= (oxygen-refill-size r0) 400)
 
        ;Place firehoses for firefighters to use
        (firehose-at fh1 r0)
  

        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)

        ;Set firefighter location
        (firefighter-at f1 r0)

        ;Make sure firefighters able to do something at start
        (has-action f1)


        ;Give firefighers free hands
        (= (hands-free f1) 2)


        ;Place civilians
        (civilian-at c1 r3)
        (civilian-at c2 r3)
        (civilian-at c3 r4)


        ;Give Civilians weight
        (= (civilian-weight c1) 1)
        (= (civilian-weight c2) 1)
        (= (civilian-weight c3) 1)

        

        ;Set minimum escape distance for each room (need to calculate manually) assume all fire cleared.
        (= (escape-distance r0) 0)
        (= (escape-distance r1) 10)
        (= (escape-distance r2) 20)
        (= (escape-distance r3) 30)
        (= (escape-distance r4) 30)


        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected r0 r1)
        (connected r1 r0)
        (= (fire-level r0 r1) 0)
        (= (fire-level r1 r0) 0)
        (= (move-distance r0 r1) 10)
        (= (move-distance r1 r0) 10)

        (connected r2 r1)
        (connected r1 r2)
        (= (fire-level r2 r1) 0)
        (= (fire-level r1 r2) 0)
        (= (move-distance r2 r1) 10)
        (= (move-distance r1 r2) 10)

        (connected r2 r3)
        (connected r3 r2)
        (= (fire-level r2 r3) 5)
        (= (fire-level r3 r2) 5)
        (= (move-distance r2 r3) 10)
        (= (move-distance r3 r2) 10)

        (connected r2 r4)
        (connected r4 r2)
        (= (fire-level r2 r4) 5)
        (= (fire-level r4 r2) 5)
        (= (move-distance r2 r4) 10)
        (= (move-distance r4 r2) 10)

        


    );Make sure everyone gets outside
    (:goal (and
            (civilian-at c1 r0)
            (civilian-at c2 r0)
            (civilian-at c3 r0)
    
            (firefighter-at f1 r0)

        )
    )
    (:metric minimize (total-time))
)