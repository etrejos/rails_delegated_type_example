# README

This is an example of how to use the `delegated_type` feature introduced in
Rails 6.1+.

## Install Ruby & gems

1. Get `asdf` if you don't have it.
1. Install Ruby 3.1.3 used in this repository.
```sh
asdf install
```
1. Install bundler.
```sh
gem install bundler -v 2.4.3
```
1. Install the gem bundle:
```sh
bundle install
```

## Create & populate the DB
```sh
bin/rails db:migrate db:seed
```

## Test preloading delegated associations

```sh
bin/rails c
```
```rb
begin
  Entry
    .includes(entryable: [:user, :message])
    .filter { |entry| entry.entryable_type == 'Comment' } # Intentionally not using .comments scope
    .last
    .entryable
    .message
end
```
```
  Entry Load (0.1ms)  SELECT "entries".* FROM "entries"
  Message Load (0.2ms)  SELECT "messages".* FROM "messages" WHERE "messages"."id" IN (?, ?)  [["id", 1], ["id", 2]]
  Comment Load (0.1ms)  SELECT "comments".* FROM "comments" WHERE "comments"."id" IN (?, ?, ?, ?, ?)  [["id", 1], ["id", 2], ["id", 3], ["id", 4], ["id", 5]]
  User Load (0.0ms)  SELECT "users".* FROM "users" WHERE "users"."id" IN (?, ?, ?, ?, ?, ?)  [["id", 1], ["id", 5], ["id", 2], ["id", 3], ["id", 4], ["id", 6]]
  Message Load (0.0ms)  SELECT "messages".* FROM "messages" WHERE "messages"."id" IN (?, ?)  [["id", 1], ["id", 2]]
=>
#<Message:0x00000001073bec70
 id: 2,
 content: "Message #2",
 user_id: 5,
 created_at: Mon, 21 Aug 2023 19:03:43.737711000 UTC +00:00,
 updated_at: Mon, 21 Aug 2023 19:03:43.737711000 UTC +00:00>
irb(main):005:0>
```
```rb
begin
  Entry
    .includes(entryable: [:user, :message])
    .filter { |entry| entry.entryable_type == 'Comment' } # Intentionally not using .comments scope
    .last
    .entryable
    .association(:message)
    .loaded?
end
```
```
=> true
```
