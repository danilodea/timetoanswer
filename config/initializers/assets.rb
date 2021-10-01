# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor')
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

# /app/assets
Rails.application.config.assets.precompile += %w( 
    admins_backoffice_head.js admins_backoffice.css admins_backoffice_body.js 
    users_backoffice.js users_backoffice.css 
    admin_devise.css admin_devise_head.js admin_devise_body.js
    user_devise.css user_devise_body.js
    site.css site_body.js
    @fortawesome/fontawesome-free/js/all.js
)

# /lib/assets
Rails.application.config.assets.precompile += %w( 
    admins_backoffice/scripts.js admins_backoffice/styles.css 
    users_backoffice/custom.js users_backoffice/custom.css
    img.jpg
    admins_backoffice/jquery-3.6.0.js
    site/navbar-top.css
    bootstrap-v4.3.1/dist/css/bootstrap.css
    fortawesome/fontawesome-free/js/all.js
)
