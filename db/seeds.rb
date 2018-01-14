User.create! :nickname => "aa1", :email => 'Aa@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "bb-2",:email => 'Bb@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "cc33",:email => 'Cc@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "dd",:email => 'dD@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "eeee",:email => 'EE@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "ffff",:email => 'ff@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "gg34",:email => 'GG@gmail.Com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "admin", :email => 'admin@gmail.com', :password => '12345678', :password_confirmation => '12345678', :role => User.roles[:admin]


c1 = Tag.create! :short_name => 'visualization'
c2 = Tag.create! :short_name => 'misc'
c3 = Tag.create! :short_name => 'data-capture'
c4 = Tag.create! :short_name => 'gui-enhancement'
c5 = Tag.create! :short_name => 'data-analysis'
c6 = Tag.create! :short_name => 'brain-waves'
c7 = Tag.create! :short_name => 'video'
c8 = Tag.create! :short_name => 'facial-expressions'
c9 = Tag.create! :short_name => 'eye-movement'
c10 = Tag.create! :short_name => 'keYBOArd'
c11 = Tag.create! :short_name => 'webcam'
c12 = Tag.create! :short_name => 'eye-tracker'
c13 = Tag.create! :short_name => 'mouse-tracker'
c14 = Tag.create! :short_name => 'screen-capture'


lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
short = "A simple plugin"
chinese = "插件（又譯外挂，英文为Plug-in、Plugin、add-in、addin、add-on、addon或extension）是一種电脑程序，透過和应用程序（例如网页浏览器，電子郵件用戶端）的互动，用来替应用程式增加一些所需要的特定的功能。最常见的有遊戲、网页浏览器的插件和媒体播放器的插件。"
html = "<b>Description with HTML</b><script>alert('HACKED')</script>"
multiline = "        texto multilinea\n\n\n\n\n\n\ntexto multilinea\n\ntexto multilinea               "


Plugin.create! :status => Plugin.statuses[:confirmed], :name => "JNativeMouseCapture", :short_name => 'j-mouse-capture', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "jnativehook-mouse-capture"

Plugin.create! :status => Plugin.statuses[:confirmed], :name => "Plugin name 1", :short_name => 'pluGin-1', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "atom     ", :repo_name => "   atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c1, c2, c3 ], :name => "Plugin name 2", :short_name => 'PLUGIN-2', :description => short, :user_id => 1, :repo_type => :github, :repo_user => "   felovilches   ", :repo_name => "mo-plugin-repository   ", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:pending], :tags => [ c4, c6 ], :name => "Plugin name 3 pending", :short_name => 'plugin-3', :description => chinese, :user_id => 1, :repo_type => :github, :repo_user => " github_user  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c7, c9 ], :name => "Plugin name 4", :short_name => 'plugin-4', :description => html, :user_id => 2, :repo_type => :github, :repo_user => "  shouldBEALLloWCase  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c7 ], :name => "Plugin name 5", :short_name => 'plugin-5', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "Plugin name 6 <b>HTML</b>", :short_name => 'plugin-6', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:pending], :tags => [ c5, c7 ], :name => "Plugin name 7 pending", :short_name => 'plugin-7', :description => short, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "Plugin name 8", :short_name => 'plugin-8', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c2, c6 ], :name => "Plugin name 9", :short_name => 'plugin-9', :description => chinese, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c3, c8 ], :name => "Plugin name 10", :short_name => 'plugin-10', :description => multiline, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:rejected], :tags => [ c4 ], :name => "Plugin name 11 rejected", :short_name => 'plugin-11', :description => html, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c6 ], :name => "Plugin name 12", :short_name => 'plugin-12', :description => multiline, :user_id => 4, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository"
Plugin.create! :status => Plugin.statuses[:rejected], :name => "Plugin name 13 rejected", :short_name => 'plugin-13', :description => short, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c3, c4, c5, c6 ], :name => "Plugin name 14", :short_name => 'plugin-14', :description => lorem, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [ c3, c4, c5, c6 ], :name => "Atom", :short_name => 'atom', :description => "IDE Atom. Repositorio de ejemplo aunque no sea un Plugin de MO.", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom", :home_page => "https://ide.atom.io/"

Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin1", :short_name => "data-analysis-plugin1", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin2", :short_name => "data-analysis-plugin2", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin3", :short_name => "data-analysis-plugin3", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin4", :short_name => "data-analysis-plugin4", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin5", :short_name => "data-analysis-plugin5", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin6", :short_name => "data-analysis-plugin6", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"

Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin7", :short_name => "data-analysis-plugin7", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin8", :short_name => "data-analysis-plugin8", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c7], :name => "data-analysis-plugin9", :short_name => "data-analysis-plugin9", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin10", :short_name => "data-analysis-plugin10", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin11", :short_name => "data-analysis-plugin11", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin12", :short_name => "data-analysis-plugin12", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"

Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin13", :short_name => "data-analysis-plugin13", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin14", :short_name => "data-analysis-plugin14", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin15", :short_name => "data-analysis-plugin15", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin16", :short_name => "data-analysis-plugin16", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin17", :short_name => "data-analysis-plugin17", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
Plugin.create! :status => Plugin.statuses[:confirmed], :tags => [c5], :name => "data-analysis-plugin18", :short_name => "data-analysis-plugin18", :user_id => 5, :repo_type => :github, :repo_user => "atom", :repo_name => "atom"
