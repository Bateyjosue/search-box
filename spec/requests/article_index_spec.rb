require 'rails_helper'
require 'capybara/rails'

RSpec.describe "Articles", type: :feature do
  scenario "displays a list of articles with titles and content" do
    article1 = Article.create(title: "Readme in github", content: "Readme in github more content")
    article2 = Article.create(title: "the rails hotwire", content: "with rails 7 you car render your without javascript but with hotwire")

    visit articles_path

    expect(page).to have_content(article1.title)
    expect(page).to have_content(article1.content)
    expect(page).to have_content(article2.title)
    expect(page).to have_content(article2.content)
  end
end