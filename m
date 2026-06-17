Return-Path: <linux-erofs+bounces-3656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LToIEEcRMmo3uQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 05:15:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A8696407
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 05:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=eQV6qiiW;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3656-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3656-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg89v1wgMz3bqh;
	Wed, 17 Jun 2026 13:15:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781666115;
	cv=none; b=jKghuaytfHqsmAc/8w89P9j5amlgMppJRMO9ngpMaXw8Tw3jviPcGDDSOxoNYPaj1ePl7+SFFQwj6qG3lCQgYCftwzQSdi48NLauK0r5H1PGVtLD8nLuE8kLvgoXg1/ST4E4pV4L0qgash6H/B73Ws4lMjLW9i/TTtJlDK+0rSl10FXpm30mfZWaxWwuRl/7+g0IJoyziKWb50Lcq7JNAwsUgXpiiFYiLWD+bmN8mxfzAneJ6M60IivBkBB2jTcFKM3GSmZpP7reht1/RSp5Em4j9N2VVFxvDvhCU4kufwwvQ49HpxlrYmTLbS2qYtsvw8dNon/4D1kHIJZaLKLZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781666115; c=relaxed/relaxed;
	bh=P5NDFyjkf73TpGKIAzG8lbQh6hC9pAvf1LyJw7eFmnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBu893mCeSbnjBKLO8zrAuhr9G8lqN1LtxJUt9fKULjU2AW0b0mUuSHZN5pp9i1yDF/mRgeoEISOwOVOKptZ1PqgJP0YfcUG110SCVZYpE5i1SLFJbYEHiaLjEIbxVg9ZpVrVgbyxo5pYb/TUc8kHdAoOuisagnCe2OPwiniuonGMTGTWWPYL/LWNwgR8aoxR3s53Yxm5kzL+af4KQig8d9Hbu/Zh6BrW1Ql5TktiXqbpPjbZPHHwgFeijK0sJvsFdBBeesvVrl+4A3BoXAdZvFSnjbgsN+Z4Xh6ZzBJgkSjBkGXFNIJBjFXPx2s5VpBBU7dl8NCdn9xVQJXzDykgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eQV6qiiW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg89r2DjCz3bpP
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 13:15:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781666106; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P5NDFyjkf73TpGKIAzG8lbQh6hC9pAvf1LyJw7eFmnM=;
	b=eQV6qiiW/IAote74I7Lkw/qLxhCSX+u7/zy9v/AKRK83r90/dCrnvxvSJm0RkMFkP2HnYTsYoJrh4T/SzWIZsv0c2z+ioYSV0iB6zNJnolJyuhOJhtwVRFAYQrPuYeabhh3OTmsnTxLIG88l8dxpZgX5VK4afA8cGC5Pg5ypbMo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X51RxrD_1781666100;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X51RxrD_1781666100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 11:15:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH] erofs: call erofs_exit_ishare() before rcu_barrier()
Date: Wed, 17 Jun 2026 11:14:59 +0800
Message-ID: <20260617031459.3980804-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3656-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C99A8696407

Ensure all inode free callbacks have completed before
destroying the inode slab cache.

Fixes: 5ef3208e3be5 ("erofs: introduce the page cache share feature")
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 802add6652fd..579443e6acfe 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1048,11 +1048,11 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
+	erofs_exit_ishare();
 
-	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
+	/* ensure all delayed rcu free inodes & pclusters are flushed */
 	rcu_barrier();
 
-	erofs_exit_ishare();
 	erofs_exit_sysfs();
 	z_erofs_exit_subsystem();
 	erofs_exit_shrinker();
-- 
2.43.5


