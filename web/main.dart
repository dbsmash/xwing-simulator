import 'dart:html';
import 'dice.dart';

// actually runs a suite of simulations
void simulateAttack(Event e) {
    int attackVal = int.parse(querySelector('#attackVal').value);
    int evadeVal = int.parse(querySelector('#evadeVal').value);
    int simulationNumber = int.parse(querySelector('#simulationVal').value);
    bool attackFocus = querySelector('#attackFocus').checked;
    bool evadeFocus = querySelector('#evadeFocus').checked;
    
    int range = int.parse(querySelector('#rangeSlider').value);
    if (range > 2) {
      evadeVal++;
    } else if (range < 2) {
      attackVal++;
    }
    
    double totalDamage = 0.0;
    for (var i = 0; i < simulationNumber; i++) {
        AttackRoll attRoll = new AttackRoll(attackVal, attackFocus);
        EvadeRoll evadeRoll = new EvadeRoll(evadeVal, evadeFocus);
              
        attRoll.roll();
        evadeRoll.roll();
        int damage =scoreAttack(attRoll, evadeRoll);
        totalDamage += damage;
    }
    
    window.alert('Average damage done in the attack: ${totalDamage / simulationNumber}');
}

// scores a given attack, by comparing the strength of the attack versus the strength of the defense
// returns zero if the attack value didn't exceed the defense value
int scoreAttack(AttackRoll attack, EvadeRoll evade) {
 int attackScore = attack.getScore();
 int evadeScore = evade.getScore();
 if (attackScore > evadeScore) {
     int damage = attackScore - evadeScore;
     return damage;
 } 
 return 0;
}

// main just wires up the button listeners to start an attack simulation
void main() {
    querySelector('#attackButton').onClick.listen(simulateAttack);
}
