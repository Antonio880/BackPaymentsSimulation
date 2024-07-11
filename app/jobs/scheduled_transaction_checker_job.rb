class ScheduledTransactionCheckerJob < ApplicationJob
    queue_as :default
  
    def perform
      PixTransaction.where(status: 'pending').where('scheduled_at <= ?', Time.current).find_each do |transaction|
        PixTransactionJob.perform_later(transaction.id)
      end
    end
  end
  