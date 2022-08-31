# frozen_string_literal: true

# @resource Project

class UffizziCore::Api::Cli::V1::ProjectsController < UffizziCore::Api::Cli::V1::ApplicationController
  before_action :authorize_uffizzi_core_api_cli_v1_projects

  # Get projects of current user
  #
  # @path [GET] /api/cli/v1/projects
  #
  # @response [object<projects: Array<object<slug: string, name: string>> >] 200 OK
  # @response 401 Not authorized
  def index
    projects = current_user.projects.active.order(updated_at: :desc)

    respond_with projects, each_serializer: UffizziCore::Api::Cli::V1::ShortProjectSerializer
  end

  # Get a project by slug
  #
  # @path [GET] /api/cli/v1/projects/{slug}
  #
  # @response <object< project: Project>> 200 OK
  # @response 404 Not Found
  # @response 401 Not authorized
  def show
    respond_with resource_project
  end

  # Delete a project
  #
  # @path [DELETE] /api/cli/v1/projects/{slug}
  #
  # @response 204 No content
  # @response 404 Not Found
  # @response 401 Not authorized

  def destroy
    resource_project.disable!

    head :no_content
  end

  private

  def project_params
    params.require(:project)
  end

  def resource_project
    @resource_project ||= current_user.projects.find_by(slug: params[:slug])
  end

  def policy_context
    account = resource_project&.account || current_user.organizational_account

    UffizziCore::AccountContext.new(current_user, user_access_module, account, params)
  end
end
