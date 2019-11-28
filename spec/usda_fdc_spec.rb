RSpec.describe UsdaFdc do
  it "has a version number" do
    expect(UsdaFdc::VERSION).not_to be nil
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end

  it "fails without an api_key provided" do
    expect{UsdaFdc::Client.new}.to raise_error (ArgumentError)
  end

end
