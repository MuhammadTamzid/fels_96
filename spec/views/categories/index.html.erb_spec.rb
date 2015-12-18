require "rails_helper"

describe "categories/index.html.erb" do
  subject{rendered}
  let(:sample_categories) do [
    FactoryGirl.create(:category),
    FactoryGirl.create(:category),
    FactoryGirl.create(:category)
  ]
  end

  before do
    assign :categories, sample_categories
  end

  context "request to categories controller and index action" do
    it {expect(controller.request.path_parameters[:controller]).to eq "categories"}
    it {expect(controller.request.path_parameters[:action]).to eq "index"}
  end
end
