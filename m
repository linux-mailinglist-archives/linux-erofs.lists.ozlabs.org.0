Return-Path: <linux-erofs+bounces-2705-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcrDvnBtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2705-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5A29106F
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgYX2D7Nz2yZ5;
	Mon, 16 Mar 2026 01:28:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584880;
	cv=none; b=aexpq1ltaB0q3aNh6XN6H0Iya83o+2JYwpqskG37s2rSXCt4eVq5mynbL9Swjrmr8v9V0axVBFFuW3aQa2DbJDa9eeqmBBvOKxAqhdXmzbRtTF+X8LzLCw0JFfgdzDjOQLW3CfYLknKN2f527DuG2HueQEihufXfoPXnPdK9WfYpZsEe1LZdl3c7Y42vKVaCEhiWWa/ZiFfU3Z/N9dd+6p6cS1fHfQP/siRwwnZbp/NrAWnKLWdRQ1hPF3lvnOnuq7gjCkx4MNVjlzk3z7KXVETgRppUji6cCON23mmqeQcRDjNijazEFmbFeva5GkO68Z2faw6LRHYObmh/e/1UUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584880; c=relaxed/relaxed;
	bh=q6vPe3nqs2lZNY/0t2/6HZfUgsxpTVmvW1jrx37i5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPBDsl5iklRyhYNBUFEANBdL4FvVzpY2LfUM5iAbTEqVjF6jcXdlkRyJW44cAgCLEaP96bUc1hb02eUxLnFLn3ppE9Rt/p2SFTNEPnbH+SgIS5tfdGArMb2UQo9t7CmGwSa8IkCDQWFy+hSkSvPdOz43mb1Z4B1NcQHT6PnPteLxX5k0z83LCxD0Ocf5IJ257kFzReyKO+4p2J7/8YtX+5anIyrFL8NZTxpDRaGuz7fDm3DO8k/o+0Ypstv+Hk/9bamghlhxFIY2My1Pj/TcdZ1IvoMMp3qlsaHHw+HQPbh6o7Auod6g1lNN1ektyUci+2g5IXrDSGruoREzPZhrNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.64; helo=out28-64.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-64.mail.aliyun.com (out28-64.mail.aliyun.com [115.124.28.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgYS5Kt1z2yYy
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:27:55 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00470827-0.000485787-0.994806;FP=9960638990053283063|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.gsmlGzT_1773584869;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gsmlGzT_1773584869 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 15 Mar 2026 22:27:50 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 4/4] erofs-utils: mount: integrate ublk backend
Date: Sun, 15 Mar 2026 22:27:45 +0800
Message-ID: <20260315142745.56845-5-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315142745.56845-1-hudson@cyzhu.com>
References: <20260315142745.56845-1-hudson@cyzhu.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2705-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.938];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,cyzhu.com:mid]
X-Rspamd-Queue-Id: 8EB5A29106F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Wire up the ublk userspace block device backend into mount.erofs,
providing an alternative to nbd for block device exposure.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 268 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 242 insertions(+), 26 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 93c8444..be650f5 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -18,6 +18,7 @@
 #include "../lib/liberofs_nbd.h"
 #include "../lib/liberofs_oci.h"
 #include "../lib/liberofs_gzran.h"
