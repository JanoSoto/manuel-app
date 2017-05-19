class ChangePaymentsPayDate < ActiveRecord::Migration
  def up
    change_column :payments, :pay_date, :datetime
  end

  def down
    change_column :payments, :pay_date, :date
  end
end
