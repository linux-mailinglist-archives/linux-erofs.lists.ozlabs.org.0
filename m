Return-Path: <linux-erofs+bounces-1506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B204ACC700F
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Dec 2025 11:13:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWV4c39qtz2yrM;
	Wed, 17 Dec 2025 21:13:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765966416;
	cv=none; b=VksVnrhUaHyRzbs3sCjCK8w1atntWaX9MyjP0Bnd6y8khb1XcR7VcQVX29TFtxhgsvH/0uZ7bAM2qV+4OYI4Tjipp6WUZfrhzTq3prBKLBfzie2EzXp7CQr5iyHa0JL83k9rn+h/1mg11GWf9HH+Sg3FDfEXDbA+bm47OuEojvY58chNH1QTQXeF+CSTupyXMPKL42bK0XWb2uBgAfSqvQhYUFc3tJ8cwy+X/b5iuIEc7NRIoLqfQYFHR+fYzMvmq9bNftrP2GFgHZ0vipzhGzfysYP7uhd8bflwvHKlgz/bb1X9SeTPObdd1WjKGkzkvgnQ/oDv0QUtYEDgfvW5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765966416; c=relaxed/relaxed;
	bh=65vk8XPmA9E0WnIcrU///VhPn8CL2lAhWdMdLsav+IM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nRVtPDUf9JZoggYy5a62PLn/J0JN2pK2QbpYCvNQLmluu0KwupqqYieDQ4bvRRPBMQ/88dxdT3iYUeBZSCHHwjvfqzupeSnlyXnVgxdBHONCyrBcc3tp/b0YPpffZVry7H4byX1aFOcih8SIEikGMe1ShC+TMF2spSks4tILmTUWFzYlcnr75pOfgDEQEsY/pahSCSXThU+qfkwFa9NRdEp86p9z+aklfoJmRV0m5UFEVAEqdKOudzfc55G0ke1J7qK3+/kK/x1a8Gl8j+8Ulg7dCM7DM3vmkmwqd7kqpYekhStYeFiyVS4KyIhe/dw/HIoZeCftaf0/pxVJCxR7MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=CPBNLoBu; dkim-atps=neutral; spf=pass (client-ip=162.62.57.64; helo=out162-62-57-64.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=CPBNLoBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=162.62.57.64; helo=out162-62-57-64.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3375 seconds by postgrey-1.37 at boromir; Wed, 17 Dec 2025 21:13:32 AEDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4dWV4X4ys3z2yqT
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Dec 2025 21:13:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765966404;
	bh=65vk8XPmA9E0WnIcrU///VhPn8CL2lAhWdMdLsav+IM=;
	h=From:To:Cc:Subject:Date;
	b=CPBNLoBuUU7mwjvchTW00CAx0RwkxlHyuylCKaYdO+hKrBNzB8JMtVBJIiQ0d3qm3
	 wfD2+mMm5S6QPJuXu3NK1IUR6kUSGbJE70mEa8bDBkS8OBFMfIBngSmMuK8zymiwUI
	 qu1MirjP0hyTw0EdtpuEw5D6vbYKwGluEV6X2U9w=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 26891639; Wed, 17 Dec 2025 17:09:40 +0800
