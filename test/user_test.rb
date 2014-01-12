gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/mapmyfitness/user'

class UserTest < Minitest::Test
  def test_it_exists
    assert MapMyFitness::User
  end

  def test_it_defines_many_data_attributes
    user = MapMyFitness::User.new({})
    MapMyFitness::User.data_attributes.each do |attribute|
      assert user.respond_to?(attribute), "Expected the User to have a #{attribute} method."
    end
  end

  def test_it_takes_in_and_stores_a_set_of_data
    expected = {:hello => :world}
    user = MapMyFitness::User.new(expected)
    assert_equal expected, user.data
  end

  def test_it_extracts_each_of_the_defined_data_attributes
    fake_data = {}
    fake_data["info"] = Hash.new(){|_, key| "#{key}_data"}
    user = MapMyFitness::User.new(fake_data)
    MapMyFitness::User.data_attributes.each do |attribute|
      assert_equal "#{attribute}_data", user.send(attribute)
    end
  end

  def test_it_extracts_each_of_the_token_attributes
    fake_data = {}
    fake_data["credentials"] = Hash.new(){|_, key| "#{key}_data"}
    user = MapMyFitness::User.new(fake_data)
    assert_equal "expires_data", user.token_expires
    assert_equal "expires_at_data", user.token_expires_at
    assert_equal "refresh_token_data", user.token_refresh
    assert_equal "token_data", user.token
  end

  def test_it_extracts_the_provider
    fake_data = {"provider" => "fake_provider"}
    user = MapMyFitness::User.new(fake_data)
    assert_equal "fake_provider", user.provider
  end

  def test_it_has_both_uid_and_id
    user = MapMyFitness::User.new({"info" => {"id" => "fake_id"}})
    assert_equal "fake_id", user.uid
  end
end