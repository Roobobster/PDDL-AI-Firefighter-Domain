(define
    (problem ring)
    (:domain firefighting)
    (:objects 
        f1 f2 -firefighter
        safe_zone room_N room_NE room_E room_SE room_S room_SW room_W room_NW -room
        c1 c2 c3 c4 - civilian
        fh1 fh2 -firehose
    )
    (:init
        ;Assign exits and oxygen refills
        (outside safe_zone)
        (= (oxygen-refill-size safe_zone) 350)

        ;Place firehoses for firefighters to use
        (firehose-at fh1 safe_zone)
        (firehose-at fh2 safe_zone)

        ;Set oxygen levels for firefighters initially
        (= (oxygen-level f1) 0)
        (= (oxygen-level f2) 0)

        ;Set firefighter location
        (firefighter-at f1 safe_zone)
        (firefighter-at f2 safe_zone)

        ;Make sure firefighters able to do something at start
        (has-action f1 )
        (has-action f2 )

        ;Give firefighers free hands
        (= (hands-free f1) 2)
        (= (hands-free f2) 2)

        ;Place civilians
        (civilian-at c1 room_W)
        (civilian-at c2 room_N)
        (civilian-at c3 room_N)
        (civilian-at c4 room_E)

        ;Give Civilians weight
        (= (civilian-weight c1) 1)
        (= (civilian-weight c2) 1)
        (= (civilian-weight c3) 1)
        (= (civilian-weight c4) 1)

        ;Set minimum escape distance for each room (need to calculate manually) assume all fire cleared.
        ; (made all movements between connected areas have distance of 5)
        ; ground floor (floor 0):
        (= (escape-distance safe_zone) 0)
        (= (escape-distance room_N) 30)
        (= (escape-distance room_NE) 20)
        (= (escape-distance room_E) 15)
        (= (escape-distance room_SE) 10)
        (= (escape-distance room_S) 5)
        (= (escape-distance room_SW) 10)
        (= (escape-distance room_W) 15)
        (= (escape-distance room_NW) 20)

        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected safe_zone room_S)
        (connected room_S safe_zone)
        (= (fire-level safe_zone room_S) 2)
        (= (fire-level room_S safe_zone) 2)
        (= (move-distance safe_zone room_S) 5)
        (= (move-distance room_S safe_zone) 5)

        (connected room_SW room_S)
        (connected room_S room_SW)
        (= (fire-level room_SW room_S) 2)
        (= (fire-level room_S room_SW) 2)
        (= (move-distance room_SW room_S) 5)
        (= (move-distance room_S room_SW) 5)

        (connected room_SW room_W)
        (connected room_W room_SW)
        (= (fire-level room_SW room_W) 2)
        (= (fire-level room_W room_SW) 2)
        (= (move-distance room_SW room_W) 5)
        (= (move-distance room_W room_SW) 5)

        (connected room_NW room_W)
        (connected room_W room_NW)
        (= (fire-level room_NW room_W) 2)
        (= (fire-level room_W room_NW) 2)
        (= (move-distance room_NW room_W) 5)
        (= (move-distance room_W room_NW) 5)

        (connected room_NW room_N)
        (connected room_N room_NW)
        (= (fire-level room_NW room_N) 2)
        (= (fire-level room_N room_NW) 2)
        (= (move-distance room_NW room_N) 5)
        (= (move-distance room_N room_NW) 5)

        (connected room_NE room_N)
        (connected room_N room_NE)
        (= (fire-level room_NE room_N) 2)
        (= (fire-level room_N room_NE) 2)
        (= (move-distance room_NE room_N) 5)
        (= (move-distance room_N room_NE) 5)

        (connected room_NE room_E)
        (connected room_E room_NE)
        (= (fire-level room_NE room_E) 2)
        (= (fire-level room_E room_NE) 2)
        (= (move-distance room_NE room_E) 5)
        (= (move-distance room_E room_NE) 5)

        (connected room_SE room_E)
        (connected room_E room_SE)
        (= (fire-level room_SE room_E) 2)
        (= (fire-level room_E room_SE) 2)
        (= (move-distance room_SE room_E) 5)
        (= (move-distance room_E room_SE) 5)

        (connected room_SE room_S)
        (connected room_S room_SE)
        (= (fire-level room_SE room_S) 2)
        (= (fire-level room_S room_SE) 2)
        (= (move-distance room_SE room_S) 5)
        (= (move-distance room_S room_SE) 5)

    );Make sure everyone gets outside
    (:goal (and
        (civilian-at c1 safe_zone)
        (civilian-at c2 safe_zone)
        (civilian-at c3 safe_zone)
        (civilian-at c4 safe_zone)

        (firefighter-at f1 safe_zone)
        (firefighter-at f2 safe_zone)
        )
    )
    (:metric minimize (total-time))
)