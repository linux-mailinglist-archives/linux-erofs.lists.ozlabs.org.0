Return-Path: <linux-erofs+bounces-2150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMJKKDMrcmlueAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 14:50:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330767872
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 14:50:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxjBF3gTTz309S;
	Fri, 23 Jan 2026 00:50:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769089829;
	cv=none; b=CJgoDL+CR/TfUUUkKrhPEEol0JYmT9XL9daKwgjU+uTxMZwEbKDatHYxwH7jmNjFL9ja91rwfyLVZ85oft0K9U/AeQjn0UWZZdPl3FXJ9fiyLtw4r9XJCZhQYVCC6UPr+2oZ80w/ta5tw1hzAs0T9pcQe+5KyO3+77hbr0SdaxIfkmBdlt9qXcvoxUhmnWz6KrTq+ZGkfLa4GN4UmoWk1g9HZGFOIh9gSKhuek85/vDP86QCBuqj5sk9lce5ICq3T2gDXpegpI5smAaOSSvbDwy2RSFcQc3V+vnuSMQbNABHbp/10+lwygWc3Iw2G2wk6W1gfmSSjD+EqB7BgrwNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769089829; c=relaxed/relaxed;
	bh=xAa8T4/dhzGgisIp59i8kaQOP1U0tmXz+haC7atdmWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Myiq7ZLkug/vvjiSRF0Xplo8DS/veLCeQRV1gMPmS1iKuekhfBHaWVqQdyIPS6RZP57FZh3xufG3OFJKyqeodtFgcHmdzBzXfAVffkF/wECSCQYpOb2I0ieaR3c+GYNjp/UW20gSUG6Ih0wa47folQyxHAj74UNM+ha135vL9aRpE8j8tkm/gAwnugz/NLitnCW1TO+1veJbXJcOSaA0X93GoaDS/mG1RFVBycz3tOUObyyXHzK03HElKifHOUZywfYvmb20L3qEkgHtt/1tmrGRJaoazJ1/eONcrLOu0zfYZGCNm/xyKM0N/tlMYTwp1bRaNVRIgg+Oz5G/p7bpCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nGyTQUOZ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=nGyTQUOZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxjB95SfWz30M0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 00:50:25 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xAa8T4/dhzGgisIp59i8kaQOP1U0tmXz+haC7atdmWY=;
	b=nGyTQUOZkihDPX/H39dxjz4qbnBOfZ+xZmMLdT4k5TyZC+nI69xCtxLut8rmURbCyeAAYq2Eg
	FClX5fuv4+9GKtTe4A9FLJ9m/m2SiDuvusXcvu9d675c55J9CeSIEdehWmlWtUZeMFEks7Ov9YU
	oXb9AAZh1fr1trqqWG7OBzA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dxj5K70sWz1T4Gp;
	Thu, 22 Jan 2026 21:46:13 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 50F612016A;
	Thu, 22 Jan 2026 21:50:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 21:50:17 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to set the aops.
Date: Thu, 22 Jan 2026 13:37:12 +0000
Message-ID: <20260122133718.658056-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260122133718.658056-1-lihongbo22@huawei.com>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
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
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2150-lists,linux-erofs=lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0330767872
X-Rspamd-Action: no action

Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops,
and using IS_ENABLED to make it cleaner.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/inode.c    | 23 +----------------------
 fs/erofs/internal.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bce98c845a18..389632bb46c4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -235,28 +235,7 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-#ifdef CONFIG_EROFS_FS_ZIP
-		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
-			  erofs_info, inode->i_sb,
-			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
-		inode->i_mapping->a_ops = &z_erofs_aops;
-#else
-		err = -EOPNOTSUPP;
-#endif
-	} else {
-		inode->i_mapping->a_ops = &erofs_aops;
-#ifdef CONFIG_EROFS_FS_ONDEMAND
-		if (erofs_is_fscache_mode(inode->i_sb))
-			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-#endif
-#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
-		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
-			inode->i_mapping->a_ops = &erofs_fileio_aops;
-#endif
-	}
-
-	return err;
+	return erofs_inode_set_aops(inode, inode, false);
 }
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ec79e8b44d3b..8e28c2fa8735 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
+static inline int erofs_inode_set_aops(struct inode *inode,
+				       struct inode *realinode, bool no_fscache)
+{
+	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
+		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
+			return -EOPNOTSUPP;
+		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
+			  erofs_info, realinode->i_sb,
+			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		inode->i_mapping->a_ops = &z_erofs_aops;
+		return 0;
+	}
+	inode->i_mapping->a_ops = &erofs_aops;
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
+		if (!no_fscache && erofs_is_fscache_mode(realinode->i_sb))
+			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+	} else {
+		if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
+			inode->i_mapping->a_ops = &erofs_fileio_aops;
+	}
+	return 0;
+}
+
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
-- 
2.22.0