+#include "../lib/liberofs_ublk.h"
 
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
@@ -43,12 +44,14 @@ struct loop_info {
 
 #define EROFSMOUNT_RUNDIR		"/var/run/erofs"
 #define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_RUNDIR "/mountnbd_nbd%d"
+#define EROFSMOUNT_UBLK_REC_FMT	EROFSMOUNT_RUNDIR "/mountublk_ublkb%d"
 
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
 	EROFSFUSE,
 	EROFSNBD,
+	EROFSUBLK,
 };
 
 enum erofsmount_mode {
@@ -98,10 +101,10 @@ static void usage(int argc, char **argv)
 		" -d <0-9>              set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
 		" -o options            comma-separated list of mount options\n"
 		" -t type[.subtype]     filesystem type (and optional subtype)\n"
-		"                       subtypes: fuse, local, nbd\n"
+		"                       subtypes: fuse, local, nbd, ublk\n"
 		" -u                    unmount the filesystem\n"
 		"    --disconnect       abort an existing NBD device forcibly\n"
-		"    --reattach         reattach to an existing NBD device\n"
+		"    --reattach         reattach to an existing NBD or ublk device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (EXPERIMENTAL, with -o):\n"
@@ -327,6 +330,8 @@ static int erofsmount_parse_options(int argc, char **argv)
 					mountcfg.backend = EROFSLOCAL;
 				} else if (!strcmp(dot + 1, "nbd")) {
 					mountcfg.backend = EROFSNBD;
+				} else if (!strcmp(dot + 1, "ublk")) {
+					mountcfg.backend = EROFSUBLK;
 				} else {
 					erofs_err("invalid filesystem subtype `%s`", dot + 1);
 					return -EINVAL;
@@ -1136,11 +1141,30 @@ out_fork:
 	return num;
 }
 
