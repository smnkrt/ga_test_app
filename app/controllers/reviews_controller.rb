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
    form_valid? ? proceed : render_wizard
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

  def form_valid?
    @form.process(form_params)
  end

  def store_review_id_in_session
    session[:review_id] = @form.model.id
  end

  def form_params
    key_name = "reviews_#{step}".to_sym
    params.fetch(key_name, {})
  end

  def proceed
    path = next_step?(:finish) ? finish_reviews_path : next_wizard_path
    redirect_to(path)
  end
end
