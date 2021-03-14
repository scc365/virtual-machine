# Virtual Machine

SCC365 requires the use of a VM. This VM provides all the software required to complete the coursework tasks and also creates a common environment for working and marking. By not using this VM image, you risk your code not running on the VM in the marking session.

## MyLab

The MyLab system will use a _similar_ VM to this, altered only by SCC Systems. However, you can make the assumption that code that works on the MyLab VM will also run on a locally instantiated version of the VM.

You can access MyLab [here](https://mylab.lancs.ac.uk).

---

## Vagrant [personal device]

> Only the MyLab VM uses comes with a GUI

You can run this VM on a personal device if you so choose using just the files from this repository. Doing so will require a large initial download to pull the base box and the required software. However, after that an internet connection will **not** be required at all times to use like with MyLab.

Required Software:
 - Vagrant
 - VirtualBox (6+)
 - Vagrant Manager (if you're on MacOS)
 - Xming/Xquartz

To create the VM, simply clone this repository, and from a terminal window in the same directory as the vagrantfile run:

```bash
$ vagrant up
```

The VM will then download/provision. To login via ssh, the username is `vagrant` and the password is `vagrant`.

```bash
vagrant ssh
```
or
```bash
ssh localhost -p 2222 -l vagrant -X
```

When using vagrant this way, you **require** a folder called `synced` in the same directory as the vagrantfile. However, you can modify the shared directories from within the vagrantfile to whatever suits you 👍

---

## Vagrant [lab machine]

Ummm, nope, not this year...🦠

---

### Contact

Any issues with the VM? [email me](mailto:w.fantom@lancs.ac.uk) 


> As a last resort for any issues with the MyLab/Horizon system? [email adrian from scc-systems](mailto:a.tucker@lancaster.ac.uk)
