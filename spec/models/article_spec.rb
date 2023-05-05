require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "is valid with a title and content" do
      article = Article.new(title: "New Article", content: "Article Content")
      expect(article).to be_valid
    end

    it "is invalid without a title" do
      article = Article.new(content: "Article Content")
      expect(article).to_not be_valid
    end

    it "is invalid without content" do
      article = Article.new(title: "New Article")
      expect(article).to_not be_valid
    end
  end
end