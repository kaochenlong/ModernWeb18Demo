require 'sinatra/base'
require_relative './app/blockchain'

class BlockchainWeb < Sinatra::Base
  set :port, ENV["HTTP_PORT"] || 9487

  configure do
    @@blockchain ||= Blockchain.new
  end

  before do
    content_type :json
  end

  # 列出目前所有的區塊
  get '/blocks' do
    @@blockchain.chain.map(&:to_hash).to_json
  end

  # 新增交易
  post '/add_transaction' do
    params = request.params
    tx = Transaction.new(from: params["from"],
                         to: params["to"],
                         amount: params["amount"])
    tx_pool = @@blockchain.add_transaction(tx)

    tx_pool.map(&:to_hash).to_json
  end

  # 檢視目前所有未處理交易
  get '/transactions' do
    @@blockchain.transaction_pool.map(&:to_hash).to_json
  end

  # 進行一個挖擴的動作!
  post '/mine' do
    @@blockchain.mine!
    redirect '/blocks'
  end

  run!
end