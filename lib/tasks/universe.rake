namespace :universe do
  task recreate: :environment do
    Sector.delete_all
    0.upto(1000) do |i|
      Sector.spawn(i, true)
    end
    sectors = Sector.all
    sector_list = sectors.map(&:id)
    sectors.each do |sector|
      Sector.create_warps(sector.id, sector_list)
    end
  end
end
