FROM smartnimbus/was8.5.5.9-profile
ARG warfile
COPY target/hello-world-war-1.0.0.war /tmp/
RUN wsadmin.sh -lang jython -conntype NONE -c "AdminApp.install('/tmp/hello-world-war-1.0.0.war', '[ -appname hello-world-war-1.0.0 -contextroot /hello-world-war-1.0.0 -MapWebModToVH [[ hello-world-war-1.0.0.war hello-world-war-1.0.0.war,WEB-INF/web.xml default_host]]]')"