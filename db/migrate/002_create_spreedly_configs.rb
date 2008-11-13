class CreateSpreedlyConfigs < ActiveRecord::Migration
  def self.up
    create_table :spreedly_configs do |t|
      t.string :api_token
      t.string :login_name
      t.integer :plan_id
      t.string :mode
      t.timestamps
    end
  end

  def self.down
    drop_table :spreedly_configs
  end
end
