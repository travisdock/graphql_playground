class MigrateToUuid < ActiveRecord::Migration[6.0]
  def up
    # Add UUID colums
    add_column :members, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :clubs, :uuid, :uuid, default: "gen_random_uuid()", null: false

    # Add UUID columns for associations
    add_column :clubs, :member_uuid, :uuid
    add_column :clubs_members, :club_uuid, :uuid
    add_column :clubs_members, :member_uuid, :uuid

    # Populate UUID columns for associations
    execute <<-SQL
      UPDATE clubs SET member_uuid = members.uuid
      FROM members WHERE clubs.member_id = members.id;
    SQL

    execute <<-SQL
      UPDATE clubs_members SET member_uuid = members.uuid
      FROM members WHERE clubs_members.member_id = members.id;
    SQL

    execute <<-SQL
      UPDATE clubs_members SET club_uuid = clubs.uuid
      FROM clubs WHERE clubs_members.club_id = clubs.id;
    SQL

    # Change null
    change_column_null :clubs, :member_uuid, false
    change_column_null :clubs_members, :member_uuid, false
    change_column_null :clubs_members, :club_uuid, false

    # Migrate UUID to ID for associations
    remove_column :clubs, :member_id
    rename_column :clubs, :member_uuid, :member_id

    remove_column :clubs_members, :member_id
    rename_column :clubs_members, :member_uuid, :member_id

    remove_column :clubs_members, :club_id
    rename_column :clubs_members, :club_uuid, :club_id

    # Add indexes for associations
    add_index :clubs, :member_id

    # Migrate primary keys from UUIDs to IDs
    remove_column :members, :id
    remove_column :clubs, :id
    rename_column :members, :uuid, :id
    rename_column :clubs, :uuid, :id

    execute "ALTER TABLE members ADD PRIMARY KEY (id);"
    execute "ALTER TABLE clubs ADD PRIMARY KEY (id);"

    # Add foreign keys
    add_foreign_key :clubs, :members
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
