import ca.uqac.gomoku.core.Player;

public aspect FinJeu {
	pointcut callNotifyGameOver() : call(void notifyGameOver(Player));
	
	after() : callNotifyGameOver(){
		//Effectuer ici un arr�t du jeu
		System.out.println("Message g�n�r� par le Aspect FinJeu apr�s appel de la m�thode notifyGameOver()");
	}
}
