
import ca.uqac.gomoku.core.BoardEventListener;
import ca.uqac.gomoku.core.Player;
import ca.uqac.gomoku.core.model.*;
import ca.uqac.gomoku.ui.App;
import ca.uqac.gomoku.ui.Board;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;

import java.util.ArrayList;
import java.util.List;

public aspect FinJeu {
	boolean stop = false;
	List<Spot> spotWin = new ArrayList<>();
	Board myBoard;

	//On récupère la variable booléenne qui indique si le jeu a été gagné
	pointcut callIsWon() : call(boolean Grid.isWonBy(Player));

	after() returning (boolean retBool): callIsWon() {
		stop = retBool;
    }

	//Si le jeu a été gagné, on annule l'action du clic sur la grille
	pointcut callSpotClicked() : call(void *spotClicked(Spot));

	void around() : callSpotClicked() {
		if (stop) {
			System.out.println("Le jeu est fini");
		} else {
			proceed();
		}
    }

	//On récupère la Board afin de pouvoir recolorier par dessus
	after(Board board): execution(Board+.new(..)) && this(board) {
		myBoard = board;
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

			//Recoloriage
			GraphicsContext gc = myBoard.getGraphicsContext2D();
			gc.setFill(Color.BLUE);
			double x = 30 + spot.x * 30; // center x
			double y = 30 + spot.y * 30; // center y
			double r = 30 / 2; // radius
			gc.fillOval(x - r, y - r, r * 2, r * 2);
		}
	}
}
