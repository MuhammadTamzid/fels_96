require "rails_helper"

describe "words/index.html.erb" do
  subject{rendered}
  let!(:user) {FactoryGirl.create :user}
  let(:sample_words) do [
    FactoryGirl.create(:word),
    FactoryGirl.create(:word),
    FactoryGirl.create(:word)
  ]
  end

  before do
    assign :words, sample_words
  end

  context "request to words controller and index action" do
    it {expect(controller.request.path_parameters[:controller]).to eq "words"}
    it {expect(controller.request.path_parameters[:action]).to eq "index"}
  end
end
