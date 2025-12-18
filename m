Return-Path: <linux-erofs+bounces-1513-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D099FCCA3E8
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 05:21:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWyCj1561z2xpg;
	Thu, 18 Dec 2025 15:21:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766031681;
	cv=none; b=HYhC0wrdBgGjmwZ6w4cQS8KujfeWB/oSJCO6KpYeVvQoQevxS9BHws9mq9ljbfbuC8BgBDuZ0a+lEvlvQou/R/NO//Yl8EQrN1pcoqtcTm7YZdf6yPSAfNDTyterYyTLmXFH72WRn2WpkjYRnLuJtEkOdXY3OvNrVEZL31KR3OK/SManYfuoZsfb5JmJVzR2LVl2HlT/uY4w55ihgRHd75u5XyX/EBUXydbTYWS8WNP7kSxvKuJdHFxo3B5A/Sk93ovK3Bwj8Xu5s3mWCRI5TqjTjJU61axJpkC5vu09fq/lfKLxMTElh1kF1eUgYqWn5W+O7Q+580QK8Um2yaasQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766031681; c=relaxed/relaxed;
	bh=ctqyRaS3xeorgfkacB3KEDK+UK2W6A4k46kc16FgGVo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IUdJcmw/hSVHG47x+txJWYYLE2ULn6dBN0pM/u8/F+X9YP46WBZVPpY/tjVVVd7Jp7kXe50Cmljy5aLosbFMJutUZ4R0V+e6PkrNFvBViyOKZ6g0y6FfLKL9WsPw3bdZYkbXU4PKIuYUcZjya33JW68CBkygp1ZJDiKkHNoHqGf6wTo5zWlujbuk4a/+KETiZw2tw35nzdnzSQOv3ozy7AHOTKy0O+hY3EfcbOpI9ObH1HRRoL++Su3w9pJT2yDEQKpqhtNBCZlqMVerPUNQP/Dfoefi6IZg9diRnfEpxeOi6H52+9vFtVGgiFOkneboQSz4xM5hTPnPZues59CsdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=WiA9xmht; dkim-atps=neutral; spf=pass (client-ip=203.205.221.155; helo=out203-205-221-155.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=WiA9xmht;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=203.205.221.155; helo=out203-205-221-155.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4dWyCc3yj2z2xS7
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 15:21:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766031670;
	bh=ctqyRaS3xeorgfkacB3KEDK+UK2W6A4k46kc16FgGVo=;
	h=From:To:Cc:Subject:Date;
	b=WiA9xmhtY/+dJvsWqYLApVmPABrgFg3ddNNpvgeiQtAuio9/GaZ4q5+VUJ9YTx4ll
	 3uemtI98wtEkHRZ9Ew2zmxV7Go1BaZADJmydFHy1Fyw9rYCHGHqyuyKN05lghs+GeN
	 cHHWocrQEFTF+KKuVvlqM+UcRpAQNv9mTgXNZMoo=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4F60224B; Thu, 18 Dec 2025 12:19:54 +0800
X-QQ-mid: xmsmtpt1766031594trni6hj9m
Message-ID: <tencent_2F5DAC4517DCA2E354AE3BE70379BF5F9108@qq.com>
X-QQ-XMAILINFO: OLkBtgoOWQUP66s18j6scmuJLMgbCkg5BCjVIaRqPQoBhM37MaaNnasTzrLJca
	 wgNeD9OdfnWBpL0mnFDRQO2cYy22GTt/X314Ip9Q0Tg1u4NT15XzrhYj1MYpMuthlFZiFktkV3hM
	 pUOb6CE3s+vHttS2y2OjPHlFZW2fkOcY2//xVgQX78lfY529Y3Qsp5KOToN39q/a5rnDQ6dPGvsD
	 BduGSkkt3sksJTgckxzzo3vfBBgRDQoQcTjGfKyV6DQzQxdgui2Dvx53daha0I1S5R83HGjrWEwV
	 Tiis9PB55hTE+9V2jSqtrFvhLqSkBh1j/RRfBIywjmr/Qc453j5A5kgk2MQrvE+BTPnyyjO6HXZx
	 EIWJitfyjZWUxKws0VINcddfWslEnWPhahIStbZUn68mtMOVnKkArTdx/xGElzFOfAtGcY5X5jqa
	 Ccjwzcmun9ttepvuq41g2fKcBS65X2ggz5tI68g415XDGtBdrLl/tcGdaW29iYzlekWKIwv2IHSr
	 tg+Igm92/YDqnDz1tJlj64KqaJ00i3WEWdZAKiGhGGi7Lp7Wu4oqsE31nyhe1c9jijWR5nrL4O3P
	 gUcFcdf1a9YIW6uZWQansswDrutL97lG4nbB3B8jsAkMoYXhf79oblirDSg8mbYWeFHnz3U27V5A
	 oE6MH95S1QppgN0fmLPCrBl4jkoCxbjy5iINxRUkVIVwHoOg1jfClWmRbJMbHDZeOBhqRSNFf+cU
	 3PMVzHyopUsHvXwBM97GeIRVKCfWCWRhE6SoxTjDxgpQlBQM2yUwfK9oEBOYt8msRzT5yG2ZYcXA
	 U6dQrkIXmJCfAc2KGhc+AC+d1S2MpNn5bqlkktXS2jKGS6JNKm/6Xe/dWPUNzI5AUc6/PZ3VwwSN
	 /X/UmoqQRWAwEaTQXK+Lez10OuCfwBbJpMqMXIWDdafctgv36o5LJ5eZeASmapu67R3z+R+0OE36
	 u0Gis+gnGT6TkyqhdaWGoLejbEUuVSSgNX7NgUQ9BuYGT2TrafWtNoWCy+qIRtt0meNiKgISVA5L
	 OWEWbVlM7ApqyN4KF14qgpv7Hel4Yv3pVYFpXPCATsEDLHrGqGzXP3fKIRXyCpibpMG9cC7w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH v3] erofs: simplify the code using for_each_set_bit
