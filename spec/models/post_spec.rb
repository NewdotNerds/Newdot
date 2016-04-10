require "rails_helper"

RSpec.describe Post do
  describe "#publish" do
    it "sets published_at and saves the record" do
      post = build(:post)
      post.publish
      expect(post.published_at).to be_present
      expect(post).to be_persisted
    end
  end

  describe "#save_as_draft" do
    it "sets published_at to nil and saves the record" do
      post = build(:post)
      post.save_as_draft
      expect(post.published_at).to be_nil
      expect(post).to be_persisted
    end
  end

  describe "scopes" do
    let!(:post)  { create(:post) }
    let!(:draft) { create(:draft) }

    describe "published" do
      it "returns published posts" do
        posts = Post.published
        expect(posts).to include(post)
        expect(posts).not_to include(draft)
      end
    end

    describe "drafts" do
      it "returns drafts" do
        drafts = Post.drafts
        expect(drafts).to include(draft)
        expect(drafts).not_to include(post)
      end
    end
  end
end