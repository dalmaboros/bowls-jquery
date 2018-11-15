# Notes

## Project Requirements

- [ ] Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend
  - [ ] render the bowls index page using AJAX?
  - display the index of a bowl's scraps on the bowls show page
  - fetching the scraps via a AJAX GET request
  - with the backend rendering the scraps in JSON format
  - and then appending the scraps to the page.

- [ ] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.
  - allow a user to sift through the bowls by clicking a 'Next' button on the bowls show page
  - with the next bowl being fetched via AJAX and rendered through JavaScript.

- [x] Your Rails application must dynamically render on the page at least one 'has-many' relationship through JSON using JavaScript.
  - if each of the bowls has many scraps, you could render those scraps as well on that bowl's show page.

- [x] Must use your Rails application and JavaScript to render a form for creating a resource that submits dynamically.
  - user might be able to add a scrap to a bowl:
    - the scrap would be serialized,
    - and submitted via an AJAX POST request
    - with the response being the new object in JSON
    - and then appending that new scrap to the DOM using JavaScript

- [x] Must translate the JSON responses into JavaScript Model Objects using either ES6 class or constructor syntax. The Model Objects must have at least one method on the prototype.
  - instead of plainly taking the JSON response of the newly created scrap and appending it to the DOM, you would create a Scrap prototype object
  - and add a function to that prototype to perhaps concatenate (format) the scraps description.
  - You would then use the object to append the scrap information to the DOM.

## Next steps (jQuery app)

## Bugs

- ~~Omniauth doesn't take you to Google sign in page, automatically signs you in with primary Google account~~ resolved on own
- Can add pre-existing scrap using 'create new scrap' feature (11/3)
- Multiple scrap creation using AJAX: all get created, but only last one gets associated with current bowl.

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
