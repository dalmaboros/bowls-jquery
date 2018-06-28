# Refactoring Notes

**_How I go about refactoring the [Bowls](https://github.com/dalmaboros/bowls) app to have a jQuery front-end._**

Instead of sending HTTP requests via Rails to fetch and load individual pages, we will send AJAX requests to the server to fetch objects in JavaScript Object Notation (JSON) and append these objects to the page.

## Steps

### Refactor `config/routes.rb`

Draw routes to change a resource such as:

```
resources :scraps
```

to:

```
get 'scraps', to: 'scraps#index'
get 'scraps/:id', to: 'scraps#show'
post 'scraps/new', to: 'scraps#create'
patch 'scraps/:id', to: 'scraps#update'
```
After which we won't be loading separate pages, but rather rendering JSON and appending it to one page, `/scraps`.

### Update `ScrapsController` to render JSON

---

**Resources**

*I used [Markdown Editor](https://jbt.github.io/markdown-editor/) and [Markdown Cheatsheet](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) to help create this document*
