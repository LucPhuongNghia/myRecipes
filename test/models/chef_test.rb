require "test_helper"

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef = Chef.new( chefname: "Jon", email: "jon@example.com" )
    end
    
    test "chef should be valid" do
        assert @chef.valid?
    end
    
    test "chef name should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end
    
    test "chef name should not be too long" do
        @chef.chefname = "a"*41
        assert_not @chef.valid?
    end
    
    test "chef name should not be too short" do
        @chef.chefname = "a"
        assert_not @chef.valid?
    end
    
    test "email should be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end
    
    test "email length should be within bounds" do
        @chef.email = "a"*101 + "@example.com"
        assert_not @chef.valid?
    end
    
   test "email address should be unique" do
      dup_chef = @chef.dup
      dup_chef.email = @chef.email.upcase
      @chef.save
      assert_not dup_chef.valid?
   end
   
   test "email validation should accept valid address" do
       valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eee.au laura+joe@example.cm]
       
       valid_addresses.each do |va|
          @chef.email = va
          assert @chef.valid?, '#{va.inspect} should be valid'
       end
   end
   
   test "email validation should reject invalid address" do
       invalid_addresses = %w[user@example,com user_at_eee.com name@example. eee@i_am.com foo@ee+aa.com]
       
       invalid_addresses.each do |iv|
          @chef.email = iv
          assert_not @chef.valid?, '#{iv.inspect} should be invalid'
       end
   end
    
end