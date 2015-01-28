package ;

/**
 * plays the first card in its hand every spawnrate amount of frames in a random lane
 * @author Matthijs van Gelder
 */
class AiPlayer
{
	// its hand
	var aiHand:Hand;
	// game reference
	var game:Game;
	// rate at which it spawns units
	var spawnRate:Int = 50;
	// keep track of wich frame its at
	var currentFrame:Int = 0;
	
	// initilize the variables
	public function new(gameRef:Game, hand:Hand) 
	{
		aiHand = hand;
		game = gameRef;
	}
	
	// counts till spawnrate, then spawn a unit
	public function update()
	{
		// if ai has cards and is at spawnrate
		if (aiHand.handArray.length != 0 && currentFrame > spawnRate)
		{
			// spawn unit at random lane
			aiHand.aiPlayCard(game.lanes[Std.random(game.lanes.length)]);
			// reset frame counting
			currentFrame = 0;
		}
		// count the frame
		currentFrame ++;
	}
}