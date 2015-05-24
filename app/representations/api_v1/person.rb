module ApiV1::Person
  extend ActiveSupport::Concern
  included do

    api_accessible :public do |t|
      t.add :slug, as: :id
      t.add :name
      t.add :born
      t.add :age
      t.add :died
      t.add :promo, as: :promo
    end
    
    api_accessible :detailed, extend: :public do |t|
      t.add :biography
      t.add :twitter
    end
    
    api_accessible :simple do |t|
      t.add :slug, as: :id
      t.add :name
    end
    
  end
end
