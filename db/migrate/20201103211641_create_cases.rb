class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.string :date
      t.integer :total_tests
      t.integer :pending_results
      t.integer :positive_cases
      t.integer :negative_results
      t.integer :recovered
      t.integer :active_cases
      t.integer :active_hospitalizations
      t.integer :discharged_today
      t.integer :resident_deaths
      t.integer :nonresident_deaths

      t.timestamps
    end
  end
end
