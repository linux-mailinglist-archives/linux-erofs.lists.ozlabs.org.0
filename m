Return-Path: <linux-erofs+bounces-3885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xmL0MmSjVGp6ogMAu9opvQ
	(envelope-from <linux-erofs+bounces-3885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 10:35:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC933748C35
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 10:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=gfTiJzlB;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3885-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3885-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzG3j5wchz2yMm;
	Mon, 13 Jul 2026 18:35:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783931745;
	cv=none; b=YGGrtTq5fojYEwp1fHkmLFjwt89q3GWgDzR3zXbNpygMX7aiL3j+P1tTNwZt5G4at4gZyomcxZZwiewW3iJPMimt08optWospa3JTVY9a3byp+9MgMKA6bxjBJqxuv79yAY3lPtphDiq3LqIFLnbTeuACbdz70QWxhONUv7EoAO0AVy/IrlZN4l7n8O8ni/4mOy4zizQOzLeq7Pv1F7dBLEIBHLz/GpJbd6WHyIjoFrW9UE5iZkTdw6KNdzUhz2tThTo0NwgVirUwEMzwR6W+6c5bkYujSSdEAodsWpxj2sRBtdq4s+NoHBDXzkN/Zjhcy7SyFQ6QQQd/+ipbm2bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783931745; c=relaxed/relaxed;
	bh=2SmJ95mWigTNYSEHKoKTBhLuvadF7wM9nv0YjuUp5Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtF2n/q5p6aH9xih6bX5Ok8+eMDs9ZCkFjU4gyZPzyLeueswxoob2iHDL6T9tuCHplkZRvfzicsEjaBb77kJJ+iKL8dXxFn+Vc2YqsRulXF/l76bUO4h7R28Cs+HfSdRCv2kBO96A9eMQefsMEjio0sPJ6FOYU9cHe8KT0kNkBCYvoBHyahPI4cOfiHQrae6LOXhJ8khpsVSwqhohOdF9Vx2NYObNGTGcMLXQrjiUfMyxb8Lnjz6qp03F25kY5Zp4k9xIxButxu8URN2yXIbjaAfOyx7sN0hVEmjkLpZT4EhSLnlb7SgVRyOX/Nh/G9eCePkyhs4FdoGKbN9NAa8uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gfTiJzlB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzG3g5x4wz2xlv
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 18:35:42 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783931739; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2SmJ95mWigTNYSEHKoKTBhLuvadF7wM9nv0YjuUp5Vg=;
	b=gfTiJzlBmqydGwVCB5PDIGaDsT0+5S7bx5hU76U9LnG7Mzphd8lLS5OQ3VdHYA+C5vilq71lfg12TiQ+FSUhBbG5QpU58nk+s4M+Ro9ysH1WLvX5pQSpu1FKXbNQqdy8ZN2NWeBkHkrEIUG2i0jUmmhZRMVtbwRbJ17sQo32POw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X6xCluZ_1783931730;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6xCluZ_1783931730 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 16:35:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: hide "cache_strategy=" for plain filesystems
Date: Mon, 13 Jul 2026 16:35:29 +0800
Message-ID: <20260713083529.3309658-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3885-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC933748C35

"cache_strategy=" is meaningless and confusing on unencoded EROFS
filesystems; gate it on compressed images only since it's now possible
after commit 7cef3c834194 ("erofs: separate plain and compressed
filesystems formally").

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..85674b08f66e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1038,7 +1038,7 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 				",user_xattr" : ",nouser_xattr");
 	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
 		seq_puts(seq, test_opt(opt, POSIX_ACL) ? ",acl" : ",noacl");
-	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP) && sbi->available_compr_algs)
 		seq_printf(seq, ",cache_strategy=%s",
 			  erofs_param_cache_strategy[opt->cache_strategy].name);
 	if (test_opt(opt, DAX_ALWAYS))
-- 
2.43.5


