# mojo_run

`mojo_run` allows you to run a Mojo shell either on the host, or on an attached
Android device.

```sh
mojo_run APP_URL  # Run on the host.
mojo_run APP_URL --android  # Run on Android device.
mojo_run "APP_URL APP_ARGUMENTS"  # Run an app with startup arguments
```

Unless running within a Mojo checkout, we need to indicate the path to the shell
binary:

```sh
mojo_run --shell-path path/to/shell/binary APP_URL
```

Some applications implement ViewProvider and are run embedded in a view. To run
these, you can pass the app url using the `--embed` flag:

```sh
mojo_run --embed APP_URL [--android]
```

## Running multiple instances simultaneously

`mojo_run` sets up development servers on fixed ports to facilitate caching
between runs and allow the script to work remotely using `adb_remote_setup`.
This would normally prevent two or more instances of `mojo_run` from running
simulatenously as the development servers cannot be spawned twice on the same
ports.

In order to run the same set of binaries simultaneously one can use the
`--reuse-servers` switch for second and further instances. This will make the
second and further instances assume that development servers are already
spawned.

On **Android** one needs to indicate the id of the device to be targeted in each
run. For example, we could run the following in one shell:

```sh
mojo_run APP_URL --android --target-device DEVICE_ID
```

and the following in another:

```sh
mojo_run APP_URL --android --target-device ANOTHER_DEVICE_ID --reuse-servers
```

Device id can be obtained from `adb devices`.

On **Linux** one needs to use a different $HOME directory for each run, to avoid
collision of the cache storage. For example, we could run the following in one
shell:

```sh
mojo_run APP_URL
```

and the following in another:

```sh
mkdir ~/another_home
HOME=~/another_home mojo_run APP_URL --reuse-servers
```

## Setting default mojo origin

When run outside of the `domokit/mojo` repository, `mojo_run` needs `--origin`
parameter to indicate where binaries of the core mojo services come from. If a
`MOJO_VERSION` file is present among ancestors of `mojo_run` and `--origin`
parameter is not set, origin will point to Google Storage location storing
binaries of core mojo services built at the git revision indicated in
`MOJO_VERSION`.
