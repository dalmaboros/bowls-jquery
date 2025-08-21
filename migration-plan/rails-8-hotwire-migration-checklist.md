# Rails 8 + Ruby 3.4.5 + Hotwire Migration Checklist

## 🔧 **Pre-Migration Preparation**

- [ ] **Backup your application**
  - [ ] Create a git branch for the migration: `git checkout -b rails-8-hotwire-migration`
  - [ ] Backup your database: `pg_dump your_database > backup.sql`
  - [ ] Document current functionality and test cases

- [ ] **Update development environment**
  - [ ] Install Ruby 3.4.5: `rbenv install 3.4.5` or `rvm install 3.4.5`
  - [ ] Install Rails 8: `gem install rails -v 8.0.0`
  - [ ] Update Node.js to latest LTS version (for asset compilation)

## 🚀 **Phase 1: Rails 8 Upgrade**

- [ ] **Update Gemfile dependencies**
  - [ ] Update Ruby version: `ruby '3.4.5'`
  - [ ] Update Rails version: `gem 'rails', '~> 8.0.0'`
  - [ ] Remove deprecated gems:
    - [ ] Remove `coffee-rails` (CoffeeScript is deprecated)
    - [ ] Remove `jquery-rails` (replacing with Hotwire)
    - [ ] Remove `sass-rails` (Sass is now built into Rails)
    - [ ] Remove `jbuilder` (replacing with JSON serializers)
  - [ ] Add Hotwire gems:
    - [ ] Add `gem 'turbo-rails'`
    - [ ] Add `gem 'stimulus-rails'`
    - [ ] Add `gem 'importmap-rails'` (for JavaScript modules)
  - [ ] Update other gems to Rails 8 compatible versions:
    - [ ] Update `devise` to latest version
    - [ ] Update `omniauth-google-oauth2` to latest version
    - [ ] Update `active_model_serializers` to latest version

- [ ] **Run bundle update**
  - [ ] Run `bundle update`
  - [ ] Fix any gem conflicts
  - [ ] Test that all gems are compatible

- [ ] **Update Rails configuration**
  - [ ] Run `rails app:update` to get new Rails 8 configuration files
  - [ ] Review and merge changes in:
    - [ ] `config/application.rb`
    - [ ] `config/environments/development.rb`
    - [ ] `config/environments/production.rb`
    - [ ] `config/environments/test.rb`
  - [ ] Update `config/load_defaults` to `8.0` in `application.rb`

- [ ] **Update database configuration**
  - [ ] Run `rails db:migrate` to ensure all migrations work
  - [ ] Update `config/database.yml` if needed for Rails 8
  - [ ] Test database connectivity

## 🎯 **Phase 2: Remove jQuery Dependencies**

- [ ] **Remove jQuery from application.js**
  - [ ] Remove `//= require jquery` from `app/assets/javascripts/application.js`
  - [ ] Remove `//= require jquery_ujs` from `app/assets/javascripts/application.js`
  - [ ] Remove `//= require_tree .` (replacing with importmap)

- [ ] **Remove jQuery-specific JavaScript files**
  - [ ] Delete `app/assets/javascripts/bowls.coffee`
  - [ ] Delete `app/assets/javascripts/scraps.coffee`
  - [ ] Archive `app/assets/javascripts/bowls_show.js` (will rewrite with Stimulus)

- [ ] **Update layout file**
  - [ ] Remove `javascript_include_tag 'application'` from `app/views/layouts/application.html.erb`
  - [ ] Add Hotwire imports:
    - [ ] Add `<%= javascript_importmap_tags %>` to layout head
    - [ ] Add `<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>`

## 🔄 **Phase 3: Implement Hotwire/Turbo**

- [ ] **Set up importmap**
  - [ ] Run `rails importmap:install`
  - [ ] Configure `config/importmap.rb` to include necessary packages
  - [ ] Add any external JavaScript libraries you need

- [ ] **Update controllers for Turbo**
  - [ ] Modify `BowlsController` to handle Turbo requests:
    - [ ] Update `create` action to respond to Turbo Streams
    - [ ] Update `update` action to respond to Turbo Streams
    - [ ] Update `destroy` action to respond to Turbo Streams
  - [ ] Modify `ScrapsController` similarly
  - [ ] Add proper error handling for Turbo requests

- [ ] **Create Turbo Stream templates**
  - [ ] Create `app/views/bowls/create.turbo_stream.erb`
  - [ ] Create `app/views/bowls/update.turbo_stream.erb`
  - [ ] Create `app/views/bowls/destroy.turbo_stream.erb`
  - [ ] Create similar templates for scraps

- [ ] **Update forms for Turbo**
  - [ ] Add `data-turbo="true"` to all forms
  - [ ] Update form submission handling
  - [ ] Test form submissions work with Turbo

