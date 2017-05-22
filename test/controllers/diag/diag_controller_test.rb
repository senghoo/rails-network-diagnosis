require 'test_helper'

module Diag
  class DiagControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get diag" do
      get diag_diag_url
      assert_response :success
    end

    test "should get network" do
      get diag_network_url
      assert_response :success
    end

    test "should get network_update" do
      get diag_network_update_url
      assert_response :success
    end

  end
end
