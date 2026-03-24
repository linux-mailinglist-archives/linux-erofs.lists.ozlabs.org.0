Return-Path: <linux-erofs+bounces-2971-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNKGMLuzwmkvlAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2971-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:54:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437A3186F3
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:54:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgF363zXxz2ynP;
	Wed, 25 Mar 2026 02:54:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774367666;
	cv=none; b=SMA4yU4spCqEO0E2kUrkXI2CFNKXlZk33+ZVX0Z6nc0qhCI+/kLNcol8GjY1Pc5ApM3OE95H/Ntx6XbiIAGaAOKlezVT6ycPnvefyKfpTiAdnAGB+0BS+JrQPwdSjDiKKruNId1b3MCb0d8uAipPZYXRhvNO73NYq5HCDrj20uPm1B1WO9C8L6LVsD5BkUaA3RDfcN5Eb9YWzrcgHF+dPuS+eqJVHackP32UN+TF/sNeLZxv2Xo36aGM6i2ywH75jcuslpdEiamFDeSeCyYPuEX4UXt0LGFzbAmEIgfXfwz3b1BMaITak1mL9JvFf1C4gKKLMk8UbXukjIiVSEUcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774367666; c=relaxed/relaxed;
	bh=4hVaJmFmshKdDCM6BozTuwWtZc1MVjyP17xXKKrx3eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OosUARepwjq4nPG9oMijMC5slqAo6qGrXbBPPdBoUQ1QsEVW02Bn0tG8AK7kTvOE2DGR5R65JqQzBrAovdYSyJDi+0Ex5TtdxW56/UtqDLfKF7TdTNcggdJ777lTExNOKWd+NjJx8jFGSBvh3fzC4NYrmnjnlkNLReSIc736QdxCyORPauisjPSRmQGqVU0wL+Q4G7VJH9FwvItOFBfctc6ZF07PBP1hlmdm30e53pTXdjy+2BEDfoLESDXOIbO+m6B4NWsUYaykXiZJfEHTfRmaF1KMDBCh0ITe8xJDL9y1FiHuerPZ2Bb1VRnQzroQ9g6fL9Q5AFDcWCGXWNfw6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AOEBdCMI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AOEBdCMI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgF325XNBz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 02:54:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774367656; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4hVaJmFmshKdDCM6BozTuwWtZc1MVjyP17xXKKrx3eM=;
	b=AOEBdCMIXs16JLUjV3TRkHivZKAXGsKWfUU96FT45q+x+sRqCluJOZOlhbjHeau4RLHbZ9IjBlEBSZOfboTR7ZpZZOJ9nRMQk5/NAhSjHm6spEPDcKyophax+ND9Iw1pzOkM+HpnDlf+XFhSPVLTBCcKYeBK/ssW7fPeyo7Kstg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.esRfB_1774367648;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.esRfB_1774367648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 23:54:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: [PATCH v2] erofs: fix .fadvise() for page cache sharing
Date: Tue, 24 Mar 2026 23:54:07 +0800
Message-ID: <20260324155407.371642-1-hsiangkao@linux.alibaba.com>
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
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2971-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 2437A3186F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, .fadvise() doesn't work well if page cache sharing is on
since shared inodes belong to a pseudo fs generated with init_pseudo(),
and sb->s_bdi is the default one &noop_backing_dev_info.

Then, generic_fadvise() will just behave as a no-op if sb->s_bdi is
&noop_backing_dev_info, but as the bdev fs (the bdev fs changes
inode_to_bdi() instead), it's actually NOT a pure memfs.

Let's generate a real bdi for erofs_ishare_mnt instead.

Fixes: d86d7817c042 ("erofs: implement .fadvise for page cache share")
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - handle super_setup_bdi() failure properly.

 fs/erofs/ishare.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 829d50d5c717..ec433bacc592 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -200,8 +200,19 @@ struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
 
 int __init erofs_init_ishare(void)
 {
-	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
-	return PTR_ERR_OR_ZERO(erofs_ishare_mnt);
+	struct vfsmount *mnt;
+	int ret;
+
+	mnt = kern_mount(&erofs_anon_fs_type);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+	/* generic_fadvise() doesn't work if s_bdi == &noop_backing_dev_info */
+	ret = super_setup_bdi(mnt->mnt_sb);
+	if (ret)
+		kern_unmount(mnt);
+	else
+		erofs_ishare_mnt = mnt;
+	return ret;
 }
 
 void erofs_exit_ishare(void)
-- 
2.43.5


