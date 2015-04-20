// all the possible options for an attack die roll
enum AttackResult {
  HIT,      // directed hit
  FOCUS,    // turns into a hit only if the attacker is focusing
  CRITICAL, // critical hit, treated as a normal hit atm
  BLANK     // blank die - no effect
}

// all the possible options for an evade die roll
enum EvadeResult {
  EVADE,    // evades one normal or critical hit
  FOCUS,    // turns into an evade only if the defender is focusing
  BLANK     // blank die - no effect
}