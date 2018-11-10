import ca.uqac.gomoku.core.Player;

public aspect FinJeu {
	pointcut callNotifyGameOver() : call(void notifyGameOver(Player));
	
	after() : callNotifyGameOver(){
		//Effectuer ici un arrêt du jeu
		System.out.println("Message généré par le Aspect FinJeu après appel de la méthode notifyGameOver()");
	}
}
