# Notes

## Project Requirements

- [ ] Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend
  - [ ] **render the bowls index page using AJAX?**
  - [x] display the index of a bowl's scraps on the bowls show page
  - [ ] fetching the scraps via a AJAX GET request
  - [ ] with the backend rendering the scraps in JSON format
  - [ ] and then appending the scraps to the page.

- [ ] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.
  - [ ] allow a user to sift through the bowls by clicking a 'Next' button on the bowls show page
  - [ ] with the next bowl being fetched via AJAX and rendered through JavaScript.

- [x] Your Rails application must dynamically render on the page at least one 'has-many' relationship through JSON using JavaScript.
  - [x] if each of the bowls has many scraps, you could render those scraps as well on that bowl's show page.

- [x] Must use your Rails application and JavaScript to render a form for creating a resource that submits dynamically.
  - [x] user might be able to add a scrap to a bowl:
    - [x] the scrap would be serialized,
    - [x] and submitted via an AJAX POST request
    - [x] with the response being the new object in JSON
    - [x] and then appending that new scrap to the DOM using JavaScript

- [x] Must translate the JSON responses into JavaScript Model Objects using either ES6 class or constructor syntax. The Model Objects must have at least one method on the prototype.
  - [x] instead of plainly taking the JSON response of the newly created scrap and appending it to the DOM, you would create a Scrap prototype object
  - [x] and add a function to that prototype to perhaps concatenate (format) the scraps description.
  - [x] You would then use the object to append the scrap information to the DOM.

## Bugs

- [x] Omniauth doesn't take you to Google sign in page, automatically signs you in with primary Google account
- [ ] Can add pre-existing scrap using 'create new scrap' feature (11/3)
- [ ] On bowls show page, the previous AJAX-created scrap is deleted before the new one is created (11/14)

## Next Steps
