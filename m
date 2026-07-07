Return-Path: <linux-erofs+bounces-3855-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mpm+KrIBTWqJtQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3855-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 15:40:02 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252F71C060
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Jul 2026 15:40:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=IWgTG8Mr;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3855-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3855-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvj5V5CW7z2xWY;
	Tue, 07 Jul 2026 23:39:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783431598;
	cv=none; b=Kk/29qABoIC34fzGD4Nn+PXNpC4Z4Bh44BWM9mQQlMjl5zyFD1+KfWRncvXnZd3Xgkcm+71bFibnHnYMAzICZd4dZBvdAJwup/xYvPt7ii23T5EZ5xv1DwYQ/ve51sFxSRLCGiFtCi9mgtQo4QoV8y1EIBoPLeP3Xg6ehxOSSIRi4jF414mfcim1CMrWgn0lJiF0f0sev+APVfLBv3RbNX2g1m6MT54tNk8FDbdhUh3TaHkNB8OE3dk+HkwoJrXFREmr4qfGGEmNM155U01RBl0UccXTXbjEPMjKekywJ7RYkLQSHt8Whs3KlvqDHFMeJd4+OE2VrQGYBZcoSaghAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783431598; c=relaxed/relaxed;
	bh=ow3ueylzDqfZ4A7Q4jx1GAQKDOjhMGDqaY2Vm+GmbVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDuuC6Dl3NNF//NcVlaf3vP6RzeK1I6mPzrMSwoePC7CIiL4oli9LJ8OdW7yEXKN+qahRmVYtM+2jfQ8xeX70K77+Vw3aHWGocus48PNPHteI4X0Qw/6++fyWoznEK6wHWNyl/YU9K38nR6RHDO8Liw5kBhp5ltFJiir139CzFSEEfPg8g1O0cJqLZhRgmTugpGsMfb7z/j2AbAOFwzdMdGqxOhRFK5Yde8K8YxCqTIoqVj8Be3YFssugjcQUfvXqCP8Ag1PTwiyb83dDVxbptz4IgSGrYKhk1O3P2+GQuiPDURgvXjtm9IjWqXzaZIoAd2sRWjA3CoIU6lTGzMBDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IWgTG8Mr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvj5R1Y1Dz2xF8
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Jul 2026 23:39:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783431589; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ow3ueylzDqfZ4A7Q4jx1GAQKDOjhMGDqaY2Vm+GmbVI=;
	b=IWgTG8Mr31OKNmSjXFCrb/P1VK1axHybtKHVpYBQ3O3FX9tsfk93xckiQkabudckx1kcEEeEVtcuALaIyZMAos8cWgLx2jl8K3RGLO/mbMr/yNdnTAG+BorKkmgfyOET/Zk9Gv/NTqmwir2wP5Lg1yz0iaznmmsgYPq7rpnoBHE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X6dqLjQ_1783431580;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6dqLjQ_1783431580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 21:39:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: get rid of erofs_is_ishare_inode() helper
Date: Tue,  7 Jul 2026 21:39:39 +0800
Message-ID: <20260707133939.1204354-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3855-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4252F71C060

Just open-code it for simplicity since FS_ONDEMAND no longer exists.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/ishare.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 0868c12fc15b..a1a20a5ba548 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -12,12 +12,6 @@
 
 static struct vfsmount *erofs_ishare_mnt;
 
-static inline bool erofs_is_ishare_inode(struct inode *inode)
-{
-	/* assumed FS_ONDEMAND is excluded with FS_PAGE_CACHE_SHARE feature */
-	return inode->i_sb->s_type == &erofs_anon_fs_type;
-}
-
 static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
 {
 	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
@@ -179,7 +173,7 @@ struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
 	struct inode *realinode;
 
 	*need_iput = false;
-	if (!erofs_is_ishare_inode(inode))
+	if (inode->i_sb != erofs_ishare_mnt->mnt_sb)
 		return inode;
 
 	vi_share = EROFS_I(inode);
-- 
2.43.5


