module Reviews
  class RatingsForm < BaseForm
    property :rating_1, type: Types::Form::Int
    property :rating_2, type: Types::Form::Int

    validates :rating_1, :rating_2, presence: true
    validates :rating_1, :rating_2,
              inclusion: {
                in: (Review::MIN_RATING_SCORE..Review::MAX_RATING_SCORE).to_a
              }
  end
end
