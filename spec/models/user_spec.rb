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
      expect(user.following_tag?(music_tag)).to be_falsy

      user.follow_tag(music_tag)
      expect(user.following_tag?(music_tag)).to be_truthy

      user.unfollow_tag(music_tag)
      expect(user.following_tag?(music_tag)).to be_falsy
    end
  end
end