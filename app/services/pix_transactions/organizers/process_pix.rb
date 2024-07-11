module PixTransaction
    module Organizers
        class ProcessPix
            include Interactor::Organizer
            organize( 
                PixTransactions::Interactors::ProcessPix
            )
        end
    end
end