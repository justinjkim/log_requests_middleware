require 'rack'
require_relative '../lib/log_requests_middleware'

RSpec.describe LogRequestsMiddleware do
  let(:app1) { double("App") }
  let(:middleware1) { LogRequestsMiddleware.new(app1) }

  let(:env1) do
    {
      "HTTP_AUTHORIZATION": anything
    }
  end

  let(:request1) { instance_double(Rack::Request) }

  describe "broken tests" do
    context "when request is of nil value" do
      it "then this test will fail" do
        expect do
          middleware1.log_request_and_response!(
            request: nil,
            headers: "anything",
            url: "anything",
            response: "anything"
          )
        end.to_not raise_error(NoMethodError)
      end
    end

    context "when the log can't be created" do
      before do
        allow(Log).to receive(:create!).and_raise("Can't do that!")
      end

      it "then this test will fail" do
        expect do
          middleware1.log_request_and_response!(
            request: "anything",
            headers: "anything",
            url: "anything",
            response: "anything"
          )
        end.to_not raise_error("Can't do that!")
      end
    end
  end
end
