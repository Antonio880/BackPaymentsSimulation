module PixTransactions
    module Interactors
        class ProcessPix
            include Interactor
            delegate :transaction, to: :context
            def call
                # Simulação de processamento de PIX
                if transaction.scheduled_at.present? && transaction.scheduled_at > Time.current
                    # Agendar processamento
                    transaction.update(status: 'pending')
                else
                    # Processar imediatamente
                    transaction.update(status: 'completed')
                end
                end
            end
        end
    end