Date: Thu, 18 Dec 2025 12:19:52 +0800
X-OQ-MSGID: <20251218041952.2905984-1-ywen.chen@foxmail.com>
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
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

v2 -> v3:
    - rebase the patch
    - remove the unnecessary judgment logic

v1 -> v2:
    - revert the modifications to the fs/erofs/internal.h

 fs/erofs/decompressor.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d5d0902763917..15b464a589939 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -452,7 +452,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int algs, alg;
+	unsigned long algs, alg;
 	erofs_off_t offset;
 	int size, ret = 0;
 
@@ -461,33 +461,30 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 	}
 
-	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
-	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
-		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
-			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
+	algs = le16_to_cpu(dsb->u1.available_compr_algs);
+	sbi->available_compr_algs = algs;
+	if (algs & ~Z_EROFS_ALL_COMPR_ALGS) {
+		erofs_err(sb, "unidentified algorithms %lx, please upgrade kernel",
+			  algs & ~Z_EROFS_ALL_COMPR_ALGS);
 		return -EOPNOTSUPP;
 	}
 
 	(void)erofs_init_metabuf(&buf, sb, false);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	alg = 0;
-	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+	for_each_set_bit(alg, &algs, Z_EROFS_COMPRESSION_MAX) {
 		const struct z_erofs_decompressor *dec = z_erofs_decomp[alg];
 		void *data;
 
-		if (!(algs & 1))
-			continue;
-
 		data = erofs_read_metadata(sb, &buf, &offset, &size);
 		if (IS_ERR(data)) {
 			ret = PTR_ERR(data);
 			break;
 		}
 
-		if (alg < Z_EROFS_COMPRESSION_MAX && dec && dec->config) {
+		if (dec && dec->config) {
 			ret = dec->config(sb, dsb, data, size);
 		} else {
-			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
+			erofs_err(sb, "algorithm %ld isn't enabled on this kernel",
 				  alg);
 			ret = -EOPNOTSUPP;
 		}
-- 
2.34.1