## 🎮 **Phase 4: Implement Stimulus Controllers**

- [ ] **Create Stimulus controllers to replace jQuery functionality**
  - [ ] Create `app/javascript/controllers/bowl_controller.js`:
    - [ ] Handle scrap display/hide functionality
    - [ ] Handle scrap addition functionality
    - [ ] Handle scrap deletion functionality
    - [ ] Handle bowl navigation (next/previous)
    - [ ] Handle random scrap pulling
  - [ ] Create `app/javascript/controllers/scrap_controller.js`:
    - [ ] Handle scrap form interactions
    - [ ] Handle scrap editing functionality
  - [ ] Create `app/javascript/controllers/navigation_controller.js`:
    - [ ] Handle navigation menu functionality
    - [ ] Handle mobile menu toggle

- [ ] **Update views to use Stimulus**
  - [ ] Add `data-controller` attributes to HTML elements
  - [ ] Add `data-action` attributes for event handling
  - [ ] Add `data-target` attributes for element targeting
  - [ ] Remove jQuery-specific classes and IDs

- [ ] **Rewrite JavaScript functionality**
  - [ ] Convert jQuery AJAX calls to fetch API
  - [ ] Convert jQuery DOM manipulation to vanilla JavaScript
  - [ ] Convert jQuery event handlers to Stimulus actions
  - [ ] Implement proper error handling

## 🎨 **Phase 5: Update Asset Pipeline**

- [ ] **Migrate from Sprockets to importmap/esbuild**
  - [ ] Run `rails javascript:install:esbuild` (if using esbuild)
  - [ ] Update `package.json` if needed
  - [ ] Configure build process

- [ ] **Update CSS organization**
  - [ ] Split large `application.css` into smaller files
  - [ ] Create component-specific CSS files
  - [ ] Update CSS imports

- [ ] **Remove old asset files**
  - [ ] Clean up unused CSS
  - [ ] Remove old JavaScript files
  - [ ] Update asset precompilation settings

## 🧪 **Phase 6: Testing & Validation**

- [ ] **Test all functionality**
  - [ ] Test bowl creation, editing, deletion
  - [ ] Test scrap creation, editing, deletion
  - [ ] Test bowl-scrap associations
  - [ ] Test navigation between bowls
  - [ ] Test random scrap pulling
  - [ ] Test form submissions
  - [ ] Test error handling

- [ ] **Test in different browsers**
  - [ ] Test in Chrome
  - [ ] Test in Firefox
  - [ ] Test in Safari
  - [ ] Test on mobile devices

- [ ] **Performance testing**
  - [ ] Test page load times
  - [ ] Test Turbo navigation speed
  - [ ] Test JavaScript bundle size
  - [ ] Test asset compilation time

## 🚀 **Phase 7: Deployment & Cleanup**

- [ ] **Update deployment configuration**
  - [ ] Update `bin/render-build.sh` for Rails 8
  - [ ] Update `render.yaml` if needed
  - [ ] Test deployment process

- [ ] **Update environment variables**
  - [ ] Check for any Rails 8 specific environment variables
  - [ ] Update production configuration

- [ ] **Final cleanup**
  - [ ] Remove any remaining jQuery references
  - [ ] Remove unused gems
  - [ ] Clean up old configuration files
  - [ ] Update documentation

- [ ] **Deploy to staging**
  - [ ] Deploy to staging environment
  - [ ] Test all functionality in staging
  - [ ] Fix any issues found

- [ ] **Deploy to production**
  - [ ] Deploy to production
  - [ ] Monitor for any issues
  - [ ] Have rollback plan ready

## 📚 **Additional Considerations**

- [ ] **Update documentation**
  - [ ] Update README.md with new setup instructions
  - [ ] Document new Hotwire/Stimulus patterns
  - [ ] Update any API documentation

- [ ] **Team training**
  - [ ] Train team on Hotwire/Stimulus patterns
  - [ ] Update development guidelines
  - [ ] Create examples for common patterns

- [ ] **Monitoring setup**
  - [ ] Set up error monitoring for JavaScript
  - [ ] Monitor Turbo navigation performance
  - [ ] Set up logging for debugging

## 📝 **Notes**

- This migration should be done incrementally, testing each phase thoroughly
- Keep the old jQuery code as backup until the new implementation is fully tested
- Consider creating feature flags for gradual rollout
- Document any issues encountered during migration for future reference

## 🔗 **Resources**

- [Rails 8 Upgrade Guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html)
- [Hotwire Documentation](https://hotwired.dev/)
- [Stimulus Handbook](https://stimulus.hotwired.dev/handbook/introduction)
- [Turbo Documentation](https://turbo.hotwired.dev/)

