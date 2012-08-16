VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :fakeweb
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
