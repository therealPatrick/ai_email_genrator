class ReplyRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reply_request, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[ show edit update destroy ]
  before_action :check_reply_limit, only: [:new, :create]

  # GET /reply_requests or /reply_requests.json
  def index
    @reply_requests = current_user.reply_requests.order(created_at: :desc)
  end

  # GET /reply_requests/1 or /reply_requests/1.json
  def show
  end

  # GET /reply_requests/new
  def new
    @reply_request = current_user.reply_requests.build
  end

  # GET /reply_requests/1/edit
  def edit
  end

  # POST /reply_requests or /reply_requests.json
  def create
    @reply_request = current_user.reply_requests.build(reply_request_params)

    respond_to do |format|
      if @reply_request.save
        begin
          # Generate AI reply
          generator = AiReplyGenerator.new(@reply_request.email, @reply_request.tone)
          ai_reply = generator.generate
          @reply_request.update(ai_reply: ai_reply)

          format.html { redirect_to @reply_request, notice: "Reply was successfully generated." }
          format.json { render :show, status: :created, location: @reply_request }
        rescue => e
          @reply_request.destroy
          format.html { redirect_to new_reply_request_path, alert: "Error generating reply: #{e.message}" }
          format.json { render json: { error: e.message }, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reply_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reply_requests/1 or /reply_requests/1.json
  def update
    respond_to do |format|
      if @reply_request.update(reply_request_params)
        format.html { redirect_to @reply_request, notice: "Reply request was successfully updated." }
        format.json { render :show, status: :ok, location: @reply_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reply_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_requests/1 or /reply_requests/1.json
  def destroy
    @reply_request.destroy!

    respond_to do |format|
      format.html { redirect_to reply_requests_path, status: :see_other, notice: "Reply request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply_request
      @reply_request = ReplyRequest.find(params[:id])
    end

    def authorize_user
      unless @reply_request.user == current_user
        redirect_to reply_requests_path, alert: "You are not authorized to access this reply request."
      end
    end

    def check_reply_limit
      unless current_user.can_generate_reply?
        redirect_to new_subscription_path, alert: "You've used all your free replies. Please upgrade to continue."
      end
    end

    # Only allow a list of trusted parameters through.
    def reply_request_params
      params.require(:reply_request).permit(:email, :tone)
    end
end
