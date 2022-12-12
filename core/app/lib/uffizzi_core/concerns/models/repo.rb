# frozen_string_literal: true

module UffizziCore::Concerns::Models::Repo
  extend ActiveSupport::Concern

  included do
    extend Enumerize
    include UffizziCore::RepoRepo

    self.table_name = UffizziCore.table_names[:repos]

    enumerize :kind, in: [:buildpacks18, :dockerfile, :dotnet, :gatsby, :barestatic], predicates: true

    belongs_to :project
    has_one :container, inverse_of: :repo, dependent: :destroy

    validates :dockerfile_path, presence: true, if: :dockerfile?
    validates :delete_preview_after, numericality: { greater_than: 0, only_integer: true }, allow_nil: true

    def docker_hub?
      type == UffizziCore::Repo::DockerHub.name
    end

    def azure?
      type == UffizziCore::Repo::Azure.name
    end

    def google?
      type == UffizziCore::Repo::Google.name
    end
  end
end
