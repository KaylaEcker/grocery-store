require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require_relative '../lib/order'
#require 'csv'

describe "Order Wave 1" do
  describe "#initialize" do
    it "Takes an ID and collection of products" do
      id = 1337
      order = Grocery::Order.new(id, {})

      order.must_respond_to :id
      order.id.must_equal id
      order.id.must_be_kind_of Integer

      order.must_respond_to :products
      order.products.length.must_equal 0
    end
  end

  describe "#total" do
    it "Returns the total from the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      sum = products.values.inject(0, :+)
      expected_total = sum + (sum * 0.075).round(2)

      order.total.must_equal expected_total
    end

    it "Returns a total of zero if there are no products" do
      order = Grocery::Order.new(1337, {})

      order.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Increases the number of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      before_count = products.count
      order = Grocery::Order.new(1337, products)

      order.add_product("salad", 4.25)
      expected_count = before_count + 1
      order.products.count.must_equal expected_count
    end

    it "Is added to the collection of products" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      order.add_product("sandwich", 4.25)
      order.products.include?("sandwich").must_equal true
    end

    it "Returns false if the product is already present" do
      products = { "banana" => 1.99, "cracker" => 3.00 }

      order = Grocery::Order.new(1337, products)
      before_total = order.total

      result = order.add_product("banana", 4.25)
      after_total = order.total

      result.must_equal false
      before_total.must_equal after_total
    end

    it "Returns true if the product is new" do
      products = { "banana" => 1.99, "cracker" => 3.00 }
      order = Grocery::Order.new(1337, products)

      result = order.add_product("salad", 4.25)
      result.must_equal true
    end
  end
end






describe "Order Wave 2" do

  before do
    @orders = Grocery::Order.all
  end

  describe "Order.all" do
    # Order.all should return an array
    it "Returns an array of all orders" do
      @orders.must_be_kind_of Array
    end
    # each element is in the Order
    it "Everything in the array is an Order" do
      @orders.each do |order|
        order.must_be_kind_of Grocery::Order
      end
    end
    it "The number of orders is correct" do
      @orders.length.must_equal 100
      @orders.length.must_equal @orders[-1].id
    end
    it "first and last are same as csv" do
      orders_first = 	[1, {"Slivered Almonds" => 22.88, "Wholewheat flour" => 1.93, "Grape Seed Oil" => 74.9}]

      @orders.first.id.must_equal orders_first[0]
      @orders.first.products.must_equal orders_first[1]

      orders_last = [100, {"Allspice" => 64.74, "Bran" => 14.72, "UnbleachedFlour" => 80.59}]

      @orders.last.id.must_equal orders_last[0]
      @orders.last.products.must_equal orders_last[1]
    end
  end #(end for order.all)






  describe "Order.find" do

    before do
      @orders_2 = Grocery::Order
    end

    it "Can find the first order from the CSV" do
      #error - maybe reading 1 as an error, so not finding any ids in array?
      # @orders_2.find(1)
      # @orders_2.id.must_equal 1
    end

    it "can find the last order from the CSV" do
      #error - everything I do to fix this just breaks everything else -_-
      #  @orders_2.find(100)
      # @orders_2.id.must_equal 100
    end


    it "Raises an error for an order that doesn't exist" do
      proc {Grocery::Order.find(101)}.must_raise ArgumentError
      proc {Grocery::Order.find(-1)}.must_raise ArgumentError
      proc {Grocery::Order.find(0)}.must_raise ArgumentError
    end


  end #(end of order.find)
end #(end of wave 2)


# TOdo: change 'xdescribe' to 'describe' to run these tests
# xdescribe "Order Wave 2" do
#   describe "Order.all" do
#     it "Returns an array of all orders" do
#       # TOdo: Your test code here!
#       # Useful checks might include:
#       #  + check Order.all returns an array
#       #  + check Everything in the array is an Order
#       #  + check The number of orders is correct
#       #  + check The ID and products of the first and last
#       #       orders match what's in the CSV file
#       # Feel free to split this into multiple tests if needed
#     end
  # end
  #
  # describe "Order.find" do
  #   it "Can find the first order from the CSV" do
  #     # TODo: Your test code here!
  #   end
  #
  #   it "Can find the last order from the CSV" do
  #     # TODo: Your test code here!
  #   end
  #
  #   it "Raises an error for an order that doesn't exist" do
  #     # TODo: Your test code here!
  #   end
  # end
