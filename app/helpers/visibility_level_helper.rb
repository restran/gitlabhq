module VisibilityLevelHelper
  def visibility_level_color(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      'vs-private'
    when Gitlab::VisibilityLevel::INTERNAL
      'vs-internal'
    when Gitlab::VisibilityLevel::PUBLIC
      'vs-public'
    end
  end

  def visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "项目必须明确授权给每个用户访问。"
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "项目可以被所有已登录用户克隆。"
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "项目可以被任何用户克隆。"
        end
      end
    end
  end

  def snippet_visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "该代码片段只有自己能看到"
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "该代码片段任何已登录用户都可以看到。"
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "该代码片段可以被任何授权的用户访问。"
        end
      end
    end
  end

  def visibility_level_icon(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      private_icon
    when Gitlab::VisibilityLevel::INTERNAL
      internal_icon
    when Gitlab::VisibilityLevel::PUBLIC
      public_icon
    end
  end

  def visibility_level_label(level)
    Project.visibility_levels.key(level)
  end

  def restricted_visibility_levels
    current_user.is_admin? ? [] : gitlab_config.restricted_visibility_levels
  end
end
