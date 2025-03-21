class StaticPagesController < ApplicationController
    
    require 'fedapay'
  
    def create

      # Vous pouvez envisager de déplacer ces configurations dans un initializer
      FedaPay.api_key = 'sk_sandbox_XXXXXXXXXXX' # Remplacer par votre clé secrète

      FedaPay.environment = 'environment' # 'sandbox' Ou 'live' en production
  
      
        transaction = FedaPay::Transaction.create(
            amount: 100000,
            currency: { iso: 'XOF' },
            callback: "http://localhost:3000/",
            description: 'Achat de montre de luxe',
        )
        

        # Génération du token de la transaction
        token = transaction.generate_token

        # Redirection automatique vers la page de paiement
        redirect_to token.url, allow_other_host: true

        puts "Transaction successfully created : #{transaction.inspect}"  
    end
  end
  
