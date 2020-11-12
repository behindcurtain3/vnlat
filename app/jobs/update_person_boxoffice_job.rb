class UpdatePersonBoxofficeJob < ApplicationJob
  queue_as :default

  def perform(*ids)
    people = Person.where(id: ids)
    people.each do |person|
      # sum up the box office totals of all their credited work and cache it
      result_us = Person.joins(:movies)
                  .select('sum(boxoffice_us) as "sum_us"')
                  .where.not({ movies: { boxoffice_us: nil } })
                  .where.not({ appearances: { uncredited: true } })
                  .where(id: person.id)
                  .first
      
      person.boxoffice_us_cache = result_us.sum_us

      result_fo = Person.joins(:movies)
                  .select('sum(boxoffice_foreign) as "sum_foreign"')
                  .where.not({ movies: { boxoffice_foreign: nil } })
                  .where.not({ appearances: { uncredited: true } })
                  .where(id: person.id)
                  .first

      person.boxoffice_foreign_cache = result_fo.sum_foreign
      person.boxoffice_worldwide_cache = person.boxoffice_us_cache + person.boxoffice_foreign_cache
      person.save
    end
  end
end
