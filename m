Return-Path: <linux-erofs+bounces-2384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HL5IRB+nWk1QQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2384-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 11:31:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92C18563B
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 11:31:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKvCc4cTDz3cM2;
	Tue, 24 Feb 2026 21:31:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771929100;
	cv=none; b=kCXEUf5iOZTxzJsRv5M7hj5GWknkciRUdy00EISwmFeDKfNKdRNeR/5DCWb1W9brzc/M87mfytA+1iokdTdN6TsIKhOrsZfBWWGEEWG7mKTo2KEzFLXjVAzJqoy9rFy99OuMJQwx75uurMSe5S54OnDETgaFg2/piKqbrohdWeCuWSLABKIjzYmZUH+JC2g3d4AzZA83VGUQXHjbFJQH6xDBagb/cQYqoCu9p6/6GIGmjQIooZ/3KGXw68yinJ/W3tDzCrpgqsmlfuYsxrmRzRYJzo9qXjlhY6DKI8ucB1jYXFKRe7XrIuy5rPjQ9c+Fm+HPxWZOjb+aERY9r22+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771929100; c=relaxed/relaxed;
	bh=5yDnhlZmVf0Zsv8d6JHtyUTkDwhpm8Vy4AX0FB6ZXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx5uMUi3xRGB/Y2fWd6x+ebQNx/O5RY5syc04gUjVxh5Y7yg7OltQk6xY5RtFHktGfVcV/mW+Sf5TyiBKxsM2lA9yxeau+P58XO3lkYvE0CeaxBdNvcFAYCPf9okN2JdbjhXn9rLmVJITmBv58oLvTH3zCIgVJVr5wMeKH7dF/NFnRNCC83qgmRsWRj0CxbjlwPj5pn+STqK+h0bRz10ScXA1sBy5B8ChwRB/B198mu9wy0BSG+QequrXi2K/o5/TjLvvZQ/45hwF045H/8CdOAVZ5jxwXWz6NDMGd/7SqKpnZdK7mG4LuJ2qRCcR3dxSv94k+asIHdq5yIneRXNjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edPRQFKE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=edPRQFKE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKvCZ21qVz3cLy
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 21:31:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771929091; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5yDnhlZmVf0Zsv8d6JHtyUTkDwhpm8Vy4AX0FB6ZXRo=;
	b=edPRQFKEItRUk15sWZpYrXSG0ICKvHtaH48O+XTdfa6NGLRL7wzZTqvefoFOLjIVkHbzhFcOK/TUriqryIS5CFhwrXjgM8VM+kTnB53qfraJhPf82ll5QCI7+qxsOZXTzgdgyOAm6Ft12Cop+JzpOzg1Fv2m0kCIJWH7NXYC7UU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzjF-0J_1771929085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 18:31:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix interlaced plain identification for encoded extents
Date: Tue, 24 Feb 2026 18:31:25 +0800
Message-ID: <20260224103125.2656548-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <699d5714.050a0220.cdd3c.03e7.GAE@google.com>
References: <699d5714.050a0220.cdd3c.03e7.GAE@google.com>
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
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2384-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs,d988dc155e740d76a331];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 7B92C18563B
X-Rspamd-Action: no action

Only plain data whose start position and on-disk physical length are
both aligned to the block size should be classified as interlaced
plain extents. Otherwise, it must be treated as shifted plain extents.

This issue was found by syzbot using a crafted compressed image
containing plain extents with unaligned physical lengths, which can
cause OOB read in z_erofs_transform_plain().

Reported-by: syzbot+d988dc155e740d76a331@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/699d5714.050a0220.cdd3c.03e7.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index c8d8e129eb4b..30775502b56d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -513,6 +513,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
 	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(inode) +
 				   vi->inode_isize + vi->xattr_isize), recsz);
+	unsigned int bmask = sb->s_blocksize - 1;
 	bool in_mbox = erofs_inode_in_metabox(inode);
 	erofs_off_t lend = inode->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
@@ -596,17 +597,17 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
+			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
+				map->m_flags |= EROFS_MAP_PARTIAL_REF;
+			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
 			if (fmt)
 				map->m_algorithmformat = fmt - 1;
-			else if (interlaced && !erofs_blkoff(sb, map->m_pa))
+			else if (interlaced && !((map->m_pa | map->m_plen) & bmask))
 				map->m_algorithmformat =
 					Z_EROFS_COMPRESSION_INTERLACED;
 			else
 				map->m_algorithmformat =
 					Z_EROFS_COMPRESSION_SHIFTED;
-			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
-				map->m_flags |= EROFS_MAP_PARTIAL_REF;
-			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
 		}
 	}
 	map->m_llen = lend - map->m_la;
-- 
2.43.5