X-QQ-mid: xmsmtpt1765962580t04h2sk38
Message-ID: <tencent_CB6FE08BB14BB368855B6D7CC515EDFC2C05@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfpcOe5t585zGNl2qaBwieBCToh8zU2Ly1CywlEVuQDvrfwWuKqt
	 Ad4d7i6Z5EhfcYoLYw2bkl2wF39s3DgdAAshaP7DlQsRxLrT6C/zmE3ldU0WQ7tqch37juT2p6wB
	 qFmvnmUuFI1mBv2oEPm19Yd/lEedSBykzVcCz4faJ/y3+L5KlfNBPNmAXompJL53wa6bkN/MnZwp
	 D+P2jdB+ej5clCTxiTFB1s+VbBKFzW0CQCTBZXU/YVIJql8sIvtQUrNYOOyLmCnR8Dpg0mB5qiax
	 Dc0ycEWPtFf2QsLVWHojQ2HxfN2JW6v0YwqPPAwxOSUT58wGq8tdckTxCOxIobtrTWfP3mX3mHCM
	 HTS6RQtE5hbww1H2iFUXu0h1g6DCixkIwtTEGlO/zzAaBESTeZVaRjfzp7HU00CbBlmfpcICXXph
	 doDzhJZsmJTv4ZiMRWRph3RMMfq52n1Q/6sSa/khn4JdoI2W1gs5Fy5dRoCqE23hCZbfmuRyKfdT
	 1Qz/f8ZwAIE/VsGXxOA6gP7im1TDlOKe4ZCYvLFgAXm3tcRK/O5QWD8CP9Zjj3h/I0oOnQdVsmSr
	 v80QwMrIuuRMFGjfNCgcDhnBIe96kg5X4mf3Ijuzn+yHpGLa9C6cXCn8JK+yTdJUtJIMYXTjz7k6
	 jzn1tKXOIw7Jb9ryBCZj16Jn0Aeh9vq+AmJPqmG+8zWKMdEfNp4d/2WXa9oCIRXfGi6BLorrpdyN
	 ygUeibtKRjz6elhTIfrV/FgmjcQaJ8Xh6Wf0KOEQ/HSv7Ib7G/yFXWkFUJNrw5Sy8QAvG9XdHBmA
	 /0B69wzy65LY5xQG4MhQcKq3c+vMNJvFgWRe5zAfmJxjlsqw/+egdpp8K4BLpkgsKT5CClgk5QUf
	 G2QZ1QzOs6CarQTg8eqyZVJ7GfrL57lRxQVlWY2E5HQohBGWHm3WajZpUhXP/kRPAyWipw8lK/D+
	 buuQZANvT6BVQW15wkcahwEWWN16OOHn4+4vpww7llWvM5RI2gflegtL1PEqRP/OEOdz2P+bx45E
	 ocm4KgzyUFlloAplOx+W71FSrenQDmg+Hh+3W7weheAwOlfwtm
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH] erofs: simplify the code using for_each_set_bit
Date: Wed, 17 Dec 2025 17:09:39 +0800
X-OQ-MSGID: <20251217090939.2814708-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [162.62.57.64 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H4 RBL: Very Good reputation (+4)
	*      [162.62.57.64 listed in wl.mailspike.net]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [ywen.chen(at)foxmail.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

When mounting the EROFS file system, it is necessary to check the
available compression algorithms. At this time, the for_each_set_bit
function can be used to simplify the code logic.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/erofs/decompressor.c | 10 +++-------
 fs/erofs/internal.h     |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2ec9b2bb628d6..93e7ae2e363ff 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -405,7 +405,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int algs, alg;
+	unsigned int alg;
 	erofs_off_t offset;
 	int size, ret = 0;
 
@@ -416,20 +416,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 
 	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
 	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
-		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
+		erofs_err(sb, "unidentified algorithms %lx, please upgrade kernel",
 			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
 		return -EOPNOTSUPP;
 	}
 
 	erofs_init_metabuf(&buf, sb);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	alg = 0;
-	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+	for_each_set_bit(alg, &sbi->available_compr_algs, Z_EROFS_COMPRESSION_MAX) {
 		void *data;
 
-		if (!(algs & 1))
-			continue;
-
 		data = erofs_read_metadata(sb, &buf, &offset, &size);
 		if (IS_ERR(data)) {
 			ret = PTR_ERR(data);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c69174675caf7..c34cfcdf1e401 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -126,7 +126,7 @@ struct erofs_sb_info {
 	struct xarray managed_pslots;
 
 	unsigned int shrinker_run_no;
-	u16 available_compr_algs;
+	unsigned long available_compr_algs;
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
-- 
2.34.1


