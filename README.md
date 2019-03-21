

## Set up CircleCi 

### Requirements
* Unix (Mac & Ubuntu tested)
* A CircleCI account
* Access to a [LAMP server](https://howtoubuntu.org/how-to-install-lamp-on-ubuntu) (MySQL and PHP are not mandatory for this setup)
* Access to a terminal window
* Culturize app installed on a client to push URI's to this repo

### Setup
1. First fork and then clone the [Culturize-Back-end-CircleCi](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI) locally: `git clone https://github.com/yourusername/CultURIze-Back-end-CircleCI`.  

![fork](https://raw.githubusercontent.com/PACKED-vzw/CultURIze-Back-end-CircleCI/master/doc/images/forklogo.png)

2. Go to https://circleci.com/ select _Log in with GitHub_.

3. Add projects to your CircleCI account (in the left pane) and select the [Culturize-Back-end-CircleCi](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI) repository. repository. Select Set Up Project and select _Start Building_

4. Choose _Start Building_. It will fail. Do not worry about that.

5. In the _Workflows_ screen, click the little cogwheel next to the name of the repository we just added to the workflows.

![cogwheel](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/cogwheelcircle.png)

6. We now need to create some [SSH keys](https://en.wikipedia.org/wiki/Public-key_cryptography) so  CircleCI can deploy your .htaccess-files on your webserver. Open a terminal window and copy paste the following command: `ssh-keygen -m pem -f changethisname` (change `changethisname` to a name of your choice). Do not enter a passpharse and save the files in your `.ssh` directory. On Mac and Linux this is `~/.ssh/`, on windows this should be `C:\Users\yourusername\.ssh\`. This command will create an ssh key-pair: a public and a private key. Your private key is called `changethisname`, The public key `changethisname.pub`. We will use the private key in CircleCI and the public key on the webserver. [More information about SSH Keys pairs.](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2)

7. Back to CircleCI. Open the _SSH-Permissions_ tab in the left pane and click _Add SSH-key_.

![ssh-permissions](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/SSH-Permissions.png)

Paste the content of the private key we just created (`changethisname`) in the _Private Key_ field.

![sshkey](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/addsshkey.png)

A simple way to do this, is to open the `changethisname` file with a text editor and copy paste the complete content of the file in the _Private Key_ field. Enter the host name of the webserver in the _Hostname_ field. Finally, click _Add SSH-Key_. 

8. Scroll up in the left menu pane and select _Environment Variables_ under _Build Settings_.

![envirinment variables](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/environmentvariables.png)

We are going to add two variables. Click _Add Variable_ and enter `SSH_HOST` under _name_. Under _value_, enter the IP-address (e.g. `172.16.254.1`) or host (e.g. `www.example.org`) of the web server.

![Ssh-host](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/SSH_host.png)

After selecting _Add Variable_ again, the variable should be added. Next, enter the second variable with name `SSH_USER` and the name of the user that has access to the web server.

![SSH_USER](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/environmentvariablesSSH_USER.png)

After selecting _Add variable_, both items should be added to the list. 

9. Now clone the repository in the home folder of your webserver (`cd ~ && git clone https://github.com/yourusername/CultURIze-Back-end-CircleCI`), and copy or move the `deploy.sh` script to your home folder on the server (`cd CultURIze-Back-end-CircleCI && mv .circleci/deploy.sh ~`).

10. Add the content of the `changethisname.pub` key file to the `authorized_keys` file on the web server. The simple way to do this is to open the `changethisname.pub` key with a text editor and copy paste everything in the `authorized_keys` file. On the server, use `vim` or `nano` to open the `authorized_keys` file. If you already have a key there, paste the new key after a new line (enter). 

11. You can now push the `.htaccess` files through the Culturize app to the forked Culturize-CircleCi-Backend repository on your account. The `.htaccess`-files will automatically be moved to the /var/www/ folder on the web server and so your PID's are live immediately. 
Keep in mind that you have to be the owner of the repository you are pushing to.


### Troubleshooting 
* If you run into problems where your URI's are not being served. It may be a permission issue, check this source and scroll down to [To set file permissions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html#To_Set_File_Permissions) for more information.
* Getting feedback about the CircleCi build status: even though CircleCi is not being used to test build software, it is still possible to use the CircleCi dashboard to get feedback when something does not work in the workflow, specifically copying files to the webserver. 
    * Click on the latest job status. 
    * At the bottom of the job detail page you will find an output of the processes that failed.

![circleciobstatus](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/circlecijob.png)

![circleciobstatus](https://github.com/PACKED-vzw/CultURIze-Back-end-CircleCI/blob/master/doc/images/circlecijobdetails.png)
