module Controllers
  module RelationFinders
    def finds_tags_for
      tag = create(:tag)

      yield

      expect(assigns(:tags)).to eq([tag])
    end

    def finds_authors_for
      author = create(:user)
      authors = Exposition::User.all

      yield

      expect(assigns(:authors)).to eq(authors)
    end
  end
end
