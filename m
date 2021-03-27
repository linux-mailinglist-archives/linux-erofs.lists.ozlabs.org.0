Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E934B419
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 04:50:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6lGj6nVbz3byQ
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 14:50:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616817005;
	bh=mBsf4gRB163jzP3hqG+vznmpRskrdgmXc0mHVUpSVZg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=D3bRCtTLRlJbzZ8R/3Q1I/bZ+T+Ni5n5C+OowBRAYcEnwspYcVT6TVc1BhvKrbeKx
	 7tPop6Vu0kB22IrMgpErFdLs05YNp78f5nx3h1Xeg2/VlgXpKjN+FVTZm6HCB09a7W
	 YLFd/qd8pzqDGW3nCwCqdzyATaF8LZd+DzGIYRjiO/fyJlrB9fK4C63vWcQSeee4RN
	 575TQ5zyrqqAI8XwbXilEiwqchB0WGYajBW/4zd7arzlM6ALJ2vRmzZnuXGkGMptAb
	 7jfNUlQfutDQ4khoUeBj69xx+fnnzQGiGvta5BKVcLvW6aa3Hi1nqOpHD2IwgrnBlX
	 /36TES0wY3YHw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Xru/UN0P; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6lGf2PZvz3btW
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 14:50:01 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616816995; bh=Qp5fkRypCjNCWrK/2AQVdEDaHyGNiG/m0af4FZGc6ut=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=tdHowSmfwaiVhp5Kinnp+mAVviIWNjzXLJfaG/BrAtwQxbxjKQm0x0S3ByDgH8MuO1K3OMHZE3Ta4wn5OrZT5NR7y2IY+aMbGu0Jd2+U/UxxtYcQVmONWE4g6gO+KgaAXYDQGKpJlljBsZ8AP60fwWZF7eQ/92I9+DMFcADbce2wCc8X8caivn14gd3e+aIIf+i3Mrb28g7hF6WQaerYXYI4oEmhcc4FQyobJMwVVcxuRp5N0tkxJnfH3S2MA250EzbOju28XvJL2lHYR3X3yn//Bav4FNywARppz/cFnGaJRtQq8aCTo+aSQUM/RWsDZMTgRlUtIuFiK19gHvVBAg==
X-YMail-OSG: ker.ajgVM1kfS40rafrrRXLTelQctl16Mm1hcdEZkKOYt5OgFDjF65aw40R633_
 Y2oFgAs6th12RTbQ.zQZQsnDfeoPaIGc4iGIk7WDTdw9ofnFd5PRZBC6SCC_n.mZTpBxolX8l6Ct
 eEHGmIokAEK2YsDLVKv4lUKmSWnMGvgFeDoEAb2PbelB9PnuflEl3omjZXwSBs7AiqMfNWW5Grrs
 _ShGkpI0A73ujgYxMGAfJnRgrgnMUSPONj0KD0zG76orye0ARwODaahI85hG0_IaaCyWYTqepUGa
 c1lWEPkBetiiHEs3mcWOndqBhQk8agvD7jZ5XAjIsBPopLlfZqD7VPF1fndkmQ5zDvHmagUzPN.5
 GGPuqeWDk.GuzEqRCgTcZMJGv8vvwSbQuEmmd0T8dQt4nAx.vRlVl9N28hwbon8oTqCTSl5hLAR6
 dgjCDjoGl6KDw5Yki5br29GrGcTPdp_zhThdF81NInGyePhklOY6TVOl4hKZUIQqxAC3CtJFHejj
 dWseFJFA14LjiPJ58RFVSgOE45mTUA0aDpEuAbUD9UDo4emRpCr8sVJPLf1VBeZhJWqTQNgDzgjg
 Fw4_ISO20gOKTdU063hvys_.QDLTxXE1il.YB39mgKGOXk9S16g3ZzvpCZRzCmxIQCUD4RNB67Kt
 KxWAzy49mpaJSGRTiCE.8WKjSqPUIArkPCoROYYYZf7zPaqGPKYKptv3iC8YhFBGNAAjJ0DGS5MT
 7ESM2wfRYQzoVxJaHCIBrwFR_WkHmGep8z4LVmgvxFW6AxdB6MnQbRp135fsfkl0MBCMCP4c4jFa
 uqo0SvXlxPx.822JRkH4mr6GUjkZ_czu2LAY0aOPoCb6Vl5YEK4PP5_bRdg4XgZAA4jXEmc9yKZ3
 BnbJEm.K5j6UIDpmWoRuyQvMQqO..iqY0twuFYOlxHKaJZRfE81Asz6pgBU3u5IccYfdnxd3thn5
 fElkXg2bqZ91wqxj8UD7tHePrTmQtNA_zGvjHUtmyrRo59NXrbqHa20MnqwbQ0GicwYyrdovVgfB
 ku1cSe2ibrVXkIKmmN8V2LUzzV3Lf7ODUjvKCUuQWU.IJwes28ubH3XwKPyvM.i3wlVgwd442j6y
 EZA84aJOoQxI84PTfH.dQZdu92iPmuUwDkPYefF5xEVPxcLNqKBs9Y5nqtgogjPQoWF0t4_3V_uZ
 BBJ2jsbIFtrZLPnKDqtcu.EOjekLCLNdDEnYj4Zi.CVAYe6Aawo1RuKQIGZTmZMIH0_8KeIHCgjD
 R6OQf_5QuFeVLARIcUuTAXrbOBQxlNjTXM0Xb0b1VKSJlBU.6mzlArrScwdMC46BgAFmzWjtO1b_
 5TMUF1vzsKu3FdPrkG79XuW_G2ZW.zv5TuH6eam.s5RE88HaT8wW3fZ2.M.b1uBBewI6yOe.__Vf
 U_7xjHT6sIN0PZ5AD8..8pSjbK6eqy4flUpGlV.hbcDpcDnteaewPFmpihmjCqn8vUL4_N9r9KaK
 qlYd77Z2y09Uxce15yzgT95Q.QKzZoDgc1gcfJSWy_ox54iDzi2.UI40Pnxz8PctwLFou8fljS9W
 g7TnhxM9JTh6UsuQ_gIJNSCSjv88uAuMLyMv0CgTFvX717FkKDsz5nHbjqTD6gZlcyhMl6jP2ji6
 UsyaXZQprR6lxUxyCoN.cylboBxToe5dQ2oCtWJMfFDewG9xkRxVCw0EtxaqFMLl_vMY48WYFyV2
 VQzF9m_2_tPwWNE1lFpEenpV_zqyJyU7V3LktTRWH6F7xVW0U56QekqF3MzzyxEMQ7NkcwiYNMZL
 OingJSlO1mt8DNfqaivYuX6T_fTS07t0kjlj6JimxCRFeCzjFaYhlXIvh.lj4Ohb4sLGc1VgTc5_
 lbEVbkGW21QTDODuP0Y9ozSk2CsU2Flb9kUgHzs1uj5RpgNiuDi4X24vzEYlB3xJb3c1SXlS6Lsg
 fuYFwHDvZay3Z.peYc5hIlMY5S5Bd.3cvz00YzkjRFrRMmKkfoVq0fVFf.eWmtV4XaoYms2iUzy4
 .t1pXhze3wHoHNXU8pjSGth4gBGh6fbe4C6uQqTu0voUBBxX0Ygx06bUQNABrjQgRI.CZQQoFxKx
 IdS_ttFj2a9B8i6knNJnxQBQiikxjJBtkBLOJgEhmpxtMEeKkx.TINHOt9_WVs.e5BM4nrZlfW0I
 I_Y95x_CJ0hK9ojXpesPRBSMskfkst_CLFpxfLHp_1nXQrkI0JIJLa_oW4xx8TbMiElhfb1AcYLk
 O.qDJC5Pymyu6B.PQ7F4_.fVRtO6XHSQNcWAH4nB7T3xOaKHXwx0DpKf_anyd61JYAQvQA3HxorV
 SRDjjzGPXneuNdObF59QjAT2lXRw3MmKML_Ibnyr9KBnlwkwGN6UwCFzdIvXDocicVMuMZzNLa98
 bGOB3v0M914jH5hq2x.8Jrt2JKPdshmy1I4M.CFFervYgwWzNbRAT.mCsOVap9SExBwp8N3TlnTR
 cRatczrnkpG8scA1cFHQMoBR6rzP4qCEFXmGouWtOpZi73TKtdhA4P4Z_lW5MHBRw0k_eFFKTfZP
 bO3e_qEJvxL6itKCjQkl_DQu9509.vewoZQJJOMzI46sC_yUivVs8heofr9ckF88mAz9V8mpvCGf
 mQ8PhNjZcZugcmNw6iEFTXjWyd77h51c-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Mar 2021 03:49:55 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID b79f63fb2a60f2e9a0e41858735ab882; 
 Sat, 27 Mar 2021 03:49:53 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] erofs: introduce erofs_sb_has_xxx() helpers
