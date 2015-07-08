require 'rails_helper'

RSpec.describe Admin::FlashesHelper, type: :helper do
  it "converts the the flash into a hash" do
    flash = double("flash")
    allow(flash).to receive(:to_hash).and_return({})
    allow(helper).to receive(:flash).and_return(flash)

    helper.user_facing_flashes

    expect(flash).to have_received(:to_hash)
  end

  it "removes unneeded keys" do
    flash = { "a" => "1",
              "alert" => "2",
              "error" => "3",
              "notice" => "4",
              "success" => "5"
            }

    allow(helper).to receive(:flash).and_return(flash)

    processed_flash = helper.user_facing_flashes

    expect(processed_flash).to include("alert")
    expect(processed_flash).to_not include("a")
  end
end
