module ApiV1::Person
  extend ActiveSupport::Concern
  included do

    api_accessible :simple do |t|
      t.add :slug, as: :id
      t.add :name
    end

    api_accessible :public, extend: :simple do |t|
      t.add :born
      t.add :age
      t.add :died
      t.add :promo, as: :promo
    end
    
    api_accessible :detailed, extend: :public do |t|
      t.add :biography
      t.add :twitter
      t.add :movies, template: :simple
    end
    
  end
end
