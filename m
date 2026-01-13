Return-Path: <linux-erofs+bounces-1832-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D7D16C5B
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 07:11:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqzRG1cQSz2xWP;
	Tue, 13 Jan 2026 17:11:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768284714;
	cv=none; b=l5WUmZdX1Ukzp3NvzSqk/wdkJhEBE0UuR/2q1ytOnHHvyZkUUNbmecBMt2m8GS2Da8yvGLitseBG+zisy1Il3Y9PlBNHvxAWOvPY3MXdm/JJCyqE9gK0bkrytttFrWDGZhjRdk0G9aHE7OhSBZdqId580wQk+9Hi2ZGUkX0Kd1KCJ8YCPUV2vPZnE8h4Uowtat0Y/vciysvwYnE6VgoYEWxo8/E3E2eDUccrPeAvL87YNO/IQeNuJ6Do6L0TMQauNy87VGlVrfP817VXhd9zjQA1sAle4KvucPASSqFZRnKhvJhHjtbxQqquPfzjOwyHgXsIV0PdLEF7ZKSKqgX7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768284714; c=relaxed/relaxed;
	bh=0hvT64qd4fxWRKFpEzI3L2nZdSUuUUVQcH1FAC0PkfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaKCVte5i+zMjxX0tevkgoz9C1yXs90v0vaB2aSxxkBb4a53AP0ULyQVYociWYDjXQfO/IasfiQqlMB7WTqCDVa66rslPpSWikC9aewGsOdcQPnh9rKilFqt6eSASmvuujWk/w2eg6/2aK1GoXSyF/qqjXDguwUbI7/R0GWPvN5S2LM61Q8bFwgAvY/gSBEgLcMXj4O3fHjGk8jRxMsbY7Suur+gBy8Mf3DH1/XO9lmPd+NM8DqJIb4r1D/i1XCSgTore3c9RwLT00XNuCTs/9dUgCpA5hGW1W5iFEiCpdqyKXc570pmkDp71bmedxq6nByHyuBPFIpzZwjFhvbvjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tKRMrtl0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=tKRMrtl0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqzRC23Hzz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 17:11:50 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0hvT64qd4fxWRKFpEzI3L2nZdSUuUUVQcH1FAC0PkfE=;
	b=tKRMrtl0hywQVL5lx3w3XT8mz7MSnyT2iDZW9NuM8HqzLKC70Fxqc/PVhjd5xdPm2x0RivYUH
	ahgRwpDi8BwnRzHOba+4aHzYs4e+mwjv/L5yTqEHoBZW/NZ/hPgrznawRjYDX2hug+7pUDidyCB
	cOirvE/2YALB0bysZYOHU10=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dqzLd3l1Yz1T4HL
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:07:53 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id BE3AB201EE
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 14:11:44 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 14:11:44 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 2/3] erofs-utils: lib: s3: set UID & GID correctly
Date: Tue, 13 Jan 2026 14:11:48 +0800
Message-ID: <20260113061149.3630464-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113061149.3630464-1-zhaoyifan28@huawei.com>
References: <20260113061149.3630464-1-zhaoyifan28@huawei.com>
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

In the current remote/s3 implementation, the default {u,g}id for files
and directories is 0. Additionally, the --force-{u,g}id flag only
affects file ownership, leaving directories unchanged.

This patch fixes the behavior by explicitly setting permissions for the
root inode:

- If --force-{u,g}id is not specified, it now defaults to the current
  user's {u,g}id.
- If --force-{u,g}id is specified, it correctly updates the ownership
  for all files and directories.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 3426585..8351674 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1050,8 +1050,8 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 	bool dumb;
 	int ret;
 
-	st.st_uid = root->i_uid;
-	st.st_gid = root->i_gid;
+	root->i_uid = st.st_uid = im->params->fixed_uid == -1 ? getuid() : im->params->fixed_uid;
+	root->i_gid = st.st_gid = im->params->fixed_gid == -1 ? getgid() : im->params->fixed_gid;
 
 	ret = s3erofs_curl_easy_init(s3);
 	if (ret) {
-- 
2.47.3


