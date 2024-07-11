class PixTransactionJob < ApplicationJob
    queue_as :default
  
    def perform(pix_transaction_id)
      pix_transaction = PixTransaction.find(pix_transaction_id)
      if pix_transaction.scheduled_at.present? && pix_transaction.scheduled_at > Time.current
        # Schedule the job to run at the scheduled time
        PixTransactionJob.set(wait_until: pix_transaction.scheduled_at).perform_later(pix_transaction.id)
      else
        process_pix(pix_transaction)
      end
    end

    private

    def process_pix(transaction)
      transaction.update(status: 'completed')
      # Adicione a lógica de processamento do PIX aqui, se necessário
    end
  end