+static int erofsmount_ublk_handler(void *ctx, struct erofs_ublk_request *req)
+{
+	struct erofs_vfile *vf = ctx;
+	ssize_t ret;
+
+	if (req->op != EROFS_UBLK_OP_READ)
+		return -EOPNOTSUPP;
+
+	ret = erofs_io_pread(vf, req->buf, req->nr_sectors << 9,
+			     req->start_sector << 9);
+	if (ret < 0)
+		return (int)ret;
+
+	req->result = ret;
+	return 0;
+}
+
 static int erofsmount_reattach(const char *target)
 {
-	char *identifier;
 	struct erofsmount_nbd_ctx ctx = {};
-	int nbdnum, err;
+	char *identifier = NULL;
+	char ublk_recp[64];
+	int ublk_dev_id = -1;
+	int nbdnum = -1, err;
 	struct stat st;
 	FILE *f;
 
@@ -1148,7 +1172,48 @@ static int erofsmount_reattach(const char *target)
 	if (err < 0)
 		return -errno;
 
-	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
+	if (!S_ISBLK(st.st_mode))
+		return -ENOTBLK;
+
+	if (sscanf(target, "/dev/ublkb%d", &ublk_dev_id) == 1) {
+		if (!erofs_ublk_is_recoverable(ublk_dev_id)) {
+			erofs_err("ublk device %d is not recoverable",
+				  ublk_dev_id);
+			return -ENODEV;
+		}
+		snprintf(ublk_recp, sizeof(ublk_recp),
+			 EROFSMOUNT_UBLK_REC_FMT, ublk_dev_id);
+		f = fopen(ublk_recp, "r");
+		if (!f) {
+			erofs_err("cannot open recovery file %s: %s",
+				  ublk_recp, strerror(errno));
+			return -errno;
+		}
+		err = erofsmount_open_recovery_source(f, &ctx.vd);
+		if (err)
+			return err;
+		if (fork() == 0) {
+			if (erofs_ublk_init() < 0)
+				exit(EXIT_FAILURE);
+			err = erofs_ublk_recover_dev(ublk_dev_id,
+						     erofsmount_ublk_handler,
+						     &ctx.vd);
+			if (err) {
+				erofs_err("erofs_ublk_recover_dev: %s",
+					  strerror(-err));
+				exit(EXIT_FAILURE);
+			}
+			erofs_ublk_start(ublk_dev_id, -1);
+			unlink(ublk_recp);
+			erofs_ublk_destroy(ublk_dev_id);
+			erofs_io_close(&ctx.vd);
+			exit(EXIT_SUCCESS);
+		}
+		erofs_io_close(&ctx.vd);
+		return 0;
+	}
+
+	if (major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
 	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
@@ -1165,7 +1230,8 @@ static int erofsmount_reattach(const char *target)
 	if (!identifier) {
 		char *recp;
 
-		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT, nbdnum) <= 0) {
+		if (asprintf(&recp, EROFSMOUNT_NBD_REC_FMT,
+			     nbdnum) <= 0) {
 			err = -ENOMEM;
 			goto err_out;
 		}
@@ -1342,6 +1408,131 @@ out_err:
 	return -errno;
 }
 
+static int erofsmount_ublk(struct erofsmount_source *source,
+			   const char *mountpoint, const char *fstype,
+			   int flags, const char *options)
+{
+	int pipefd[2];
+	char dev_path[64];
+	pid_t pid;
+	int dev_id, err;
+	char ready;
+
+	err = erofs_ublk_init();
+	if (err) {
+		erofs_err("ublk not supported");
+		return err;
+	}
+
+	if (pipe(pipefd) < 0)
+		return -errno;
+
+	pid = fork();
+	if (pid < 0) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return -errno;
+	}
+
+	if (pid == 0) {
+		struct erofs_vfile vf = {};
+		struct erofs_ublk_dev_info info = {};
+		char ublk_recp[64], *recp;
+		struct stat st;
+
+		close(pipefd[0]);
+
+		err = erofsmount_open_source(&vf, source);
+		if (err)
+			exit(EXIT_FAILURE);
+
+		info.nr_hw_queues = 1;
+		info.queue_depth = 64;
+		info.max_io_buf_bytes = 65536;
+		info.dev_id = -1;
+		info.blkbits = 12;
+		info.flags = EROFS_UBLK_F_USER_RECOVERY;
+
+		if (source->type == EROFSMOUNT_SOURCE_LOCAL &&
+		    fstat(vf.fd, &st) == 0)
+			info.dev_size = st.st_size;
+		else
+			info.dev_size = INT64_MAX;
+
+		dev_id = erofs_ublk_create_dev(&info,
+				erofsmount_ublk_handler, &vf);
+		if (dev_id < 0) {
+			erofs_err("erofs_ublk_create_dev failed: %s",
+				  strerror(-dev_id));
+			exit(EXIT_FAILURE);
+		}
+
+		snprintf(ublk_recp, sizeof(ublk_recp),
+			 EROFSMOUNT_UBLK_REC_FMT, dev_id);
+		recp = erofsmount_write_recovery_info(source);
+		if (IS_ERR(recp)) {
+			erofs_err("write_recovery_info: %s",
+				  strerror(-(int)PTR_ERR(recp)));
+		} else {
+			if (rename(recp, ublk_recp))
+				erofs_err("rename recovery: %s",
+					  strerror(errno));
+			free(recp);
+		}
+
+		if (write(pipefd[1], &dev_id,
+			  sizeof(dev_id)) != sizeof(dev_id))
+			exit(EXIT_FAILURE);
+
+		err = erofs_ublk_start(dev_id, pipefd[1]);
+		if (err)
+			erofs_err("erofs_ublk_start: %s",
+				  strerror(-err));
+
+		unlink(ublk_recp);
+		erofs_ublk_destroy(dev_id);
+		if (vf.fd > 0)
+			close(vf.fd);
+		exit(EXIT_SUCCESS);
+	}
+
+	close(pipefd[1]);
+	if (read(pipefd[0], &dev_id, sizeof(dev_id)) !=
+	    sizeof(dev_id)) {
+		waitpid(pid, NULL, 0);
+		close(pipefd[0]);
+		return -EIO;
+	}
+
+	snprintf(dev_path, sizeof(dev_path),
+		 "/dev/ublkb%d", dev_id);
+
+	if (read(pipefd[0], &ready, 1) != 1) {
+		waitpid(pid, NULL, 0);
+		close(pipefd[0]);
+		return -EIO;
+	}
+	close(pipefd[0]);
+
+	err = mount(dev_path, mountpoint, fstype, flags, options);
+	if (err < 0) {
+		err = -errno;
+		kill(pid, SIGTERM);
+		waitpid(pid, NULL, 0);
+		return err;
+	}
+	return 0;
+}
+
+static int ublk_dev_id_from_path(const char *path)
+{
+	int dev_id;
+
+	if (sscanf(path, "/dev/ublkb%d", &dev_id) == 1)
+		return dev_id;
+	return -1;
+}
+
 int erofsmount_umount(char *target)
 {
 	char *device = NULL, *mountpoint = NULL;
@@ -1379,7 +1570,7 @@ int erofsmount_umount(char *target)
 
 	for (s = NULL; (getline(&s, &n, mounts)) > 0;) {
 		bool hit = false;
-		char *f1, *f2, *end;
+		char *f1, *f2 = NULL, *end;
 
 		f1 = s;
 		end = strchr(f1, ' ');
@@ -1396,31 +1587,48 @@ int erofsmount_umount(char *target)
 				hit = true;
 		}
 		if (hit) {
-			if (isblk) {
-				err = -EBUSY;
-				free(s);
-				fclose(mounts);
-				goto err_out;
-			}
 			free(device);
 			device = strdup(f1);
-			if (!mountpoint)
-				mountpoint = strdup(f2);
+			free(mountpoint);
+			mountpoint = f2 ? strdup(f2) : NULL;
 		}
 	}
 	free(s);
 	fclose(mounts);
