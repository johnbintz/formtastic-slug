Add a slug field, that generates a slug based on another field.

``` haml
= semantic_form_for @blog_entry do |f|
  = f.input :title
  = f.input :slug, :as => :slug, :based_on => :title
```

You can put in the list of existing slugs and the editor will avoid using those:

``` haml
= semantic_form_for @blog_entry do |f|
  = f.input :title
  = f.input :slug, :as => :slug, :based_on => :title, :existing_slugs => @blog_entry.class.slugs
```

Just add it to your Gemfile:

``` ruby
gem 'formtastic-slug', :git => 'git://github.com/johnbintz/formtastic-slug.git'
```
