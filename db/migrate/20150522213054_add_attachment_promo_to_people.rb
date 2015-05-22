class AddAttachmentPromoToPeople < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.attachment :promo
    end
  end

  def self.down
    remove_attachment :people, :promo
  end
end
