(define
    (problem firefighting_problem)
    (:domain firefighting)
    (:objects
        f1 -firefighter
        r0 r1 r2 r3 r4 r5 r6 -room
        c1 c2 c3 c4 c5 c6 c7 -civilian
        fh1 fh2 - firehose

    )
    (:init
        ;Test if planner takes shortest route and saves people faster
        ;Assign exits and oxygen refills
        (outside r0)
        (= (oxygen-refill-size r0) 400)

        ;Place firehoses for firefighters to use
        (firehose-at fh1 r0)
        (firehose-at fh2 r0)


        ;Make sure firefighters able to do something at start
        (has-action f1)

        
        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)


        ;Set firefighter location
        (firefighter-at f1 r0)

        ;Give firefighters free hands
        (= (hands-free f1) 2)

        ;Place civilians
        (civilian-at c1 r2)
        (civilian-at c2 r3)
        (civilian-at c3 r2)
        (civilian-at c4 r4)
        (civilian-at c5 r5)
        (civilian-at c6 r6)
        (civilian-at c7 r2)


        ;Give Civilians weight
        (= (civilian-weight c1) 1)
        (= (civilian-weight c2) 1)
        (= (civilian-weight c3) 1)
        (= (civilian-weight c4) 1)
        (= (civilian-weight c5) 1)
        (= (civilian-weight c6) 1)
        (= (civilian-weight c7) 1)

        ;Set minimum escape distance for each room (need to calculate manually)  assume all fire cleared.
        (= (escape-distance r0) 0)
        (= (escape-distance r1) 20)
        (= (escape-distance r2) 30)
        (= (escape-distance r3) 30)
        (= (escape-distance r4) 30)
        (= (escape-distance r5) 40)
        (= (escape-distance r6) 50)


        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected r0 r1)
        (connected r1 r0)
        (= (fire-level r0 r1) 10)
        (= (fire-level r1 r0) 10)
        (= (move-distance r0 r1) 10)
        (= (move-distance r1 r0) 10)

        (connected r1 r2)
        (connected r2 r1)
        (= (fire-level r1 r2) 5)
        (= (fire-level r2 r1) 5)
        (= (move-distance r1 r2) 10)
        (= (move-distance r2 r1) 10)

        (connected r1 r3)
        (connected r3 r1)
        (= (fire-level r1 r3) 5)
        (= (fire-level r3 r1) 5)
        (= (move-distance r1 r3) 10)
        (= (move-distance r3 r1) 10)

        (connected r1 r4)
        (connected r4 r1)
        (= (fire-level r1 r4) 5)
        (= (fire-level r4 r1) 5)
        (= (move-distance r1 r4) 10)
        (= (move-distance r4 r1) 10)

        (connected r5 r6)
        (connected r6 r5)
        (= (fire-level r5 r6) 5)
        (= (fire-level r6 r5) 5)
        (= (move-distance r5 r6) 10)
        (= (move-distance r6 r5) 10)

        (connected r4 r5)
        (connected r5 r4)
        (= (fire-level r4 r5) 5)
        (= (fire-level r5 r4) 5)
        (= (move-distance r4 r5) 10)
        (= (move-distance r5 r4) 10)



    );Make sure everyone gets outside
    (:goal (and
            (civilian-at c1 r0)
            (civilian-at c2 r0)
            (civilian-at c3 r0)
            (civilian-at c4 r0)
            (civilian-at c5 r0)
            (civilian-at c6 r0)
            (civilian-at c6 r0)
            (firefighter-at f1 r0)
        )
    )
    (:metric minimize (total-time))
)
