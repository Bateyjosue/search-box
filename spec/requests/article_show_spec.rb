require 'rails_helper'

RSpec.describe 'Articles', type: :feature do
  let!(:article) { Article.create(title: "Readme in github", content: "Readme in github more content") }
  scenario 'show article details with title, content, and destroy link' do
    visit article_path(article)

    expect(page).to have_content(article.title)
    expect(page).to have_content(article.content)
    expect(page).to have_link('Destroy', href: article_path(article))
  end
end