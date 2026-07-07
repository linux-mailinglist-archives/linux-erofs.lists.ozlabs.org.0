Return-Path: <linux-erofs+bounces-3854-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rLeuHoL9TGp4tAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3854-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 15:22:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B59EB71BD61
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 15:22:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=OiwVnYFc;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3854-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3854-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvhht1dMqz2xWY;
	Tue, 07 Jul 2026 23:22:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783430526;
	cv=none; b=nh2fUFlPPybVQ1pz0Um63ALB6OjKpzmxXYiISoPIFfjEbcT8m2Ii1z3MlosZHJtRpNtqtEgMbxzAIptyNDNwsiqm1Q2BAB6SIhz3jHFaoQVxwpsuDVo7WKxiedExxTfYsCvzP8gqc89OzDC5VjqDg3iO+HxJ3e523LVsGHtJ0BKhf5di9S72qZ1qrWN82T6cvPuR9B0aIaFkmibUYMbfzDhcpht1yvNrs5I7vZbwL7UBDCSMCmnW3ZUPTCOA9AkH8L4nZIeifHtaa1VhFaV/OJjpP1AxgjpPpOR543KreiBgK272zhGlIBHekL45kGy9QH0jTViBbm9RGTN1+nqo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783430526; c=relaxed/relaxed;
	bh=a5hsotvxZtzR80XULwNX5K5SDey/8iDcL/FmljrpJ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp8nEX0W3DK4ux3UXRmnNxdu8ZV2XNzdi2JGLuNr4cAf9qdkoRn3GrpL/yF6Uz1Mza1vHA15reinCnlknKP5t94F2GCJFJ3aDzTBMQ7lh1aeCclvosbbehlRU2ER0arACNcZiHXhIa7/t/IEQXm/bdCOGWihlwdnXPa8nhP3oWgLyVjHmy5EFXfmepN+LlqusQKdf7GCQiHcexQBvB6vL+SWwSIxSkC61kH3Y3QFJsAD49gkIzGnqX2dwclIp4tRWquxOiSQj5lJ0lt82i8Teu09VmaQnZNKsEilhA+QS7yvEY6hE7F1J5OQKsZdYbCaw0TkfUdsMAme9nF/psiigg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OiwVnYFc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvhhq59Q1z2xF8
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Jul 2026 23:22:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783430518; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a5hsotvxZtzR80XULwNX5K5SDey/8iDcL/FmljrpJ4s=;
	b=OiwVnYFcbKDGdZs2pS1bMMO1eVEgbLrmWpDB+zPVf+P8yW/n06QfsVXvt1Sv3c9hMJ0W5rvH2Xs8XUjZtGVcCbo9AH7u7WfDYsmQa/KYAlNIxPkUBcNtylMI6p6zw0H93ZzpkMV9BpoWiMaf4TRfMbeEB55lJ0JQD4odptjNeGU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6dnFPA_1783430512;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6dnFPA_1783430512 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 21:21:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Alberto Salvia Novella <es20490446e@gmail.com>
Subject: [PATCH] erofs: relax sanity check for tail pclusters on ztailpacking images
Date: Tue,  7 Jul 2026 21:21:52 +0800
Message-ID: <20260707132152.1176967-1-hsiangkao@linux.alibaba.com>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3854-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B59EB71BD61

If the tail data can be inlined into the inode meta block, it should
be converted into a regular tail pcluster.

In principle, it should be converted into an uncompressed pcluster if
there is not enough gain to use compression (map->m_llen < map->m_plen);
but since there are various shipped images, relax the condition for
ztailpacking tail pclusters instead of reporting corruption incorrectly.

Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
Reported-by: Alberto Salvia Novella <es20490446e@gmail.com>
Closes: https://github.com/erofs/erofs-utils/issues/51
Fixes: a5242d37c83a ("erofs: error out obviously illegal extents in advance")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bab521613552..f6b0172a6acc 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -732,7 +732,9 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 				  map->m_algorithmformat, EROFS_I(inode)->nid);
 			return -EFSCORRUPTED;
 		}
-		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen) {
+		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen &&
+		    (map->m_la + map->m_llen < inode->i_size ||
+		     !erofs_sb_has_ztailpacking(sbi))) {
 			erofs_err(inode->i_sb, "too much compressed data @ la %llu of nid %llu",
 				  map->m_la, EROFS_I(inode)->nid);
 			return -EFSCORRUPTED;
-- 
2.43.5


