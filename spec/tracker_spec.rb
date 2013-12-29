require 'spec_helper'

describe Totangorb::Tracker do
  describe '#initialize' do
    it 'fails when service_id not provided' do
      expect { Totangorb::Tracker.new }.to raise_error
    end
  end

  describe '#track' do
    before { @totango = Totangorb::Tracker.new("fake1234") }

    describe 'invocation with block and hash' do
      before do
        @totango.should_receive(:perform_request).with({
          username:     'Sample User',
          account_id:   1,
          account_name: 'Sample Account',
          activity:     'Sample Activity',
          module:       'Sample Module',
          })
      end

      it 'takes a hash of params and passes it to perform_request' do
        @totango.track({
          username:     'Sample User',
          account_id:   1,
          account_name: 'Sample Account',
          activity:     'Sample Activity',
          module:       'Sample Module'
          })
      end

      it 'takes a block, converts it to hash, and passes to perform_request' do
        @totango.track do |t|
          t.username     = 'Sample User'
          t.account_id   = 1
          t.account_name = 'Sample Account'
          t.activity     = 'Sample Activity'
          t.module       = 'Sample Module'
        end
      end
    end

    describe 'performing request' do
      it 'decodes basic attributes' do
        Net::HTTP.should_receive(:get).with(URI('http://sdr.totango.com/pixel.gif/?sdr_s=fake1234&sdr_u=Sample+User&sdr_o=1&sdr_odn=Sample+Account&sdr_a=Sample+Activity&sdr_m=Sample+Module'))

        @totango.track do |t|
          t.username     = 'Sample User'
          t.account_id   = 1
          t.account_name = 'Sample Account'
          t.activity     = 'Sample Activity'
          t.module       = 'Sample Module'
        end
      end

      it 'decodes extra optional attributes' do
        Net::HTTP.should_receive(:get).with(URI('http://sdr.totango.com/pixel.gif/?sdr_s=fake1234&sdr_u=Sample+User&sdr_o=1&sdr_odn=Sample+Account&sdr_a=Sample+Activity&sdr_m=Sample+Module&sdr_o.Sample+Attribute+1=Sample+Value+1&sdr_o.Sample+Attribute+2=Sample+Attribute+2'))

        @totango.track do |t|
          t.username     = 'Sample User'
          t.account_id   = 1
          t.account_name = 'Sample Account'
          t.activity     = 'Sample Activity'
          t.module       = 'Sample Module'
          t.attributes   = {
            'Sample Attribute 1' => 'Sample Value 1',
            'Sample Attribute 2' => 'Sample Attribute 2'
          }
        end
      end
    end

    describe 'logging and debugging' do
      it 'should log the output url and never make real http request' do
        logger = double()
        logger.should_receive(:info)
        Net::HTTP.should_receive(:get).never
        @totango = Totangorb::Tracker.new("fake1234", debug: true, logger: logger)

        @totango.track do |t|
          t.username     = 'Sample User'
          t.account_id   = 1
          t.account_name = 'Sample Account'
          t.activity     = 'Sample Activity'
          t.module       = 'Sample Module'
        end
      end
    end
  end
end
