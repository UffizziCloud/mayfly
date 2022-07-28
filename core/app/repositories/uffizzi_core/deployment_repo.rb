# frozen_string_literal: true

module UffizziCore::DeploymentRepo
  extend ActiveSupport::Concern

  included do
    scope :with_name, ->(name) {
      where(name: name)
    }
    scope :with_amazon_repos, -> { includes(containers: [:repo]).where(containers: { repos: { type: UffizziCore::Repo::Amazon.name } }) }
    scope :existed, -> { where(state: [:active, :failed]) }
    scope :active_for_credentials_id, ->(credentials_id) {
      active.joins(project: :credentials).merge(UffizziCore::Project.active).where(credentials: { id: credentials_id })
    }
  end
end
