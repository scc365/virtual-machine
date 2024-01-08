# Virtual Machine

This repository contains the files needed to build a virtual machine suitable for the SCC365 tutorial and coursework tasks.

---

## Lancaster University Students 🎓

As a Lancaster University student, you should use the pre-built VM hosted on the MyLab system that can be found [here](https://mylab.lancs.ac.uk). You may use it in the web browser or the VMWare Horizon client application, but expect a better user experience with the client application. You should use your university credentials to login to the VM and you will have access to your shared storage.

This pre-built VM contains all the software required to complete the tasks and some user-friendly applications such as VS Code, so you can use the VM as both a build and testing environment (as is recommended).

> ⚠️ All assessed work for SCC365 will be carried out on MyLab. If for any reason you do not complete any assessed work on the MyLab platform, test any work on MyLab prior to submission as you can not be marked on any non-MyLab VM.

---

## Software

The VM contains software that is typically incompatible with non-Linux systems, and is somewhat inconvenient to install even on Linux systems. This is why the VM is expected to be used for all SCC365 activities, including the tutorials.

Some of the software components installed in the VM are as follows:
 - Mininet
 - Wireshark
 - Open vSwitch

## Making a VM

If you are not a Lancaster University student and do not have access to the
MyLab system, you can create your own Linux-based VM to complete the public
tutorials easily. Simply run the script found in this repository in a minimal
Ubuntu VM that you are not using for anything else. The command to execute the
script should be like so:

```bash
chmod +x ./provision.sh
./provision.sh -r "${HOME}/.bashrc"
```

---

## Docker 🐳

For the most part, Docker can be used to run the main software. You can find relevant base images in the following repositories:

- https://github.com/scc365/mininet-base-image
- https://github.com/scc365/ryu-base-image

> ⚠️ As Mininet can require access to the host features, Mininet containers should be run as privileged. Various issues may be encountered when using Docker for Windows (including WSL 1 & 2).
