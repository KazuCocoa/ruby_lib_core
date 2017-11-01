require 'test_helper'

# $ rake android TEST=test/android/patch_test.rb
class AppiumLibCoreTest
  class PathTest < Minitest::Test
    def setup
      @@core ||= ::Appium::Core.for(self, Caps::ANDROID_OPS)
      @@driver ||= @@core.start_driver

      @@driver.start_activity app_package: 'io.appium.android.apis',
                              app_activity: '.ApiDemos'
    end

    def test_value
      skip "Android doesn't support"
      e = @@core.wait { @@driver.find_element :accessibility_id, 'App' }

      assert_equal 'App', e.value
    end

    def test_name
      skip "Android doesn't support"
      e = @@core.wait { @@driver.find_element :accessibility_id, 'App' }

      assert_equal 'App', e.name
    end

    def test_label
      skip "Android doesn't support"
      e = @@core.wait { @@driver.find_element :accessibility_id, 'App' }

      assert_equal 'App', e.label
    end

    def test_type
      @@core.wait { @@driver.find_element :accessibility_id, 'App' }.click
      @@core.wait { @@driver.find_element :accessibility_id, 'Activity' }.click
      @@core.wait { @@driver.find_element :accessibility_id, 'Custom Title' }.click

      @@core.wait { @@driver.find_element :id, 'io.appium.android.apis:id/left_text_edit' }.type 'Pökémön'

      text = @@core.wait { @@driver.find_element :id, 'io.appium.android.apis:id/left_text_edit' }
      assert_equal 'Left is bestPökémön', text.name
    end

    def test_location_rel
      e = @@core.wait { @@driver.find_element :accessibility_id, 'App' }
      location = e.location_rel(@@driver)

      assert_match /\A[0-9]+\.[0-9]+ \/ [0-9]+\.[0-9]+\z/, location.x
      assert_match /\A[0-9]+\.[0-9]+ \/ [0-9]+\.[0-9]+\z/, location.y
    end
  end
end
