module Reviews
  class SummaryForm < BaseForm
    property :comments,       type: Types::Strict::String
    property :terms_accepted, type: Types::Form::Bool

    validates :terms_accepted, presence: true
  end
end
