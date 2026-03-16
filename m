Return-Path: <linux-erofs+bounces-2769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHiYJOF3uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2769-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C162A1080
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:36:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZT1S0Vxnz2xlh;
	Tue, 17 Mar 2026 08:36:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696988;
	cv=none; b=Y+b+cI50T9Q3rfOB0eBMby9SsDozJmf3wHThaQ2ErIhGMIkWtKzpH3Gb3n4OyEPQ2kLbpxXCP2/Utzqi2ukV2tg46wYmGVKFz8vrxbutvLNjDuafCNO/Vju6MTY4cXQjdd/kFkhYh/OVL7eHEAM4fV8jMc5JX269PPXZLsAy8Z9t1OfrcOAzV3wR0gS5UN5pouwbmZJmiBnZhMWy9iYRbOiqnYfGrlhAXLpba0ffYx0gsduWa7Z0NNeH3kwm+QSL0tX8FXBPRGuNRLTBCpfEgtjPL/VHPnP1PLDWQ+wt9kffzWgnkrguSdtaU2CtewBvaAWviJnNvn2OR4ux1ZHdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696988; c=relaxed/relaxed;
	bh=K65XnocK8kG+6tfBdzIF+tZj3LHNhmW0Q9HX3G1TK3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXLTOdfgxIsnAqr2KUcFQ3sR1NTkM75Pt8c1nYfvo4fz3TA67p1aU1jbaGa4zPsUKj/3Bx+ooFM7jpptTQTjnTMPjlWFxFDDmhe8vBU0VNfYHgJjgyW2fwEXunHWFMV2cWInRhSLDO2PVxnjUvMYneTGMuJV+kb45hNExa0sYZDibkho+CgkCgDT3EdBaDG1G+0WIZekwaRXpL3N2johQ/fUEePxLRUCBCmO3egfXZzntmpt5Ym4oHMQr5qO5Cl/3bDKQmGy9730G1DzCwTcIzpuEcXaKAGqUJ7Pa1dGpKaoBBbPJiw8iDjTwz0N04zzw5MQgiqHT+iyFUmnunr/hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=WKQYx1yr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=WKQYx1yr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZT1R1c8Qz2xQB
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:36:26 +1100 (AEDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-8c9f6b78ca4so645235785a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696984; x=1774301784; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K65XnocK8kG+6tfBdzIF+tZj3LHNhmW0Q9HX3G1TK3M=;
        b=WKQYx1yrljAi/56l21lxI8IzKYdIaI7tGKdA/zdSyxzUxaL5WZYpMwwjnf6AIKQe4H
         9d11sRN2dI6uVocCQ2U16SR6Ev9gX8Yhx2xJ64NnFxGSn+tGwJrE5JFxLCgXAE6G09eg
         nSrPkHiym1P6v5t2LKOLbir673MsdzNywVkxdteRrhPfaDJIoeQ0djsWm4we+W3aLUgP
         O1TO6WKUjdi2J0JtVwIagFTKVV2bfm2m3d44AsOQUOP/J0i/GHSe98nuF8ad5GZdGdoP
         UoCCKA/sx9PDmGNoghSFr/o3lepN7eMp/s39D7tQUokRUk84viINrPpXhWVkIE2U3Un2
         xRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696984; x=1774301784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K65XnocK8kG+6tfBdzIF+tZj3LHNhmW0Q9HX3G1TK3M=;
        b=EUDaX9ZUL66Yut/1eak06f9dTZc4GRu63VTScN+ZnqreLNMYdiDmh/jzCPxeKkgvbh
         iilnwWStEe+tJaoXs0wD5ePHY8TlebXNLUivkOrwdAuBphw4RqA3pl16w9tpahOMD4K1
         xCdMkYBTT3W5KenShoYYNQn/4I44jnQu7J/kgIylVTWPTwAcFiSOm2s4+83JQJnuB5oS
         m7Vk4duGkXN3MNtMgQ283982rhtvnp9gKVm0vEBGSgTVcCm5H3Py9ce8P6hVMUE4LXxI
         U/jSDGVTvUuiAI+mz+tfVKK1DzhEXhvvs+/2gfRRqU4WQ5uMpbLeVQyTfVhKA0bqiiM3
         wT4g==
X-Forwarded-Encrypted: i=1; AJvYcCXaQWBMi50xhCYYJzpY6BZc+LG+h2kLvdAv9RLj/OC9vxYCsn4T8Zx4y1MhOyZTPnylehlE5pqNC2HpRA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1lCHsT/rYycH4FJK9chsrOuvhFR1JrtB15+C3z7MzbzmrKRh1
	DuJomzaXc2rxHYPFEGBqd5ZfTmfgQxDEhaE6Q5dotjOLSIY5NYwrdo9VVqkfKXaDWQ==
X-Gm-Gg: ATEYQzwQECY4AEdKtbagW6MQawMHX6d+GbKXvgxoV6h5g4aQdC5QJEnrrxBrYmtW6tX
	OVpvMaUy4YZQpCBUj2aiZWQ7TSmtS+c831CacgmD1wA0kUgNB4iVrKNrgAbMgH4SpmUNHwrOLHw
	/t1EqhXO+gDbkQs0nKuoj4QIcpnLXzkQrREVN9O+clqwMe/rMBwocSA12ZycIniL1vS7unWx9J6
	2nv+qT5BQXrwAn8l1sEFmeLrsrO9NKJZgRWNz4bkL3fKKPe2aeyIXHiP95gFWADYSD+m6mRmwyB
	O5HTYCk/pC/ODZ1HF5VAwYaA+htihnlf2LaJ6EnB341O1kvbYL7f3RBxTh1Zc6Fg/AFH0bLF4Rt
	p3x++EadMVfi3SCOTSJ8YgBgMHMMs9ysnrR7PvOFHzX9C0Wlk3NEWJSKmDMMJ1c96a5TQKH8xhD
	dkwIOkJtxz+Fvfc5O2UecFed0Jpj/+hHWpmHB/+sF+atkh3A5/20sVvQQLCKNTSMKM3hlQP8HbO
	j69/4c=
X-Received: by 2002:a05:620a:4713:b0:8cd:92c5:b3e5 with SMTP id af79cd13be357-8cdb5a76411mr1964899185a.20.1773696984421;
        Mon, 16 Mar 2026 14:36:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fc09efsm1371730385a.2.2026.03.16.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
Date: Mon, 16 Mar 2026 17:35:57 -0400
Message-ID: <20260316213606.374109-7-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
References: <20260316213606.374109-5-paul@paul-moore.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=paul@paul-moore.com; h=from:subject; bh=dX3vSVluZ2sVFC8E0ytSSXIe/yQh8rLeBSsPIlH/scU=; b=kA0DAAoB6iDy2pc3iXMByyZiAGm4d8rIUmXCtbyU0o7TJ7z5uf6AVXhPQq3cnyUX5r9tfC3LR YkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJpuHfKAAoJEOog8tqXN4lzt/AQAJQ4 93OpEdrzoe5s8FEXqefSpadTyy9aCf1lD2hYDQom/uhTtgtFk0ejVnnNHEd3BH5Ahabe1zTSkiU xFVqhuFscJLhMnMyFn0LbSScm5RLHoeG1F6FeX5eP7sA1lAIvT/mGqcwmCgl9xjVo/jHmUJNejf uBJ+Evjm6HhsjwF6PTnUUq2PPe6rIw19nBXe4kdVYPJRvA5448OWAoilV/wKyZCkwDNUom1/hQL olnRSWOw3kJrAJOh4foNnttrL3ioEghpuR86GghSrDQN/NTXwGkJ+3saoBxs0O6XAGDIdN97gHQ Q3tsRKj976wEgQmgdHGlmB3wJ32QQeYwgf8czLMeUtmH0uGnnYoeqqpKJB6Ki5yaK73ShIHWe4M a5ipcP2h4n8EfLjMiWBYTrpnlB47cvROjFTw2jguEyx4pc//qH0Tx/UzTQQaXnSv7MCsKrQQJdc 0t1aYYB+P/n56XVxbBT3irEdG4YzrR5tay6NaZwFSRNobPS+ndq3uzQJuJDR1+OC3OcfJVbKhNb fFH+nEDz0XvTvIlt95afWFahx0/brtnNXNLPII8WqXW2NVLWuyS5v+TP9ovgUkRBHpd/TBIRgJa n26i59ei9ei7tEFlHVG7ADkfVx3UHbwn5hJ4YhRtZGvpPaE/TI8yluMVcr2t7oFr0GVX1tYRN74 SLbqr
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-2769-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B1C162A1080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the security_mmap_backing_file() hook to allow LSMs to properly
enforce access controls on mmap() operations on stacked filesystems
such as overlayfs.

The existing security_mmap_file() hook exists as an access control point
for mmap() but on stacked filesystems it only provides a way to enforce
access controls on the user visible file.  In order to enforce access
controls on the underlying backing file, the new
security_mmap_backing_file() hook is needed.

In addition the LSM hook additions, this patch also constifies the file
struct field in the LSM common_audit_data struct to better support LSMs
that will likely need to pass a const file struct pointer from the new
backing_file_user_path_file() API into the common LSM audit code.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/backing-file.c             |  8 +++++++-
 fs/erofs/ishare.c             |  6 ++++++
 include/linux/lsm_audit.h     |  2 +-
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 25 +++++++++++++++++++++++++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index acabeea7efff..cfc7f6611313 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -13,6 +13,7 @@
 #include <linux/splice.h>
 #include <linux/uio.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -338,8 +339,13 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 
 	vma_set_file(vma, file);
 
-	scoped_with_creds(ctx->cred)
+	scoped_with_creds(ctx->cred) {
+		ret = security_mmap_backing_file(vma, file, user_file);
+		if (ret)
+			return ret;
+
 		ret = vfs_mmap(vma->vm_file, vma);
+	}
 
 	if (ctx->accessed)
 		ctx->accessed(user_file);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 17a4941d4518..d66c3a935d83 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
 static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
+	int err;
 
 	vma_set_file(vma, realfile);
+
+	err = security_mmap_backing_file(vma, realfile, file);
+	if (err)
+		return err;
+
 	return generic_file_readonly_mmap(file, vma);
 }
 
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 382c56a97bba..584db296e43b 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -94,7 +94,7 @@ struct common_audit_data {
 #endif
 		char *kmod_name;
 		struct lsm_ioctlop_audit *op;
-		struct file *file;
+		const struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..4150c50a0482 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -198,6 +198,8 @@ LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
+LSM_HOOK(int, 0, mmap_backing_file, struct vm_area_struct *vma,
+	 struct file *backing_file, struct file *user_file)
 LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct *vma,
 	 unsigned long reqprot, unsigned long prot)
 LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..4017361d8cba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -476,6 +476,9 @@ int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file);
 int security_mmap_addr(unsigned long addr);
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
@@ -1159,6 +1162,13 @@ static inline int security_mmap_file(struct file *file, unsigned long prot,
 	return 0;
 }
 
