class TextsController < ApplicationController
  def index
    @texts = Text.where(usuario: params[:usuario])
    logger.info "Cargando textos, Total: #{@texts.count}"
    render json: @texts
  end
  
  def create
    @text = Text.new(text_params)
    if @text.save
      render json: @text, status: :created
    else
      render json: @text.errors, status: :unprocessable_entity
    end
  end
  
  def update
    @text = Text.find(params[:id])
    @text.usuario = params[:usuario]
    if @text.update(text_params)
      render json: @text
    else
      render json: @text.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @text = Text.find(params[:id])
    if @text.destroy
      head :ok
    else
      render json: { error: "Failed to delete" }, status: :unprocessable_entity
    end
  end

  private

  def text_params
    params.require(:text).permit(:content, :bold, :italic, :underline, :usuario)
  end
end
