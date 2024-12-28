# dawumr (development version)

# 0.2.0

## Breaking Changes

### Renamed Functions

The following functions have been renamed to improve clarity and consistency in naming:

-   `pull_dawum()` has been renamed to **`load_dawum_db`**.\
    This function retrieves the DAWUM database in its raw JSON-like structure.

-   `pull_dawum_dataframe()` has been renamed to **`load_dawum_results`**.\
    This function retrieves a denormalized dataframe of survey results from the DAWUM database.

These changes are **not backward-compatible**. Please update any code or scripts using the old function names accordingly.

# 0.1.0.9008

-   Export only `pull_dawum()` and `pull_dawum_dataframe()`
