# add this directory to the load path if it hasn't already been added

require File.join(File.dirname(__FILE__), 'mash') unless defined?(Mash)

unless Hash.respond_to?(:to_mash)
  class Hash
    def to_mash
      Mash.new(self)
    end
  end
end

require 'rubygems'
require 'gsolr_ext'

module GSolr
  module Ext
    autoload :Client, 'gsolr_ext/client.rb'
    autoload :Doc, 'gsolr_ext/doc.rb'
    autoload :Request, 'gsolr_ext/request.rb'
    autoload :Response, 'gsolr_ext/response.rb'
    autoload :Model, 'gsolr_ext/model.rb'

    def self.version
      @version ||= File.read(File.join(File.dirname(__FILE__), '..', 'VERSION'))
    end

    VERSION = self.version

    # modify the GSolr::Client (provides #find and #luke methods)
    GSolr::Client.class_eval do
      include GSolr::Ext::Client
    end

    # this is for backward compatibility: GSolr::Ext.connect
    # recommended way is to just use GSolr.connect
    def self.connect *args, &blk
      GSolr.connect *args, &blk
    end
  end
end