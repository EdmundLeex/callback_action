require 'test_helper'

class CallbackActionTest < Minitest::Test
  class Car
    attr_reader :log

    extend CallbackAction

    before_action :check_battery, on: [:turn_on_headlight]
    before_action :check_engine,  on: [:start]
    before_action :check_tire,    on: [:start]
    before_action :check_brake,   on: [:start]

    before_action :check_engine_oil, on: [:maintenance]
    before_action :check_oil_filter, on: [:check_engine_oil]

    before_action :check_oil_filter, on: [:engine_issue, :unknown_issue]

    def initialize
      @log = ''
    end

    def start
      insert_log 'engine started'
    end

    def turn_on_headlight
      insert_log 'headlight turned on'
    end

    def check_battery
      insert_log 'battery check completed'
    end

    def check_engine
      insert_log 'engine check completed'
    end

    def check_tire
      insert_log 'tire check completed'
    end

    def check_brake
      insert_log 'brake check completed'
    end

    def check_oil_filter
      insert_log 'oil filter check completed'
    end

    def check_engine_oil
      insert_log 'engine oil check completed'
    end

    def maintenance
      insert_log 'maintenance completed'
    end

    def engine_issue
      insert_log 'engine issue detected'
    end

    def unknown_issue
      insert_log 'unknown issue detected'
    end

    def insert_log(log)
      @log << log + "\n"
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::CallbackAction::VERSION
  end

  def test_it_adds_one_before_callback
    car = Car.new
    car.turn_on_headlight

    assert car.log.gsub(/\s+/, ' ').strip == <<-LOG.gsub(/\s+/, ' ').strip
      battery check completed
      headlight turned on
    LOG
  end

  def test_it_adds_multiple_before_callback
    car = Car.new
    car.start

    assert car.log.gsub(/\s+/, ' ').strip == <<-LOG.gsub(/\s+/, ' ').strip
      engine check completed
      tire check completed
      brake check completed
      engine started
    LOG
  end

  def test_it_stacks_callbacks
    car = Car.new
    car.maintenance

    assert car.log.gsub(/\s+/, ' ').strip == <<-LOG.gsub(/\s+/, ' ').strip
      oil filter check completed
      engine oil check completed
      maintenance completed
    LOG
  end

  def test_it_adds_callbacks_to_multiple_actions
    car = Car.new
    car.engine_issue

    assert car.log.gsub(/\s+/, ' ').strip == <<-LOG.gsub(/\s+/, ' ').strip
      oil filter check completed
      engine issue detected
    LOG

    car = Car.new
    car.unknown_issue

    assert car.log.gsub(/\s+/, ' ').strip == <<-LOG.gsub(/\s+/, ' ').strip
      oil filter check completed
      unknown issue detected
    LOG
  end

  # def test_it_adds_after_callback
  #   foobar = Foobar.new
  #   foobar.bar
  #   assert foobar.foobar == 'bar_after'
  # end

  # def test_it_adds_multiple_after_callback
  #   foobar = Foobar.new
  #   foobar.double_bar
  #   assert foobar.foobar == 'double_bar_after_another_after'
  # end

  # def test_it_invokes_callback_everytime
  #   foobar = Foobar.new
  #   foobar.foo
  #   assert foobar.foobar == 'before_foo'
  #   foobar.foo
  #   assert foobar.foobar == 'before_foobefore_foo'
  # end

  # def test_it_calls_both_before_and_after_callback
  #   foobar = Foobar.new
  #   foobar.around_foo
  #   assert foobar.foobar == 'before_around_foo_after'
  # end
end
