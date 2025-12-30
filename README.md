# 1. COOP ?

COOP is the result of a personal project around the  monitoring of building rehabilitation projects in mix mode involving professionals and private individuals. These projects are monitored and coordinated by a network of independent associations. This explains the name of the app and the section devoted to collaborative
work. 

COOP is a 3 in 1 modular app combining a website, teams workspaces and building rehab projects management. COOP is a multilevel user app : admin, supervisor, editor, viewer, public, with a possibility of group permissions at each level (*if needed, COOP can be sliced down to one or two modules*).

  * The project management module allows to monitor  project schedule through Gantt charts, team composition, workhours, expenses, wastes, carbon footprint, meetings schedules, pictures gallery and documents . The module include also a supervisor dashboard with various stats and an address book.
  * The workspace module includes various tools : FAQ, forum, chat, news, events.
  * The website module includes standard features : About us, Contact form, FAQ, news, events, event registration. It includes also some tools to manage a small organization : members and membership follow up, document.
  * The admin panel includes the users permissions management,  a debug forum, help and process management, connexions stats, list of choices and patterns management. 


Disclaimer: _I am a self-taught developer. I copy and paste snippets of code found in forums or tutorials or created using AI engines. I don't even understand always what I am pasting ! A professional developer will surely be able to produce a faster and cleaner code. Your comments and suggestions are therefore welcome!_


I am not an IT pro so I choose [SQLPage](https://sql-page.com/) to develop COOP. COOP code is very simple: basic SQL queries, SQLPage base (no custom components, no scripts), very academic query writing, very explicit file and folder names... The first version of COOP was develop with sqlite as database engine but it was not consistent with the collaborative aim of COOP, so COOP was rewrite to work on Postgresql. Postgreql allows multiple connections in the same time and postgresql offers much more features for further developments (for example : links to Postgis).

COOP can be used as a template, a draft to develop more complex apps around project management, or as a set of examples to discover SQLpage.

COOP was developed with SQLpage 0.40.0, Postgresql 16, linux mint 22.1. Development tools : VSCodium, DBeaver-CE, Pandoc, Retex (*all free and open source apps, thanks to all developers !*)


# 2. Install COOP

Installing COOP is straightforward:

-   install postgresql (version 16 or +)

-   create a user : coop with its password

-   download the entire COOP_pg folder from Github

-   paste the files and folder from  COOP_pg folder into` /var/www/coop`

-   restore coop database from the dump file located at` /var/www/coop/a_install/dump-coop-*******.sql ;` the dump comes with few data which are necessary to use COOP : users accounts, list of choices...(*You may have to adjust the beginning of the file about the users and roles*)

-   modify the json file located at `/var/www/coop/sqlpage/sqlpage.json` to setup the password in


` "database_url": "postgres://coop:CoopPassword@localhost:5432/coop",`


- to display the correct info about your organisation, you need to set up the `orga_dept_id` in `$orga_footer, $orga_dept_name, $logo` in  `/var/www/coop/a_shells/shell_core.sql`. By default, the `orga_dept_id` is set on '2' but if you have made some changes in the `orga_dept` table it can be the good value. You may have to do the same adjustments in the files of the folder `/var/www/coop/b_about`.


-   set up write permissions on the sub-folders with an "x\_" prefix (these
    are used to download documents or images)

-   in the terminal, go to the COOP folder:` /var/www/coop`

-   in the terminal, launch SQLPage: `/var/www/coop/sqlpage/sqlpage.bin`

-   *you can create a sevice to launch sqlpage when starting you computer [see the post](https://github.com/sqlpage/SQLPage/discussions/603)*

-   in your browser, go to: `http://localhost:8080/`

# 3. Start the tour.

COOP comes with several preset user accounts :

-   admin1@coopcoop.net, admin2@coopcoop.net, admin3@coopcoop.net

-   supervisor1@coopcoop.net, supervisor2@coopcoop.net, supervisor3@coopcoop.net

-   editor1@coopcoop.net, editor2@coopcoop.net, editor3@coopcoop.net

-   viewer1@coopcoop.net, viewer2@coopcoop.net, viewer3@coopcoop.net,

**all accounts are using the same password: CoopCoop1@**

Playing with different accounts can be useful to test the collaborative tools : forum, chat, event.

To create new users,you need to use the sign up form in the menu "connect" then log as admin to set the rights of the new user in the menu "NEW USERS" in the admin dashboard panel.


# 4. To learn more about COOP and SQLpage

When logged as admin, in the admin panel, you will find a "Help Dev" menu with COOP on-board
documentation. you will find also a complete description of COOP [in the wiki in github ](https://github.com/SebastiendOrnano/coop_pg/wiki).

 [SQLapge is well documented](https://sql-page.com/documentation.sql) ; you may find good examples also in [Learn SQLPage](https://learnsqlpage.com/).
