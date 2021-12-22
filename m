Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178047CAEC
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:49:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbpy4wVNz2ym7
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640137770;
	bh=SCVjxpx69JqQRUPBVZUdJptjdb+SR9S4a1qsTSMJNJg=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BCxOiFCzJ7iIeSQVmmPRLw8N+p0s0CfPl9o6i8o5QGZ8U/GfEJQzSTIebcumr+8zS
	 cRJldpJaEHjQUhV/tzJZAUb8B8IOqNhRIBleiUqf/nAIJbxp0QvHL+51ITVfEzHCrf
	 PVw7QYoe/eWi1I3hWoPz6FSZu+cStU36O1OqV4Lqkac19G8ZyiEDhJn2Ge4AXYWBCn
	 HGcV9acZVZ/2/E7Kgd3vsWbXn+BkJKlmQwkHi61Qn4GhPCyZp7bFYlG4DsPqymMC/6
	 WcrHvtkPyVW7tCBGkcl7fMXNzksnTTgUV0n+0r4NL+wVNBabcpB80c8IQ2c/PhK8Ec
	 TQNfXEE7ljaPw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::94a; helo=mail-ua1-x94a.google.com;
 envelope-from=3iotcyqskc0kaslyrvpw6tyrzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=sOf5l32N; dkim-atps=neutral
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbps1SPNz2xrP
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:49:24 +1100 (AEDT)
Received: by mail-ua1-x94a.google.com with SMTP id
 e19-20020ab07e53000000b002f9b403017aso414953uax.16
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 17:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=SCVjxpx69JqQRUPBVZUdJptjdb+SR9S4a1qsTSMJNJg=;
 b=a3CBqWpyzQRV0Ywz91KRsBLUdLc9MI2bip4YYZNdlkyRmmBLEYGY233OXfSMTbDklW
 W05MtYufyp0st66sklnqJhnXTIXO5uEbDY0845G/LPXPEsT9lIstuc/pvaWZtiCtsC/a
 dbGYGcUUddyeZax3HXROW3mTn4+49tsjnHYKAbg78zLBpj3CcWad/USMTVQtXZRU6Ie3
 /03vXSNkwcHIHiTkLe+uKI4naoHnA1YDkkicHMXVdSJ5doe6OZOj5+S8ZZ/IKnBXJ6kI
 d+0Kg3RV62traVvuC87TbmPUmjEfxbPYB+A3bBosnJGrwwmvG1tM8kNcKQbotzNZWkgJ
 Eb3w==
X-Gm-Message-State: AOAM533vK5Beks80x3ddXBNpvi3KhrPgxyO+W4hpqj5Omeyc3f2BdxSM
 kbT9XwPV11Oaa41Eg+rIf+yQt0iCdmiTa+3bs8bSnJMysxKgWjN+01Mtjuc5rWgo+PR9yFhFJpq
 qdhHbmcO/ohp9LKpXkQNouzcPDtqzGjP4oRMHOGqy8zkxtJHCdMnlir/vF5imd8FfgTh7VPeMXH
 3Jh2Ag7ZM=
X-Google-Smtp-Source: ABdhPJz5qfMKUciBNq0QC4VwBtocbHuoWOcM0xx8fhsuYvNOab/Gp8/et3BTDvpMyVPr1A1olV7tFNP516ckvu5VEw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a67:cb0d:: with SMTP id
 b13mr291398vsl.81.1640137762092; Tue, 21 Dec 2021 17:49:22 -0800 (PST)
Date: Tue, 21 Dec 2021 17:49:17 -0800
In-Reply-To: <20211222014917.265476-1-zhangkelvin@google.com>
Message-Id: <20211222014917.265476-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
 <20211222014917.265476-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 2/3] erofs-utils: lib: Add API to get on disk size of an
 inode
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Marginally improve code re-use. It's quite common for users to query for
compressed size of an inode.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c              |  4 ++--
 include/erofs/internal.h |  2 ++
 lib/data.c               | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 71b44b4..cdde561 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -175,7 +175,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
-static int erofs_get_occupied_size(struct erofs_inode *inode,
+static int dump_get_occupied_size(struct erofs_inode *inode,
 		erofs_off_t *size)
 {
 	*size = 0;
@@ -291,7 +291,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 		return err;
 	}
 
-	err = erofs_get_occupied_size(&inode, &occupied_size);
+	err = dump_get_occupied_size(&inode, &occupied_size);
 	if (err) {
 		erofs_err("get file size failed\n");
 		return err;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 947304f..8f13e69 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -320,6 +320,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_get_occupied_size(const struct erofs_inode *inode,
+			    erofs_off_t *size);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/lib/data.c b/lib/data.c
index 27710f9..92e54b5 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -320,3 +320,24 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	}
 	return -EINVAL;
 }
+
+int erofs_get_occupied_size(const struct erofs_inode *inode,
+			    erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		*size = inode->i_size;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		break;
+	default:
+		erofs_err("unknown datalayout");
+		return -1;
+	}
+	return 0;
+}
-- 
2.34.1.448.ga2b2bfdf31-goog

