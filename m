Return-Path: <linux-erofs+bounces-1511-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D653CCA2BB
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 04:26:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWx0R2CnVz2xpg;
	Thu, 18 Dec 2025 14:26:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766028391;
	cv=none; b=IlpErTnTR8aiRiVkeMCdzELf8k3RkFeiB6jE6ZLg455p4WdcFQwV7jeHTe7S3o2HUDMBfZUWZOW87Q2FlEUzOfrPen3BqLdhDaMpICf1th8c71YpRfbItmAI7K2pKDODjsf04kjH0C43v3jUq5BBLjtK/KEDO4MzbrWuqaW3tkszSW0D232kx/C9xHUoH1DfqXVjIxIcBuCqPiBQq1aqQjcPfqg+IHQHoOJnfaIcNkTyXSJjEM1HGccMMTcHbLfZitJdHR/b3IMfG2UdX+AAQ/zaakNRQgQd6hcNiB+Ya2R65sRc9UdbAqNx1iWaY3ZakQXcZ9en3OiW1Glrjueu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766028391; c=relaxed/relaxed;
	bh=bAdcmA8CvwRhTQpBhq5+riI/wTamEHCQOUhPZkS0JVc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XY7KgWIc8gLUB8hzyc3TAv9qD5Gn0QthN65KPqnWsITP+iaLPVb35Ot5RTgy9+smimJMWx4VIkHCG8WIgi3L9qPT9yc8TCZSC1buqS1ku+ty/M0FmM+Wq3/TPGflQXg1gHcKlo7vsJLNtEdJ99TC2jb8wgLKetQ8ORG/hdflBLz3+F6mmQH3fMaff5DawhBpCphLWoj7QWOOdJWsP3iLnTC0pQeVRDIiCZhODiDGC9I9oaIltz7/D4cVlvEMbqzuHzRc5SkWUCFWfIx9xo/COLezGbvbGC+b4ewgiTy81/GleUFA4DBGL5599ql7XR+5S49cF3mr3KXTuyt/N14BwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=uAcNiqLn; dkim-atps=neutral; spf=pass (client-ip=162.62.57.49; helo=out162-62-57-49.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=uAcNiqLn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=162.62.57.49; helo=out162-62-57-49.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4dWx0N16p7z2xDD
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 14:26:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766028382;
	bh=bAdcmA8CvwRhTQpBhq5+riI/wTamEHCQOUhPZkS0JVc=;
	h=From:To:Cc:Subject:Date;
	b=uAcNiqLnMRy6HKVlQVn8GyV6UHjXpoIsSsPX1WyKGGGJTPUkqPvX+KBdp6PSMWDtp
	 Yb3/kdiTuoEIVx5rsLjxIEIUTKihg58Berc09w8J5HaOwQSAA1GUDguWNBxfb0D8qL
	 iMNtL0Lmp8KFwxmyVoBz7/iQBQQNjjCjF6aFHmfU=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 4BB1741C; Thu, 18 Dec 2025 11:18:59 +0800
X-QQ-mid: xmsmtpt1766027939tkg226rvk
Message-ID: <tencent_D4F8982BC9797B5EE01759574F512CF7E506@qq.com>
X-QQ-XMAILINFO: ON4JYNczNu10xLni2mZ47bEz3+euTrmIk4DBqL8MooDVnGqNfWNTJ8Z/GrBizZ
	 1l0Jr5nv8kMMLat8zGlknmpHHM0Dw212Z+H1G1so/4CrSWsyeZ3QjLGI+ubdv2a7i9O3eo9Gw4NV
	 4bgMj5z5N05CfkRDjlGMMW7wavlAhRkMT/Tg1INdp6o7bS6I+kIHynn3uSn9LEXyDRvVr1xIhlCy
	 WD307IFVGSCLnRNFiMQH+omgEiYbzH+uccohqqy9cFCnXHsBCi3s0KMFuh0WEjN74P7G8Z6bhlsn
	 4EmhAzsjQisEuV8gaAyZJuS29VSg4iFhhlcm68/e/z17aroeIhE93hhnqgBX3n2c1/Dh+GRsDu8M
	 e7MAn6fS40VAazxOTfL0EpFs4xv52pPsQzZfk3WsFGQPcFqmrgyy2vBdqmwUhMjxAvzvjcVdmHuG
	 TpixJ8C/ChencTa56eByrOOY2XnLNy10KOYfnYnyzRwAw7LOnoN0XlovwKmcrL43Fwu8LFnkcUwz
	 Pp7KZU4k3dg3tp8qvcVGUobkBqnn7UGt9xG7YocyL0x5dH372XBu+2iEW+tfIFKJkMWt2acUYii7
	 yAKkECY+TAcr6f8cRG5Yjz7Wmyy5GDClxBNE5y9+XxFQ7VExQ+TDikaDcatuOx0XbIJWE3bS8Ap8
	 OHdQHBGv9XZBrGtE99y5iezLe6oTgkAEGJAGIimlfGKAS6kwsGBpZLW6Kf/oB9wZb26t4WGo1LTN
	 hwgkAz/oLBv7zOH+s8g8uxDB5zKifJ4R4MD3P+CuCdbFMkilh11cWkjCFZZGN/4FRzX0CQBktk+G
	 u9HoRCU9j9cIglte4Q7kZFgaioGe1r5APEJi3lSElE3nUM5/D7+drqsDmKuw5xPadoDaLlOJSe9r
	 IHW0TGj7MOYo5s5me6BQYKUjS1v74GbTSLrt7h0ZpBH2es7b8mRzEpSWihmbIB322LopQn+NqRfh
	 IizOXiEVs+ZbojZh8jAfiyLnNOaalMovC4v/aXMDY9HAHEO13WI+QnlQsI+K6S8VSJXKJ/v3ZMhJ
	 WtJn4AEC0E4PvSuh6MP7QY5q5V7zPFnYjwHOGtbOQHQWJAIxsda7DPkcfGa8119Q6R2Q8FKg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH] erofs: print the names of unsupported compression algorithms
