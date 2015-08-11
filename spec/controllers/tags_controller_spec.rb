require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe "GET #show" do
    it "finds the given tag" do
      tag = create(:tag)

      get :show, id: tag

      expect(assigns(:tag)).to eq(tag)
    end

    it "finds all the published posts ordered by date with the tag" do
      tag = create(:tag)
      tagged_older_post = create(:post, published: true, tags: [tag])
      tagged_newer_post = create(:post, published: true, tags: [tag])
      tagged_unpublished_post = create(:post, published: false, tags: [tag])
      untagged_post = create(:post, published: true)

      tagged_older_post.published_at = Date.today - 2.days
      tagged_newer_post.published_at = Date.today
      tagged_older_post.save!
      tagged_newer_post.save!
      get :show, id: tag

      expect(assigns(:posts)).to eq([tagged_newer_post, tagged_older_post])
    end
  end

end
