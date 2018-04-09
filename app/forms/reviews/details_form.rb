module Reviews
  class DetailsForm < BaseForm
    property :name, type: Types::Strict::String
    property :age,  type: Types::Form::Int

    validates :name, :age, presence: true
    validates :age, numericality:
              {
                greater_than_or_equal_to: Review::MIN_AGE,
                less_than_or_equal_to:    Review::MAX_AGE
              }
  end
end
