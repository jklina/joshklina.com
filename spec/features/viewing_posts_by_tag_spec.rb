require "rails_helper"

RSpec.feature "Viewing posts by tag", :type => :feature do
  scenario "a visitor can view published posts by clicking a tag" do
    tag1 = create(:tag, label: 'tag1')
    tag2 = create(:tag, label: 'tag2')
    post1 = create(:post, published: true, title: 'post1', tags: [tag1])
    post2 = create(:post, published: true, title: 'post2', tags: [tag2])

    visit root_path
    click_on 'tag1'

    expect(current_path).to eq(tag_path(tag1))
    expect(page).to have_text('post1')
    expect(page).to_not have_text('post2')
  end
end
