Return-Path: <linux-erofs+bounces-3444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGWfKaPnC2pXQgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3444-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 06:31:31 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE25773AF
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 06:31:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKMFC3nXxz2yDs;
	Tue, 19 May 2026 14:31:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779165087;
	cv=none; b=cIk39YEYg0pvAFEev9zVhSXN+AAXlfvY76rIHc/rWKYRWThGZ2KK2nKPGUurwoDpQ/ZKyheuzYjEMEKve8ImQUo9mHowLiJAKtHGUXZB2oW9zePX/g/4Q6ahBux7mQ/1QDMOs3YVMq9vDN1sSPaa+tKOJDos4qg1JI3tdi/v/rrvOFc7IQqMrEf+37GDWa+uhXMSjVWMuUmTWj2UOhoJ8JC0e1aKaHpeTo7Q01qAv6Hd0WvNXUbSVx058azCTs9g0iKUW9wPAYo3ozeiJJt3VhGAkYGewdk5MERCki5cGscymdlDd2QalvWw3wNUUgrOOuqlOlC1JhXEWzwgRyPqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779165087; c=relaxed/relaxed;
	bh=C2fzVrjorUAen66bVJJju35rOz6QW7C/i3ZstZppHFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBBWYcUUajel+fEpXyYDcAiCdA8/w+vepTbTwlP6myYQKpUDynSlWwbSNoxETWTkRSKYGmIbj5yyoWKTWfsPd15rlmwKl7rh7+urNJxwL+SExlbcMsZOtpFSPusCsjxQ9Qk3HDNT+ltv8sBUvX7kCSQMoU/5TKt269rTkd8PNbLlJOqDkITJiH4qad7d/jS8o3gkJyxLLPqLCpCwLe03dmng+yY99cnuYuW5Z0QS8CMZVJWyHy3iPBPK4FNRIHjKZ1J/996EDMTtEBNMI3t8JL3Mgmmiz3VSH3BkER81tUJH4YbvYQiWQ7vU9tPIxMUqQfU9EICPagN7SD7P4GxO4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RcDPJ0QA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RcDPJ0QA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKMF91nTpz2yD6
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 14:31:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779165080; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C2fzVrjorUAen66bVJJju35rOz6QW7C/i3ZstZppHFs=;
	b=RcDPJ0QAgpy5wB/gRSdCK9BsuCP1mvKzA4GDUM3INL8hyAmptO3daWX7Cr5rGta0hRcVOsU0HOwIn2dQBhqBsh5oYgLHRqFiEjLIbZr/PPNZN6oWbTPnDe31fW9nru/UP5pBINLf9lODTqTv5B3O0iyzrVmk7uNIbHWnh42Ato0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X3EIuYu_1779165078;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X3EIuYu_1779165078 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 12:31:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH rebased 3/3] erofs-utils: mount: integrate ublk backend
Date: Tue, 19 May 2026 12:31:11 +0800
Message-ID: <20260519043111.2007421-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260519043111.2007421-1-hsiangkao@linux.alibaba.com>
References: <20260315142745.56845-1-hudson@cyzhu.com>
 <20260519043111.2007421-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3444-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: ADCE25773AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chengyu Zhu <hudsonzhu@tencent.com>

Wire up the ublk userspace block device backend into mount.erofs,
providing an alternative to nbd for block device exposure.

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 244 insertions(+), 22 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 90fbdc68f88d..7713ba41058c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -23,6 +23,7 @@
 #include "../lib/liberofs_fanotify.h"
 #endif
 #include "../lib/liberofs_s3.h"
+#include "../lib/liberofs_ublk.h"
 
 #ifdef HAVE_LINUX_LOOP_H
 #include <linux/loop.h>
