module Reviews
  class FormForStep
    def initialize(step, session_review_id)
      @step      = step
      @review_id = session_review_id
    end

    def form
      @form ||= form_for_step
    end

    private

    FORM_CLASS_MAPPING = {
      details: Reviews::DetailsForm,
      ratings: Reviews::RatingsForm,
      summary: Reviews::SummaryForm
    }.freeze

    private_constant :FORM_CLASS_MAPPING

    def form_for_step
      form_class = FORM_CLASS_MAPPING.fetch(@step)
      form_class.new(prepare_review)
    end

    def prepare_review
      return review_from_session if @review_id.present?
      create_review
    end

    def review_from_session
      Review.find(@review_id)
    end

    def create_review
      Review.create
    end
  end
end
