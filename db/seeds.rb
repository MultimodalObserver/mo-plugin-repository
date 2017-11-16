User.create! :id => 1, :email => 'Aa@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 2, :email => 'Bb@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 3, :email => 'Cc@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 4, :email => 'dD@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 5, :email => 'EE@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 6, :email => 'ff@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 7, :email => 'GG@gmail.Com', :password => '12345678', :password_confirmation => '12345678'



c1 = Tag.create! :id => 1, :name => 'Visualization', :short_name => 'visualization'
c2 = Tag.create! :id => 2, :name => 'Misc', :short_name => 'misc'
c3 = Tag.create! :id => 3, :name => 'Data capture', :short_name => 'data-capture'
c4 = Tag.create! :id => 4, :name => 'GUI enhancement', :short_name => 'gui-enhancement'
c5 = Tag.create! :id => 5, :name => 'Data analysis', :short_name => 'data-analysis'
c6 = Tag.create! :id => 6, :name => 'Brain waves', :short_name => 'brain-waves'
c7 = Tag.create! :id => 7, :name => 'Video', :short_name => 'video'
c8 = Tag.create! :id => 8, :name => 'Facial expressions', :short_name => 'facial-expressions'
c9 = Tag.create! :id => 9, :name => 'Eye movement', :short_name => 'eye-movement'
c10 = Tag.create! :id => 10, :name => 'Keyboard', :short_name => 'keYBOArd'
c11 = Tag.create! :id => 11, :name => 'Webcam', :short_name => 'webcam'
c12 = Tag.create! :id => 12, :name => 'Eyetracker', :short_name => 'eye-tracker'
c13 = Tag.create! :id => 13, :name => 'Mousetracker', :short_name => 'mouse-tracker'
c14 = Tag.create! :id => 14, :name => 'Screencapture', :short_name => 'screen-capture'


lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
short = "A simple plugin"
chinese = "插件（又譯外挂，英文为Plug-in、Plugin、add-in、addin、add-on、addon或extension）是一種电脑程序，透過和应用程序（例如网页浏览器，電子郵件用戶端）的互动，用来替应用程式增加一些所需要的特定的功能。最常见的有遊戲、网页浏览器的插件和媒体播放器的插件。"
html = "<b>Description with HTML</b><script>alert('HACKED')</script>"
multiline = "        texto multilinea\n\n\n\n\n\n\ntexto multilinea\n\ntexto multilinea               "


Plugin.create! :id => 1, :name => "Plugin name 1", :short_name => 'pluGin-1', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "atom     ", :repo_name => "   atom"
Plugin.create! :id => 2, :tags => [ c1, c2, c3 ], :name => "Plugin name 2", :short_name => 'PLUGIN-2', :description => short, :user_id => 1, :repo_type => :github, :repo_user => "   felovilches   ", :repo_name => "mo-plugin-repository   ", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 3, :tags => [ c4, c6 ], :name => "Plugin name 3", :short_name => 'plugin-3', :description => chinese, :user_id => 1, :repo_type => :github, :repo_user => " github_user  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 4, :tags => [ c7, c9 ], :name => "Plugin name 4", :short_name => 'plugin-4', :description => html, :user_id => 2, :repo_type => :github, :repo_user => "  shouldBEALLloWCase  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 5, :tags => [ c7 ], :name => "Plugin name 5", :short_name => 'plugin-5', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 6, :name => "Plugin name 6 <b>HTML</b>", :short_name => 'plugin-6', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 7, :tags => [ c5, c7 ], :name => "Plugin name 7", :short_name => 'plugin-7', :description => short, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 8, :name => "Plugin name 8", :short_name => 'plugin-8', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository"
Plugin.create! :id => 9, :tags => [ c2, c6 ], :name => "Plugin name 9", :short_name => 'plugin-9', :description => chinese, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 10, :tags => [ c3, c8 ], :name => "Plugin name 10", :short_name => 'plugin-10', :description => multiline, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 11, :tags => [ c4 ], :name => "Plugin name 11", :short_name => 'plugin-11', :description => html, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 12, :tags => [ c6 ], :name => "Plugin name 12", :short_name => 'plugin-12', :description => multiline, :user_id => 4, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository"
Plugin.create! :id => 13, :name => "Plugin name 13", :short_name => 'plugin-13', :description => short, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 14, :tags => [ c3, c4, c5, c6 ], :name => "Plugin name 14", :short_name => 'plugin-14', :description => lorem, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
