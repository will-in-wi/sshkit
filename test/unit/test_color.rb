require 'helper'
require 'sshkit'

module SSHKit
  class TestColor < UnitTest

    def test_colorize_when_tty_available
      color = SSHKit::Color.new(stub(tty?: true), {})
      assert_equal "\e[1;32;49mhi\e[0m", color.colorize('hi', :green, :bold)
    end

    def test_colorize_when_SSHKIT_COLOR_present
      color = SSHKit::Color.new(stub(tty?: false), {'SSHKIT_COLOR' => 'a'})
      assert_equal "\e[0;31;49mhi\e[0m", color.colorize('hi', :red)
    end

    def test_does_not_colorize_when_no_tty_and_SSHKIT_COLOR_not_present
      color = SSHKit::Color.new(stub(tty?: false), {})
      assert_equal 'hi', color.colorize('hi', :red)
    end
  end
end
