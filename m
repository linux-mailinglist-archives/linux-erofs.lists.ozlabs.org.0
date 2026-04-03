Return-Path: <linux-erofs+bounces-3193-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COfQMLxiz2lZvwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3193-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:48:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D543917C7
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:48:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn8LH4h4lz2ygT;
	Fri, 03 Apr 2026 17:43:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775198583;
	cv=none; b=GvAOexrvqw0pMxXLKGGgv65REx+O3hnfdqlXgKdGqRbasR1egiT2WKecZz+3IWa/S7H+ecOaLdVlE9ShhXN3T9rg8JPu4M/wtV4QSg/ncMMR7Bq9hEIR7j0rFIRL0eLd4sotm6NJ3CsEf4QiWUYyZ6GMU1EuiQxQK4+mWvtN9z8tw20hROJghzZi5sk2MGE3rYYUTi4l8ShpBDkp0AfTTFvIW1BEiRv2vVstF8HS7Sdd0Ll5rmkiLj0rd/6PFpeG+kbQZSibC7dAujmppHYRO6CdiM1GnuBvEF5pJtxwBEQ0p1xIqon17iQPCTgUgiWHHpnYJRTCaMbUa529hixJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775198583; c=relaxed/relaxed;
	bh=+Y+BNHrwXS5TUcNQR5uuX3w1Thuscu944ok5H7ydLOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izA/+cPJnhb7GbWbXsCfQjTrMjYGT3tc9i7cObfEl4XGigmECI34fjLhPm2RBB7uQ3XLsyO98Q2btbqkozqFQGSWxDdGheyV1knJCdwwotxKxrCZ9JWOK/nPJgiTtx/t+YUWDFpe42URdCfDeUXdo+s1fVKegMoU2+4jS2/NC+O/+pE8fTEbG+F6f705DziQWtAk0thN0EDECzozqL7F4zPB6HqWAuZfpI9Ca9udG2W/GHvBWWytdWEe6FGuiDaXylrZyz2WVJ6ufkqshQISW/TMt7z0kCmEDiSgy6YuQJp5qe14+BsXMZYMsruOuhMU+WjlzfN35tIpcUsPjm0sZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3l5o7zVB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3l5o7zVB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn8LD5rkSz2yVP
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 17:43:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+Y+BNHrwXS5TUcNQR5uuX3w1Thuscu944ok5H7ydLOM=;
	b=3l5o7zVB1wQUacYXsyqn5PtYSWT4p5wRhmyR6NeOgdaDF2fp0mgJeu0nIZTwctCGjiyK+Kgde
	JUSEbBBf3LZ8LjLLihOmc1bq3qpBgxvf0oPYtqmSwaD5MJ64ZMcY/7VC1wjzVcgP++LESQoUR+d
	3Rxjd7Ej7XWpsmvSI1PSBsI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fn8CK47VFzpTJn
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Apr 2026 14:37:01 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id D4B9940575
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Apr 2026 14:42:52 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 3 Apr
 2026 14:42:52 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/2] erofs-utils: mount: add --worker-log for detached workers
