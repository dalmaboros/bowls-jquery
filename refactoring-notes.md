# Refactoring Notes

**_How I go about refactoring the [Bowls](https://github.com/dalmaboros/bowls) app to have a jQuery front-end._**

Instead of sending HTTP requests via Rails to fetch and load individual pages, we will send AJAX requests to the server to fetch objects in JavaScript Object Notation (JSON) and append these objects to the page.

## Process

### Refactor `config/routes.rb`

Draw routes to change a resource such as:

```ruby
# config/routes.rb

resources :scraps
```

to:

```ruby
# config/routes.rb

get 'scraps', to: 'scraps#index'
get 'scraps/:id', to: 'scraps#show'
post 'scraps/new', to: 'scraps#create'
patch 'scraps/:id', to: 'scraps#update'
```
After which we won't be loading separate pages, but rather rendering JSON and appending it to one page, `/scraps`.

Set up the remaining routes for API endpoints.

### Update `ScrapsController` to render JSON

For example in the `scraps#index` action:
```ruby
# app/controllers/scraps_controller.rb

def index
  if !@bowl
    @scraps = current_user.scraps.all
  else
    @scraps = @bowl.scraps
  end
end
```
add `render json: @scraps, status: 200` :
```ruby
# app/controllers/scraps_controller.rb

def index
  if !@bowl
    @scraps = current_user.scraps.all
  else
    @scraps = @bowl.scraps
  end
  render json: @scraps, status: 200
end
```
to render JSON, not redirect to another page.

For `scraps#show` add `render json: @scrap, status: 200`.

### Set up ActiveModel::Serializer

To serialize Ruby objects into JSON objects, first add the gem:

```ruby
# Gemfile

gem 'active_model_serializers'
```
Then run `bundle install`.

To generate an ActiveModel::Serializer for `Scrap` run the generator in your console:
```bash
$ rails g serializer scrap
```
Add scrap attributes to `scrap_serializer.rb`:
```ruby
# app/serializers/scrap_serializer.rb

class ScrapSerializer < ActiveModel::Serializer
  attributes :id, :description, :category
end
```
Restart the Rails server, and navigate to `/scraps` to see scraps rendered in JSON.

Make an ActiveModel:: Serializer for `Bowl`:
```bash
$ rails g serializer bowl
```
Create associations by adding `has_many :scraps` to `bowl_serializer.rb`:
```ruby
# app/serializers/bowl_serializer.rb

class BowlSerializer < ActiveModel::Serializer
  attributes :id

  has_many :scraps
end
```
And `has_many :bowls` to `scrap_serializre.rb`:
```ruby
# app/serializers/scrap_serializer.rb

class ScrapSerializer < ActiveModel::Serializer
  attributes :id, :description, :category

  has_many :bowls
end
```
Create a `BowlScrapSerializer`:
```bash
$ rails g serializer bowl_scrap
```
Add the `description` attribute to and remove the `id` attribute from this `BowlScrapSerializer`:
```ruby
# app/serializers/bowl_scrap_serializer.rb

class BowlScrapSerializer < ActiveModel::Serializer
  attributes :description
end
```
Explicitly give the `BowlSerializer` the `BowlScrapSerializer` when rendering a `Scrap`:
```ruby
# app/serializers/bowl_serializer.rb

class BowlSerializer < ActiveModel::Serializer
  attributes :id

  has_many :scraps, serializer: BowlScrapSerializer
end
```
## Configure AMS

Like in this lesson [here](https://learn.co/tracks/full-stack-web-development-v5/rails-and-javascript/project-mode/jquery-tic-tac-toe-with-a-rails-api-part-1#ams-configuration).

## Update Views

---

**Resources**

*I used [Markdown Editor](https://jbt.github.io/markdown-editor/) and Markdown Cheatsheets [[1]](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) [[2]](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#hr) to help create this document*
