(define
    (problem ring)
    (:domain firefighting)
    (:objects 
        f1 f2 f3 f4 -firefighter
        r0 r1 r2 r3 r4 r5 r6 r7 r8 -room
        c1 c2 c3 c4 c5 c6 c7 - civilian
        fh1 fh2 -firehose
    )
    (:init
        ;Assign exits and oxygen refills
        (outside r0)
        (= (oxygen-refill-size r0) 350)

        ;Place firehoses for firefighters to use
        (firehose-at fh1 r0)
        (firehose-at fh2 r0)

        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)
        (= (oxygen-level f2) 0)

        ;Set firefighter location
        (firefighter-at f1 r0)
        (firefighter-at f2 r0)
        (firefighter-at f3 r0)
        (firefighter-at f4 r0)

        ;Make sure firefighters able to do something at start
        (has-action f1 )
        (has-action f2 )
        (has-action f3 )
        (has-action f4 )

        ;Give firefighers free hands
        (= (hands-free f1) 2)
        (= (hands-free f2) 2)
        (= (hands-free f3) 2)
        (= (hands-free f4) 2)

        ;Place civilians
        (civilian-at c1 r7)
        (civilian-at c2 r1)
        (civilian-at c3 r1)
        (civilian-at c4 r3)
        (civilian-at c5 r1)
        (civilian-at c6 r3)
        (civilian-at c7 r1)


        ;Give Civilians weight
        (= (civilian-weight c1) 1)
        (= (civilian-weight c2) 1)
        (= (civilian-weight c3) 1)
        (= (civilian-weight c4) 1)
        (= (civilian-weight c5) 2)
        (= (civilian-weight c6) 2)
        (= (civilian-weight c7) 2)

        ;Set minimum escape distance for each room (need to calculate manually) assume all fire cleared.
        ; (made all movements between connected areas have distance of 5)
        ; ground floor (floor 0):
        (= (escape-distance r0) 0)
        (= (escape-distance r1) 30)
        (= (escape-distance r2) 20)
        (= (escape-distance r3) 15)
        (= (escape-distance r4) 10)
        (= (escape-distance r5) 5)
        (= (escape-distance r6) 10)
        (= (escape-distance r7) 15)
        (= (escape-distance r8) 20)

        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected r0 r5)
        (connected r5 r0)
        (= (fire-level r0 r5) 16)
        (= (fire-level r5 r0) 16)
        (= (move-distance r0 r5) 5)
        (= (move-distance r5 r0) 5)

        (connected r6 r5)
        (connected r5 r6)
        (= (fire-level r6 r5) 12)
        (= (fire-level r5 r6) 12)
        (= (move-distance r6 r5) 5)
        (= (move-distance r5 r6) 5)

        (connected r6 r7)
        (connected r7 r6)
        (= (fire-level r6 r7) 22)
        (= (fire-level r7 r6) 22)
        (= (move-distance r6 r7) 5)
        (= (move-distance r7 r6) 5)

        (connected r8 r7)
        (connected r7 r8)
        (= (fire-level r8 r7) 42)
        (= (fire-level r7 r8) 42)
        (= (move-distance r8 r7) 5)
        (= (move-distance r7 r8) 5)

        (connected r8 r1)
        (connected r1 r8)
        (= (fire-level r8 r1) 32)
        (= (fire-level r1 r8) 32)
        (= (move-distance r8 r1) 5)
        (= (move-distance r1 r8) 5)

        (connected r2 r1)
        (connected r1 r2)
        (= (fire-level r2 r1) 2)
        (= (fire-level r1 r2) 2)
        (= (move-distance r2 r1) 5)
        (= (move-distance r1 r2) 5)

        (connected r2 r3)
        (connected r3 r2)
        (= (fire-level r2 r3) 12)
        (= (fire-level r3 r2) 12)
        (= (move-distance r2 r3) 5)
        (= (move-distance r3 r2) 5)

        (connected r4 r3)
        (connected r3 r4)
        (= (fire-level r4 r3) 15)
        (= (fire-level r3 r4) 15)
        (= (move-distance r4 r3) 5)
        (= (move-distance r3 r4) 5)

        (connected r4 r5)
        (connected r5 r4)
        (= (fire-level r4 r5) 29)
        (= (fire-level r5 r4) 29)
        (= (move-distance r4 r5) 5)
        (= (move-distance r5 r4) 5)

    );Make sure everyone gets outside
    (:goal (and
        (civilian-at c1 r0)
        (civilian-at c2 r0)
        (civilian-at c3 r0)
        (civilian-at c4 r0)
        (civilian-at c5 r0)
        (civilian-at c6 r0)
        (civilian-at c7 r0)
        

        (firefighter-at f1 r0)
        (firefighter-at f2 r0)
        (firefighter-at f3 r0)
        (firefighter-at f4 r0)
        )
    )
    (:metric minimize (total-time))
)