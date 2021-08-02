(define
    (domain firefighting)
    (:requirements :fluents :typing :durative-actions )
    (:types firefighter room civilian firehose)


    (:predicates
        (firefighter-at ?firefighter -firefighter ?room - room)
        (civilian-at ?civilian -civilian ?room -room)
        (firehose-at ?firehose -firehose ?room -room)

        (firefighter-has ?firefighter -firefighter ?civilian -civilian)

        (connected ?room1 -room ?room2 -room)
        (outside ?room -room)
        (has-firehose ?firefighter -firefighter ?firehose -firehose)
        (has-action ?firefighter - firefighter)
    )

    (:functions
        (oxygen-level ?firefighter -firefighter)
        (fire-level ?from -room ?to -room); the fire between rooms is the amount of fire between rooms which must be cleared to progess to next room
        (hands-free ?firefighter - firefighter)
        (escape-distance ?room -room)
        (oxygen-refill-size ?room -room)
        (civilian-weight ?civilian -civilian)
        (move-distance ?from -room ?to -room)
    )

    (:durative-action move
        :parameters (?firefighter -firefighter ?from -room ?to -room)
        :duration (= ?duration (move-distance ?from ?to))
        :condition (and
            (at start (firefighter-at ?firefighter ?from))
            (at start (connected ?from ?to))
            (at start (= (fire-level ?from ?to) 0))  ; should not be any fire blocking entrance in order to move from one room to next
            (at start (>= (oxygen-level ?firefighter) (* (move-distance ?from ?to) (- 3 (hands-free ?firefighter)))))
            (at start (> (oxygen-level ?firefighter) (* (escape-distance ?to) (- 3 (hands-free ?firefighter))))) ;Makes it easier for planner to escape so that they can only move in direction that firefighter doesn't die going to
            (at start (has-action ?firefighter))
        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))

            (at start (not (firefighter-at ?firefighter ?from)))
            ;Oxygen used is scaled with amount carrying, if hand full oxygen used 3x, if 1 hand used 2x and if empty 1x (normal movement)
            (at end(decrease (oxygen-level ?firefighter) (* (move-distance ?from ?to) (- 3 (hands-free ?firefighter))))) 
            (at end (firefighter-at ?firefighter ?to))
        )
    )


    ; clearing fire between two rooms takes as long as the amount of fire there is
    ; furthermore, the firefighter will use up an amount of oxygen equal to the amount of fire there is
    (:durative-action clear-fire
        :parameters (?firefighter -firefighter ?from -room ?to -room ?firehose -firehose)
        :duration (= ?duration 5)
        :condition (and
            (at start (firefighter-at ?firefighter ?from))
            (at start (connected ?from ?to))
            (at start (> (fire-level ?from ?to) 0)) ; can't clear fire if there ain't any
            (at start (> (oxygen-level ?firefighter) 15)) ;oxygen level should be greater than fire-level so firefighter don't die#
            (over all (has-firehose ?firefighter ?firehose))
            (at start (> (oxygen-level ?firefighter) (* (escape-distance ?to) (- 3 (hands-free ?firefighter)))))
            (at start (has-action ?firefighter))
            
        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at end (decrease (oxygen-level ?firefighter) 5))
            (at end (decrease (fire-level ?from ?to) 1)) 
            (at end (decrease (fire-level ?to ?from) 1)) 
        )
    )

    (:durative-action pickup-firehose
        :parameters (?firefighter -firefighter ?from -room ?firehose -firehose)
        :duration (= ?duration 5)
        :condition (and
            (at start (firefighter-at ?firefighter ?from))
            (at start(firehose-at ?firehose ?from ))
            (at start (>= (oxygen-level ?firefighter) 15)) ; Requires 15 at least so can move.
            (at start(> (hands-free ?firefighter) 0)) ;can only pick up if have empty hand.
            (at start (> (- (oxygen-level ?firefighter) 5) (* (escape-distance ?from) (- 4 (hands-free ?firefighter)))))
            (at start (has-action ?firefighter))
        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at start (not (firehose-at ?firehose ?from)))
            (at end (has-firehose ?firefighter ?firehose ))
            (at end(decrease (oxygen-level ?firefighter) 5)) 
            (at start(decrease (hands-free ?firefighter) 1))

        )
    )

    (:durative-action drop-firehose
        :parameters (?firefighter -firefighter ?dropRoom -room ?firehose -firehose)
        :duration (= ?duration 5)
        :condition (and
            (at start (firefighter-at ?firefighter ?dropRoom))
            (at start(has-firehose ?firefighter ?firehose ))      
            (at start (>= (oxygen-level ?firefighter) 5))
            (at start (> (- (oxygen-level ?firefighter) 5) (* (escape-distance ?dropRoom) (- 2 (hands-free ?firefighter)))))
            (at start (has-action ?firefighter))

        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at start (not (has-firehose ?firefighter ?firehose )))      
            (at end (decrease(oxygen-level ?firefighter) 5))
            (at end ( firehose-at ?firehose ?dropRoom))
            (at start (increase (hands-free ?firefighter) 1))
        )
    )

    (:durative-action pickup-civilian
        :parameters (?firefighter -firefighter ?from -room ?civilian -civilian)
        :duration (= ?duration 5)
        :condition (and
            (over all (firefighter-at ?firefighter ?from))
            (at start(civilian-at ?civilian ?from ))
            (at start(>= (hands-free ?firefighter) (civilian-weight ?civilian))) ;can only pick up if civillian weight isn't too high
            (at start (> (- (oxygen-level ?firefighter) 5) (* (escape-distance ?from) (- 4 (hands-free ?firefighter)))))
            (at start (has-action ?firefighter))

            
        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at start (not (civilian-at ?civilian ?from)))
            (at end (firefighter-has ?firefighter ?civilian ))
            (at end(decrease (oxygen-level ?firefighter) 5)) 
            (at start(decrease (hands-free ?firefighter) (civilian-weight ?civilian)))

        )
    )

    (:durative-action drop-civilian
        :parameters (?firefighter -firefighter ?dropRoom -room ?civilian -civilian)
        :duration (= ?duration 5)
        :condition (and
            (at start (firefighter-at ?firefighter ?dropRoom))
            (at start(firefighter-has ?firefighter ?civilian ))      
            (at start (>= (oxygen-level ?firefighter) 5))
            (at start (> (oxygen-level ?firefighter) (escape-distance ?dropRoom)))
            (at start (> (- (oxygen-level ?firefighter) 5) (* (escape-distance ?dropRoom) (- 2 (hands-free ?firefighter)))))
            (at start (has-action ?firefighter))

        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at end (decrease(oxygen-level ?firefighter) 5))
            (at end (civilian-at ?civilian ?dropRoom))
            (at start (increase (hands-free ?firefighter) (civilian-weight ?civilian)))
            (at start (not (firefighter-has ?firefighter ?civilian )))


        )
    )
    


    (:durative-action replace-oxygen-tank
        :parameters (?firefighter -firefighter ?room -room)
        :duration (= ?duration 20)
        :condition (and
            (at start (firefighter-at ?firefighter ?room))    
            (at start(outside ?room )) 
            (at start(>= (oxygen-level ?firefighter) 0))
            (at start(< (oxygen-level ?firefighter) 150))
            (at start (has-action ?firefighter))
        )
        :effect (and
            (at start (not (has-action ?firefighter)))
            (at end (has-action ?firefighter))
            (at end(assign (oxygen-level ?firefighter) (oxygen-refill-size ?room)))


        )
    )

)