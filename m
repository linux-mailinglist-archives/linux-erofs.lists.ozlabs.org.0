Return-Path: <linux-erofs+bounces-1622-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2464ECDF91E
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Dec 2025 12:40:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ddgXc2nymz2xpg;
	Sat, 27 Dec 2025 22:40:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766835648;
	cv=none; b=DG9nwmU7V9UUN6eedGpMBYZOFA161TN/yjGVY2u/GDSas4/zPydkBNP7DvmTeiqt0Hl4JZ5/rAIROvAhqJVMuwewl09Fm6laU/4RbZL5bq7RJiXOjcKp0l90xsaOthG5bPuG+bxIXD0YTmXrfM0W9JrwZUvah4ncBoO8jVtWRw8FJIj+rnywayqYtNkZogkP6t1F+iKQLml436ByAX6k+IheAqKIyQStxZ2+GjBBWWWhqxHTkt4EtFX5668iSJL9JdUkk7cHLp4at2mdr97lmGujvIy4tcK3Y/nnv4j/LyHSQ93BwG4HCORmfq9ymUR2pOP5T0iI5Q4eRLykRoq9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766835648; c=relaxed/relaxed;
	bh=sD7ZFu9LwR/y3vzt7IIbOvUItYZ1RnfTy9cI8xmwVv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=echWgmUytfjLghGW77x0FyuwlQAuCEhmfpSw04oEO/KCSugZEWN4t3wzToaFuBCBEHMtvjlaqbDjhXNxQqUeni0zfrTayjmo/GmV/67atgD48VgLHB4/SF6fQoDDKjPxIIljZLtsDHZQuuJpo9FC2LooU9zeC4krZyOJbVpcVcE+2fy/DauyBx2RlqSqu222SgiYSV8W/TEMy5aPFx3GpulNAJ+PXlls+fh2n1t88FGjIO4ku5DW6h3Liw0Gswvs4Ykjm1yQbFBaVsqh/vHVK16UP8/NgFsDF/FFdJWLKkjIq0c2oobi5f0mlLweYE5K8WILca19eVKYdLuDadKACg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gebJjKvN; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gebJjKvN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ddgXY4RS1z2xQK
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 22:40:44 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sD7ZFu9LwR/y3vzt7IIbOvUItYZ1RnfTy9cI8xmwVv8=;
	b=gebJjKvNgibkkhgF39JSj1kYy5qOksTcH7869cb0+hltzB54D4ry2YNgwTvzQUq1Za2CkgKln
	2HLqETZrGlPye3cQm/Q7zCGmkJEEAWEwMWyO7OqS/0jH0bsQNVXh53Y+0XG7vuwyJ0ngE6lUx6j
	wSbx1FN4nxzVpReJaD70708=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4ddgSt6lTrzpSx3
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 19:37:34 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA6040363
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Dec 2025 19:40:36 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 27 Dec
 2025 19:40:36 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/2] erofs-utils: mount: fix ioctl-based NBD disconnect behavior
Date: Sat, 27 Dec 2025 19:39:33 +0800
Message-ID: <20251227113933.45791-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227113933.45791-1-zhaoyifan28@huawei.com>
References: <20251227113933.45791-1-zhaoyifan28@huawei.com>
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

Currently erofsmount_startnbd() doesn't ignore SIGPIPE, causing
erofsmount_nbd_loopfn() to be killed abruptly without clean up during
disconnect. Moreover, -EPIPE from NBD socket I/O is expected while
disconnecting, and erofsmount_startnbd() treats it as error, leading to
redundant print:
```
<E> erofs: NBD worker failed with [Error 32] Broken pipe
```

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mount/main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 5ba2e0a..965b0b8 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -621,11 +621,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
 		off_t pos;
 
 		err = erofs_nbd_get_request(ctx->sk.fd, &rq);
-		if (err < 0) {
-			if (err == -EPIPE)
-				err = 0;
+		if (err < 0)
 			break;
-		}
 
 		if (rq.type != EROFS_NBD_CMD_READ) {
 			err = erofs_nbd_send_reply_header(ctx->sk.fd,
@@ -653,6 +650,8 @@ static void *erofsmount_nbd_loopfn(void *arg)
 out:
 	erofs_io_close(&ctx->vd);
 	erofs_io_close(&ctx->sk);
+	if (err == -EPIPE)
+		err = 0;
 	return (void *)(uintptr_t)err;
 }
 
@@ -663,6 +662,12 @@ static int erofsmount_startnbd(int nbdfd, struct erofs_nbd_source *source)
 	pthread_t th;
 	int err, err2;
 
+	/* Otherwise, NBD disconnect sends SIGPIPE, skipping cleanup */
+	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR) {
+		err = -errno;
+		goto out_closefd;
+	}
+
 	if (source->type == EROFSNBD_SOURCE_OCI) {
 		if (source->ocicfg.tarindex_path || source->ocicfg.zinfo_path) {
 			err = erofsmount_tarindex_open(&ctx.vd, &source->ocicfg,
-- 
2.43.0


