class BattleOdds
  def initialize(attacker, defender)
    @attacker = attacker
    @defender = defender
    @attacker_odds = (@attacker.primary_ship.fighters * @attacker.primary_ship.ship_type.offensive_odds)
    @defender_odds = (@defender.primary_ship.fighters * (@defender.primary_ship.ship_type.defensive_odds))
  end

  def success?
    battle(@attacker_odds, @defender_odds)
  end

  def battle(odds1, odds2)
    score = rand * (odds1 + odds2)
    (score > odds1) ? 2 : 1
  end
end

