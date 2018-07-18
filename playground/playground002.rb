require 'pp'
require_relative '../app/block'

block0 = Block.new('0000000000000000', '我要變成海賊王!')
block1 = Block.new(block0.hash, '我是 1 號區塊!')
block2 = Block.new(block1.hash, '我是 2 號區塊!')

pp block0
pp block1
pp block2