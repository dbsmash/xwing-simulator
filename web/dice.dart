import "dart:math";
import "constants.dart";

// math.random: used to simulate dice rolls
final _random = new Random();

// models one single attack die
class AttackDie {
  
    // simulats a single die by containing 8 possible options
    var resultList = [AttackResult.HIT, AttackResult.HIT, AttackResult.HIT, AttackResult.CRITICAL, AttackResult.FOCUS, AttackResult.FOCUS, AttackResult.BLANK, AttackResult.BLANK];
    
    // defaults to a blank result
    AttackResult result = AttackResult.BLANK;
  
    // 'rolls' this single die by randomly choosing a result from the resultList
    AttackResult roll () {
        result = resultList[_random.nextInt(resultList.length)];
    }
}

class EvadeDie {
    // simulats a single die by containing 8 possible options
    var resultList = [EvadeResult.EVADE, EvadeResult.EVADE, EvadeResult.EVADE, EvadeResult.FOCUS, EvadeResult.FOCUS, EvadeResult.FOCUS, EvadeResult.BLANK, EvadeResult.BLANK];
    
    // defaults to a blank result
    EvadeResult result = EvadeResult.BLANK;
    
    // 'rolls' this single die by randomly choosing a result from the resultList
    EvadeResult roll () {
        result = resultList[_random.nextInt(resultList.length)];
    }
}

class AttackRoll {
    // a roll contains a list of dice
    List<AttackDie> attackDice = new List();
    
    // whether or not the attack is focused; defaults to false
    bool isFocused = false;
    
    // constructor
    // param size: number of dice to include in the roll
    // param isfocused: whether or not this attack is from a focusing attacker
    AttackRoll(num size, bool isFocused) {
        for (var i = 0; i < size; i++) {
            attackDice.add(new AttackDie());
        }
        this.isFocused = isFocused;
    }
    
    // 'rolls' all of the dice in this roll individually
    void roll () {
        for (AttackDie die in attackDice) {
            die.roll();
        }
    }
    
    // gets the score of the attack (how much damage it would do), or how many hit/criticals there were
    // includes focus results only if the attacker is focusing
    int getScore() {
        int score = 0;
        for (AttackDie die in attackDice) {
            if (die.result == AttackResult.HIT || die.result == AttackResult.CRITICAL) {
              score++;
            }
            if (die.result == AttackResult.FOCUS && this.isFocused) {
                score++;
            }
        }
        return score;
    }
    
}

class EvadeRoll {
    // a roll contains a list of dice
    List<EvadeDie> evadeDice = new List();
    
    // whether or not the defender is focused; defaults to false
    bool isFocused = false;
    
    // constructor
    // param size: number of dice to include in the roll
    // param isfocused: whether or not this defense is from a focusing defender
    EvadeRoll(num size, bool isFocused) {
        for (var i = 0; i < size; i++) {
            evadeDice.add(new EvadeDie());
        }
        this.isFocused = isFocused;
    }
    
    // 'rolls' all of the dice in this roll individually
    void roll () {
        for (EvadeDie die in evadeDice) {
            die.roll();
        }
    }
    
    // gets the score of the defense (how much damage it would cancel), or how many evades there were
    // includes focus results only if the defender is focusing
    int getScore() {
        int score = 0;
        for (EvadeDie die in evadeDice) {
            if (die.result == EvadeResult.EVADE) {
                score++;
            }
            if (die.result == EvadeResult.FOCUS && this.isFocused) {
                score++;
            }
        }
        return score;
    }
}