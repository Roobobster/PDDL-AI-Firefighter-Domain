(define
    (problem firefighting_problem)
    (:domain firefighting)
    (:objects
        f1 -firefighter
        r0 r1 r2 r3 r4 r5 r6 r7 -room
        c1 c2 c3 -civilian
        fh1 - firehose

    )
    (:init
        ;Test if planner takes shortest route and saves people faster
        ;Assign exits and oxygen refills
        (outside r0)
        (= (oxygen-refill-size r0) 400)

        ;Place firehoses for firefighters to use
        (firehose-at fh1 r0)


        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)

        ;Make sure firefighters able to do something at start
        (has-action f1)




        ;Set firefighter location
        (firefighter-at f1 r0)

        ;Give firefighters free hands
        (= (hands-free f1) 2)

        ;Place civilians
        (civilian-at c1 r3)
        (civilian-at c2 r4)
        (civilian-at c3 r5)

        ;Give Civilians weight
        (= (civilian-weight c1) 1)
        (= (civilian-weight c2) 1)
        (= (civilian-weight c3) 1)

        ;Set minimum escape distance for each room (need to calculate manually)  assume all fire cleared.
        (= (escape-distance r0) 0)
        (= (escape-distance r1) 20)
        (= (escape-distance r2) 30)
        (= (escape-distance r3) 50)
        (= (escape-distance r4) 30)
        (= (escape-distance r5) 40)
        (= (escape-distance r6) 40)
        (= (escape-distance r7) 10)



        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected r0 r1)
        (connected r1 r0)
        (= (fire-level r0 r1) 0)
        (= (fire-level r1 r0) 0)
        (= (move-distance r0 r1) 10)
        (= (move-distance r1 r0) 10)

        (connected r0 r7)
        (connected r7 r0)
        (= (fire-level r0 r7) 0)
        (= (fire-level r7 r0) 0)
        (= (move-distance r0 r7) 10)
        (= (move-distance r7 r0) 10)

        (connected r1 r4)
        (connected r4 r1)
        (= (fire-level r1 r4) 5)
        (= (fire-level r4 r1) 5)
        (= (move-distance r1 r4) 10)
        (= (move-distance r4 r1) 10)

        (connected r1 r2)
        (connected r2 r1)
        (= (fire-level r1 r2) 0)
        (= (fire-level r2 r1) 0)
        (= (move-distance r1 r2) 10)
        (= (move-distance r2 r1) 10)

        (connected r7 r4)
        (connected r4 r7)
        (= (fire-level r7 r4) 0)
        (= (fire-level r4 r7) 0)
        (= (move-distance r7 r4) 10)
        (= (move-distance r4 r7) 10)

        (connected r4 r5)
        (connected r5 r4)
        (= (fire-level r4 r5) 0)
        (= (fire-level r5 r4) 0)
        (= (move-distance r4 r5) 10)
        (= (move-distance r5 r4) 10)

        (connected r4 r6)
        (connected r6 r4)
        (= (fire-level r4 r6) 0)
        (= (fire-level r6 r4) 0)
        (= (move-distance r4 r6) 10)
        (= (move-distance r6 r4) 10)

        (connected r2 r6)
        (connected r6 r2)
        (= (fire-level r2 r6) 0)
        (= (fire-level r6 r2) 0)
        (= (move-distance r2 r6) 10)
        (= (move-distance r6 r2) 10)

        (connected r5 r3)
        (connected r3 r5)
        (= (fire-level r5 r3) 2)
        (= (fire-level r3 r5) 2)
        (= (move-distance r5 r3) 10)
        (= (move-distance r3 r5) 10)



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
