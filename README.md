Add a slug field, that generates a slug based on another field.

``` haml
= semantic_form_for @blog_entry do |f|
  = f.input :title
  = f.input :slug, :as => :slug, :based_on => :title
```

Just add it to your Gemfile:

``` ruby
gem 'formtastic-slug', :git => 'git://github.com/johnbintz/formtastic-slug.git'
```
