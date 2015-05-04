part of xwing;

class _SimulationPanel extends Component {
    getInitialState() {
        return {
            'attackVal': '2',
            'evadeVal': '2',
            'attackFocus': 'false',
            'evadeFocus': 'false',
            'attackRange': '2',
            'obstructed': 'false',
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
        this.setState({'attackFocus': event.target.value});
    }
    
    onEvadeFocusChange(event) {
        this.setState({'evadeFocus': event.target.value});
    }
    
    onAttackRangeChange(event) {
        this.setState({'attackRange': event.target.value});
    }
    
    onObstructedChange(event) {
        this.setState({'obstructed': event.target.value});
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
         
         bool attackFocus = this.state['attackFocus'] == 'true';
         bool evadeFocus = this.state['evadeFocus'] == 'true';
         bool obstructed = this.state['obstructed'] == 'true';
         
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
             AttackRoll attRoll = new AttackRoll(attackVal, attackFocus);
             EvadeRoll evadeRoll = new EvadeRoll(evadeVal, evadeFocus);
                   
             attRoll.roll();
             evadeRoll.roll();
             int damage = scoreAttack(attRoll, evadeRoll);
             totalDamage += damage;
         }
         window.alert('Average damage done in the attack: ${totalDamage / simulationNumber}');
    }
    
    render() {
        return div({'className':'configurationPanel'},
            [form({},
            [label({}, 'Attack Value:'),
             input({'value':this.state['attackVal'],'onChange': this.onAttackValChange}),
             br({}),
             label({}, 'Evade Value:'),
             input({'value':this.state['evadeVal'],'onChange': this.onEvadeValChange}),
             br({}),
             label({}, 'Attacker Focusing:'),
             input({'type':'checkbox', 'value':this.state['attackFocus'],'onChange': this.onAttackFocusChange}),
             br({}),
             label({}, 'Defender Focusing:'),
             input({'type':'checkbox', 'value':this.state['evadeFocus'],'onChange': this.onEvadeFocusChange}),
             br({}),
             label({}, 'Attack Range:'),
             input({'type':'range', 'min':'1', 'max':'3', 'step':'1', 'value':this.state['attackRange'],'onChange': this.onAttackRangeChange}),
             br({}),
             label({}, 'Obstructed:'),
             input({'type':'checkbox', 'value':this.state['obstructed'],'onChange': this.onObstructedChange}),
             br({}),
             label({}, 'Simulation Number::'),
             input({'value':this.state['simulations'],'onChange': this.onSimulationsChange}),
             br({})]),
             button({'onClick':this.onAttackButtonClick}, 'Attack!')]);
    }
}

var SimulationPanel = registerComponent(() => new _SimulationPanel());