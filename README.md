# task3-module-vi

## Developer
```sh
name: marco antonio baltazar santos
email: mabsbaltazar@gmail.com
```

## Description

* The Project contains two entities Teachers, Courses, and with the ability to `CRUD` Create, Read, Update, Delete
* Teachers entity, contains `teacher_name`, `teacher_email`
    * The Search teacher input works only with the field "teacher_name"
    * The Filter works only with teacher_email example: gmail, hotmail

* Courses entity, contains `course_name`, `course_description`, `teacher_id
    * The Search course input works only with the  field "course_description"
    * The Filter works only with Course example: A, B ,C


## Repository

Clone the repository from

```sh
git clone 
```

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies and devDependencies and start the server.

```sh
npm install
```

Start the json-server (backend).

```sh
npm run json-server
```

Start the app(frontend).

```sh
npm run serve
```