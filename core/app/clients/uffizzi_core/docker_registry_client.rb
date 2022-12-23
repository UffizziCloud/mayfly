# frozen_string_literal: true

class UffizziCore::DockerRegistryClient
  def initialize(registry_url:, username: nil, password: nil)
    @registry_url = registry_url
    @connection = build_connection(@registry_url, username, password)
  end

  def authenticated?
    response = @connection.head('/v2/')
    response.status == 200
  rescue Faraday::ConnectionFailed
    false
  end

  def manifests(image:, tag:, namespace: nil)
    full_image = [namespace, image].compact.join('/')
    url = "/v2/#{full_image}/manifests/#{tag}"
    response = @connection.get(url)

    RequestResult.new(status: response.status, result: response.body)
  end

  private

  def build_connection(registry_url, username, password)
    Faraday.new(registry_url) do |conn|
      conn.request(:basic_auth, username, password) if username.present? && password.present?
      conn.request(:json)
      conn.response(:json)
      conn.adapter(Faraday.default_adapter)
    end
  end
end
