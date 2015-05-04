part of xwing;

// math.random: used to simulate dice rolls
final _random = new Random();

// abstract class describing a Die
abstract class Die {
  void roll ();
}

// models one single attack die
class AttackDie extends Die {
  
    // simulats a single die by containing 8 possible options
    var resultList = [AttackResult.HIT, AttackResult.HIT, AttackResult.HIT, AttackResult.CRITICAL, AttackResult.FOCUS, AttackResult.FOCUS, AttackResult.BLANK, AttackResult.BLANK];
    
    // defaults to a blank result
    AttackResult result = AttackResult.BLANK;
  
    // 'rolls' this single die by randomly choosing a result from the resultList
    void roll () {
        result = resultList[_random.nextInt(resultList.length)];
    }
}

class EvadeDie extends Die {
    // simulats a single die by containing 8 possible options
    var resultList = [EvadeResult.EVADE, EvadeResult.EVADE, EvadeResult.EVADE, EvadeResult.FOCUS, EvadeResult.FOCUS, EvadeResult.FOCUS, EvadeResult.BLANK, EvadeResult.BLANK];
    
    // defaults to a blank result
    EvadeResult result = EvadeResult.BLANK;
    
    // 'rolls' this single die by randomly choosing a result from the resultList
    void roll () {
        result = resultList[_random.nextInt(resultList.length)];
    }
}

// abstract class describing a Roll
abstract class Roll {
    // all Rolls contain a list of Die
    List<Die> dice = new List();
    
    // all Rolls can be focused or not, which affects their scoring
    bool isFocused = false;
    
    // all Rolls can actually be rolled out which just involves rolling each Die
    void roll () {
      for (Die die in dice) {
          die.roll();
      }
    }
}

class AttackRoll extends Roll {
    
    // constructor
    // param size: number of dice to include in the roll
    // param isfocused: whether or not this attack is from a focusing attacker
    AttackRoll(num size, bool isFocused) {
        for (var i = 0; i < size; i++) {
          dice.add(new AttackDie());
        }
        this.isFocused = isFocused;
    }
    
    // gets the score of the attack (how much damage it would do), or how many hit/criticals there were
    // includes focus results only if the attacker is focusing
    int getScore() {
        int score = 0;
        for (AttackDie die in dice) {
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

class EvadeRoll extends Roll {
    // constructor
    // param size: number of dice to include in the roll
    // param isfocused: whether or not this defense is from a focusing defender
    EvadeRoll(num size, bool isFocused) {
        for (var i = 0; i < size; i++) {
          dice.add(new EvadeDie());
        }
        this.isFocused = isFocused;
    }
    
    // gets the score of the defense (how much damage it would cancel), or how many evades there were
    // includes focus results only if the defender is focusing
    int getScore() {
        int score = 0;
        for (EvadeDie die in dice) {
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