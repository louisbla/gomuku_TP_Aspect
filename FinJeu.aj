
import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.*;

public aspect FinJeu {
	boolean stop = false;

	/*pointcut callNotifyGameOver() : call(void notifyGameOver(Player));

	after() : callNotifyGameOver(){
		//Effectuer ici un arrêt du jeu
		System.out.println("Message généré par le Aspect FinJeu après appel de la méthode notifyGameOver()");
	}*/

	pointcut callIsWon() : call(boolean Grid.isWonBy(Player));

	after() returning (boolean retBool): callIsWon() {
		stop = retBool;
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
