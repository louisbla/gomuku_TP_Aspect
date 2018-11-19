
import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.*;

import java.util.ArrayList;
import java.util.List;

public aspect FinJeu {
	boolean stop = false;
	List<Spot> spotWin = new ArrayList<>();

	/*pointcut callNotifyGameOver() : call(void notifyGameOver(Player));

	after() : callNotifyGameOver(){
		//Effectuer ici un arr�t du jeu
		System.out.println("Message g�n�r� par le Aspect FinJeu apr�s appel de la m�thode notifyGameOver()");
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
	
	/**==================================Affichage de la combinaison gagnante============================================================= */
	
	pointcut getSpotWin(List<Spot> winStones) : (set(List<Spot> Grid.winningStones) ) && args(winStones);
	
	after(List<Spot> winStones): getSpotWin(winStones){
		spotWin = winStones;
	}
	
	pointcut afficherSpotWin() : call (void notifyGameOver(Player));
	
	after() : afficherSpotWin(){
		System.out.println("Pierres gagnantes :");
		for (Spot spot : spotWin) {
			System.out.println("["+spot.x+","+spot.y+"]");
		}
	}
}
