User.create! :nickname => "user-a", :email => 'a@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "user-b", :email => 'b@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "user-c", :email => 'c@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "user-d", :email => 'd@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "user-e", :email => 'e@gmail.com', :password => '12345678', :password_confirmation => '12345678'
User.create! :nickname => "user-f", :email => 'f@gmail.com', :password => '12345678', :password_confirmation => '12345678'
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
html = "Descripcion de plugin con HTML (para verificar que no se inyecta en la pagina)<b>Negrita</b>"
multiline = "        texto multilinea\n\n\n\n\n\n\ntexto multilinea\n\ntexto multilinea               "


Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 1", :short_name => 'webcam-capture-1', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 2", :short_name => 'webcam-capture-2', :description => short, :user_id => 1, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 3", :short_name => 'webcam-capture-3', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 4", :short_name => 'webcam-capture-4', :description => short, :user_id => 2, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 5", :short_name => 'webcam-capture-5', :description => html, :user_id => 3, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 6", :short_name => 'webcam-capture-6', :description => lorem, :user_id => 3, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Webcam Capture 7", :short_name => 'webcam-capture-7', :description => multiline, :user_id => 4, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Webcam-Capture"

Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 1", :short_name => 'eye-tribe-1', :description => lorem, :user_id => 1, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 2", :short_name => 'eye-tribe-2', :description => multiline, :user_id => 1, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 3", :short_name => 'eye-tribe-3', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 4", :short_name => 'eye-tribe-4', :description => lorem, :user_id => 2, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 5", :short_name => 'eye-tribe-5', :description => multiline, :user_id => 3, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 6", :short_name => 'eye-tribe-6', :description => html, :user_id => 3, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
Plugin.create! :status => Plugin.statuses[:confirmed], :name => "MO Eye Tribe 7", :short_name => 'eye-tribe-7', :description => lorem, :user_id => 4, :repo_type => :github, :repo_user => "felovilches-extra", :repo_name => "MO-Eye-Tribe"
