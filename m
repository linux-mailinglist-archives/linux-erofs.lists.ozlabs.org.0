Return-Path: <linux-erofs+bounces-3857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ilY6IaXBTWp69wEAu9opvQ
	(envelope-from <linux-erofs+bounces-3857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 05:19:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68161721590
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 05:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="gBlaSq/a";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3857-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3857-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw3GV0Y14z3078;
	Wed, 08 Jul 2026 13:18:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783480737;
	cv=none; b=fXvMhB/1V7skvTmWMFsi0Jn9r1mSdUhcZ71tg/ljYhbem27t4xHvTSoOHnBw5mObDaq58/DK8BkkeVT8i1GG2XTz8OC2mYTZ9ebX41Xv//a+d84HTusO6NfoQm/L0sB/cTP3QfBDKLO13ftT8ndjvJVTdPAfDt0XBxstCj1xpBegUkR/E2f16JfkYqeJALrD7h/xKqkEb7fQSJjc7YczhnkJa6RX7loUctBPXlLPQRUsJml7bTrMpHWJUHijCOIGgUzpu+/Z29fSneLTEn9tfRGbKUTiCXMw2eJ7Ax/exxY4ETtMGyHfZuoHttVS/PMdhfym5qrSuPetO7lKQZho8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783480737; c=relaxed/relaxed;
	bh=BLeHLE49B5FtV3V+uSkjb7tYH+qKS9FjkqCOvbVciPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9NSdqpMAlHo83ZalAMFTQcmB07JnCMR8YusyZCpSdEh/vacVuUThfCB9DdxbFnzQNCIfsyptXfPcXsHxCmAjFlsnpQUW0VSDXML0bmyfH4lqwZJJZGKDESJciSlT8plX87zBqzcsS6L18qO/pUHnXe2Ppf6EA6iO8WQjBdSJgs+wwKA0LkzQSwPFpTTSz0QzID3M0y4Nq0q8PbxYa/Q/L7cGNoBsVhXmhqZBQEF/U1qCqxedqBwv6d4pabjIhLAeIdOywOGvR3MVg15noGaSqv1/Rppvcl+4uh0fSn270PUd3zhHvVwFGH8gri2ezSnijNBXuD02vgSGIqcFno0+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gBlaSq/a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw3GR4gSjz2yQL
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 13:18:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783480730; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BLeHLE49B5FtV3V+uSkjb7tYH+qKS9FjkqCOvbVciPA=;
	b=gBlaSq/aLEqZcfc/mWFyi5Hj5iDRrjly6HLe0Yh+5MtmMOIpEqkmWUc23528Oi8ut6ugCoVbqFdMDDWzopDb46B/YvUQtXaLpuRCi8Rr8hHpmEZGPjO8Opbyfa5jIbtJYdXZebP0nl9yHfYSKf9vmH6nikE2hnmnlrJamkiDqik=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X6gIU32_1783480726;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6gIU32_1783480726 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 11:18:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Alberto Salvia Novella <es20490446e@gmail.com>
Subject: [PATCH v2] erofs: relax sanity check for tail pclusters due to ztailpacking
Date: Wed,  8 Jul 2026 11:18:45 +0800
Message-ID: <20260708031845.2300538-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260707132152.1176967-1-hsiangkao@linux.alibaba.com>
References: <20260707132152.1176967-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3857-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68161721590

If the tail data can be inlined into the inode meta block, it should
be converted into a regular tail pcluster.

In principle, it should be converted into an uncompressed pcluster if
there is not enough gain to use compression (map->m_llen < map->m_plen);
but since there are various shipped images, relax the condition for
ztailpacking tail pcluster fallback instead of reporting corruption
incorrectly.

Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
Reported-by: Alberto Salvia Novella <es20490446e@gmail.com>
Closes: https://github.com/erofs/erofs-utils/issues/51
Fixes: a5242d37c83a ("erofs: error out obviously illegal extents in advance")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - Drop ztailpacking sb feature check since it might not be set for
   single-file ztailpacking fallback images.

 fs/erofs/zmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bab521613552..5811556a7b71 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -732,7 +732,8 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 				  map->m_algorithmformat, EROFS_I(inode)->nid);
 			return -EFSCORRUPTED;
 		}
-		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen) {
+		if (EROFS_MAP_FULL(map->m_flags) && map->m_llen < map->m_plen &&
+		    map->m_la + map->m_llen < inode->i_size) {
 			erofs_err(inode->i_sb, "too much compressed data @ la %llu of nid %llu",
 				  map->m_la, EROFS_I(inode)->nid);
 			return -EFSCORRUPTED;
-- 
2.43.5


