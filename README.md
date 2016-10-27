# buckit

[![Build Status](https://travis-ci.org/andela-cnwosu/buckit.svg?branch=develop)](https://travis-ci.org/andela-cnwosu/buckit)
[![Coverage Status](https://coveralls.io/repos/github/andela-cnwosu/buckit/badge.svg?branch=develop)](https://coveralls.io/github/andela-cnwosu/buckit?branch=develop)
[![Code Climate](https://codeclimate.com/github/andela-cnwosu/buckit/badges/gpa.svg)](https://codeclimate.com/github/andela-cnwosu/buckit)

## Description

Buckit is an API that lets a user manage his/her bucketlists. A user can create, modify, delete and display bucketlists. These bucketlists could also have items in them which could be modified or deleted. This project can also be extended to other kinds of lists such as todo lists.


## Getting Started

Visit [Buckit](http://buckit-api.herokuapp.com/) to get started. The documentation page on [Buckit Documentation](http://buckit-api.herokuapp.com/documentation) will give you steps on how to get started.


## External Dependencies

This project is built on Rails 5. All other dependencies can be found in the [Gemfile](https://github.com/andela-cnwosu/buckit/blob/develop/Gemfile)


## Endpoints

All endpoints can only be accessed by the user and do not have public access.

EndPoint | Description
--------- | -----------
POST /bucketlists/ | Creates a new bucketlist for the user.
GET /bucketlists/ | Retrieves all bucketlists belonging to the user.
GET /bucketlists/<id> | Retrieves a bucketlist with id = ``` <id> ```.
PUT /bucketlists/<id> | Updates a bucketlist with id = ``` <id> ```.
DELETE /bucketlists/<id> | Deletes a bucketlist with id = ``` <id> ```.
POST /bucketlists/<id>/items/ | Creates an item in a bucketlist with id = ``` <id> ```.
PUT /bucketlists/<id>/items/<item_id> | Updates an item with id = ``` <item_id> ``` in a bucketlist with id = ``` <id> ```.
DELETE /bucketlists/<id>/items/<item_id> | Deletes an item with id = ``` <item_id> ``` in a bucketlist with id = ``` <id> ```.

Full documentation on the various endpoints can be viewed on [Buckit Documentation](http://buckit-api.herokuapp.com/documentation)


##Resources

A typical bucketlist requested by a user would look like this:
```json
[
  {
    "id": 1,
    "name": "list1",
    "items": [],
    "date_created": "2016-10-26 11:21:01",
    "date_modified": "2016-10-26 11:21:01",
    "created_by": "Jane Doe"
  },
  {
    "id": 2,
    "name": "list2",
    "items": [
      {
        "id": 1,
        "name": "item1",
        "date_created": "2016-10-26 12:37:42",
        "date_modified": "2016-10-26 12:37:42",
        "done": false
      }
    ],
    "date_created": "2016-10-26 12:28:00",
    "date_modified": "2016-10-26 12:28:00",
    "created_by": "Jane Doe"
  }
]
```

## Pagination

The bucketlists can be paginated such that users can specify the number of bucketlists they would like to have using query parameters page and limit.

`GET http://buckit-api.herokuapp.com/api/bucketlists?page=<page>&limit=<limit>`

Example:

*Request*: GET http://buckit-api.herokuapp.com/api/bucketlists?page=2&limit=5

*Response*: `5` bucketlists starting from the 6th bucketlist. First page would have bucketlists 1 to 5.

### Query Parameters

Parameter | Default | Required | Description
--------- | ------- | ----------- | ---------
page | 1 | false | This sets a specified page with the specified number of lists.
limit | 20 | false | This sets the specified number of lists on a page. The maximum limit is 100.

##Searching by Name

Users can search for a bucket list by name using a query parameter q.

`GET http://buckit-api.herokuapp.com/api/bucketlists?q=<q>`

Example

*Request*: GET http://buckit-api.herokuapp.com/api/bucketlists?q=mylist

*Response*: Bucketlist with the string ```mylist``` as its name.

### Query Parameter

Parameter | Default | Required | Description
--------- | ------- | ----------- | ---------
q | - | false | This finds a bucketlist with name = ``` q ```.


## Versions
Buckit API currently has only one version. Hopefu


## Tests

Buckit API uses `rspec` for testing.

To test locally, go through the following steps.

1. Clone the repo to your local machine.

  ```bash
  $  git clone git@github.com:andela-cnwosu/buckit.git
  ```

2. `cd` into the `buckit` folder.

  ```bash
  $  cd buckit
  ```

3. Install dependencies listed on the Gemfile

  ```bash
    $  bundle install
  ```

4. Migrate the database.

  ```bash
  $ rails db:migrate
  ```

5. Run the tests.

  ```bash
  $  bundle exec rspec
  ```

## Limitations
This API has not been optimised to handle many requests at the same time efficiently. Also, it is limited to only 8 endpoints and could be modified to include other endpoints and features.


## Contributions

You can give bug reports and make pull requests by forking the repository on GitHub at https://github.com/andela-cnwosu/buckit.
