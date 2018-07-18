require 'pp'
require_relative '../app/blockchain'
require_relative '../app/transaction'

blockchain = Blockchain.new
tx1 = Transaction.new(from: 'Eddie', to: 'Sherly', amount: 10)
blockchain.add_transaction(tx1)

pp blockchain