class Warp < ApplicationRecord

    def self.connected?(origin, dest)
      where(origin_id: origin, dest_id: dest)
        .or(Warp.where(origin_id: dest, dest_id: origin)).count > 0
    end

end
