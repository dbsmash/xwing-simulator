part of xwing;

class _SimulationPanel extends Component {
    getInitialState() {
        return {
            'attackVal': '2',
            'evadeVal': '2',
            'attackFocus': false,
            'evadeFocus': false,
            'isTargetLocked':false,
            'attackRange': '2',
            'obstructed': false,
            'simulations': '1000'
        };
    }
    
    onAttackValChange(event) {
        this.setState({'attackVal': event.target.value});
    }
    
    onEvadeValChange(event) {
        this.setState({'evadeVal': event.target.value});
    }
    
    onAttackFocusChange(event) {
        this.setState({'attackFocus': event.target.checked});
    }

    onTargetLockedChange(event) {
        this.setState({'isTargetLocked': event.target.checked});
    }
    
    onEvadeFocusChange(event) {
        this.setState({'evadeFocus': event.target.checked});
    }
    
    onAttackRangeChange(event) {
        this.setState({'attackRange': event.target.value});
    }
    
    onObstructedChange(event) {
        this.setState({'obstructed': event.target.checked});
    }
    
    onSimulationsChange(event) {
        this.setState({'simulations': event.target.value});
    }
    
    onAttackButtonClick(event) {
        this.commenceAttack();
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
    
    commenceAttack() {
         int attackVal = int.parse(this.state['attackVal']);
         int evadeVal = int.parse(this.state['evadeVal']);
         int simulationNumber = int.parse(this.state['simulations']);
         int range = int.parse(this.state['attackRange']);
         
         bool attackFocus = this.state['attackFocus'];
         bool evadeFocus = this.state['evadeFocus'];
         bool obstructed = this.state['obstructed'];
         bool isTargetLocked = this.state['isTargetLocked'];
         
         if (range > 2) {
           evadeVal++;
         } else if (range < 2) {
           attackVal++;
         }
         
         if (obstructed) {
           evadeVal++;
         }
         
         double totalDamage = 0.0;
         for (var i = 0; i < simulationNumber; i++) {
             AttackRoll attRoll = new AttackRoll(attackVal, attackFocus, isTargetLocked);
             EvadeRoll evadeRoll = new EvadeRoll(evadeVal, evadeFocus);
                   
             attRoll.roll();
             evadeRoll.roll();
             int damage = scoreAttack(attRoll, evadeRoll);
             totalDamage += damage;
         }
         window.alert('Average damage done in the attack: ${totalDamage / simulationNumber}');
    }
    
    render() {
      return div({'className':'configurationPanel container'},
                [h1({'className':''},'X-Wing Damage Simulator'),
                  div({'className': 'form-group'}, [
                  label({'className':'cnlabel'}, 'Attack Value:'),
                  input({'className':'cnvalue', 'value':this.state['attackVal'],'onChange': this.onAttackValChange})
                  ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Evade Value:'),
                   input({'className':'cnvalue', 'value':this.state['evadeVal'],'onChange': this.onEvadeValChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Attacker Focusing:'),
                   input({'className':'cnvalue', 'type':'checkbox', 'value':this.state['attackFocus'],'onChange': this.onAttackFocusChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Attacker Target Locked:'),
                   input({'className':'cnvalue', 'type':'checkbox', 'value':this.state['isTargetLocked'],'onChange': this.onTargetLockedChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Defender Focusing:'),
                   input({'className':'cnvalue', 'type':'checkbox', 'value':this.state['evadeFocus'],'onChange': this.onEvadeFocusChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Attack Range:'),
                   input({'className':'cnvalue', 'type':'range', 'min':'1', 'max':'3', 'step':'1', 'value':this.state['attackRange'],'onChange': this.onAttackRangeChange}),
                   label({'className':'chaser'}, 'range '+this.state['attackRange'])
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Obstructed:'),
                   input({'className':'cnvalue', 'type':'checkbox', 'value':this.state['obstructed'],'onChange': this.onObstructedChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Simulation Number::'),
                   input({'className':'cnvalue', 'value':this.state['simulations'],'onChange': this.onSimulationsChange})
                   ]),
                 div({'className': 'form-group'}, [
                   label({'className':'cnlabel'}, 'Ready: '),
                   button({'className':'cnvalue btn btn-primary', 'onClick':this.onAttackButtonClick}, 'Attack!')
                   ])]);
    }
}

var SimulationPanel = registerComponent(() => new _SimulationPanel());
