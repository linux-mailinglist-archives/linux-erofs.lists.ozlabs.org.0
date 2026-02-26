Return-Path: <linux-erofs+bounces-2419-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NF5GVypn2mddAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2419-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:01:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301819FFB8
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:00:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLvnM3h1Fz30BR;
	Thu, 26 Feb 2026 13:00:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772071255;
	cv=none; b=WBKTAnwQ7ssG9IF19llJcSH7zGyiF9zsj5ZlM8aZR8FIjsp5Eq+x4EKX2JIUs+PxSTwUx9J+GSQuABarSZ4ThjpAwTZ/ukG7y5kXIM/GSvI0mLhaLXh2eRC8lamMV2EVXrYuGZGBC5QZdQePYeew0unH10DYjsEwkrShYL1/OwaoB/jfv3gVssZQD+eQOIPzUJ66UwvLnQG0UnH6PgdRY7LbvHcOkRGPou+AzJ7Ft/4MsVb67Nz9Qd6OCFg1K0gq9XeQoXLcVJ6WQo9ae114BCvKiHI4tvWJfuCzGr5OnbTYcvEqD59gl1wryUzgL46CEWBVptaN3qPB7bMofmZAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772071255; c=relaxed/relaxed;
	bh=0mEGH4gebqaJuiEPzxWLC1UOmFMYOI08W5KQCpjo0+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bsubHAJrLfcjMBTWmTof1dwOyL7GeQJHqCN1otJfo+OsjuuOLELB/Gcw/azVabt+yiUzbQhhtyvi5ABBTpRUGLRd5eeZJqmMGMGQ1kz4Lvbt3Ca+UbovI/NApvm3XHOSDbnemnxlEKDyWR38KQZ1MIdUITQYv8yp8OXCsLF16RnAIyHGWFErEkPJrECO/tBb3/boVR8BI+iJx+jPuiYpysT6ORd396mLDvboSyrBOPSzfojsdlQKlZx3yr0JHo+HjSky/IWhf6Vk2mqLDXeKKdLhOoOyVufY4Ju1Rc2FZ89JFIeB0VtPhHTKcqtjmrYCu6kygpRmmqOAWLlq1QlT5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1DAm+eUl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1DAm+eUl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLvnJ4Ql3z309y
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 13:00:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0mEGH4gebqaJuiEPzxWLC1UOmFMYOI08W5KQCpjo0+g=;
	b=1DAm+eUlJUdF69rGsr1wsJ9hZvbfkh0drXZx/srsIQooZmpxFv49xAelt/3H43NIXfHTZDexr
	egLOhdR9m7zvrYUtIMa3lhBXYI5YxYo2EQqYftlw96FZ/miMQ1lOnX8QeSlACv65idwpUP8e+K7
	RRTJIYEw8ux8rSNdlbcbwSk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fLvgh4c2czRhRZ;
	Thu, 26 Feb 2026 09:56:00 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 383AC40363;
	Thu, 26 Feb 2026 10:00:47 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 26 Feb
 2026 10:00:46 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: lib: fix several compile warnings under glibc-2.43
Date: Thu, 26 Feb 2026 10:00:49 +0800
Message-ID: <20260226020049.691505-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2419-lists,linux-erofs=lfdr.de];
	TO_DN_NONE(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email,gnu.org:url]
X-Rspamd-Queue-Id: 6301819FFB8
X-Rspamd-Action: no action

Since glibc-2.43 and ISO C23 [1]:
- For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
  strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
  pointers into their input arrays now have definitions as macros that
  return a pointer to a const-qualified type when the input argument is
  a pointer to a const-qualified type.

Add missing 'const' qualifiers to pointer variables that are assigned
from functions returning 'const char *' (e.g. strchr, strstr), which
caused -Wdiscarded-qualifiers warnings under glibc-2.43:

remotes/oci.c: In function 'ocierofs_parse_ref':
remotes/oci.c:1058:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
 1058 |         slash = strchr(ref_str, '/');
      |               ^

[1] https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00005.html

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/oci.c | 2 +-
 lib/remotes/s3.c  | 2 +-
 mount/main.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 193464b..e5b2f7c 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -1047,7 +1047,7 @@ out_auth:
  */
 static int ocierofs_parse_ref(struct ocierofs_ctx *ctx, const char *ref_str)
 {
-	char *slash, *colon, *dot;
+	const char *slash, *colon, *dot;
 	const char *repo_part;
 	size_t len;
 	char *tmp;
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 5e4e9d3..768232a 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -897,7 +897,7 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 			       const char *delimiter)
 {
 	struct s3erofs_object_iterator *iter;
-	char *prefix;
+	const char *prefix;
 
 	iter = calloc(1, sizeof(struct s3erofs_object_iterator));
 	if (!iter)
diff --git a/mount/main.c b/mount/main.c
index 5fdda81..3530b2c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -122,7 +122,7 @@ static void version(void)
 static int erofsmount_parse_oci_option(const char *option)
 {
 	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
-	char *p;
+	const char *p;
 	long idx;
 
 	if ((p = strstr(option, "oci.blob=")) != NULL) {
-- 
2.47.3


