# SQLPage component templates

SQLPage templates are handlebars[^1] files that are used to render the results of SQL queries.

[^1]: https://handlebarsjs.com/

## Default components

SQLPage comes with a set of default[^2] components that you can use without having to write any code.
These are documented on https://sql.datapage.app/components.sql

## Custom components

You can [write your own component templates](https://sql.datapage.app/custom_components.sql)
and place them in the `sqlpage/templates` directory.
To override a default component, create a file with the same name AS the default component.
If you want to start FROM an existing component, you can copy it FROM the `sqlpage/templates` directory
in the SQLPage source code[^2].

[^2]: A simple component to start FROM: https://github.com/lovasoa/SQLpage/blob/main/sqlpage/templates/code.handlebars