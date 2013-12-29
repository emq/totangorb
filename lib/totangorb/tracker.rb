require 'ostruct'
require 'net/http'
require 'logger'

module Totangorb
  class NullLogger
    def info(msg) end
  end

  class Tracker
    BASE_URL = 'http://sdr.totango.com/pixel.gif/?'

    def initialize(service_id = nil, options = {})
      raise(::Error, 'You must provide your private API key.') unless service_id
      @service_id = service_id
      @debug      = options.fetch(:debug, false)
      @logger     = options.fetch(:logger) { NullLogger.new }

      yield(self) if block_given?
    end

    def track(params = nil)
      params ||= OpenStruct.new

      yield(params) if block_given?

      perform_request(params.to_h)
    end

    private

    attr_reader :service_id, :debug, :logger

    def perform_request(params = {})
      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(translate_params(params))

      logger.info "Performing request to #{uri}"
      Net::HTTP.get(uri) unless debug
    end

    # Translate params to names that totango understands
    def translate_params(params = {})
      {
        sdr_s:   service_id,
        sdr_u:   params.fetch(:username,     'Unknown'),
        sdr_o:   params.fetch(:account_id,   'Unknown'),
        sdr_odn: params.fetch(:account_name, 'Unknown'),
        sdr_a:   params.fetch(:activity,     'Unknown'),
        sdr_m:   params.fetch(:module,       'Unknown')
      }.merge(parse_attributes(params.fetch(:attributes, {})))
    end

    # Prepends every optional account attribute hash key with 'sdr_u.<key>'
    def parse_attributes(attributes = {})
      attributes.each.reduce({}) do |r, (k, v)|
        r.merge("sdr_o.#{k}" => v)
      end
    end
  end
end
