extends Node

enum ACTIONS {
	IDLE,  # Boxer idle state
	DEFEND,  # Boxer defending (input rel)
	RIGHT_JAB,  # (input)
	RIGHT_HEAVY,  # (input)
	LEFT_JAB,  # (input)
	LEFT_HEAVY,  # (input)
	DROP,  # Boxer falls to the floor 
	STAND  # Boxer stands back up
}