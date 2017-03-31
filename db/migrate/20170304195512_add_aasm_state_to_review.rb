class AddAasmStateToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :aasm_state, :string
  end
end
