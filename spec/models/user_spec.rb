require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "requires a unique username" do
      user1 = create(:user, username: 'exampleuser')
      user2 = build(:user, username: 'exampleuser')
      user2.valid?
      expect(user2.errors[:username]).to include('has already been taken')
    end
 
    it "requires a username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end
  end

  describe "user relationships" do
    let(:luke) { create(:user, username: "Luke Skywalker") }
    let(:solo) { create(:user, username: "Han Solo") }

    it "can follow and unfollow a user" do
      expect(luke).not_to be_following(solo)

      luke.follow(solo)
      expect(luke).to be_following(solo)
      expect(solo.followers).to include(luke)

      luke.unfollow(solo)
      expect(luke).not_to be_following(solo)
      expect(solo.followers).not_to include(luke)
    end

    it "returns false when asked whether a user is following self" do
      expect(luke.following?(luke)).to be_falsy
    end

    it "does not allow to follow self" do
      expect { luke.follow(luke) }.not_to change { Relationship.count }
      expect(luke.follow(luke)).to be_falsy
    end
  end

  describe "user interests" do
    let(:user) { create(:user) }
    let(:music_tag) { Tag.create(name: "Music") }

    it "can follow and unfollow a tag" do
      expect(user).not_to be_following_tag(music_tag)

      user.follow_tag(music_tag)
      expect(user).ro be_following_tag(music_tag)

      user.unfollow_tag(music_tag)
      expect(user).not_to be_following_tag(music_tag)
    end
  end

  describe "adding likes" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:response) { build(:response) }
    before :each do
      post.responses << response
    end

    it "can like and unlike a post" do
      user.add_like_to(post)
      expect(user.likes_post?(post)).to be_truthy

      user.remove_like_from(post)
      expect(user.likes_post?(post)).to be_falsy

      it "can like and unlike a response" do
        user.add_like_to(response)
        expect(user.likes_response?(response)).to be_truthy

        user.remove_like_from(response)
        expect(user.likes_response?(response)).to be_falsy
      end
    end
  end
end



