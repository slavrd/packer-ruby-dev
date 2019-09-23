# Packer Ruby dev Vagrant box

A packer project to build a Ruby dev Vagrant box. The box has `rbenv` and some other basic tools like `git`, `vim`, `curl` etc. installed.

There are also some rbenv ruby versions preinstalled - `2.3.x`, `2.5.x`, `2.6.x`. For each of those `bundler` is installed as well.

The box is currently based on using `slavrd/bionic64`. This can be set as a packer variable in the `template.json`.

## Prerequisites

* Install [packer](https://www.packer.io/downloads.html).
* Install [vagrant](https://www.vagrantup.com/downloads.html).
* Ruby version ~> 2.5.1 for running KitchenCI test.

## Building the box with Packer

The packer template is in `template.json`. In the `variables` section you can set parameters to customize the build. Help on setting, overriding variables in packer can be found [here](https://www.packer.io/docs/templates/user-variables.html#setting-variables).


Run `packer validate template.json` - to make basic template validation.

Run `packer build template.json` - to build the Vagrant box with packer.

## Testing with KitchenCI

The project includes a KitchenCI configuration to run basic tests against the box outputted from packer.

To run it you need to install the gems from the `Gemfile`. Its recommended to use ruby [`bundler`](https://bundler.io/).

Installing gems with bundler:

* `gem install bundler`
* `bundle install`

Running Kitchen tests:

* `bundle exec kitchen converge` - will build the test environment.
* `bundle exec kitchen verify` - will run the tests.
* `bundle exec kitchen destroy` - will destroy the test environment.
* `bundle exec kitchen test` - will perform the above steps with a single command.

**Caveat** - Kitchen will not remove the box from vagrant after running `kitchen destroy`. For the moment need to clean up manually by running `vagrant box remove ubuntu-1804-ruby-dev-virtualbox-test`

## Uploading to Vagrant cloud

The project includes a script `vagrant_cloud_upload.sh` to upload the box to Vagrant cloud. It is basically a wrapper for the `vagrant cloud publish` [command](https://www.vagrantup.com/docs/cli/cloud.html#cloud-publish) so you can use it instead.

You need to set up Vagrant cloud access by setting the `VAGRANT_CLOUD_TOKEN` environment variable to your user token.

script usage: `./vagrant_cloud_upload.sh [box_version]`, box_version will default to `yy.mm.dd` if not set.

The variables `BOX`, `BOX_DESC` and `BOX_PATH` inside the script can be changed to further configure its behavior.

## Example

```bash
packer validate template.json # basic template validation.

packer build template.json   # build the box with packer.

bundle exec kitchen test # run tests

./vagrant_cloud_upload.sh 0.1 # upload to Vagrant cloud
```
