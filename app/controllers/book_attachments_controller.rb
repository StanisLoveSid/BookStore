class BookAttachmentsController < ApplicationController
  before_action :set_book_attachment, only: [:show, :edit, :update, :destroy]

  # GET /book_attachments
  # GET /book_attachments.json
  def index
    @book_attachments = BookAttachment.all
  end

  # GET /book_attachments/1
  # GET /book_attachments/1.json
  def show
  end

  # GET /book_attachments/new
  def new
    @book_attachment = BookAttachment.new
  end

  # GET /book_attachments/1/edit
  def edit
  end

  # POST /book_attachments
  # POST /book_attachments.json
  def create
    @book_attachment = BookAttachment.new(book_attachment_params)

    respond_to do |format|
      if @book_attachment.save
        format.html { redirect_to @book_attachment, notice: 'Book attachment was successfully created.' }
        format.json { render :show, status: :created, location: @book_attachment }
      else
        format.html { render :new }
        format.json { render json: @book_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_attachments/1
  # PATCH/PUT /book_attachments/1.json
  def update
    respond_to do |format|
      if @book_attachment.update(book_attachment_params)
        format.html { redirect_to @book_attachment, notice: 'Book attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_attachment }
      else
        format.html { render :edit }
        format.json { render json: @book_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_attachments/1
  # DELETE /book_attachments/1.json
  def destroy
    @book_attachment.destroy
    respond_to do |format|
      format.html { redirect_to book_attachments_url, notice: 'Book attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_attachment
      @book_attachment = BookAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_attachment_params
      params.require(:book_attachment).permit(:book_id, :photo)
    end
end
