require './lib/subscribers/experience_tracker'
require './lib/subscribers/promotions_tracker'
require './lib/subscribers/event_logger'

PlayerCreated = Class.new(RailsEventStore::Event)
PlayerMoved = Class.new(RailsEventStore::Event)
PlayerDestroyed = Class.new(RailsEventStore::Event)
PlayerTraded = Class.new(RailsEventStore::Event)
PlayerUpdatedData = Class.new(RailsEventStore::Event)
PlayerBoughtShip = Class.new(RailsEventStore::Event)
AchievementUnlocked = Class.new(RailsEventStore::Event)
PlayerLoadedColonists = Class.new(RailsEventStore::Event)
PlayerBoughtHolds = Class.new(RailsEventStore::Event)
PlayerBoughtFighters = Class.new(RailsEventStore::Event)
PlayerBoughtShieldPoints = Class.new(RailsEventStore::Event)
TradeRejected = Class.new(RailsEventStore::Event)
TradeAccepted = Class.new(RailsEventStore::Event)
CorporationCreated = Class.new(RailsEventStore::Event)
PlayerJoinedCorporation = Class.new(RailsEventStore::Event)
PlayerLeftcorporation = Class.new(RailsEventStore::Event)
PlayerGainedExperience = Class.new(RailsEventStore::Event)
PlayerPromoted = Class.new(RailsEventStore::Event)
