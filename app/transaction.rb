class Transaction
  attr_reader :from
  attr_reader :to
  attr_reader :amount
  attr_reader :timestamp

  def initialize(from:, to:, amount:)
    @from = from
    @to = to
    @amount = amount.to_f
    @timestamp = Time.now.to_i
  end

  def to_hash
    {
      from: from,
      to: to,
      amount: amount,
      timestamp: timestamp
    }
  end
end