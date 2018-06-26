require './lib/universe'

namespace :universe do
  task recreate: :environment do
    Sector.delete_all
    Universe.create(1000)
  end
end
