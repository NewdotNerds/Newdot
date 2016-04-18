require "rails_helper"

RSpec.describe Tag do
  describe "#first_or_create_with_name!" do
    it "searchs in DB with name case insensitively and simply returns if there's a match" do
      tag = Tag.create(name: "Music", lowercase_name: 'music')
      expect(Tag.first_or_create_with_name!('Music')).to eq(tag)
    end

    it "creates a new tag if there's no match" do
      tag = Tag.first_or_create_with_name!("Star Wars")
      expect(tag.name).to eq("Star Wars")
      expect(tag.lowercase_name).to eq("star wars")
    end
  end
end