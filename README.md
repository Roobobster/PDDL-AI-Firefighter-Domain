# PDDL-AI-Firefighter-Domain

A PDDL domain and problem files for AI to solve 

## Domain Features
  - FireFighter (Agent)
  - Civilian (Object for Agent to Pick up)
  - FireHose (Object for Agent to Pick up)
  - Oxygen Tank (Object for Agent to reset Oxygen)
  - Weight
    - Fire Figher can only hold so much weight
    - Civilians can be either 1 or 2
      - One Indicating one hand is full and 2 meaning both hands needed
    - FireHose is 1
  - Rooms 
    - Have Connections to other rooms (can be one one connections)
    - Firefighters move between rooms
    - Minimum distance to exit is required to be calculated for quicker AI 
      - Can be Removed if you want to the AI try calculate this as well
  - Oxygen
    - Firefighters have oxygen tanks they have to get to refil their oxygen
    - If they run out they can no longer move
  - Fire
    - Can only remove fire if firefighter is in same room and is holding firehose
    - Can have multiple levels so that multiple firefighters can put it out at same time
    - Can pass to the next room unless fire is put out
    
