class ReplyRequestsController < ApplicationController
  before_action :set_reply_request, only: %i[ show edit update destroy ]

  # GET /reply_requests or /reply_requests.json
  def index
    @reply_requests = ReplyRequest.all
  end

  # GET /reply_requests/1 or /reply_requests/1.json
  def show
  end

  # GET /reply_requests/new
  def new
    @reply_request = ReplyRequest.new
  end

  # GET /reply_requests/1/edit
  def edit
  end

  # POST /reply_requests or /reply_requests.json
  def create
    @reply_request = ReplyRequest.new(reply_request_params)

    respond_to do |format|
      if @reply_request.save
        format.html { redirect_to @reply_request, notice: "Reply request was successfully created." }
        format.json { render :show, status: :created, location: @reply_request }
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

    # Only allow a list of trusted parameters through.
    def reply_request_params
      params.require(:reply_request).permit(:user_id, :email, :tone, :ai_reply)
    end
end
