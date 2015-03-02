#encoding: utf-8
module GroupsHelper
  def remove_user_from_group_message(group, user)
    "确定要从 \"#{group.name}\" 删除 \"#{user.name}\"?"
  end

  def leave_group_message(group)
    "确定要离开 \"#{group}\" 群组么？"
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

  def group_settings_page?
    if current_controller?('groups')
      current_action?('edit') || current_action?('projects')
    else
      false
    end
  end
end
