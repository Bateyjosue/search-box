class Article < ApplicationRecord
  has_many :searches

  # def self.search(query)
  #   if query.present?
  #     where('title LIKE ?', "%#{query}%")
  #   else
  #     all
  #   end
  # end
end