+
+	if (isblk && !device) {
+		if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
+			nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
+			err = erofs_nbd_nl_disconnect(nbdnum);
+			if (err != -EOPNOTSUPP)
+				goto err_out;
+		}
+		err = ublk_dev_id_from_path(target);
+		if (err >= 0) {
+			err = erofs_ublk_del_dev_by_id(err);
+			goto err_out;
+		}
+		err = -ENOENT;
+		goto err_out;
+	}
+
 	if (!isblk && !device) {
 		err = -ENOENT;
 		goto err_out;
 	}
 
-	if (isblk && !mountpoint &&
-	    S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
-		nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
-		err = erofs_nbd_nl_disconnect(nbdnum);
-		if (err != -EOPNOTSUPP)
-			return err;
+	err = ublk_dev_id_from_path(device);
+	if (err >= 0) {
+		if (mountpoint) {
+			int ret = umount(mountpoint);
+
+			if (ret) {
+				err = -errno;
+				goto err_out;
+			}
+		}
+		err = erofs_ublk_del_dev_by_id(err);
+		goto err_out;
 	}
 
 	/* Avoid TOCTOU issue with NBD_CFLAG_DISCONNECT_ON_CLOSE */
@@ -1438,15 +1646,16 @@ int erofsmount_umount(char *target)
 		}
 	}
 	err = fstat(fd, &st);
-	if (err < 0)
+	if (err < 0) {
 		err = -errno;
-	else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
+	} else if (S_ISBLK(st.st_mode) && major(st.st_rdev) == EROFS_NBD_MAJOR) {
 		nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
 		err = erofs_nbd_nl_disconnect(nbdnum);
 		if (err == -EOPNOTSUPP)
 			err = erofs_nbd_disconnect(fd);
 	}
 	close(fd);
+
 err_out:
 	free(device);
 	free(mountpoint);
@@ -1523,13 +1732,20 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
-	if (mountcfg.backend == EROFSNBD) {
+	if (mountcfg.backend == EROFSNBD || mountcfg.backend == EROFSUBLK) {
 		if (mountsrc.type == EROFSMOUNT_SOURCE_OCI)
 			mountsrc.ocicfg.image_ref = mountcfg.device;
 		else
 			mountsrc.device_path = mountcfg.device;
-		err = erofsmount_nbd(&mountsrc, mountcfg.target,
-				     mountcfg.fstype, mountcfg.flags, mountcfg.options);
+
+		if (mountcfg.backend == EROFSNBD)
+			err = erofsmount_nbd(&mountsrc, mountcfg.target,
+					     mountcfg.fstype, mountcfg.flags,
+					     mountcfg.options);
+		else
+			err = erofsmount_ublk(&mountsrc, mountcfg.target,
+					      mountcfg.fstype, mountcfg.flags,
+					      mountcfg.options);
 		goto exit;
 	}
 
-- 
2.47.1