Date: Thu, 18 Dec 2025 11:18:58 +0800
X-OQ-MSGID: <20251218031858.2864347-1-ywen.chen@foxmail.com>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
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
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [162.62.57.49 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
	*      [162.62.57.49 listed in wl.mailspike.net]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

After simplifying the implementation of z_erofs_parse_cfgs, the
names of unsupported algorithms can now be directly output.
Moreover, some unnecessary additional judgments can be removed.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/erofs/decompressor.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index be1e19b620523..866bd9158615b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -385,21 +385,22 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
-#ifdef CONFIG_EROFS_FS_ZIP_LZMA
 	[Z_EROFS_COMPRESSION_LZMA] = {
+#ifdef CONFIG_EROFS_FS_ZIP_LZMA
 		.config = z_erofs_load_lzma_config,
 		.decompress = z_erofs_lzma_decompress,
+#endif
 		.name = "lzma"
 	},
-#endif
-#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
 	[Z_EROFS_COMPRESSION_DEFLATE] = {
+#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
 		.config = z_erofs_load_deflate_config,
 		.decompress = z_erofs_deflate_decompress,
+#endif
 		.name = "deflate"
 	},
-#endif
 };
+static_assert(Z_EROFS_COMPRESSION_RUNTIME_MAX == ARRAY_SIZE(erofs_decompressors));
 
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 {
@@ -433,10 +434,9 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 			break;
 		}
 
-		if (alg >= ARRAY_SIZE(erofs_decompressors) ||
-		    !erofs_decompressors[alg].config) {
-			erofs_err(sb, "algorithm %ld isn't enabled on this kernel",
-				  alg);
+		if (!erofs_decompressors[alg].config) {
+			erofs_err(sb, "algorithm %s isn't enabled on this kernel",
+				  erofs_decompressors[alg].name);
 			ret = -EOPNOTSUPP;
 		} else {
 			ret = erofs_decompressors[alg].config(sb,
-- 
2.34.1


