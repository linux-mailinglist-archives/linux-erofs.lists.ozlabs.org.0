Return-Path: <linux-erofs+bounces-1512-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6ADCCA2C7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 04:28:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWx341FLTz2xqL;
	Thu, 18 Dec 2025 14:28:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766028528;
	cv=none; b=HMU9hiITUiyPnIk8yWJRL3gc1iKWb4j9YwR8BAkFsUPn68X4h7vo+Pkl9Up1Ry2ITQtdOxRzVOSaZlfw7s/N2d7oRV/ZGVTp6F6nJREBKMQkH9uWR6rTbm+spJ+6SCaVCP/s3sO992fLXBk7dLhnw0aZwZ48fUkPcn/NrLmb3pldsJrcXdtrd0PZcBuBBbeSqUevdnsSLGh+cdtgCf5cZaw+Qx4jBpkRrpnz3g2vuypKDh+XfyMiz/PQOTrsiuaEKqI8T9IRuN2fvEHPpYjoEQleVatrwN+EzXevkrwTJTgkbRWCVprV1CYE2/zlOsGb3LWvmPehXYt6GSde/EoSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766028528; c=relaxed/relaxed;
	bh=o28QEsHhGcO7wQDXuYXlbUCSabm5UXZunnyQ5RtJ2S8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=J07L7/JRpRVcwe1L+AnvHGrv6/OLw3k5El9OTaCtA01O6aGgaVYTCngdPW47aquJH1nhuQMrQTuO9UsnybFid5WJBWtnl5cgy0Vca6T0tQn+w1Skn7XGIsZrtFPK3q9TIygj274Xvmru9nq1svDFYhhtYyhUpNDYNzEUeEd1NARkYSGJ+8m583NoEjsCwu8a+bsfKRkKWDX6W8IhZZ/UDTQPKn+uV1vzXHqWnateOkwublU9FvbaUJzwGNuwGTQKhmZxs0jHcm+4R2FPIOukjjbZn7ka9iqVKL/0Wr03bATMKCG+f+9M9xZVe02TR/vlY8UrqixLCEmUKMxi9Dm6nQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=PDWXfVoL; dkim-atps=neutral; spf=pass (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=PDWXfVoL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4dWx331KvYz2xDD
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 14:28:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766028525;
	bh=o28QEsHhGcO7wQDXuYXlbUCSabm5UXZunnyQ5RtJ2S8=;
	h=From:To:Cc:Subject:Date;
	b=PDWXfVoLdRfq0SCXU7FV+Ob3rgU1j6gudAGY+aB7x+TDgEfbI+HWYo1TGRjMgVMT1
	 NiLx5pGOEdjAhE8ONORv+PyrUQF72Ok+IWiAa7KWuJMyrIDtQ3RsE2+BEQvBQkoagr
	 2napQeKWHv8u2OLjEZ8AykZ8e6EJLl8kRXook774=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6DF8807C; Thu, 18 Dec 2025 11:27:31 +0800
X-QQ-mid: xmsmtpt1766028451ticvcafm4
Message-ID: <tencent_22096EE17176D799F3BC3CA9AFF62EA0A207@qq.com>
X-QQ-XMAILINFO: Nte9/BsRzcszBFeLXhxxh18xc4dQYK4Bwnu3A3xEDO7VqjQZWP67FqdYr28SvW
	 GR7bjJiw3SZBdyWjeyj6LQSLi8K9fKbPSQhaJOL7KfckOKe+cCaXagmqImVH8F+l6ZoErTbuuH8h
	 hP5zirduLrOxTsyGuUPvEUTXKRZ5Z18QtuNKLY+rN4ps8baLC7TIQfljTc0f326Sg+UR0pL3znWB
	 Qxy2WW1mmGYjhtxSwbnOvMQMp48XoWpd4o71a/YgzgADhMrHeSdJ+zs1BFr48bGq4HApd/Wg/Is8
	 I6wANZ146qZKuosPRuOv1iwvX+mvs2x+vfDy+DTETEc/MuhvPEhezs1tAMTVeGgv8ixRdT61NSHu
	 IMeFCYXQLJ4qBV+gaFRsLsC5v84q60XzZGMLQTgsf4UAErHCSs+/t2Sh3aNRIQPjs7K9YsEAppjs
	 fa9OsewUGvPpEfc7l8PngDDt+ynZ/XNl7cMrwIaCjGOxrBL33xTO6o3aM4kW5ugGkW8uWx2Kc2m1
	 2jF1Slqy8dIL9ENTAKe7SL7un2if20SxrOvISt06q+o0a49W2jdlSI3U/rc1xQVVQkvhAjxGoQzv
	 p0byshylCg9CPGCEuLXm/Bc63coSYAh79kFGCl6l9oE9A4+2fKNkcPLcQNqufgmkE1047pl5CN5X
	 65yRw43p2shHYPcUlYA8F4stMFEImkxmkznJaACgm+2yHpUZAVc/NW5sTEUAm2QhrEB4EJjHB556
	 Gn2VrYKv3r+Kw2Q/Ccc8zgX93enX9AhqPm9nA2tatdyQbYABER+ITXMcE+KhBmLERraBGBiKO6WI
	 3pK2VcNgp1gqmPQl5jQE4iqNQrHTrtZdQexX7JRW16bML6TTknwSCF1+A3PyqX8U1nr8+jNECvqh
	 4gpsLsTyw3s8JwjtncDgsbNrIRgNKTUr/Lzzcgt95AU+3rxNBUpXCl7dFE8xvphiRR1XX8zgRH8D
	 XBjN6SMWrMugvjmb3VbK1eBlJO6sslaYOwQJCdMovvbnclyH5fxvdjqv7iEE6BixffQA3Y5Xr5IP
	 OisoHxCwGD4e8KBZNt6MfoP8ImBkRGVkhZVHI1NPQE9IfNzXQk50IxjYn/NfQ8ycw1v+ztQjGof/
	 Xz1PGsV4AQ4sx6lKk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH v2] erofs: print the names of unsupported compression algorithms
Date: Thu, 18 Dec 2025 11:27:29 +0800
X-OQ-MSGID: <20251218032729.2866825-1-ywen.chen@foxmail.com>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.231 listed in list.dnswl.org]
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
	*  0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
	*      [203.205.221.231 listed in wl.mailspike.net]
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

After simplifying the implementation of z_erofs_parse_cfgs, the
names of unsupported algorithms can now be directly output.
Moreover, some unnecessary additional judgments can be removed.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---

v1 -> v2:
   - fix the code style issues prompted by the checkpatch.pl script

 fs/erofs/decompressor.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index be1e19b620523..f64b08fe81791 100644
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
+static_assert(ARRAY_SIZE(erofs_decompressors) == Z_EROFS_COMPRESSION_RUNTIME_MAX);
 
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


