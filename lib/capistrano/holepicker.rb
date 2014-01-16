require "capistrano/holepicker/version"
require 'holepicker'

module Capistrano
  module Holepicker
    class VulnerableException < Exception
    end
  end
end

load File.expand_path("../tasks/holepicker.rake", __FILE__)