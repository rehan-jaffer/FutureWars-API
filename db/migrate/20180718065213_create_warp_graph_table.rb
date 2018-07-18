class CreateWarpGraphTable < ActiveRecord::Migration[5.1]
  def up
    change_column :warps, :origin_id, :integer, null: false
    change_column :warps, :dest_id, :integer, null: false

    execute('CREATE TABLE `warp_graph` (
     `latch` varchar(32) DEFAULT NULL,
     `origid` bigint(20) unsigned DEFAULT NULL,
     `destid` bigint(20) unsigned DEFAULT NULL,
     `weight` double DEFAULT NULL,
     `seq` bigint(20) unsigned DEFAULT NULL,
     `linkid` bigint(20) unsigned DEFAULT NULL,
     KEY `latch` (`latch`,`origid`,`destid`) USING HASH,
     KEY `latch_2` (`latch`,`destid`,`origid`) USING HASH
    ) ENGINE=OQGRAPH DEFAULT CHARSET=latin1 `data_table`=warps `origid`=origin_id `destid`=dest_id')
  end
  def down
    remove_table :warp_graph
  end
 end
