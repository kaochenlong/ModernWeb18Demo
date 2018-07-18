require_relative './block'
require_relative './transaction'

class Blockchain
  attr_reader :chain
  attr_reader :transaction_pool

  def initialize
    @chain = [ genesis_block ]
    @transaction_pool = []
  end

  def add_transaction(tx)
    raise "必須是交易" unless tx.is_a?(Transaction)
    raise "交易金額必須大於 0" if tx.amount <= 0

    @transaction_pool << tx
  end

  def mine!
    if transaction_pool.any?
      @chain << Block.new(last_block.hash, pick_transactions)
      clean_transactions
    end
  end

  def valid?
    # 來，叔叔幫你檢查...你的 Hash 值

    # 第一顆區塊應該要是創世區塊
    return false if first_block != genesis_block

    # 接下來檢查每個區塊是不是合法...
    chain.each.with_index do |b, i|
      # 第一顆不用檢查
      if i > 0
        current_block = chain[i]
        previous_block = chain[i - 1]

        # 目前這顆的 previous_hash 應該要等於前一顆的 hash
        return false if current_block.previous_hash != previous_block.hash

        # 目前這顆的 hash，再重新計算後應該要得到一樣的結果
        return false if current_block.hash != Block.block_hash(current_block)
      end
    end

    # 如果都通過檢查...
    return true
  end

  private
  def genesis_block
    @genesis_block ||= Block.new('0' * 64, '2018/7/18 我宣佈參選天龍國國王，我要變成海賊王!')
  end

  def first_block
    chain.first
  end

  def last_block
    chain.last
  end

  def pick_transactions
    # 細節待實作，暫時先回傳整個 @transaction_pool 陣列
    @transaction_pool
  end

  def clean_transactions
    # 細節待實作，暫時先把全部的交易都清掉
    @transaction_pool = []
  end
end