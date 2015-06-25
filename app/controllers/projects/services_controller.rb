#encoding: utf-8
class Projects::ServicesController < Projects::ApplicationController
  ALLOWED_PARAMS = [:title, :token, :type, :active, :api_key, :api_version, :subdomain,
                    :room, :recipients, :project_url, :webhook,
                    :user_key, :device, :priority, :sound, :bamboo_url, :username, :password,
                    :build_key, :server, :teamcity_url, :build_type,
                    :description, :issues_url, :new_issue_url, :restrict_to_branch, :channel,
                    :colorize_messages, :channels,
                    :push_events, :issues_events, :merge_requests_events, :tag_push_events,
                    :note_events, :send_from_committer_email, :disable_diffs, :external_wiki_url,
                    :notify, :color]
  # Authorize
  before_action :authorize_admin_project!
  before_action :service, only: [:edit, :update, :test]

  respond_to :html

  layout "project_settings"

  def index
    @project.build_missing_services
    @services = @project.services.visible.reload
  end

  def edit
  end

  def update
    if @service.update_attributes(service_params)
      redirect_to(
        edit_namespace_project_service_path(@project.namespace, @project,
                                            @service.to_param, notice:
                                            '已更新成功。')
      )
    else
      render 'edit'
    end
  end

  def test
    data = Gitlab::PushDataBuilder.build_sample(project, current_user)
    if @service.execute(data)
      message = { notice: '已发送请求到提供的链接' }
    else
      message = { alert: '已发送请求到提供的链接，但收到一个错误回应' }
    end

    redirect_to :back, message
  end

  private

  def service
    @service ||= @project.services.find { |service| service.to_param == params[:id] }
  end

  def service_params
    params.require(:service).permit(ALLOWED_PARAMS)
  end
end
