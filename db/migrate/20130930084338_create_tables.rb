class CreateTables < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string :username

    	t.timestamps
    end

    create_table :events do |t|
    	t. string :description
    	t.datetime :date

    	t.timestamps
    end
  end

  def down
  	drop_table :users
  	drop_table :events
  end
end
