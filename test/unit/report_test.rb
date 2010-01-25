# -*- coding: utf-8 -*-
require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  def test_should_not_save_geolocation_data_with_no_location_specified
    report = Factory.build(:report, :location => nil)
    assert report.save
    assert_equal [nil,nil], [report.latitude,report.longitude]
  end

  def test_should_save_geolocation_data
    report = Factory.build(:report, :latitude => nil, :longitude => nil, :location => "somewhere")
    assert report.save
    assert_not_equal [nil,nil], [report.latitude,report.longitude]
  end

  def test_should_save_uber_twitter_location_data
    latlon = [23.45,-98.76]
    report = Factory.build(:report, :latitude => nil, :longitude => nil, :location => "ÜT: #{latlon.join(',')}")
    assert report.save
    assert_equal latlon, [report.latitude,report.longitude]
  end

  def test_should_save_iphone_location_data
    latlon = [23.45,-98.76]
    report = Factory.build(:report, :latitude => nil, :longitude => nil, :location => "iPhone: #{latlon.join(',')}")
    assert report.save
    assert_equal latlon, [report.latitude,report.longitude]
  end

end
