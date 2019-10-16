Micromanager -- for all your Open edx micro frontend (MFE) applications
=======================================================================

*Micromanager* is a tool for configuring, building and deploying [Open edX micro frontend applications](https://github.com/edx/edx-developer-docs/blob/master/docs/micro-frontends-in-open-edx.rst).

⚠️ THIS IS ALPHA SOFTWARE NOT YET READY FOR RELEASE ⚠️

Quickstart
----------

Build the docker images::

    make images

Then, you should generate a base environment file that will be used to configure all your applications::

    echo "LMS_BASE_URL: http://localhost" >> ./env.yml

Configure your application::

    make configure APP=/absolute/path/to/your/frontend-app-repo/

Install requirements for your application::

    make install APP=/absolute/path/to/your/frontend-app-repo/

Build your application::

    make configure APP=/absolute/path/to/your/frontend-app-repo/
  
Deploy your application::

    (This is not implemented, yet)
  
License
-------

This software is licensed under the terms of the AGPLv3.