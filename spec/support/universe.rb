def create_universe

  Sector.destroy_all
  Port.destroy_all
  Warp.destroy_all

  FactoryBot.create_list(:sector, 10)
  FactoryBot.create(:special_port, sector_id: 1)
  FactoryBot.create(:port, sector_id: 2, port_class: 3)
  FactoryBot.create(:port, sector_id: 3, port_class: 3)
  FactoryBot.create(:port, sector_id: 4, port_class: 5)
  FactoryBot.create(:port, sector_id: 5, port_class: 6)
  1.upto(10) do |i|
    1.upto(10) do |j|
      next if i == j
      create_warp(i, j)
    end
  end
  create_tunnel
  create_hole
  FactoryBot.create(:planet, sector_id: 4, planet_type_id: FactoryBot.create(:planet_type).id)

end

def create_tunnel
  11.upto(14) do |i|
    FactoryBot.create(:sector, id: i)
  end

  10.upto(14).to_a.each_cons(2) do |i, j|
    create_warp(i, j)
  end
end

def create_hole
  FactoryBot.create(:sector, id: 15)
end

def create_warp(from, to)
  Warp.create(origin_id: from, dest_id: to)
end
