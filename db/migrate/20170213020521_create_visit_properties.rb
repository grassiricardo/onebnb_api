class CreateVisitProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :visit_properties do |t|

    end

    add_reference :visit_properties, :property, foreign_key: true
    add_reference :visit_properties, :user, foreign_key: true
  end
end
