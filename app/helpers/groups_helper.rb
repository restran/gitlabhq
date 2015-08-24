#encoding: utf-8
module GroupsHelper
  def remove_user_from_group_message(group, member)
    if member.user
      "确定要从 \"#{group.name}\" 删除 \"#{member.user.name}\"？"
    else
      "确定要收回邀请 \"#{member.invite_email}\" 加入到 \"#{group.name}\"？"
    end
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

  def group_icon(group)
    if group.is_a?(String)
      group = Group.find_by(path: group)
    end

    if group && group.avatar.present?
      group.avatar.url
    else
      image_path('no_group_avatar.png')
    end
  end
end
