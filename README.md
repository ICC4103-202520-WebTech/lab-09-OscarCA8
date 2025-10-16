# Lab 8 — Recipe Book Application: Authorization and User Roles

## Objective
Extend the Recipe Book application by implementing **authorization** so that only certain users can perform specific actions.  
You will use either **CanCanCan** or **Pundit** to manage permissions, and define user **roles** in the `User` model using an `enum`.

By the end of this lab:
- Users with different roles will have different access levels.
- You will understand how to define and enforce authorization rules in Rails.

## Instructions
1. **Add Roles to the User Model**
   - Add an `enum` field called `role` to the `User` model.  
     Suggested roles:
       - `regular` (default)
       - `admin`
   - Update or seed the database to include at least one admin user.

2. **Choose an Authorization Library**
   - Use either **CanCanCan** or **Pundit** for this lab.  
   - Install and configure the gem following its documentation.
   - Create the necessary files (`Ability` for CanCanCan or `Policy` for Pundit).

3. **Define Authorization Rules**
   - **Admin users** should be able to:
     - Manage all recipes (create, edit, delete, view).
     - Manage all users (optional if you want to extend functionality).
   - **Regular users** should be able to:
     - Create new recipes.
     - Edit or delete **only their own** recipes.
     - View all recipes.

4. **Apply Authorization in Controllers**
   - Add the proper checks in controllers to enforce permissions.
   - Redirect users or show an error message when they try to access unauthorized actions.

5. **User Interface**
   - Update the navigation bar to show or hide options based on the user’s role.
     - For example, only admins should see management links.
   - Add friendly messages when a user attempts to perform an unauthorized action.

## Deliverables
- Recipe Book application extended with authorization using CanCanCan or Pundit.
- Users have defined roles (`regular` and `admin`).
- Regular users can only manage their own recipes.
- Admins can manage all recipes.
- Interface updated to reflect available actions according to user role.