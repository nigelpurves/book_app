class InterestParams
  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates_presence_of :artist_name

  attr_accessor :track_name, :artist_name


  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def save
    self.valid?
  end

  def persisted?
    false
  end

  def model_name
    "Interest"
  end

  def build_interest
    Interest.build_interest(@track_name, @artist_name)
  end

end
