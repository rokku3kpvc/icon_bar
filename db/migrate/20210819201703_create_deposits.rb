class CreateDeposits < ActiveRecord::Migration[6.1]
  def up
    create_table :deposits do |t|
      t.string :owners_name, null: false
      t.integer :primary_size, null: false, default: 0
      t.integer :accumulated_size, null: false, default: 0
      t.timestamps
    end

    execute <<-DDL
      CREATE TYPE order_kind AS ENUM (
        'regular', 'deposit'
      );
    DDL

    execute <<-DDL
      CREATE TYPE order_state AS ENUM (
        'opened', 'confirmed'
      );
    DDL

    change_table :orders do |t|
      t.column :kind, :order_kind, null: false, default: 'regular'
      t.column :state, :order_state, null: false, default: 'opened'
      t.belongs_to :deposit
    end
  end

  def down
    drop_table :deposits
    remove_column :orders, :kind
    remove_column :orders, :deposit_id
    execute <<-DDL
      DROP TYPE order_kind;
      DROP TYPE order_state;
    DDL
  end
end
