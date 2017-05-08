# Volunteer Database

#### By Ben Metzger

## Description

Use Postgres/SQL and Ruby/Sinatra to create an application that tracks projects and the volunteers working on them. Each volunteer will belong to only one project (one project, many volunteers).

The following user stories should be completed:

1. As a non-profit employee, I want to view, add, update and delete projects.
2. As a non-profit employee, I want to view, add, update and delete volunteers.
3. As a non-profit employee, I want to add volunteers to a project.

## Setup Instructions
You must have Postgres installed. Clone the directory and run the database setup instructions below.

1. CREATE DATABASE volunteer_tracker;
2. CREATE TABLE projects (id serial PRIMARY KEY, name varchar);
3. CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, project_id int);

Open your Ruby terminal and run $ bundle, followed by $ ruby app.rb.
