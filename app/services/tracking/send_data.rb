module Tracking
  class SendData
    def initialize(request)
      @params = request.params
      @host_with_port = request.host_with_port
    end

    def call
      tracker.pageview(
        path: path,
        hostname: @host_with_port,
        title: 'Reviews view'
      )
      tracker.event(
        category: @params[:controller],
        action:   @params[:action],
        label:    @params[:id]
      )
    end

    private

    def tracker
      Staccato.tracker(Rails.application.secrets.tracking_id)
    end

    def path
      "#{@params[:controller]}/#{@params[:action]}/#{@params[:id]}"
    end
  end
end
