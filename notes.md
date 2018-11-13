# Notes

## Project Requirements

[ ] Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend

[ ] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.

[ ] Your Rails application must dynamically render on the page at least one 'has-many' relationship through JSON using JavaScript.

[ ] Must use your Rails application and JavaScript to render a form for creating a resource that submits dynamically.
- add a scrap to a bowl:
  - the scrap would be serialized,
  - and submitted via an AJAX POST request
  - with the response being the new object in JSON
  - and then appending that new scrap to the DOM using JavaScript

[ ] Must translate the JSON responses into JavaScript Model Objects using either ES6 class or constructor syntax. The Model Objects must have at least one method on the prototype. Formatters work really well for this.

## Next steps (jQuery app)
[] append new scrap to DOM
  [] refactor getScraps(id)
    [] $('#show-scraps').on('click') needs to hide/show div, not populate it with content
[x] show new scrap without having to click anything

## Bugs

- ~~Omniauth doesn't take you to Google sign in page, automatically signs you in with primary Google account~~ resolved on own
- Can add pre-existing scrap using 'create new scrap' feature (11/3)

## Next steps (from Rails-only app)

* priority input for bowl_scraps is being created without a scrap, which doesn't make sense
* fix this somehow, maybe by changing the models to be Bowl, Activity, Scrap?

scrap belongs_to bowl
bowl has_many scraps

scrap belongs_to activity
activity has_many scraps

bowl has_many activities, through: :scraps

scrap.priority

???
