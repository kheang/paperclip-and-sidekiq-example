class AddStartTimeandLengthToRingtones < ActiveRecord::Migration
  def change
    add_column :ringtones, :start_time, :integer
    add_column :ringtones, :length, :integer, default: 30
  end
end
