class ShopBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :user_id, :created_at, :updated_at
end