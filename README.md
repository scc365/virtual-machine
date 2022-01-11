# Virtual Machine

The easiest way to get started with the advanced networking materials is though the use of this provided VM. It contains all the software you will need to complete the tutorial series and any coursework activities.

## Using the VM

If you are an active Lancaster University student and are enrolled in the SCC365 module, you can access the VM via the VMWare Horizon MyLab found [here](https://mylab.lancs.ac.uk).

Otherwise, this VM can easily be created using Virtual Box and Vagrant. Simply navigate to the root directory of this repository and run:

```
vagrant up
```

---

 - **Username**: `vagrant`
 - **Password**: `vagrant`
---

## Updating the VM

If you are currently participating in SCC365 @ Lancaster University, you can force the VM to update minor changes using the command "`updater`" as the `vagrant` user in the VM.

## Marking Sessions

In the marking sessions your code will be tested on a `mylab` instance of the Virtual Machine. Running it locally or using Docker should be suitable for development, but be sure to test your work on `mylab` before submission. 

> 🚫 Using "it worked on [a non-`mylab` platform]" won't be a valid excuse