+static inline int security_mmap_backing_file(struct vm_area_struct *vma,
+					     struct file *backing_file,
+					     struct file *user_file)
+{
+	return 0;
+}
+
 static inline int security_mmap_addr(unsigned long addr)
 {
 	return cap_mmap_addr(addr);
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..8d10b184ce25 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2505,6 +2505,31 @@ int security_mmap_file(struct file *file, unsigned long prot,
 			     flags);
 }
 
+/**
+ * security_mmap_backing_file - Check if mmap'ing a backing file is allowed
+ * @vma: the vm_area_struct for the mmap'd region
+ * @backing_file: the backing file being mmap'd
+ * @user_file: the user file being mmap'd
+ *
+ * Check permissions for a mmap operation on a stacked filesystem.  This hook
+ * is called after the security_mmap_file() and is responsible for authorizing
+ * the mmap on @backing_file.  It is important to note that the mmap operation
+ * on @user_file has already been authorized and the @vma->vm_file has been
+ * set to @backing_file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mmap_backing_file(struct vm_area_struct *vma,
+			       struct file *backing_file,
+			       struct file *user_file)
+{
+	/* recommended by the stackable filesystem devs */
+	if (WARN_ON_ONCE(!(backing_file->f_mode & FMODE_BACKING)))
+		return -EIO;
+
+	return call_int_hook(mmap_backing_file, vma, backing_file, user_file);
+}
+
 /**
  * security_mmap_addr() - Check if mmap'ing an address is allowed
  * @addr: address
-- 
2.53.0


