Return-Path: <linux-erofs+bounces-1621-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFEDCDF921
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Dec 2025 12:40:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ddgXc2xd0z2y8c;
	Sat, 27 Dec 2025 22:40:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766835648;
	cv=none; b=lu6cFeSjyD+o3qDyt31WfXXevYE4Iq/eelGLxJO+8ow8TQc9x00DBT0EeHnXHTvZ8HaLRgv4a/fWSYTzKWJF5ZX/GGpWhBLjsdN+jDgpgrfToS3eU7T7NTWmuJu6yoa6tC5hrh1I1coTehPIBw2OdGVkTskjlrYFKFsj9Xm6Es6uJ9yfJjPd13tJ7tj6BsxVO0cnKS5G8R9JCXmwUOIiGgokQ80NfDbk7oliWJ5HYZIDcSsW5AEDY/XP3jEFRUEr4F78bZxI1vsz3ulGI/m+MMKm1J+jQMLnYpjCodaTIvKpSTjGiWSJlvItqioTcEL8aG7sAvr2MWbIYX+ZB5PCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766835648; c=relaxed/relaxed;
	bh=hSKBA2VtQjgDI1COUm8U/n4ooXPTNlszYJW3CJEAtOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M0TWOZKEt3usaqAKC8xrpNL2vd7P8PvanA1semMr3GHwGCHPE9xjmcOjAoyqoifHobFo06AUYaVIg6eOR16CvoHJoMM2rw4OdeE1Eip1CfmrWMTmAuWcSBIvjpGYV3kS4cx0oPnY0Lzjwpa0An/fKO+FDdwq9ZGSBb8QXI+ZhzaTERHWTF/ix/hp5FlrspWl/CgQgV8dMtDRQ0/R4GcnQeyfJUTLg0LCeHyxNSioJHifaRFzcJOuWOphuFqfs+6MsC2ioEqQf9lETfVzN8zL6ZrDMaZ26AdZMPr3q2X7uLz6JdEjEkx+ovXdrZbI0JhMoJj7i1UWS4MPA7wmnm2EVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=J+INrXua; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=J+INrXua;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ddgXY4xZlz2xlP
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 22:40:43 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hSKBA2VtQjgDI1COUm8U/n4ooXPTNlszYJW3CJEAtOc=;
	b=J+INrXuaO9Yf8aqgFiK3PJE0ANLiNqEEWrw/toy9VVEDz1N/dVGy1QOTLJ7uSUracio9BvpKl
	vFJh5Is6xihVDcr2n0JzZ7WMEXs6nY+PTyz1LzXVXJTYr2abwEXRz6JtDSEZrm6qfuoUP6Cqn5K
	ZSzZzzEdK4pf8Nl4YUFWv9A=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ddgSl18B1zmV6l
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 19:37:27 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 974F240565
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 19:40:36 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 27 Dec
 2025 19:40:36 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: mount: gracefully exit when `erofsmount_nbd()` encounts an error
Date: Sat, 27 Dec 2025 19:39:32 +0800
Message-ID: <20251227113933.45791-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

If the main process of `erofsmount_nbd()` encounters an error after the
nbd device has been successfully set up, it fails to disconnect it
before exiting, resulting in the subprocess not being cleaned up and
keeping its connection with NBD device.

This patch resolves the issue by disconnecting NBD device before exiting
on error.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mount/main.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 02a7962..5ba2e0a 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1194,7 +1194,7 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 {
 	bool is_netlink = false;
 	char nbdpath[32], *id;
-	int num, nbdfd;
+	int num, nbdfd = -1;
 	pid_t pid = 0;
 	long err;
 
@@ -1220,7 +1220,6 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 		if ((pid = fork()) == 0)
 			return erofsmount_startnbd(nbdfd, source) ?
 				EXIT_FAILURE : EXIT_SUCCESS;
-		close(nbdfd);
 	} else {
 		num = err;
 		(void)snprintf(nbdpath, sizeof(nbdpath), "/dev/nbd%d", num);
@@ -1230,13 +1229,15 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 	while (1) {
 		err = erofs_nbd_in_service(num);
 		if (err == -ENOENT || err == -ENOTCONN) {
-			int status;
-
-			err = waitpid(pid, &status, WNOHANG);
-			if (err < 0)
-				return -errno;
-			else if (err > 0)
-				return status ? -EIO : 0;
+			err = waitpid(pid, NULL, WNOHANG);
+			if (err < 0) {
+				err = -errno;
+				break;
+			} else if (err > 0) {
+				/* child process exited unexpectedly */
+				err = -EIO;
+				break;
+			}
 
 			usleep(50000);
 			continue;
@@ -1246,9 +1247,13 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 		break;
 	}
 	if (!err) {
-		err = mount(nbdpath, mountpoint, fstype, flags, options);
-		if (err < 0)
+		if (mount(nbdpath, mountpoint, fstype, flags, options) < 0) {
 			err = -errno;
+			if (is_netlink)
+				erofs_nbd_nl_disconnect(num);
+			else
+				erofs_nbd_disconnect(nbdfd);
+		}
 
 		if (!err && is_netlink) {
 			id = erofs_nbd_get_identifier(num);
@@ -1262,6 +1267,8 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 				free(id);
 		}
 	}
+	if (!is_netlink)
+		close(nbdfd);
 	return err;
 }
 
-- 
2.43.0


