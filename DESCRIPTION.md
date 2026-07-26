
---

### Looking for the CLI version? Check out the [green-tunnel-cli](https://community.chocolatey.org/packages/green-tunnel-cli) package

---

## Green Tunnel

Green Tunnel is an anti-censorship utility, implemented as a local proxy server, that is intended to subvert malicious Deep Packet Inspection (DPI) systems. These may be configured by some Internet Service Providers (ISPs) to block access to certain websites.

![Green Tunnel Demo](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-green-tunnel-gui@37abd9c770cbdc846a80294e240268709073d646/demo.gif)

## Package Notes

The installer executed by this package was built using Nullsoft Scriptable Install System (NSIS). For advanced setup scenarios, refer to [NSIS's command-line interface documentation](https://nsis.sourceforge.io/Docs/Chapter3.html#installerusage). Any desired arguments can be appended to (or optionally overriding with the `--override-arguments` switch) the package's default install arguments with the `--install-arguments` option.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name="'useRememberedArgumentsForUpgrades'"
```
