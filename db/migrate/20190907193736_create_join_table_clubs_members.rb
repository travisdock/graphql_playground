class CreateJoinTableClubsMembers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :clubs, :members do |t|
      # t.index [:club_id, :member_id]
      # t.index [:member_id, :club_id]
    end
  end
end
