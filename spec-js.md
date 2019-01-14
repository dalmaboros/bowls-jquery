# Rails App with JavaScript Frontend Spec
## Project Specs:
- [x] Must have a Rails Backend and new requirements implemented through JavaScript.
- [x] Makes use of ES6 features as much as possible(e.g Arrow functions, Let & Const, Constructor Functions)
- [x] Must translate the JSON responses into Javascript Model Objects using either ES6 class or constructor syntax.
    1. Scrap Prototype constructor
    [/app/assets/javascripts/bowls_show.js Lines 5-13](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L5-L13)
- [x] Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend.
    1. Index of `scraps` is rendered on `bowls#show` page via JS and an AMS JSON backend
    [/app/assets/javascripts/bowls_show.js Lines 20-64](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L20-L64)
- [x] Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.
    1. Bowls show pages render via JS and an AMS JSON backend
    [/app/assets/javascripts/bowls_show.js Lines 162-223](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L162-223)
    2. Scraps show pages render via JS and an AMS JSON backend
    [/app/assets/javascripts/bowls_show.js Lines 225-252](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L225-252)
- [x] Your Rails application must reveal at least one 'has-many' relationship through JSON that is then rendered to the page.
    1. Index of `scraps` belonging to `bowl` is rendered on `bowls#show` page via JS and an AMS JSON backend
    [/app/assets/javascripts/bowls_show.js Lines 20-64](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L20-L64)
- [x] Must use your Rails application to render a form for creating a resource that is submitted dynamically through JavaScript.
    1. New scrap form data is serialized and submitted via AJAX, with the response being a new object in JSON
    [/app/assets/javascripts/bowls_show.js Lines 84-106](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L84-106)
    and appending to the DOM using ES6
    [/app/assets/javascripts/bowls_show.js Lines 56-64](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L56-64)
- [x] At least one of the JS Model Objects must have a method on the prototype.
    1. The Scrap Prototype has a method called `this.format()`
    [/app/assets/javascripts/bowls_show.js Lines 10-12](https://github.com/dalmaboros/bowls-jquery/blob/master/app/assets/javascripts/bowls_show.js#L10-12)

# Project Repo Specs:
## Read Me file contains:
- [x] Application Description
- [x] Installation guide (e.g. fork and clone repo, migrate db, bundle install, etc)
- [x] Contributors guide (e.g. file an issue, file an issue with a pull request, etc)
- [x] Licensing statement at the bottom (e.g. This project has been licensed under the MIT open source license.)

## Repo General
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
