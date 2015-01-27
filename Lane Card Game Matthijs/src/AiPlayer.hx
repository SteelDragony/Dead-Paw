package ;

/**
 * ...
 * @author Matthijs van Gelder
 */
class AiPlayer
{
	var aiHand:Hand;
	var game:Game;
	var spawnRate:Int = 50;
	var currentFrame:Int = 0;
	
	public function new(gameRef:Game, hand:Hand) 
	{
		aiHand = hand;
		game = gameRef;
	}
	
	public function update()
	{
		if (aiHand.handArray.length != 0 && currentFrame > spawnRate)
		{
			aiHand.aiPlayCard(game.lanes[Std.random(game.lanes.length)]);
			currentFrame = 0;
		}
		currentFrame ++;
	}
}