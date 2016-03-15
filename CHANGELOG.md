## Siphon 0.2.4 (Mar 2016)

* Fixed scopes with no argument still sending nil !
* Added `method: 'GET'` to simple_form_for generator.

## Siphon 0.2.3 (Feb 2016)

* Generator for a controller using Siphon
* Generator for a `simple_form_for`

## Siphon 0.2.1 (Dec 2015)

* Boilerplate only sets params (relation is left to the user)
* Search#order_by isn't called in result (left to user as well )

## Siphon 0.2.0 (Dec 2015)

* The ModelSearch can now respond_to `siphon_attributes`
* Boilerplate provides all the stuff ModelSearch needs...
* ...hence the generated ModelSearch is now minimal
* Boilerplate also gives users a `ransack` macro to set ransack attributes 

## Siphon 0.1.3

* handle time & dates arguments for scope from issue #2
