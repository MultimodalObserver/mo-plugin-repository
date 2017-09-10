User.create! :id => 1, :email => 'Aa@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 2, :email => 'Bb@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 3, :email => 'Cc@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 4, :email => 'dD@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 5, :email => 'EE@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 6, :email => 'ff@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :id => 7, :email => 'GG@gmail.Com', :password => '12345678', :password_confirmation => '12345678'



c1 = Category.create! :id => 1, :name => 'Visualization', :short_name => 'visualization'
c2 = Category.create! :id => 2, :name => 'Misc', :short_name => 'misc'
c3 = Category.create! :id => 3, :name => 'Data capture', :short_name => 'data-capture'
c4 = Category.create! :id => 4, :name => 'GUI enhancement', :short_name => 'gui-enhancement'
c5 = Category.create! :id => 5, :name => 'Data analysis', :short_name => 'data-analysis'
c6 = Category.create! :id => 6, :name => 'Brain waves', :short_name => 'brain-waves'
c7 = Category.create! :id => 7, :name => 'Video', :short_name => 'video'
c8 = Category.create! :id => 8, :name => 'Facial expressions', :short_name => 'facial-expressions'
c9 = Category.create! :id => 9, :name => 'Eye movement', :short_name => 'eye-movement'
c10 = Category.create! :id => 10, :name => 'Keyboard', :short_name => 'keYBOArd'


lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."


Plugin.create! :id => 1, :name => "Plugin name 1", :short_name => 'pluGin-1', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "felovilches     ", :repo_name => "   mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 2, :categories => [ c1, c2, c3 ], :name => "Plugin name 2", :short_name => 'PLUGIN-2', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "   felovilches   ", :repo_name => "mo-plugin-repository   ", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 3, :categories => [ c4, c6 ], :name => "Plugin name 3 (Bitbucket)", :short_name => 'plugin-3', :description => lorem, :user_id => 1, :repo_type => :bitbucket, :repo_user => " bitbucket_user  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 4, :categories => [ c7, c9 ], :name => "Plugin name 4", :short_name => 'plugin-4', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "  shouldBEALLloWCase  ", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 5, :categories => [ c7 ], :name => "Plugin name 5", :short_name => 'plugin-5', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 6, :name => "Plugin name 6", :short_name => 'plugin-6', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 7, :categories => [ c5, c7 ], :name => "Plugin name 7", :short_name => 'plugin-7', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 8, :name => "Plugin name 8", :short_name => 'plugin-8', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 9, :categories => [ c2, c6 ], :name => "Plugin name 9", :short_name => 'plugin-9', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 10, :categories => [ c3, c8 ], :name => "Plugin name 10", :short_name => 'plugin-10', :description => lorem, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 11, :categories => [ c4 ], :name => "Plugin name 11", :short_name => 'plugin-11', :description => lorem, :user_id => 3, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 12, :categories => [ c6 ], :name => "Plugin name 12", :short_name => 'plugin-12', :description => lorem, :user_id => 4, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 13, :name => "Plugin name 13", :short_name => 'plugin-13', :description => lorem, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
Plugin.create! :id => 14, :categories => [ c3, c4, c5, c6 ], :name => "Plugin name 14", :short_name => 'plugin-14', :description => lorem, :user_id => 5, :repo_type => :github, :repo_user => "felovilches", :repo_name => "mo-plugin-repository", :home_page => "https://www.facebook.com/felo.vilches"
