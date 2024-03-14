# Chapters

Each chapter is a self contained set of content that tells one story within the larger Red Eclipse universe. The structure is intended to allow contributions from many sources with a relatively low bar of entry compared to writing a single large story to encompass all chapters. Due to the nature of a volunteer project that's taken 15 years to even get this far, a more realistic approach is being taken.

The project itself will release chapters that create and expand on the larger universe, beginning with the Prologue. This will be the only mandatory chapter of the game a player would need to complete before being able to play other chapters. It is otherwise intended that other chapters can be played in any order and be contained to a single map.

# Series

It is inevitable that some people may want to tell larger stories over time, and that there be some sort of structure to that in order to tell a linear story within the larger universe. While the players will not be required to pick any specific chapter as their starting point, creators should be given the opportunity to provide "sets" of chapters with a specific order should the party wish to do them in sequence.

# Parties

The structure of the system should allow each chapter to be completed by any number of players. When voting on a story chapter, all players in the game will become one party and cooperatively work together to progress to the objective. This means that all events need to be asynchronous and not interrupt the flow of the game.

# Storytelling

For dialogue, Valve's approach to Half Life should be taken. The players are silent (but sentient) protagonists and the characters within the universe tell the story to them. The game should not take control away from the player at any time, and the story should be told as the players progress through the level. In addition to this, being a fast paced arena style shooter, story beats should be fairly well paced but not entirely interruptible to keep up with parties progressing through the map faster.

# Gameplay

The gameplay itself needs to be fairly linear with a clear objective that parties can progress towards in a reasonable amount of time. It should consist of parkour challenges interspersed with enemy confrontations at specific points. Due to the variable number of players and skill levels in a party, an "AI director" approach will need to be taken to create a scaling level of difficulty.

Players will start with either their full loadout or no weapons at the beginning of each chapter, depending on the setting the creator sets in their map. The director will create the necessary ammo for the party along the path at creator defined points. The "stop and resupply" points are good places to advance the story while also keeping the players occupied with a task. It should never feel like the party is being held back by anything other than a straggling party member to promote cooperative play and social interaction.

# Raids

The action should be contained in sequences of different game types called Raids. The game types should be "friendly competition" Player-vs-Environment focused where the concept is that the party is cooperating to complete a task, but are individually competing against each other for points. The most basic description of this being the locked room with waves of enemies (or a boss) to destroy before progress is unlocked.

*NOTE: Raids can be adapted to work as a Deathmatch mutator as well.*

# Guides

To propel the stories forward, an "on rail" character will be provided to act as a guide. The first of these being a rogue Janitor that assists the player through the prologue, but more can be added as the greater universe is expanded upon. It is the job of the Guide to show the party through the level and create story beats along the way, if someone is having difficulty it should be able to assist them.

The use of the Guide will also allow a mechanism for limiting the progression through the level without all members of the party. The on rail system for the Guide will lock out further areas until they are present to open them. This also allows for forks in the path depending on the nature of the game type.

It is not necessary for the Guide to be any specific character, but is instead intended to function as a focal point for progression, keeping a party together. It is a broad term that could be anything from an invisible person on the radio, to a silent ball of light that simply shows the way. The system should facilitate creativity in design with a structured application.

*Guides will need to be able to display key combinations over their head when assisting players, as a route-based UI element may not always be appropriate to display the way to progress, and would likely get tedious if necessary to add at every single point on the route.*

# Singleplayer

The variable number of players required to play through a chapter means that one could play through it alone. The previously mentioned forks can be used to create alternate paths/dialogue depending on if the player is alone or in a party. The distinction between these should be kept fairly simple/vague and only consist of relatively minor changes to suit the situation.

# Prologue

The prologue will be a special map that consists of a tutorial embedded in with the opening story beats of the entire game. It will use the forks feature to take the player through a modified version of the chapter (tutorial) the first time it is played in order to teach the mechanics, keys, etc needed for all other chapters. See: [Prologue](Prologue.md).

# Choices

Player choices when interacting with the story should be conveyed through the use of triggerss or graphical map UI elements. The ability to interact with them should be locked until the Guide has caught up to the interaction point. It should only be necessary for one player in a party to interact in order to proceed.

*NOTE: This requires a rewrite of the trigger/event handling system and modification of entity spawning rules to be more general.*