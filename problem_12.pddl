(define
    (problem small_school)
    (:domain firefighting)
    (:objects 
        f1 f2 -firefighter
        safe_zone corridor_0 room_0A room_0B room_0C room_0D room_0E corridor_1 room_1A room_1B room_1C room_1D room_1E -room
        student1 student2 student3 teacher1 teacher2 - civilian
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
        (civilian-at student1 room_0B)
        (civilian-at student2 room_1E)
        (civilian-at student3 room_1D)
        (civilian-at teacher1 room_0A)
        (civilian-at teacher2 room_1B)

        ;Give Civilians weight
        (= (civilian-weight teacher1) 2)
        (= (civilian-weight teacher2) 2)
        (= (civilian-weight student1) 1)
        (= (civilian-weight student2) 1)
        (= (civilian-weight student3) 1)

        ;Set minimum escape distance for each room (need to calculate manually) assume all fire cleared.
        ; (made all movements between connected areas have distance of 5)
        ; ground floor (floor 0):
        (= (escape-distance safe_zone) 0)
        (= (escape-distance corridor_0) 10)
        (= (escape-distance room_0A) 5)
        (= (escape-distance room_0B) 5)
        (= (escape-distance room_0C) 5)
        (= (escape-distance room_0D) 15)
        (= (escape-distance room_0E) 15)
        ; floor 1:
        (= (escape-distance corridor_1) 15)
        (= (escape-distance room_1A) 20)
        (= (escape-distance room_1B) 20)
        (= (escape-distance room_1C) 20)
        (= (escape-distance room_1D) 20)
        (= (escape-distance room_1E) 20)

        ;Connect Rooms together and set the connection fire levels (must be set 0 if none) and move distance between rooms
        (connected safe_zone room_0A)
        (connected room_0A safe_zone)
        (= (fire-level safe_zone room_0A) 0)
        (= (fire-level room_0A safe_zone) 0)
        (= (move-distance safe_zone room_0A) 5)
        (= (move-distance room_0A safe_zone) 5)

        (connected safe_zone room_0B)
        (connected room_0B safe_zone)
        (= (fire-level safe_zone room_0B) 0)
        (= (fire-level room_0B safe_zone) 0)
        (= (move-distance safe_zone room_0B) 5)
        (= (move-distance room_0B safe_zone) 5)

        (connected safe_zone room_0C)
        (connected room_0C safe_zone)
        (= (fire-level safe_zone room_0C) 0)
        (= (fire-level room_0C safe_zone) 0)
        (= (move-distance safe_zone room_0C) 5)
        (= (move-distance room_0C safe_zone) 5)

        (connected corridor_0 room_0A)
        (connected room_0A corridor_0)
        (= (fire-level corridor_0 room_0A) 2)
        (= (fire-level room_0A corridor_0) 2)
        (= (move-distance corridor_0 room_0A) 5)
        (= (move-distance room_0A corridor_0) 5)

        (connected corridor_0 room_0B)
        (connected room_0B corridor_0)
        (= (fire-level corridor_0 room_0B) 2)
        (= (fire-level room_0B corridor_0) 2)
        (= (move-distance corridor_0 room_0B) 5)
        (= (move-distance room_0B corridor_0) 5)

        (connected corridor_0 room_0C)
        (connected room_0C corridor_0)
        (= (fire-level corridor_0 room_0C) 2)
        (= (fire-level room_0C corridor_0) 2)
        (= (move-distance corridor_0 room_0C) 5)
        (= (move-distance room_0C corridor_0) 5)

        (connected corridor_0 room_0D)
        (connected room_0D corridor_0)
        (= (fire-level corridor_0 room_0D) 2)
        (= (fire-level room_0D corridor_0) 2)
        (= (move-distance corridor_0 room_0D) 5)
        (= (move-distance room_0D corridor_0) 5)

        (connected corridor_0 room_0E)
        (connected room_0E corridor_0)
        (= (fire-level corridor_0 room_0E) 2)
        (= (fire-level room_0E corridor_0) 2)
        (= (move-distance corridor_0 room_0E) 5)
        (= (move-distance room_0E corridor_0) 5)

        ; connect the corridors together (the connection acts as a staircase)
        (connected corridor_1 corridor_0)
        (connected corridor_0 corridor_1)
        (= (fire-level corridor_1 corridor_0) 1)
        (= (fire-level corridor_0 corridor_1) 1)
        (= (move-distance corridor_1 corridor_0) 5)
        (= (move-distance corridor_0 corridor_1) 5)

        (connected corridor_1 room_1A)
        (connected room_1A corridor_1)
        (= (fire-level corridor_1 room_1A) 2)
        (= (fire-level room_1A corridor_1) 2)
        (= (move-distance corridor_1 room_1A) 5)
        (= (move-distance room_1A corridor_1) 5)

        (connected corridor_1 room_1B)
        (connected room_1B corridor_1)
        (= (fire-level corridor_1 room_1B) 2)
        (= (fire-level room_1B corridor_1) 2)
        (= (move-distance corridor_1 room_1B) 5)
        (= (move-distance room_1B corridor_1) 5)

        (connected corridor_1 room_1C)
        (connected room_1C corridor_1)
        (= (fire-level corridor_1 room_1C) 2)
        (= (fire-level room_1C corridor_1) 2)
        (= (move-distance corridor_1 room_1C) 5)
        (= (move-distance room_1C corridor_1) 5)

        (connected corridor_1 room_1D)
        (connected room_1D corridor_1)
        (= (fire-level corridor_1 room_1D) 2)
        (= (fire-level room_1D corridor_1) 2)
        (= (move-distance corridor_1 room_1D) 5)
        (= (move-distance room_1D corridor_1) 5)

        (connected corridor_1 room_1E)
        (connected room_1E corridor_1)
        (= (fire-level corridor_1 room_1E) 2)
        (= (fire-level room_1E corridor_1) 2)
        (= (move-distance corridor_1 room_1E) 5)
        (= (move-distance room_1E corridor_1) 5)


    );Make sure everyone gets outside
    (:goal (and
        (civilian-at student1 safe_zone)
        (civilian-at student2 safe_zone)
        (civilian-at student3 safe_zone)
        (civilian-at teacher1 safe_zone)
        (civilian-at teacher2 safe_zone)
        (firefighter-at f1 safe_zone)
        (firefighter-at f2 safe_zone)
        )
    )
    (:metric minimize (total-time))
)