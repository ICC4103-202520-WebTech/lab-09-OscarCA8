# Lab 6 — Recipe Book Application

## Objective
Build a complete **Ruby on Rails** application for managing a personal recipe book.  
The application must implement a full CRUD (Create, Read, Update, Delete) for a single model and use **ActionText** for rich text content.

This lab consolidates what you have learned so far:
- Building models, controllers, and views in Rails.
- Using **PostgreSQL** as the database.
- Styling with **Bootstrap**.
- Adding **ActionText** for rich text fields.
- Implementing full CRUD functionality (`index`, `show`, `new`, `edit`, `destroy`).

## Instructions
1. **Model**
   - Create a `Recipe` model with the following attributes:
     - `title` (string): the name of the recipe.
     - `cook_time` (integer): preparation time in minutes.
     - `difficulty` (string): level of difficulty (e.g., "Easy", "Medium", "Hard").
     - `instructions` (ActionText): detailed cooking instructions with formatted text, links, and images.

2. **Database**
   - Use **PostgreSQL** as the database engine.

3. **Interface and Styling**
   - Style all views with **Bootstrap**.
   - Add a navigation bar with links to the list of recipes and the form for creating a new recipe.

4. **CRUD Functionality**
   - **Index view**: list all recipes showing their title, cook time, and difficulty.
   - **Show view**: display full details of a recipe, including the rich text instructions.
   - **New view**: form to add a new recipe.
   - **Edit view**: form to edit an existing recipe.
   - **Destroy action**: option to delete a recipe with confirmation, redirecting to the index.

## Deliverables
- A fully working Rails application implementing the recipe book.
- All views styled with Bootstrap.
- ActionText correctly set up for the `instructions` field.
- Clean and organized code, following Rails conventions.
