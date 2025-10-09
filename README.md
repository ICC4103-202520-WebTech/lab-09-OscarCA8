# Lab 7 — Recipe Book Application: Authentication with Devise

## Objective
Extend the Recipe Book application from the previous lab by adding **user authentication** using the **Devise** gem.  
By the end of this lab, users should be able to sign up, log in, and manage their session securely.  

This lab reinforces:
- Integrating external gems into a Rails project.
- Setting up Devise for user authentication.
- Restricting access to certain pages for authenticated users.

## Instructions
1. **Add Devise to the Application**
   - Integrate **Devise** into your project and complete the required setup.
   - Make sure the configuration steps are correctly followed so that authentication views and routes work properly.

2. **Create the User Model**
   - Generate a `User` model using Devise.
   - Run the necessary migrations to create the users table.
   - Verify that the login and registration flows work as expected.

3. **Associate Recipes with Users**
   - Add a reference from recipes to users so that each recipe belongs to a specific user.
   - Update model relationships:
     - A user can have many recipes.
     - Each recipe belongs to a user.

4. **Restrict Access**
   - Ensure that only authenticated users can create, edit, or delete recipes.
   - Visitors who are not logged in should still be able to view the list of recipes and read individual recipe details.
   - Use built-in Devise helpers to manage access control.

5. **User Interface**
   - Add navigation links for **Sign up**, **Log in**, and **Log out**.
   - Display the logged-in user’s email or name in the navigation bar.
   - **Customize Devise views** to match the look & feel of your Recipe Book application (using your existing layout, Bootstrap styles, and consistent navigation).
   - Optionally, show only the recipes created by the logged-in user on the index page.

## Deliverables
- Recipe Book application extended with authentication using Devise.
- Users can register, log in, and log out successfully.
- Only authenticated users can create, edit, or delete recipes.
- Public users can view the list of recipes.
- Navigation updated to include authentication links.
