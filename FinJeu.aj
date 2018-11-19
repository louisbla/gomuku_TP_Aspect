
import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.*;
import java.util.List;

public aspect FinJeu {
	boolean stop = false;

	/*pointcut callNotifyGameOver() : call(void notifyGameOver(Player));

	after() : callNotifyGameOver(){
		//Effectuer ici un arr�t du jeu
		System.out.println("Message g�n�r� par le Aspect FinJeu apr�s appel de la m�thode notifyGameOver()");
	}*/

	pointcut callIsWon() : call(boolean Grid.isWonBy(Player));

	after() returning (boolean retBool): callIsWon() {
		stop = retBool;
    }
	
	pointcut callShowWinner(List<Spot> winStones) : (set(List<Spot> Grid.winningStones) ) && args(winStones);
	
	after(List<Spot> winStones): callShowWinner(winStones){
		if(!winStones.isEmpty()) {
			System.out.println("Pierres gagnantes :");
			for (Spot spot : winStones) {
				System.out.println("["+spot.x+","+spot.y+"]");
			}
		}
	}
	

	pointcut callSpotClicked() : call(void *spotClicked(Spot));

	void around() : callSpotClicked() {
		if (stop) {
			System.out.println("Le jeu est fini");
		} else {
			proceed();
		}
    }
}
