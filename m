Return-Path: <linux-erofs+bounces-1833-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CD152D16C5C
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 07:11:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqzRG3F9qz2xWJ;
	Tue, 13 Jan 2026 17:11:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768284714;
	cv=none; b=nyi4nxpnPJsrXJJapoeGPze135pF+ZJikFP2GYnJYbHBnmaF6eZeZaHHYOxPo+SwHmqdnTaF2oZg7+KJeHLNtGMWtzgiZ7QSiNNwp2uynFHZXjhKcPhMjexShGOWG1z3Y26q9a7DysGZ4WXuXR2Yhvh+g5nVHG6mFlDnGwMf5HaOfg3sraQUkC/R755YaUheW0YQGrwGVLnyhYFUSH0GhxKN9ajPI0SCjqMcUy6USixBlXrQm5U8J9mk/rWCj5+kov5UxOYeQ7t1myervX5INAi/EVKAZVabZj4xNIOFDTroMoRJbaf46pTRmW3JlmGYP3XASq9J9xIiyDaxLqIzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768284714; c=relaxed/relaxed;
	bh=ol4heH4EWHwCFp0nj2TVij8MVoW5aDP/OZaFrt3hH0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OimopTswRH404S1OcQv4MN8e8neaMJfpZarr8Wxv5IHlRqW/GJTLJnlNiGLDXf+5Ls7KaPyn7y6J+krPG8cm4f0NFDD7omyT3JCHhm9nUDeqSl86/RZKgLjs/K40xN0X7zkq4tTqTS9zBAFgRUmXpW/KaO28JESQOSsZAvcywCBHKzkmgOPmY9gA3UT9hajjy3/wGsNqQItaYd6esDkNSL0qgDiQKqnmEKjqnQxi9JkLBZhHpKe+RrPV5Ar3ILxMifNpHYW7HJgrNhxOfwNW/LNJo2e26EeEjoD2vd/WHGW2b+9dcaY7xhrtWWsy6DIxq0qSn51SKFCIpoKew5fElA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=siu5wjxA; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=siu5wjxA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqzRC1zqSz2xKx
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 17:11:49 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ol4heH4EWHwCFp0nj2TVij8MVoW5aDP/OZaFrt3hH0w=;
	b=siu5wjxAJFf5anELiopV10WLCtLKy/4LKWg2wqbo3PvzFq/141vBi00DSet0FOlZKqDQTZPai
	qpuU0h4DotR8Zm668uQN91492n3EKMY5ASAFXtpVt81KbXuBFUZ4FAC1/qW5scad8bNtJPzgB38
	pPerWBd9ARUNcprOGnrUZdU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dqzMF6Gtxz1cyPw
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:08:25 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 46B1140563
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:11:44 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 14:11:43 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/3] erofs-utils: lib: s3: fix diskbuf commit size
Date: Tue, 13 Jan 2026 14:11:47 +0800
Message-ID: <20260113061149.3630464-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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

Currently, when calling erofs_diskbuf_commit() in the S3 code, the
argument passed is `resp.end - resp.pos`. This value is always zero upon
a successful GetObject operation, making erofs_diskbuf_commit() a no-op.
It should use the modified `resp.pos` in s3erofs_remote_getobject_cb()
minus its original value instead.

Fixes: 093c7e2f97a1 ("erofs-utils: mkfs: support full image generation from S3")
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 296df61..3426585 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -980,6 +980,7 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 	struct s3erofs_curl_request req = {};
 	struct s3erofs_curl_getobject_resp resp;
 	struct erofs_vfile vf;
+	u64 diskbuf_off;
 	int ret;
 
 	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key, NULL,
@@ -1003,8 +1004,6 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 		resp.pos = erofs_pos(inode->sbi, inode->u.i_blkaddr);
 		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
 	} else {
-		u64 off;
-
 		if (!inode->i_diskbuf) {
 			inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
 			if (!inode->i_diskbuf)
@@ -1014,10 +1013,10 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 		}
 
 		vf = (struct erofs_vfile) {.fd =
-			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off)};
+			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &diskbuf_off)};
 		if (vf.fd < 0)
 			return -EBADF;
-		resp.pos = off;
+		resp.pos = diskbuf_off;
 		resp.vf = &vf;
 		inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
 	}
@@ -1025,7 +1024,7 @@ static int s3erofs_remote_getobject(struct erofs_importer *im,
 
 	ret = s3erofs_request_perform(s3, &req, &resp);
 	if (resp.vf == &vf) {
-		erofs_diskbuf_commit(inode->i_diskbuf, resp.end - resp.pos);
+		erofs_diskbuf_commit(inode->i_diskbuf, resp.pos - diskbuf_off);
 		if (ret) {
 			erofs_diskbuf_close(inode->i_diskbuf);
 			inode->i_diskbuf = NULL;
-- 
2.47.3


