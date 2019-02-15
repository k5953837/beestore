module SelectorsHelper
  # Maps a name to a link.
  def to_selector(selector_name)
    return unless selector_name

    case selector_name
    when 'User Log In Form'
      '#new_user'
    else
      "##{selector_name}"
    end
  end
end

World SelectorsHelper
