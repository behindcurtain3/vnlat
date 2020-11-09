namespace :maint do
  desc "Update all booleans from t/f to 1/0"
  task :migrate_booleans => :environment do
    Appearance.where("uncredited = 't'").update_all(uncredited: 1)
    Appearance.where("uncredited = 'f'").update_all(uncredited: 0)

    Crew.where("featured = 't'").update_all(featured: 1)
    Crew.where("featured = 'f'").update_all(featured: 0)

    Like.where("love = 't'").update_all(love: 1)
    Like.where("love = 'f'").update_all(love: 0)

    Like.where("like = 't'").update_all(like: 1)
    Like.where("like = 'f'").update_all(like: 0)

    Like.where("hate = 't'").update_all(hate: 1)
    Like.where("hate = 'f'").update_all(hate: 0)

    Review.where("active = 't'").update_all(active: 1)
    Review.where("active = 'f'").update_all(active: 0)

    Trailer.where("active = 't'").update_all(active: 1)
    Trailer.where("active = 'f'").update_all(active: 0)
  end
end
