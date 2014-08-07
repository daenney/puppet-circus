## 2014-08-07 0.1.5
### Features
* Log daemon activity to /var/log/circus/circusd.log.

## 2014-06-19 0.1.4
### Bugfixes
* Only symlink circusd when installed from pip. Without adding the symlink
  the init-scripts won't be able to start the daemon.

## 2014-06-19 0.1.3
### Bugfixes
* Forgot to add `modules/` to the source attribute of file resources.

## 2014-06-19 0.1.2
### Bugfixes
* Fix a dependency cycle. We were notifying `Circus::Install` from the package resource whereas we should be notifying `Circus::Configure`.

## 2014-06-18 0.1.1
### Bugfixes
* Fix an issue with `metadata.json` preventing uploads to the forge.

## 2014-06-18 0.1.0
Initial realese.
