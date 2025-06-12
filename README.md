# INTRODUCTION

This is a data analytics project that focuses on:
 - Modern Data Stack technologies
 - Fetch data with API (using Python)
 - Migrate the data into Snowflake (using Fivetran)
 - Transform the data in Snowflake (using dbt)
 - Develop models that answers specific question in Snowflake (using dbt)
 - Visualize in Tableau

Follow along as I take you through the process.


## CREATING A `dbt` PROJECT

1. Create an empty Github repo
2. Clone Github repo locally
3. `dbt init project_name` in the repo
    1. Don’t configure the repo here. This would allow dbt create a blank/empty repository
4. cd into the repository root folder `cd transformation_with_dbt`
5. Open `/.dbt/profiles.yml` to configure profile

The purpose is to run all operation from a virtual env

1. Run `touch Pipfile`
2. Open the pipfile created and paste this:
    
    ```toml
    [[source]]
    url = "https://pypi.org/simple"
    verify_ssl = true
    name = "pypi"

    [packages]
    dbt-core = "==1.9.8"
    dbt-snowflake = "==1.9.4"
    dbt-databricks = "==1.10.3"
    sqlfluff = "==3.4.0"
    sqlfluff-templater-dbt = "==3.4.0"
    pre-commit = "==4.2.0"

    [requires]
    python_version = "3.12"
    ```
    
3. Run `pip install pipenv`
4. Run `pipenv install`
5. Active virtual envr. Run `pipenv shell`
6. Confirm if dbt has been successfully installed
    
    Run `dbt --version`

Resources: [Configure dbt core in databricks](https://youtu.be/frkz-dBiaM4)
Documentation: [dbt Databricks](https://docs.getdbt.com/docs/core/connect-data-platform/databricks-setup)
    
    You should have something as this
    
    ![dbt debug](.img/1.img)
