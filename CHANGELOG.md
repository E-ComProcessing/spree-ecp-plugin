0.2.0
-----
**Features**:

* Deprecated e-comprocessing Gateway Module for Spree eCommerce

0.1.8
-----
**Features**:

* Updated Genesis Ruby SDK to version 0.1.7
* Updated Card JS to the latest
* Updated transaction type list in the ecomprocessing Checkout payment method
* Removed GiroPay transaction type
* Added Spree eCommerce version 4.8.x support

0.1.7
-----
**Features**:

* Added the following Mobile transaction types support through the ecomprocessing Checkout payment method:
  * Apple Pay
  * Google Pay
  * Pay Pal

0.1.6
-----
**Features**:

* Added Docker project
* Added Spree Rails FrontEnd Redirect URL handling (asynchronous payments)
* Updated README

0.1.5
-----
**Features**:

* Added `ecomprocessing Checkout` Description field handling
* Updated Genesis Ruby SDK to version 0.1.6
* Updated project dependencies
* Added `ecomprocessing Checkout` Custom Attributes handling
* Added `ecomprocessing Checkout` Language support

0.1.4
-----
**Features**:

* Added `EcomprocessingCheckout` payment method
* Updated Genesis Ruby SDK to version 0.1.5
* Update Card JS to the latest version

**Fixes**:

* Fixed project's URLs listed on RubyGems

0.1.3
-----
**Features**

* Added tests to the library
* Added Appraisals for Spree 4.4 and Spree main GitHub Branch
* Added `spree_ecomprocessing_genesis` to [RubyGems](https://rubygems.org/gems/spree_ecomprocessing_genesis)

**Fixes**:

* Fixed 3DSv2 parameters handling
* Fixed engine installation without Spree Rails Frontend
* Fixed minor issues

0.1.2
-----

**Features**:

* Updated project license to MIT
* Added support for the following transaction types:
  * Authorize 3D
  * Sale 3D
* Added 3DSv2 parameters support to the 3D payments
* Added support for 3DSv2 payment flow
* Added `ecomprocessing_payment` inside Spree API V2 Create Payment response containing payment state and redirect_url
* Added Gateway Notifications handling used for asynchronous payments
* Updated Genesis Ruby SDK to version 0.1.3

0.1.1
-----

**Features**:

* Added support for the following reference payment actions via Genesis Gateway:
  * Capture
  * Void
  * Refund

0.1.0
-----

**Features**:

* Added initial code base for E-Comprocessing Gateway Module for Spree payment method
* Added EcomprocessingDirect Spree Gateway
* Added Spree Payment Creation decoration
* Added Spree Payment Methods settings decorator
* Added Payment Source View decorator
* Added Spree V2 Checkout controller decorator
* Added Ecomprocessing Payments database migration
* Added Spree Payment Processing decorator
