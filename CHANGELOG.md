# Changelog

## [Unreleased]
### Summary
This release adds options for secure and insecure download of the Deep Security agent, and allows the passing of install options to the package resource. It also enforces data types for all pre-existing parameters, consistent with the pre-existing values in the Params class, as well as any newly added parameters, from [@rmartin-alarm](https://github.com/rmartin-alarm).

## [0.1.1] - 2018-11-28
### Features

- Allows download options for curl command to be passed such as insecure download and specific cipher
- Allows install to be done from a pre-downloaded rpm as the rpm command does not handle insecure URLs well
- Allows install options to be passed to the package provider

### Improvements

- Specifies data types for all parameters
- Parameterizes the curl command so that insecure download may be used
