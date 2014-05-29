require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.

Post.blueprint do
  title { "Post #{sn}" }
  body  { 'Lorem ipsum...' }
  link { 'http://google.com' }
end
