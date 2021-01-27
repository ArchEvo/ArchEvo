#!/bin/bash

if ! grep -q NoDisplay=true /usr/share/applications/qv4l2.desktop; then 
  echo NoDisplay=true >> /usr/share/applications/qv4l2.desktop
fi

if ! grep -q NoDisplay=true /usr/share/applications/qvidcap.desktop; then 
  echo NoDisplay=true >> /usr/share/applications/qvidcap.desktop 
fi

if ! grep -q NoDisplay=true /usr/share/applications/bssh.desktop; then 
  echo NoDisplay=true >> /usr/share/applications/bssh.desktop
fi

if ! grep -q NoDisplay=true /usr/share/applications/bvnc.desktop; then 
  echo NoDisplay=true >> /usr/share/applications/bvnc.desktop
fi

if ! grep -q NoDisplay=true /usr/share/applications/avahi-discover.desktop; then 
  echo NoDisplay=true >> /usr/share/applications/avahi-discover.desktop
fi
