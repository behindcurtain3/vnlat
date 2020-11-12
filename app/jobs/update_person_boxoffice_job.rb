class UpdatePersonBoxofficeJob < ApplicationJob
  queue_as :default

  def perform(*ids)
    people = Person.where(id: ids)
    people.each do |person|
      # sum up the box office totals of all their credited work and cache it
      result_us = Person.joins(:movies)
                  .select('people.id, sum(boxoffice_us) as "sum_us"')
                  .where.not({ movies: { boxoffice_us: nil } })
                  .where.not({ appearances: { uncredited: true } })
                  .where(id: person.id)
                  .first
      
      us_cache = result_us.nil? || result_us.sum_us.blank? ? 0 : result_us.sum_us

      result_fo = Person.joins(:movies)
                  .select('people.id, sum(boxoffice_foreign) as "sum_foreign"')
                  .where.not({ movies: { boxoffice_foreign: nil } })
                  .where.not({ appearances: { uncredited: true } })
                  .where(id: person.id)
                  .first

      foreign_cache = result_fo.nil? || result_fo.sum_foreign.blank? ? 0 : result_fo.sum_foreign

      puts "#{person.id} (#{us_cache}, #{foreign_cache})"

      person.boxoffice_us_cache         = us_cache
      person.boxoffice_foreign_cache    = foreign_cache
      person.boxoffice_worldwide_cache  = us_cache + foreign_cache
      person.save
    end
  end
end