Date: Fri, 3 Apr 2026 14:42:30 +0800
Message-ID: <20260403064230.914563-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403064230.914563-1-zhaoyifan28@huawei.com>
References: <20260403064230.914563-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [113.46.200.218 listed in zen.spamhaus.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3193-lists,linux-erofs=lfdr.de];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_XOIP(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 60D543917C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Detached NBD and fanotify workers currently redirect stdout and stderr
to /dev/null after fork(), which makes their runtime logs invisible once
mount.erofs returns.

Add a `--worker-log=PATH` option so detached workers can append logs to
a caller-provided file for better observability.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mount/main.c | 58 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 45ac32e..40175e3 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -75,6 +75,7 @@ static struct erofsmount_cfg {
 	char *options;
 	char *full_options;		/* used for erofsfuse */
 	char *fstype;
+	char *worker_log_path;
 	long flags;
 	enum erofs_backend_drv backend;
 	enum erofsmount_mode mountmode;
@@ -119,10 +120,10 @@ static int erofsmount_worker_set_signal(int signum, sighandler_t handler)
 	return 0;
 }
 
-static int erofsmount_worker_detach(void)
+static int erofsmount_worker_detach(const char *log_path)
 {
 	sigset_t mask;
-	int fd, err;
+	int infd, outfd, err;
 
 	if (setsid() < 0)
 		return -errno;
@@ -148,18 +149,33 @@ static int erofsmount_worker_detach(void)
 	if (err)
 		return err;
 
-	fd = open("/dev/null", O_RDWR);
-	if (fd < 0)
+	infd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	if (infd < 0)
 		return -errno;
-	if (dup2(fd, STDIN_FILENO) < 0 || dup2(fd, STDOUT_FILENO) < 0 ||
-	    dup2(fd, STDERR_FILENO) < 0) {
+
+	if (log_path)
+		outfd = open(log_path, O_WRONLY | O_CREAT |
+			     O_APPEND | O_CLOEXEC, 0644);
+	else
+		outfd = open("/dev/null", O_WRONLY | O_CLOEXEC);
+	if (outfd < 0) {
 		err = -errno;
-		close(fd);
-		return err;
+		goto infd;
 	}
-	if (fd > STDERR_FILENO)
-		close(fd);
-	return 0;
+	if (dup2(infd, STDIN_FILENO) < 0 || dup2(outfd, STDOUT_FILENO) < 0 ||
+	    dup2(outfd, STDERR_FILENO) < 0) {
+		err = -errno;
+		goto outfd;
+	}
+	err = 0;
+
+outfd:
+	if (outfd > STDERR_FILENO)
+		close(outfd);
+infd:
+	if (infd > STDERR_FILENO)
+		close(infd);
+	return err;
 }
 
 static void erofsmount_worker_exit(int err)
@@ -182,6 +198,11 @@ static void usage(int argc, char **argv)
 		" -u                    unmount the filesystem\n"
 		"    --disconnect       abort an existing NBD device forcibly\n"
 		"    --reattach         reattach to an existing NBD device\n"
+#ifdef EROFS_FANOTIFY_ENABLED
+		"    --worker-log=PATH  redirect nbd/fanotify worker logs to PATH\n"
+#else
+		"    --worker-log=PATH  redirect nbd worker logs to PATH\n"
+#endif
 #ifdef OCIEROFS_ENABLED
 		"\n"
 		"OCI-specific options (EXPERIMENTAL, with -o):\n"
@@ -364,6 +385,7 @@ static int erofsmount_parse_options(int argc, char **argv)
 		{"version", no_argument, 0, 'V'},
 		{"reattach", no_argument, 0, 512},
 		{"disconnect", no_argument, 0, 513},
+		{"worker-log", required_argument, 0, 514},
 		{0, 0, 0, 0},
 	};
 	char *dot;
@@ -431,6 +453,12 @@ static int erofsmount_parse_options(int argc, char **argv)
 		case 513:
 			mountcfg.mountmode = EROFSMOUNT_MODE_DISCONNECT;
 			break;
+		case 514:
+			free(mountcfg.worker_log_path);
+			mountcfg.worker_log_path = strdup(optarg);
+			if (!mountcfg.worker_log_path)
+				return -ENOMEM;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -789,7 +817,7 @@ static int erofsmount_startnbd(int nbdfd, struct erofsmount_source *source)
 	}
 	ctx.sk.fd = err;
 
-	err = erofsmount_worker_detach();
+	err = erofsmount_worker_detach(mountcfg.worker_log_path);
 	if (err) {
 		erofs_io_close(&ctx.vd);
 		erofs_io_close(&ctx.sk);
@@ -1176,7 +1204,7 @@ static int erofsmount_startnbd_nl(pid_t *pid, struct erofsmount_source *source)
 		if (err)
 			goto err_sk;
 
-		err = erofsmount_worker_detach();
+		err = erofsmount_worker_detach(mountcfg.worker_log_path);
 		if (err)
 			goto err_sk;
 
@@ -1301,7 +1329,7 @@ static int erofsmount_reattach(const char *target)
 	if (err == 0) {
 		free(line);
 		free(identifier);
-		err = erofsmount_worker_detach();
+		err = erofsmount_worker_detach(mountcfg.worker_log_path);
 		if (!err)
 			err = (int)(uintptr_t)erofsmount_nbd_loopfn(&ctx);
 		erofsmount_worker_exit(err);
@@ -1763,7 +1791,7 @@ static int erofsmount_fanotify_child(struct erofs_fanotify_ctx *ctx,
 	if (err)
 		goto notify;
 
-	err = erofsmount_worker_detach();
+	err = erofsmount_worker_detach(mountcfg.worker_log_path);
 	if (err)
 		goto notify;
 
-- 
2.47.3


