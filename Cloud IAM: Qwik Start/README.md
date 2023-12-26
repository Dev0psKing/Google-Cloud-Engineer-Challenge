# Cloud IAM: Qwik Start

## Overview
Google Cloud's Identity and Access Management (IAM) service provides a centralized way to manage permissions for Google Cloud resources. IAM unifies access control across various Google Cloud services, offering a consistent set of operations. This hands-on lab introduces you to the fundamentals of IAM, where you'll learn how to assign roles to users, experience permissions as Google Cloud Project Owner and Viewer, and explore the process of granting and revoking permissions.

## Prerequisites
This is an introductory-level lab, requiring little to no prior knowledge of Cloud IAM. While experience with Cloud Storage is beneficial, it is not mandatory. Ensure you have a file in either .txt or .html format available for use. If you're looking for more advanced practice with Cloud IAM, consider exploring the Google Cloud Skills Boost lab, IAM Custom Roles.

## Lab Tasks

### Setup for Two Users
This lab provides two sets of credentials to illustrate IAM policies and showcase available permissions for specific roles. Follow these steps to set up the environment:

1. Return to the Username 1 Cloud Console page.
2. Select Navigation menu > IAM & Admin > IAM. You are now in the "IAM & Admin" console.
3. Click the +GRANT ACCESS button at the top of the page.
4. Scroll down to Basic and hover over the four roles:
   - Browser
   - Editor
   - Owner
   - Viewer

   These are primitive roles in Google Cloud, setting project-level permissions for various services.

### IAM Console and Project Level Roles
Explore the IAM console and project-level roles to understand the available roles and their permissions:

1. **Browser Role:** This role grants permissions to view resources but not make any changes.
2. **Editor Role:** Users with this role can make changes to resources, excluding access to grant permissions.
3. **Owner Role:** Owners have full control, including the ability to grant permissions to others.
4. **Viewer Role:** Users with this role can view resources and settings but cannot make changes.

Understand the definitions and permissions associated with each role by referring to the Google Cloud IAM article on Basic roles.

## Conclusion
Upon completing this lab, you will have gained practical experience in IAM by assigning roles to users and exploring permissions. This knowledge is foundational for effective access control and resource management within Google Cloud. If you have any questions or encounter challenges, consult the troubleshooting section or seek assistance from the community. Enjoy your exploration of Cloud IAM!