Date: Sat, 27 Mar 2021 11:49:33 +0800
Message-Id: <20210327034936.12537-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210327034936.12537-1-hsiangkao@aol.com>
References: <20210327034936.12537-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Introduce erofs_sb_has_xxx() to make long checks short, especially
for later big pcluster & LZMA features.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 3 +--
 fs/erofs/internal.h     | 9 +++++++++
 fs/erofs/super.c        | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 34e73ff76f89..80e8871aef71 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -124,8 +124,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	support_0padding = false;
 
 	/* decompression inplace is only safe when 0padding is enabled */
-	if (EROFS_SB(rq->sb)->feature_incompat &
-	    EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
+	if (erofs_sb_has_lz4_0padding(EROFS_SB(rq->sb))) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 30e63b73a675..d29fc0c56032 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -218,6 +218,15 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
 }
 
+#define EROFS_FEATURE_FUNCS(name, compat, feature) \
+static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
+{ \
+	return sbi->feature_##compat & EROFS_FEATURE_##feature; \
+}
+
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
 #define EROFS_I_Z_INITED_BIT	1
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0445d09b6331..991b99eaf22a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -149,7 +149,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
-	if (sbi->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+	if (erofs_sb_has_sb_chksum(sbi)) {
 		ret = erofs_superblock_csum_verify(sb, data);
 		if (ret)
 			goto out;
-- 
2.20.1

