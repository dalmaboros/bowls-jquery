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

---

**Resources**

*I used [Markdown Editor](https://jbt.github.io/markdown-editor/) and Markdown Cheatsheets [[1]](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) [[2]](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#hr) to help create this document*