@@ -51,6 +52,7 @@ struct loop_info {
 
 #define EROFSMOUNT_RUNDIR		"/var/run/erofs"
 #define EROFSMOUNT_NBD_REC_FMT		EROFSMOUNT_RUNDIR "/mountnbd_nbd%d"
+#define EROFSMOUNT_UBLK_REC_FMT	EROFSMOUNT_RUNDIR "/mountublk_ublkb%d"
 
 #ifdef EROFS_FANOTIFY_ENABLED
 #define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
@@ -58,12 +60,19 @@ struct loop_info {
 #define EROFSMOUNT_FANOTIFY_HELP	""
 #endif
 
+#ifdef HAVE_LIBURING
+#define EROFSMOUNT_UBLK_HELP		", ublk"
+#else
+#define EROFSMOUNT_UBLK_HELP		""
+#endif
+
 enum erofs_backend_drv {
 	EROFSAUTO,
 	EROFSLOCAL,
 	EROFSFUSE,
 	EROFSNBD,
 	EROFSFANOTIFY,
+	EROFSUBLK,
 };
 
 enum erofsmount_mode {
@@ -117,10 +126,10 @@ static void usage(int argc, char **argv)
 		" -d <0-9>                   set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
 		" -o options                 comma-separated list of mount options\n"
 		" -t type[.subtype]          filesystem type (and optional subtype)\n"
-		"                            subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP "\n"
+		"                            subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP EROFSMOUNT_UBLK_HELP "\n"
 		" -u                         unmount the filesystem\n"
 		"    --disconnect            abort an existing NBD device forcibly\n"
-		"    --reattach              reattach to an existing NBD device\n"
+		"    --reattach              reattach to an existing NBD or ublk device\n"
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (EXPERIMENTAL, with -o):\n"
@@ -465,6 +474,12 @@ static int erofsmount_parse_options(int argc, char **argv)
 #else
 					erofs_err("fanotify backend support is not built-in");
 					return -EINVAL;
+#endif
+				} else if (!strcmp(dot + 1, "ublk")) {
+#ifdef HAVE_LIBURING
+					mountcfg.backend = EROFSUBLK;
+#else
+					erofs_err("ublk backend support is not built-in");
 #endif
 				} else {
 					erofs_err("invalid filesystem subtype `%s`", dot + 1);
@@ -1399,11 +1414,29 @@ out_fork:
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
 	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+	int ublk_dev_id, nbdnum, err;
+	char ublk_recp[64];
 	char *identifier;
-	int nbdnum, err;
 	struct stat st;
 	FILE *f;
 
@@ -1411,7 +1444,48 @@ static int erofsmount_reattach(const char *target)
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
+		err = erofsmount_recovery_open_source(&ctx, f);
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
+			erofs_io_close(ctx.vd);
+			exit(EXIT_SUCCESS);
+		}
+		erofs_io_close(ctx.vd);
+		return 0;
+	}
+
+	if (major(st.st_rdev) != EROFS_NBD_MAJOR)
 		return -ENOTBLK;
 
 	nbdnum = erofs_nbd_get_index_from_minor(minor(st.st_rdev));
@@ -2034,6 +2108,130 @@ out:
 }
 #endif
 
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
+		struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
+		struct erofs_ublk_dev_info info = {};
+		char ublk_recp[64], *recp;
+		struct stat st;
+
+		close(pipefd[0]);
+
+		err = erofsmount_open_source(&ctx, source);
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
+		    erofs_io_fstat(ctx.vd, &st) == 0)
+			info.dev_size = st.st_size;
+		else
+			info.dev_size = INT64_MAX;
+
+		dev_id = erofs_ublk_create_dev(&info,
+				erofsmount_ublk_handler, ctx.vd);
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
+		erofs_io_close(ctx.vd);
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
@@ -2071,7 +2269,7 @@ int erofsmount_umount(char *target)
 
 	for (s = NULL; (getline(&s, &n, mounts)) > 0;) {
 		bool hit = false;
-		char *f1, *f2, *end;
+		char *f1, *f2 = NULL, *end;
 
 		f1 = s;
 		end = strchr(f1, ' ');
@@ -2088,31 +2286,48 @@ int erofsmount_umount(char *target)
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
@@ -2224,13 +2439,20 @@ int main(int argc, char *argv[])
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
2.43.5


