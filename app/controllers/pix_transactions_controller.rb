class PixTransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :index, :destroy]
  def index
    status = params[:status]
    if status.present?
      @pix_transactions = PixTransaction.where(status: status).order(created_at: :desc)
    else
      @pix_transactions = PixTransaction.order(created_at: :desc)
    end

    render json: @pix_transactions
  end

  def create
    Rails.logger.info "Parametros recebidos: #{params.inspect}"
    @pix_transaction = PixTransaction.new(pix_transaction_params)
    @pix_transaction.status = 'pending'

    if @pix_transaction.save
      if @pix_transaction.scheduled_at.present? && @pix_transaction.scheduled_at > Time.current
        PixTransactionJob.set(wait_until: @pix_transaction.scheduled_at).perform_later(@pix_transaction.id)
      else
        Pix_transactions::Organizers::Process_pix.call(pix_transaction: @pix_transaction)
      end

      qr_code = @pix_transaction.generate_qr_code

      render json: {
        pix_transaction: @pix_transaction,
        pix_key: qr_code.base64,
        qr_code: qr_code.payload
      }, status: :created
    else
      render json: @pix_transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pix_transaction = PixTransaction.find(params[:id])
    @pix_transaction.destroy

    render json: { message: 'Pix transaction deleted' }
  end

  private

  def pix_transaction_params
    params.require(:pix_transaction).permit(:pix_key, :amount, :scheduled_at, :pix_key_type)
  end

  def process_pix(transaction)
    if transaction.scheduled_at.present? && transaction.scheduled_at > Time.current
      transaction.update(status: 'pending')
    else
      transaction.update(status: 'completed')
    end
  end
end