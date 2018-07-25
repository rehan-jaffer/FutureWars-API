class Warp < ApplicationRecord

    def self.connected?(origin, dest)
      where(origin_id: origin, dest_id: dest)
        .or(Warp.where(origin_id: dest, dest_id: origin)).count > 0
    end

    def self.connect(orig, dest)
      Warp.create!(origin_id: orig, dest_id: dest)
    end

    def self.warps_for(id)
      Warp.where(origin_id: id)
          .or(Warp.where(dest_id: id))
          .map { |el| [el[:origin_id], el[:dest_id]] }
          .flatten
          .uniq
          .reject { |x| x == id }
    end

end
