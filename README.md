# Bowls

## Description
Bowls is a digital version of something I call an "idea bowl," which is a bowl that contains scraps of paper on which are written activities that interest you. When you have spare time, you reach into this bowl, pull out a scrap, and do the activity.

Bowls, the application, lets you create digital bowls containing digital scraps with activities, and it lets you pull these scraps at random.

## How to Use
To watch a video demonstration of Bowls, click [this link](https://www.youtube.com/watch?v=pTkqv5MzIBU&feature=youtu.be), or click below.

[![Bowls Video Demo](https://img.youtube.com/vi/pTkqv5MzIBU/0.jpg)](https://www.youtube.com/watch?v=pTkqv5MzIBU&feature=youtu.be)

## Technical Details
This project uses Rails version 4.2.7.1. Dependencies can be found in the [Gemfile](https://github.com/dalmaboros/bowls-jquery/blob/master/Gemfile.lock).

## Installation Guide
1. [Fork this repository](https://help.github.com/articles/fork-a-repo/).
2. [Clone forked repository](https://help.github.com/articles/cloning-a-repository/).
3. Navigate to project directory in your terminal.
4. Run `bundle install` to install all the required gems.
5. If you don't have Bundler installed, run `gem install bundler`, then run the above code in step 4 again.
6. Run `rake db:migrate` to run database migrations.
7. Run `rails s` in your terminal.
8. In your web browser, navigate to [http://localhost:3000](http://localhost:3000).

## Contributor's Guide
### What do I need to know to help?
If you are looking to help to with a code contribution our project uses Ruby on Rails and JavaScript/jQuery. Check out our [open issues](https://github.com/dalmaboros/bowls-jquery/issues).

If you are interested in making a code contribution and would like to learn more about the technologies that we use, check out the list below.

- [Ruby on Rails](https://rubyonrails.org/)
- [JavaScript](https://www.javascript.com/)
- [Working With JavaScript in Rails](https://guides.rubyonrails.org/working_with_javascript_in_rails.html)

### How do I make a contribution?
Never made an open source contribution before? Wondering how contributions work in the in our project? Here's a quick rundown!

1. Find an issue that you are interested in addressing or a feature that you would like to add.
2. Fork the repository associated with the issue to your local GitHub organization. This means that you will have a copy of the repository under **your-GitHub-username/repository-name**.
3. Clone the repository to your local machine using `git clone https://github.com/github-username/repository-name.git`.
4. Create a new branch for your fix using `git checkout -b branch-name-here`.
5. Make the appropriate changes for the issue you are trying to address or the feature that you want to add.
6. Use `git add insert-paths-of-changed-files-here` to add the file contents of the changed files to the "snapshot" git uses to manage the state of the project, also known as the index.
7. Use `git commit -m "Insert a short message of the changes made here"` to store the contents of the index with a descriptive message.
8. Push the changes to the remote repository using `git push origin branch-name-here`.
9. Submit a pull request to the upstream repository.
10. Title the pull request with a short description of the changes made and the issue or bug number associated with your change. For example, you can title an issue like so "Added more log outputting to resolve #4352".
11. In the description of the pull request, explain the changes that you made, any issues you think exist with the pull request you made, and any questions you have for the maintainer. It's OK if your pull request is not perfect (no pull request is), the reviewer will be able to help you fix any problems and improve it!
12. Wait for the pull request to be reviewed by a maintainer.
13. Make changes to the pull request if the reviewing maintainer recommends them.
14. Celebrate your success after your pull request is merged!

### Where can I go for help?
If you need help, you can ask Dalma Boros at [dalma.boros@gmail.com](mailto:dalma.boros@gmail.com).

## Licensing Statement
This project has been licensed under the MIT open source license. The full licelicensing statement can be found in the [LICENSE.md file](https://github.com/dalmaboros/bowls-jquery/blob/master/LICENSE.md).
