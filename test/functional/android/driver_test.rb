require 'test_helper'

# $ rake android TEST=test/android/driver_test.rb
class AppiumLibCoreTest
  class DriverTest < Minitest::Test
    def setup
      @@core ||= ::Appium::Core.for(self, Caps::ANDROID_OPS)
      @@driver ||= @@core.start_driver
    end

    def test_appium_server_version
      v = @@core.appium_server_version

      refute_nil v['build']['version']
      refute_nil v['build']['revision']
    end

    def test_platform_version
      # @@core.platform_version #=> [7, 1, 1]
      assert @@core.platform_version.length > 1
    end

    def test_screenshot
      file = @@core.screenshot './android_test.png'

      assert File.exist?(file.path)

      File.delete file.path
      assert !File.exist?(file.path)
    end

    def test_wait_true
      e = @@core.wait_true { @@driver.find_element :accessibility_id, 'Content' }
      assert e.name
    end

    def test_wait
      e = @@core.wait { @@driver.find_element :accessibility_id, 'Content' }
      assert_equal 'Content', e.name
    end

    # TODO: call @driver.quit after tests
  end
end
