class ReviewsController < ApplicationController
  before_action :send_tracking_data

  include Wicked::Wizard

  steps :details, :ratings, :summary, :finish

  def show
    prepare_form_for_step
    store_review_id_in_session
    render_wizard
  end

  def update
    prepare_form_for_step
    if @form.process(form_params)
      redirect_to success_path
    else
      render_wizard
    end
  end

  def finish
    session.clear
  end

  private

  def send_tracking_data
    Tracking::SendData.new(request).call
  end

  def prepare_form_for_step
    @form = Reviews::FormForStep.new(step, session[:review_id]).form
  end

  def store_review_id_in_session
    session[:review_id] = @form.model.id
  end

  def form_params
    key_name = "reviews_#{step}".to_sym
    params.fetch(key_name, {})
  end

  def success_path
    return finish_reviews_path if next_step?(:finish)
    next_wizard_path
  end
end
