module GroupsHelper
  def remove_user_from_group_message(group, user)
    "Are you sure you want to remove \"#{user.name}\" from \"#{group.name}\"?"
  end

  def leave_group_message(group)
    "Are you sure you want to leave \"#{group}\" group?"
  end
  
  def should_user_see_group_roles?(user, group)
    if user
      user.is_admin? || group.members.exists?(user_id: user.id)
    else
      false
    end
  end

  def group_head_title
    title = @group.name

    title = if current_action?(:issues)
              "问题 - " + title
            elsif current_action?(:merge_requests)
              "合并请求 - " + title
            elsif current_action?(:members)
              "成员 - " + title
            elsif current_action?(:edit)
              "设置 - " + title
            else
              title
            end

    title
  end

  def group_filter_path(entity, options={})
    exist_opts = {
      status: params[:status]
    }

    options = exist_opts.merge(options)

    path = request.path
    path << "?#{options.to_param}"
    path
  end
end
