# app/models/pix_transaction.rb
class PixTransaction < ApplicationRecord
  require 'qrcode_pix_ruby'

  validates :pix_key, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  # Remove ou comente a linha abaixo
  # validates :scheduled_at, presence: true

  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }
  
    def generate_qr_code
      qr_code = QrcodePixRuby::Payload.new(
        pix_key:        pix_key,
        description:    'teste',
        merchant_name:  'Student Test',
        merchant_city:  'ITAPAJE',
        transaction_id: 'TID12345',
        amount:         amount,
        currency:       '986',
        country_code:   'BR',
        postal_code:    '62600000',
        repeatable:     false
      )
      qr_code
    end
  
    def generate_pix_key
      pix_key_data = "00020126360014BR.GOV.BCB.PIX0114#{pix_key}52040000530398654041.005802BR5925Nome do Recebedor6009Cidade62070503***6304"
      "#{pix_key_data}#{calculate_checksum(pix_key_data)}"
    end
    
    private
    
    def calculate_checksum(data)
      # Implementar a lógica de cálculo do checksum aqui
      # Este é apenas um exemplo fictício
      checksum = 0
      data.each_byte { |byte| checksum ^= byte }
      checksum.to_s(16).upcase
    end
  end