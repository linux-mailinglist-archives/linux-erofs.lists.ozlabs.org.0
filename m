Return-Path: <linux-erofs+bounces-948-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B323FB4087F
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Sep 2025 17:06:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGTbN4S6xz30YZ;
	Wed,  3 Sep 2025 01:06:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756825584;
	cv=none; b=azMVK0RhOw5AJLzJVQsZAtKCpIZq5yzRiOQHr+JpRjuRZ2PU8jxsVfD2k8Vzq+QFW8f3vxTmhrGJapUPLOyrJD8qH2xIN09AqJSjpRqVafV6AyuakSpO58OGDVvm9Eq91q7rDe8HuDbEhx/rb4zDpialj4QbIS0ntS9TSKO8z9y1pVoDfc7FWivF+QtCfJKwUfuX7ljmZ52rMxbe0CO9YlExYWOa3SJWZg69Qd2/o2USN0zN9wF27mBOUWKvHlcbKpiDkiJ2oFuWxopbZX0pTZLL1prxcVIJiENWwMmTkqw4esMWn0O4MtcYfe1Cl3EufOq8m4kRC35ysaExfOkN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756825584; c=relaxed/relaxed;
	bh=MHKKmVzIkFZ4O6OP9LcS1EXhfFrozeyfK/gOWlZnMBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lek5QkQXPf1sa3UeFy1IySpij7hfQCZFNvyArBJTLUKcR36MAsoecObUhJ2tt5wawVUFHEWKA++/cbIcdzvMFxcDP9QsUIztbWOZiKev9QGVKbKqmUsnuBE/uSfmKwfxj8Dv1yHff+oREnGEK5gvAvBpm8iTD3IQzzPhHjY8OkyAmTJpnteopvr7P/Gj4lwzGDS2ohTFWxEwyjQ61P3Mri9VZItKKloFlWm2BDqamCTG2I856Cr1VHyaaMJHDXYglVcNJAzgW92dnjACfEou1Ua6NH9EujCfZqcFZaE82fMpwXFmOHTNuXlE/AvJw1gOVBfCTDLRuJkVhcmPK7c7gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ti4HwmBU; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ti4HwmBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGTbL6Qmhz30gC
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 01:06:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756825579; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MHKKmVzIkFZ4O6OP9LcS1EXhfFrozeyfK/gOWlZnMBM=;
	b=Ti4HwmBUveLPQBmi2QYoPLNDybPGh7+kTe2SZtsMGYXlCDn5sLI3uSRQURn4ViIeynANuMBqCLQcD+9vFlWNTUEIAcTkwHum+AJb707oBhIVOdRVzLXB1ggbiPjZQ3AL3Pns+IRmfr7vQTNaiEJEPDDMSDQgGLVDhHCc/eAkXbE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wn88Zim_1756825577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 23:06:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/4] erofs-utils: mount: recover from detached NBD devices
Date: Tue,  2 Sep 2025 23:06:10 +0800
Message-ID: <20250902150610.887543-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250902150610.887543-1-hsiangkao@linux.alibaba.com>
References: <20250902150610.887543-1-hsiangkao@linux.alibaba.com>
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

Add support for reconnecting to devices using recovery files, e.g.
 $ sudo killall -9 mount.erofs
 $ sudo mount.erofs --reattach /dev/nbdX

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/liberofs_nbd.h |   1 +
 mount/main.c       | 140 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 126 insertions(+), 15 deletions(-)

diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 03886de..cc80899 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -37,6 +37,7 @@ struct erofs_nbd_request {
 long erofs_nbd_in_service(int nbdnum);
 int erofs_nbd_devscan(void);
 int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
+char *erofs_nbd_get_identifier(int nbdnum);
 int erofs_nbd_do_it(int nbdfd);
 int erofs_nbd_get_request(int skfd, struct erofs_nbd_request *rq);
 int erofs_nbd_send_reply_header(int skfd, __le64 cookie, int err);
diff --git a/mount/main.c b/mount/main.c
index a534dd3..d2d292b 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -41,15 +41,21 @@ enum erofs_backend_drv {
 	EROFSNBD,
 };
 
+enum erofsmount_mode {
+	EROFSMOUNT_MODE_MOUNT,
+	EROFSMOUNT_MODE_UMOUNT,
+	EROFSMOUNT_MODE_REATTACH,
+};
+
 static struct erofsmount_cfg {
 	char *device;
-	char *mountpoint;
+	char *target;
 	char *options;
 	char *full_options;		/* used for erofsfuse */
 	char *fstype;
 	long flags;
 	enum erofs_backend_drv backend;
-	bool umount;
+	enum erofsmount_mode mountmode;
 } mountcfg = {
 	.full_options = "ro",
 	.flags = MS_RDONLY,		/* default mountflags */
@@ -121,6 +127,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 {
 	static const struct option long_options[] = {
 		{"help", no_argument, 0, 'h'},
+		{"reattach", no_argument, 0, 512},
 		{0, 0, 0, 0},
 	};
 	char *dot;
@@ -153,13 +160,16 @@ static int erofsmount_parse_options(int argc, char **argv)
 			mountcfg.fstype = optarg;
 			break;
 		case 'u':
-			mountcfg.umount = true;
+			mountcfg.mountmode = EROFSMOUNT_MODE_UMOUNT;
+			break;
+		case 512:
+			mountcfg.mountmode = EROFSMOUNT_MODE_REATTACH;
 			break;
 		default:
 			return -EINVAL;
 		}
 	}
-	if (!mountcfg.umount) {
+	if (mountcfg.mountmode == EROFSMOUNT_MODE_MOUNT) {
 		if (optind >= argc) {
 			erofs_err("missing argument: DEVICE");
 			return -EINVAL;
@@ -170,12 +180,15 @@ static int erofsmount_parse_options(int argc, char **argv)
 			return -ENOMEM;
 	}
 	if (optind >= argc) {
-		erofs_err("missing argument: MOUNTPOINT");
+		if (mountcfg.mountmode == EROFSMOUNT_MODE_MOUNT)
+			erofs_err("missing argument: MOUNTPOINT");
+		else
+			erofs_err("missing argument: TARGET");
 		return -EINVAL;
 	}
 
-	mountcfg.mountpoint = strdup(argv[optind++]);
-	if (!mountcfg.mountpoint)
+	mountcfg.target = strdup(argv[optind++]);
+	if (!mountcfg.target)
 		return -ENOMEM;
 
 	if (optind < argc) {
@@ -418,6 +431,94 @@ out_fork:
 	return num;
 }
 
+static int erofsmount_reattach(const char *target)
+{
+	struct erofsmount_nbd_ctx ctx = {};
+	char *identifier, *line, *source, *recp;
+	int nbdnum, err;
+	struct stat st;
+	size_t n;
+	FILE *f;
+
+	err = lstat(target, &st);
+	if (err < 0)
+		return -errno;
+
+	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
+		return -ENOTBLK;
+	nbdnum = minor(st.st_rdev);
+
+	identifier = erofs_nbd_get_identifier(nbdnum);
+	if (IS_ERR(identifier))
+		identifier = NULL;
+
+	if (!identifier &&
+	    (asprintf(&recp, "/var/run/erofs/mountnbd_nbd%d", nbdnum) <= 0)) {
+		err = -ENOMEM;
+		goto err_identifier;
+	}
+
+	f = fopen(identifier ?: recp, "r");
+	if (!f) {
+		err = -errno;
+		free(recp);
+		goto err_identifier;
+	}
+	free(recp);
+
+	line = NULL;
+	if ((err = getline(&line, &n, f)) <= 0) {
+		err = -errno;
+		fclose(f);
+		goto err_identifier;
+	}
+	fclose(f);
+	if (err && line[err - 1] == '\n')
+		line[err - 1] = '\0';
+
+	source = strchr(line, ' ');
+	if (!source) {
+		erofs_err("invalid source recorded in recovery file: %s", line);
+		err = -EINVAL;
+		goto err_line;
+	} else {
+		*(source++) = '\0';
+	}
+
+	if (strcmp(line, "LOCAL")) {
+		err = -EOPNOTSUPP;
+		erofs_err("unsupported source type %s recorded in recovery file", line);
+		goto err_line;
+	}
+
+	err = open(source, O_RDONLY);
+	if (err < 0) {
+		err = -errno;
+		goto err_line;
+	}
+	ctx.vd.fd = err;
+
+	err = erofs_nbd_nl_reconnect(nbdnum, identifier);
+	if (err >= 0) {
+		ctx.sk.fd = err;
+		if (fork() == 0) {
+			free(line);
+			free(identifier);
+			if ((uintptr_t)erofsmount_nbd_loopfn(&ctx))
+				return EXIT_FAILURE;
+			return EXIT_SUCCESS;
+		}
+		close(ctx.sk.fd);
+		err = 0;
+	}
+	close(ctx.vd.fd);
+err_line:
+	free(line);
+err_identifier:
+	free(identifier);
+	return err;
+}
+
 static int erofsmount_nbd(const char *source, const char *mountpoint,
 			  const char *fstype, int flags,
 			  const char *options)
@@ -436,6 +537,7 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 
 	err = erofsmount_startnbd_nl(&pid, source);
 	if (err < 0) {
+		erofs_info("Fall back to ioctl-based NBD; failover is unsupported");
 		num = erofs_nbd_devscan();
 		if (num < 0)
 			return num;
@@ -639,37 +741,45 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (mountcfg.umount) {
-		err = erofsmount_umount(mountcfg.mountpoint);
+	if (mountcfg.mountmode == EROFSMOUNT_MODE_UMOUNT) {
+		err = erofsmount_umount(mountcfg.target);
 		if (err < 0)
 			fprintf(stderr, "Failed to unmount %s: %s\n",
-				mountcfg.mountpoint, erofs_strerror(err));
+				mountcfg.target, erofs_strerror(err));
+		return err ? EXIT_FAILURE : EXIT_SUCCESS;
+	}
+
+	if (mountcfg.mountmode == EROFSMOUNT_MODE_REATTACH) {
+		err = erofsmount_reattach(mountcfg.target);
+		if (err < 0)
+			fprintf(stderr, "Failed to reattach %s: %s\n",
+				mountcfg.target, erofs_strerror(err));
 		return err ? EXIT_FAILURE : EXIT_SUCCESS;
 	}
 
 	if (mountcfg.backend == EROFSFUSE) {
-		err = erofsmount_fuse(mountcfg.device, mountcfg.mountpoint,
+		err = erofsmount_fuse(mountcfg.device, mountcfg.target,
 				      mountcfg.fstype, mountcfg.full_options);
 		goto exit;
 	}
 
 	if (mountcfg.backend == EROFSNBD) {
-		err = erofsmount_nbd(mountcfg.device, mountcfg.mountpoint,
+		err = erofsmount_nbd(mountcfg.device, mountcfg.target,
 				     mountcfg.fstype, mountcfg.flags,
 				     mountcfg.options);
 		goto exit;
 	}
 
-	err = mount(mountcfg.device, mountcfg.mountpoint, mountcfg.fstype,
+	err = mount(mountcfg.device, mountcfg.target, mountcfg.fstype,
 		    mountcfg.flags, mountcfg.options);
 	if (err < 0)
 		err = -errno;
 
 	if ((err == -ENODEV || err == -EPERM) && mountcfg.backend == EROFSAUTO)
-		err = erofsmount_fuse(mountcfg.device, mountcfg.mountpoint,
+		err = erofsmount_fuse(mountcfg.device, mountcfg.target,
 				      mountcfg.fstype, mountcfg.full_options);
 	else if (err == -ENOTBLK)
-		err = erofsmount_loopmount(mountcfg.device, mountcfg.mountpoint,
+		err = erofsmount_loopmount(mountcfg.device, mountcfg.target,
 					   mountcfg.fstype, mountcfg.flags,
 					   mountcfg.options);
 exit:
-- 
2.43.5


