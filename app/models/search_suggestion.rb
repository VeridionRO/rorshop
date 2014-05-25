class SearchSuggestion < ActiveRecord::Base

  def self.terms_for(prefix)
    suggestions = where("term like ?", "#{prefix}_%")
    suggestions.order("popularity desc").limit(10).pluck(:term)
  end
  
  def self.index_products
    Product.find_each do |product|
      index_product product      
    end
  end

  def self.index_product product
    index_term(product.name)
    # index_term(product.category)
    product.name.split.each { |t| index_term(t) }
    # product.category.split.each { |t| index_term(t) }
    product.description.split.each { |t| index_term(t) }
    product.type_values.each { |t| index_term(t.value) }
  end
  
  def self.index_term(term)
    t = where(term: term).first
    if t.nil?
      t = SearchSuggestion.new(term: term, popularity: 1)
    else
      t.popularity=(t.popularity + 1)
    end
    t.save!
  end

end