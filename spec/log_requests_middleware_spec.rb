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
        end.to raise_error(NoMethodError)
      end
    end
  end
end
