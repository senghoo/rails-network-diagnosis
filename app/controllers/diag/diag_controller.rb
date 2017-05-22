# coding: utf-8
require_dependency "diag/application_controller"

module Diag
  class DiagController < ApplicationController
    before_action :enable_network, only: [:network, :network_update]
    def index
    end

    def network
    end

    def network_update
      DiagService.network ENV['NETWORK_TEMPLATE'], params
      redirect_to network_path
    end

    def ping
    end
    def ping_do
      begin
        @res = DiagService.ping params[:host]
      rescue
        @res = "非法请求"
      end
    end

    def traceroute
    end
    def traceroute_do
      begin
        @res = DiagService.traceroute params[:host]
      rescue
        @res = "非法请求"
      end
    end

    def dig
    end
    def dig_do
      begin
        @res = DiagService.dig params[:host]
      rescue
        @res = "非法请求"
      end
    end


    def connection
    end
    def connection_do
      begin
        @res = DiagService.connection params[:host], params[:port]
      rescue
        @res = "非法请求"
      end
    end

    private
    def enable_network
      if ENV['NETWORK_TEMPLATE'].nil? or ENV['NETWORK_TEMPLATE'].blank?
        redirect_to diag_index_path
      end
    end
  end
end
