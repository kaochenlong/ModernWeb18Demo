require 'digest'

class Block
  attr_reader :hash
  attr_reader :previous_hash
  attr_reader :data
  attr_reader :timestamp
  attr_reader :nonce

  def initialize(previous_hash, data)
    @previous_hash = previous_hash
    @data = data
    @timestamp = Time.now.to_i
    @nonce = 0
    @hash = ''

    mine!
  end

  def mine!
    loop do
      result = calculate_hash
      if result.start_with?("000")
        @hash = result
        break
      else
        @nonce += 1
        @timestamp = Time.now.to_i
      end
    end
  end

  def self.block_hash(b)
    Digest::SHA256.hexdigest("#{b.previous_hash}#{b.timestamp}#{b.data}#{b.nonce}")
  end

  def to_hash
    tx = data.is_a?(Array) ? data.map(&:to_hash) : data

    {
      hash: hash,
      previous_hash: previous_hash,
      data: data.is_a?(Array) ? data.map(&:to_hash) : data,
      timestamp: timestamp,
      nonce: nonce
    }
  end

  private
  def calculate_hash
    Digest::SHA256.hexdigest("#{previous_hash}#{timestamp}#{data}#{nonce}")
  end
end