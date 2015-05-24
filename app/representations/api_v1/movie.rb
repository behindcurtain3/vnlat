module ApiV1::Movie
  extend ActiveSupport::Concern
  included do

    api_accessible :public do |t|
      t.add :slug, as: :id
      t.add :title
      t.add :year
      t.add :avg_v, as: :V
      t.add :avg_n, as: :N
      t.add :avg_l, as: :L
      t.add :avg_at, as: :AT
      t.add :thumb, as: :thumbnail
      t.add :medium, as: :poster
    end
  
    api_accessible :detailed, extend: :public do |t|
      t.add :tag_list
      t.add :director, template: :simple
      t.add :summary
      t.add :boxoffice_us
      t.add :boxoffice_foreign
      t.add :boxoffice_worldwide
    end

  end
end
