Return-Path: <linux-erofs+bounces-3699-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +7kpMo2vOGrhfwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3699-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:44:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C96AC523
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=0EC4JeTq;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3699-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3699-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkDZy50h3z2yVP;
	Mon, 22 Jun 2026 13:44:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782099850;
	cv=none; b=iqwvlmXqK9Q5C4jXCMNzoC0i1wIVSqt2gXPFKqlUUWMCicYZjoEQM3GJk8kUvT7E2kYjrQg+JspLMB/cUgmN04uafLOMgRs0553lkMVycmKMEeSH0BS78LTRh5wFA+T68rEMHRRZ8Fi/MwQp8hHRGM3N9JLMFxRIVNwkx9pEEoqWtMFupYE6xJ3k2L3000qiC127MymWPrmtqUwM7ftLlhw0+KFfrIXtHL8ZT7HmjOlI+kjhGN09t8yjOdKFmq161il4eGiKI3MMAiQjfBB3nYqw6fMHwAUAr7ggGQyYreS4q+eTqMoZah6BPwR7w6F9Br3Tt+8qps/43xcaetZBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782099850; c=relaxed/relaxed;
	bh=P5KJxfSmJk0SBRiu6YtpNQiDsOnTPPK7lIxxA4bAmK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgomFKGYgfpj06eYAwVPJWPYCixoQiOpvgYlLzoABxWlu7B9s7Aj8qk7ttMtMStMie+dChj8nDSh0qsirce5W75qagNloLRFSxJmRPxJ96WXOVMRPg/3bVAwfJc811hZZipHumnpV485Few0iuh8ahXfmiILLBr22Qi9t5hts8MaJ6y0gYYE2ZOsvOBL8+uok51lE6AakZ0nOOG4EoGF/iHROoJpbxPK+O1dVYFo4+3YClZupPQ+ZTNy6vTIszWJKXIwqVcTPwihOndXKLn6HizpogpKa6L7cohXlGmEmPuD0TTjZTs0MliQZ4TCXptqjC8O2TVfbZKxOcndaj0wXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0EC4JeTq; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkDZy0GX7z2xyh
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 13:44:10 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P5KJxfSmJk0SBRiu6YtpNQiDsOnTPPK7lIxxA4bAmK0=;
	b=0EC4JeTqvn8CwtsgwWN33N9yFSp++rWBkcLnnFJdbnr7NH6JndsuLumO5AGSVfJhFvcEzAkZg
	q/oA+8CLZ0NwttXPYuAC4+5rTOXLOpP9j+Qh8AVfSYRNop98iDu0XH9MIv0RpuLS0aSqvXodyut
	euykJ6sppD/nZ24owLkQ5/E=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gkDNS572Dz1K9Y5;
	Mon, 22 Jun 2026 11:35:04 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E5CF4056C;
	Mon, 22 Jun 2026 11:44:07 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Jun
 2026 11:44:06 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [RESEND PATCH 2/2] erofs-utils: lib: honor rebuild whiteouts for recreated dirs
Date: Mon, 22 Jun 2026 11:42:48 +0800
Message-ID: <20260622034248.1047783-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
References: <20260622034248.1047783-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3699-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E08C96AC523

When rebuilding from upper to lower, a whiteout below an already
recreated directory should keep that directory but stop older lower
entries from being merged into it.

Mark the existing directory opaque before applying the generic
non-directory bailout.

Reported-by: cayoub-oai <276123840+cayoub-oai@users.noreply.github.com>
Closes: https://github.com/erofs/erofs-utils/issues/49
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/rebuild.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 51dfe18..108a464 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -401,7 +401,13 @@ static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
 			.nid = ctx->de_nid
 		};
 		ret = erofs_read_inode_from_disk(&src);
-		if (ret || !S_ISDIR(src.i_mode))
+		if (ret)
+			goto out;
+		if (erofs_inode_is_whiteout(&src)) {
+			d->inode->opaque = true;
+			goto out;
+		}
+		if (!S_ISDIR(src.i_mode))
 			goto out;
 		mergedir = d->inode;
 		inode = dir = &src;
-- 
2.47.3


