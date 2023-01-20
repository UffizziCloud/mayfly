# frozen_string_literal: true

class UffizziCore::DockerRegistryClient
  ACCEPTED_TYPES = [
    'application/vnd.oci.image.index.v1+json',
    'application/vnd.oci.image.manifest.v1+json',
    'application/vnd.docker.distribution.manifest.v1+json',
    'application/vnd.docker.distribution.manifest.v2+json',
    'application/vnd.docker.distribution.manifest.list.v2+json',
    '*/*',
  ].freeze

  def initialize(registry_url:, username: nil, password: nil)
    @registry_url = registry_url
    @connection = build_connection(@registry_url, username, password)
  end

  def authenticated?
    @connection.head('/v2/')

    true
  end

  def manifests(image:, tag:, namespace: nil)
    full_image = [namespace, image].compact.join('/')
    url = "/v2/#{full_image}/manifests/#{tag}"
    response = @connection.get(url)

    RequestResult.new(status: response.status, result: response.body)
  end

  private

  def build_connection(registry_url, username, password)
    connection = Faraday.new(registry_url) do |faraday|
      faraday.headers['Accept'] = ACCEPTED_TYPES
      faraday.request(:basic_auth, username, password) if username.present? && password.present?
      faraday.request(:json)
      faraday.response(:json)
      faraday.response(:follow_redirects)
      faraday.response(:raise_error)
      faraday.adapter(Faraday.default_adapter)
    end

    connection.extend(UffizziCore::ContainerRegistryRequestDecorator)
  end
end
