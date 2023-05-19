Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D0709E5C
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 19:40:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNDd44kp1z3fc1
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 03:40:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMNisRAW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvtzhDA5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMNisRAW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvtzhDA5;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNDd135Pdz3fFf
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 03:40:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684518002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elfgW7tKNb29ihjCch2YIk6r7ELP9CtfYC92ffU/TJY=;
	b=fMNisRAWwYRQ9Hqc9gG/+/ZbGMSc/wKGvsmA05aoIjMVpsrW3PXC2KQ5JUDt4AZMO9qUY3
	voIlX1dOMxmirMmgEdJiyS3VLfnLSzAxvfMBF57jsFCp5aGwBOK9vOSrMU7wOV5A190MES
	Vj3sOMF4KC5gwLcEVJTt5BFDgYTGKmA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684518003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elfgW7tKNb29ihjCch2YIk6r7ELP9CtfYC92ffU/TJY=;
	b=UvtzhDA5XmFZAgZ3eM8n9bBzxqBEt0a7+XtmBLEFCdKj4u+TN6OQN+RPxtRojEkgIdKOgO
	Du/2q6lMtsop/btG1pz7EJCzFNEkqPmWpj9AXLrSWC1s27M+BUR7sr0s/PF87RBPRn5AiB
	pay14OwLBt1oW99rNITx8+p4ussmzSg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Cj9ZeTx9MMyLbVOhFsRhJw-1; Fri, 19 May 2023 13:40:01 -0400
X-MC-Unique: Cj9ZeTx9MMyLbVOhFsRhJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CC50811E78;
	Fri, 19 May 2023 17:40:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 70C792166B25;
	Fri, 19 May 2023 17:40:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: linux-cachefs@redhat.com
Subject: [PATCH] cachefilesd: Allow the daemon to run as a non-root user
MIME-Version: 1.0
Date: Fri, 19 May 2023 18:39:59 +0100
Message-ID: <1853961.1684517999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1853960.1684517999.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: dhowells@redhat.com, linux-erofs@lists.ozlabs.org, Jeff Layton <jlayton@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

   =20
Allow the daemon to run as a non-root user after opening the control device
- which will also make the kernel driver run as the same non-root user
since it borrows the daemons credentials.

This requires a fix to the cachefiles kernel driver to make it set the mode
on files in creates to 0600.

This also requires the SELinux policy to be changed so that cachefilesd can
access /etc/passwd, otherwise only numeric uids and gids can be set.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 cachefilesd.c      |   59 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++--
 cachefilesd.conf.5 |    7 ++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/cachefilesd.c b/cachefilesd.c
index 6c435f6..81bb87d 100644
--- a/cachefilesd.c
+++ b/cachefilesd.c
@@ -48,6 +48,7 @@
 #include <poll.h>
 #include <limits.h>
 #include <grp.h>
+#include <pwd.h>
 #include <sys/inotify.h>
 #include <sys/time.h>
 #include <sys/vfs.h>
@@ -121,6 +122,8 @@ static unsigned long long brun, bcull, bstop, frun, fcu=
ll, fstop;
 static unsigned long long b_resume_threshold =3D ULLONG_MAX;
 static unsigned long long f_resume_threshold =3D 5;
=20
+static uid_t daemon_uid;
+static gid_t daemon_gid;
 static const gid_t group_list[0];
=20
 #define cachefd 3
@@ -489,6 +492,47 @@ int main(int argc, char *argv[])
 =09=09=09continue;
 =09=09}
=20
+=09=09/* Note UID to run as. */
+=09=09if (memcmp(cp, "uid", 3) =3D=3D 0 && isspace(cp[3])) {
+=09=09=09struct passwd *pwd;
+=09=09=09char *end;
+
+=09=09=09for (cp +=3D 3; isspace(*cp); cp++) {;}
+=09=09=09if (!*cp)
+=09=09=09=09cfgerror("Error parsing username/uid");
+
+=09=09=09daemon_uid =3D strtoul(cp, &end, 10);
+=09=09=09if (*end) {
+=09=09=09=09pwd =3D getpwnam(cp);
+=09=09=09=09if (!pwd)
+=09=09=09=09=09oserror("Couldn't look up username/uid '%s'", cp);
+=09=09=09=09daemon_uid =3D pwd->pw_uid;
+=09=09=09=09daemon_gid =3D pwd->pw_gid;
+=09=09=09} else {
+=09=09=09=09daemon_gid =3D -1;
+=09=09=09}
+=09=09=09continue;
+=09=09}
+
+=09=09/* Note GID to run as. */
+=09=09if (memcmp(cp, "gid", 3) =3D=3D 0 && isspace(cp[3])) {
+=09=09=09struct group *grp;
+=09=09=09char *end;
+
+=09=09=09for (cp +=3D 3; isspace(*cp); cp++) {;}
+=09=09=09if (!*cp)
+=09=09=09=09cfgerror("Error parsing group name/gid");
+
+=09=09=09daemon_gid =3D strtoul(cp, &end, 10);
+=09=09=09if (*end) {
+=09=09=09=09grp =3D getgrnam(cp);
+=09=09=09=09if (!grp)
+=09=09=09=09=09oserror("Couldn't look up group name/gid '%s'", cp);
+=09=09=09=09daemon_gid =3D grp->gr_gid;
+=09=09=09}
+=09=09=09continue;
+=09=09}
+
 =09=09/* note the dir command */
 =09=09if (memcmp(cp, "dir", 3) =3D=3D 0 && isspace(cp[3])) {
 =09=09=09char *sp;
@@ -545,13 +589,24 @@ int main(int argc, char *argv[])
 =09if (nullfd !=3D 1)
 =09=09dup2(nullfd, 1);
=20
-=09for (loop =3D 4; loop < open_max; loop++)
-=09=09close(loop);
+=09if (close_range(4, open_max, 0) =3D=3D -1) {
+=09=09for (loop =3D 4; loop < open_max; loop++)
+=09=09=09close(loop);
+=09}
=20
 =09/* set up a connection to syslog whilst we still can (the bind command
 =09 * will give us our own namespace with no /dev/log */
 =09openlog("cachefilesd", LOG_PID, LOG_DAEMON);
 =09xopenedlog =3D true;
+
+=09if (daemon_uid || daemon_gid) {
+=09=09info("Setting credentials");
+=09=09if (setresgid(daemon_gid, daemon_gid, daemon_gid) < 0)
+=09=09=09oserror("Unable to set GID to %d", daemon_gid);
+=09=09if (setresuid(daemon_uid, daemon_uid, daemon_uid) < 0)
+=09=09=09oserror("Unable to set UID to %d", daemon_uid);
+=09}
+
 =09info("About to bind cache");
=20
 =09/* now issue the bind command */
diff --git a/cachefilesd.conf.5 b/cachefilesd.conf.5
index b108bdc..534b8f0 100644
--- a/cachefilesd.conf.5
+++ b/cachefilesd.conf.5
@@ -35,6 +35,13 @@ access the cache.  The default is to use cachefilesd's s=
ecurity context.  Files
 will be created in the cache with the label of directory specified to the =
'dir'
 command.
 .TP
+.B uid <id>
+.TP
+.B gid <id>
+Set the UID or GID that the daemon runs as to the specified ID.  The ID ca=
n be
+given as a number or as a name.  The base cache directory and all the
+directories and files under it must be owned by these IDs.
+.TP
 .B brun <N>%
 .TP
 .B bcull <N>%

