Return-Path: <linux-erofs+bounces-1565-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61493CD8B7C
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 11:06:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db9d31B85z2yF1;
	Tue, 23 Dec 2025 21:05:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766484359;
	cv=none; b=DlgQLnDT4MZlufOPLdkhQ/5qRk/qadn1/TPvKY31TMOKjSkJY6nkgYrj1GpDARUjNnzpQqtrrwT/WKPN/pbEY9HOgxOlBMt4WgwBzXl+8v5bwDkLsIsCWzOmc4SepJWeLeuAix8wobBJZvtjVZRpuqdv/CxaLrLmorAG1PZA2vD4rofy1/WodmmErbmaW1Ak67wXNk+m80d3xEySp09rQe+FJYuLXQbEvwDa2CL2eitF0zkcmCzXxHcT6ythXXHfP4k6K0o4wXGQJiU66kr7I6LF6+cAO9Zv+TfXUUeM4ud9He0MEHiYZO8kH19EgxCK2KAsKXZ1gZ3IA3t2vxUCig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766484359; c=relaxed/relaxed;
	bh=CW80KdaLK3hNPDKxgerfYIB141QrhQNwTYl8q5zB3m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icjYk+uhw8yEd+aQc8aVINKTu6pzLnWld9iVhgArqu1WIxf/ZkzUtsZpjW62XAyeSm1HSEknjns+3o0w4Shj5Mh9Ja0yF6hOWStzt0Bo5YKh0+XJeNIzrgTx+d81MWjXwL9C1gHSo6vYyet8fv0U09rsnJXF5C8GmhNMZEc/awuEagYG1Qkjb4rdTcxNN/irzQ9ylQem5ztw+2DF1d4a9kLlRlyWHTZow7bj6Gl1D1V+71jLR58EtX3Bg2QEGgPnXEj1cUAcbE1ZymoD2o3IggN2hgOsfYfVdbLZ5gly7nVPI4GMQQFpRsMjpRrDLLfQA3WLndvKmVgOBgyfgT7Z3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YX0I/3BS; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YX0I/3BS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db9d146bgz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 21:05:57 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CW80KdaLK3hNPDKxgerfYIB141QrhQNwTYl8q5zB3m8=;
	b=YX0I/3BSDwxiVs6LDwSVaY1ebiflWstKu2CuzG2K66GlTxKb9r5PK48jEu0AC/RI6+F4U5x35
	C64v0PuaeeDXEYquhluPuhRBAhl7qXHWsKGo/+STjWHRg324AKVhwVZJQxd2we8sqKa80RNgcrz
	nmO0kI3Vaig+yqsKvZn8/cc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4db9YL6Ztrz1cySP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:02:46 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id BB1A84056B
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:05:52 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 18:05:52 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 5/5] erofs-utils: mount: stop checking `/sys/block/nbdX/pid`
Date: Tue, 23 Dec 2025 18:04:52 +0800
Message-ID: <20251223100452.229684-4-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223100452.229684-1-zhaoyifan28@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The `current erofsmount_nbd()` implementation verifies that the value in
`/sys/block/nbdX/pid`` matches the PID of the process executing
`erofsmount_nbd_loopfn()`, using this as an indicator that the NBD
device is ready. This check is incorrect, as the PID recorded in the
aforementioned sysfs file may belong to a kernel thread rather than a
userspace process (see [1]).

Moreover, since this verification only occurs after the child process
has successfully issued and returned from the NBD connect request,
removing it introduces no risk of NBD device hijacking by malicious
actors. This patch removes the erroneous check.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/block/nbd.c#L1501

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/backends/nbd.c | 16 +++++-----------
 lib/liberofs_nbd.h |  2 +-
 mount/main.c       |  5 ++---
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index 46e75cd..2d941a9 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -52,7 +52,8 @@ struct nbd_reply {
 	};
 } __packed;
 
-long erofs_nbd_in_service(int nbdnum)
+/* Return: 0 while nbd is in service, <0 otherwise */
+int erofs_nbd_in_service(int nbdnum)
 {
 	int fd, err;
 	char s[32];
@@ -72,17 +73,10 @@ long erofs_nbd_in_service(int nbdnum)
 		return -ENOTCONN;
 
 	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/pid", nbdnum);
-	fd = open(s, O_RDONLY);
-	if (fd < 0)
+	if (access(s, F_OK) < 0)
 		return -errno;
-	err = read(fd, s, sizeof(s));
-	if (err < 0) {
-		err = -errno;
-		close(fd);
-		return err;
-	}
-	close(fd);
-	return strtol(s, NULL, 10);
+
+	return 0;
 }
 
 int erofs_nbd_devscan(void)
diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 78c8af5..b719d80 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -34,7 +34,7 @@ struct erofs_nbd_request {
 /* 30-day timeout for NBD recovery */
 #define EROFS_NBD_DEAD_CONN_TIMEOUT	(3600 * 24 * 30)
 
-long erofs_nbd_in_service(int nbdnum);
+int erofs_nbd_in_service(int nbdnum);
 int erofs_nbd_devscan(void);
 int erofs_nbd_connect(int nbdfd, int blkbits, u64 blocks);
 char *erofs_nbd_get_identifier(int nbdnum);
diff --git a/mount/main.c b/mount/main.c
index d2d4815..f6cba33 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1270,6 +1270,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 
 	while (1) {
 		err = erofs_nbd_in_service(msg.nbdnum);
+		if (!err)
+			break;
 		if (err == -ENOENT || err == -ENOTCONN) {
 			err = waitpid(child, &child_status, WNOHANG);
 			if (err < 0)
@@ -1280,9 +1282,6 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 			usleep(50000);
 			continue;
 		}
-		if (err >= 0)
-			err = (err != child ? -EBUSY : 0);
-		break;
 	}
 
 	if (!err) {
-- 
2.43.0


