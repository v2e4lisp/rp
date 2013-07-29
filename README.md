# Rp

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'rp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rp

## Usage

```yaml
html!
  p "hello world"
  div class: "user-name", id: "first-one"
    title "hello title"
    >> a = "hell world"
    >> (1..4).each do |x|
    >> a << " again"
    div a
    >> end
  div class: "nothing"
  p "done"
```

output

```html
<html>
  <p>
    hello world
  </p>
  <div class='user-name' id='first-one'>
    <title>
      hello title
    </title>
    <div>
      hell world again
    </div>
    <div>
      hell world again again
    </div>
    <div>
      hell world again again again
    </div>
    <div>
      hell world again again again again
    </div>
  </div>
  <div class='nothing'>
  </div>
  <p>
    done
  </p>
</html>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
