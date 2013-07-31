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

```haml
html!
  head
    script type: "text/javascript", src: "http://slkdfksja.js"
  body
    div#content data_para: "hello world"
      p.first "first p"
      p.second-p#special-p
        "special p"
      - a = "username"
      p
        - b = "<b>---------------x--------------</b>"
        = b
        - a.split("").each do |x|
        font x
        - end
      p
        "helloworld"
      div.comments.hahaha
        p.a-comment#no-comment "no comments yet!"
```

**FIRST, converted to ruby code**

```ruby
html! do
  head do
    script type: "text/javascript", src: "http://slkdfksja.js"
  end
  body do
    @id = 'content'
    div data_para: "hello world" do
      @cls = 'first'
      p "first p"
      @cls = 'second-p'
      @id = 'special-p'
      p do
        "special p"
      end
      a = "username"
      p do
        b = "<b>---------------x--------------</b>"
        self.== b
        a.split("").each do |x|
        font x
        end
      end
      p do
        "helloworld"
      end
      @cls = 'comments hahaha'
      div do
        @cls = 'a-comment'
        @id = 'no-comment'
        p "no comments yet!"
      end
    end
  end
end

```

**OUTPUT html**

```html
<html>
  <head>
    <script type='text/javascript' src='http://slkdfksja.js'>
    </script>
  </head>
  <body>
    <div data-para='hello world' id='content'>
      <p class='first'>
        first p
      </p>
      <p class='second-p' id='special-p'>
        special p
      </p>
      <p>
<b>---------------x--------------</b>
        <font>
          u
        </font>
        <font>
          s
        </font>
        <font>
          e
        </font>
        <font>
          r
        </font>
        <font>
          n
        </font>
        <font>
          a
        </font>
        <font>
          m
        </font>
        <font>
          e
        </font>
      </p>
      <p>
        helloworld
      </p>
      <div class='comments hahaha'>
        <p class='a-comment' id='no-comment'>
          no comments yet!
        </p>
      </div>
    </div>
  </body>
</html>
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
