## TODO
* [] default param values e.g : has_scopes({ state: "pending" })
* [] play well with ransack
* [] more complex examples

## Investigate Crazy Idea

A new dsl
url: bla?published&after=1950author_lang="english"

    @books = siphon(Book.includes :author)

    # applies scope only if the corresponding params are present
    @books.with(params).published.after(1900).author_lang("french")
    # applies scope event if the params are absent but overrides argument ???
    # may not be necessary : siphon(Book.order(params[:order] || "authors.birth"))
    @books.ensure.instore(true).order("authors.birth")