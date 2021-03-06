module MoviesHelper
  def find_version_user_name(version)
    if version.nil? or version.whodunnit.nil?
      return "Unknown"
    end
    user = User.find_version_author(version) 
    user ? user.email : ''
  end
  
  def diff(content1, content2)
     changes = Diffy::Diff.new(content1, content2, 
                               include_plus_and_minus_in_html: true, 
                               include_diff_info: true)
     changes.to_s.present? ? changes.to_s(:html).html_safe : 'No Changes'
  end
end