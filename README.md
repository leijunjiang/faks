## Enoncé

tu as une liste de joueurs d'échecs avec leurs ages et scores (elo).
tu dois extraire de la liste les "champions"
un joueur est dit "champion" si et seulement si il n'y a personne d'autre dans la liste qui "l'élimine", c'est à dire:
 - personne d'autre n'est a la fois strictement plus fort et plus jeune ou même age
et
 - personne d'autre n'est à la fois strictement plus jeune et plus fort ou même score

ta mission: dans le language de ton choix, coder la fonction permettant de trouver les champions de la liste

On attachera une importance particulière aux points suivants:
- L'exactitude des resultats: Le(a) candidat(e) a t-il(elle) pensé(e) à la logique d'ensemble et aux cas particuliers ?
- La performance: Comment se comporte l'algorithme à mesure que le nombre de joueurs grandit ?
- La clarté et la lisibilité du code

## Instruction

je trie d'abord les joueurs par ordre décroissant de score, puis par ordre croissant d'âge pour chaque groupe de score,
le premier joueur de chaque groupe de score rencontré sera le joueur avec le score le plus élevé pour ce group

la complexité temporelle est O(n log n) en raison du tri initial.




