Return-Path: <linux-erofs+bounces-2336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aw2+Nf1hlml5egIAu9opvQ
	(envelope-from <linux-erofs+bounces-2336-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Feb 2026 02:06:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3015B4ED
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Feb 2026 02:06:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGZvF0ngQz2xlj;
	Thu, 19 Feb 2026 12:06:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771463161;
	cv=none; b=Rhs0Jc1mRRqRpHp2ztBBiT4a2ogMnRPOTC80zUx0uResQyXm3Gz4a/dpa2PMRGh+0Wxz19cMO97f+qmyzF3tHRXBzOCQY9xPbx1wSCQxEJPm93411pBLANyEuaF+swsGJOIAKeiR6ztDn/L5aucm6FBusNCrCrLMUE5kyDjUOZ6RA15tLMAoj+kyu+Ul1z+izwu5gdPNzB0T5P0nxm1V0tY+JsqNHGgPGBHNLD1aQ9rmOlDT6g4AHh3KClRPzpZ/pD3dXcfj6JkA/3iw7Jx39u1YSuX2O4/YfSv7m0LGmBtEU0WCo2stQ2TyB8SxyKKEfc7S1xkw9xTLKx0eZ0Lwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771463161; c=relaxed/relaxed;
	bh=w3RCsWBzYhsGFMnVg8AkrItzzodIYkHkCkcoCOYKUhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnMC2lFB0RDNlb9rD0ZpoHJzmS/PWZ8zy73UWZQERhCN8zoJX/aFUWJp0OvEK+90es1obNyMU6lfjhenknmPKiN8j+St9EybbJe8OaA/N0TcV3XDEeFx3iYUqjJMloHzZGcKdnPrSCP3BoeRJQpyg6iicfRuXRNtEge+zg9VORt5DCStpDPhirEpjyJX3fk7HF20Vsj0CKEaTkArYIOpNQcKeh44CZr+2nBlwhItLqoX1/0X+1TRUi2/4aOE6MWVZ6Lt2Gpg3y3ZdSHW9Tnnp/48IaOF9mKAOYfn03Fb12ZvSPKNKbXdTPDKRzVhaljZdfNdsy13GKnxEkFXZumHhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHA0vs8n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FHA0vs8n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGZvB51rMz2xN8
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Feb 2026 12:05:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771463152; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=w3RCsWBzYhsGFMnVg8AkrItzzodIYkHkCkcoCOYKUhs=;
	b=FHA0vs8nMDkrxZipfAhEGeOwMjWsTX32CA+kkkOmPtWzJeIEgevrUl4llTZ6SYz5BVpuIBaiPdb7pLYAtMXqE6KhmkbLBDBe3BKgqDtDp5BqqH3who3k7uATu/HVfwaxc+pY3pAWz6ys9xwJrkZ7GhKTk9hjh6XuZtkG/N1XNho=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzTkn5Y_1771463146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Feb 2026 09:05:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib,fuse: fix encoded extents handling
Date: Thu, 19 Feb 2026 09:05:46 +0800
Message-ID: <20260219010546.1265893-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2336-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: CFD3015B4ED
X-Rspamd-Action: no action

Source kernel commit: be45319c9fb1d5c272da9fd34854a7d39e7f58d1
Source kernel commit: a429b76114aaca3ef1aff4cd469dcf025431bd11

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index c1cf698c828b..baec278cc745 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -560,7 +560,8 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 			pos += sizeof(__le64);
 			lstart = 0;
 		} else {
-			lstart = map->m_la >> vi->z_lclusterbits;
+			lstart = round_down(map->m_la, 1 << vi->z_lclusterbits);
+			pos += (lstart >> vi->z_lclusterbits) * recsz;
 			pa = EROFS_NULL_ADDR;
 		}
 
@@ -579,7 +580,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		}
 		last = (lstart >= round_up(lend, 1 << vi->z_lclusterbits));
 		lend = min(lstart, lend);
-		lstart -= 1ULL << vi->z_lclusterbits;
+		lstart -= 1 << vi->z_lclusterbits;
 	} else {
 		lstart = lend;
 		for (l = 0, r = vi->z_extents; l < r; ) {
@@ -621,7 +622,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
-		} else if (map->m_plen) {
+		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
-- 
2.43.5


