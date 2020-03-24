Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A232219076E
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2020 09:20:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mkhT5DHVzDqv3
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2020 19:20:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585038025;
	bh=wspaI/WqCh0xN/xb14ALdS7Ow0Y6iycP0EGsDMDwkO8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CMtTMSV2S2QWiDPSSD57vX9/N8SN0eKveVBmqNA2bsRfMGhCwSxkugEmToq29wTAp
	 ozNs6CNKIwyb6YRQ9cwqd6BKVWdl6LKQh8K1AMCV7NotTwbHyTj0kIAj4/ITeOnZzs
	 /CwU17bGuxihZzjygTRZ6IxkVF9MW7Vjih653VAY4OoJgcx73ctfj3GREm/fr4mRHi
	 iVydBMKHHFOkCtyjQLIzJzWUGquK2xrM587siKWWQNy3vB2Dg5n7ltsoXO3u5J9C+/
	 Znbk5FVHvQ9T+znZNls7yyQcP6nxfuPNSAr1F0dOikZrFggfmH08AkBCuF383UYgtR
	 ivdL64/oFG0jw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.186.204; helo=sonic310-23.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=KfpHGsNy; dkim-atps=neutral
Received: from sonic310-23.consmr.mail.ne1.yahoo.com
 (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mkhK44xFzDqs3
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2020 19:20:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1585038010; bh=bwRFpDkboiemWvBPQMBpFEPz8a5WGylEmulfIHlbggQ=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=KfpHGsNyGdMVv/RQcGe30ZeQ3VbCDh9BDJtnwp0GGnb+l+xt+SjIulPyYaja3Vx+kFbsB0eBQ0fodPPK0GrhxbNLMhXxSZhp/KGTpD/P0w6zNeA47NzoqPQX2oQjrk5TO+6NgNLCzURUM/L0goGBoP13MR0zovPQFQEUvdRFte3RoWI/CGnRryMG1ZPYH8KxVNeuEcbF/wqHS1lzn/99pTuQrljoTsxf4LoY+doFWhOQcaKNbaa9FlbDV3RBhlU49W5VagFHOn3vENhnDjXg3TOuMfR2Sdx2UySoes89bcsOzDfx3mxDWozdPymhdZ8ljz6DU0pJ/2s18a4fcP/MBQ==
X-YMail-OSG: 5_oNnTAVM1l0lW5mkaR32GbbBsUYncyhZz33eW_XIKmeon.9ASjnx2BIpVfUPLd
 gP1Mxe85TGT7QgtScPJPrUjg3r3Vp2ej3G5JjqLryO1xNLBP5EYbRgPGxM81VzPNLMGcjZJeucjP
 wbG4wCgWNIGXC1DjjnTxlwmFMRhJ44Qchs.mK4gfP_Q3bnZ8bV15eKwDbX1NoRN6bdoYjAA.5KrU
 TGxvUDFS24lzV4Wz9vh9oe6ndMvYX8nzk.VzzBF05PqOn0rmanxkNbFr1a7GAB0QGHseJZM4RTVf
 o8Rp.PqTa3iiHhULYFVSlidonFroF9lI7IOkaQ0NUMgkZSABuAF4a5SjEMBrUvMqLLIK.xGA7Jhy
 ryLWUtiwlCiK8CWIOFmlIH91trbTKlVJlq512l.xMkbZ4hkhFa4zDXZ6GRanV781Uiuk3uQpqYva
 1fhbJz4sWE69gzBl4gKpXy5Hsymn_BqlIO_qFRWDVG6S3zd6mZnvmbM_49eVNn5_wGhqkc7G.1Sm
 5tIz1iENHQoEaR7_tUO27vbPuapZmgYUQmTqWhpC6b3gI._HwfgnLpRfutk95qtg05jFrJBkqsND
 1slahcFLtegC1g1VK4e8qhQg48C24WVTGa05eyxFTR46IUdpsjtiaHfEAOvtwnGVfTge8f8sti_A
 j.zDm7B.IiP_AiG9c1anirT6fosSyr7MzaUQ5dpnMnHGExQiU6vG86cgpGIq5dYrr0xP.KnYfZ4z
 PspkLGaDol1dDrdV3JKxO4Nf.fZ5wtYNvyp7ibZg6FCAP_NiEaFYc_5hUf7LEZmziYCJCOJYm4zz
 AQl8UC9zbR9Ii9miNhN4_Eh.M7qMqszZjqDtsTr.BaPEU6kITGHjv3uhNOALub67tE7xROU83UOK
 VOS0akfGhaH7bawSB7ANKEqxiMXrolF62WRcPyl0sFlTOs5sXVyZTHWE8GST69t6zElnIXKymbT3
 PIWfbLDc07WrSEReailJngNkCAcRjiTo.uyucJsOWSYOi.3iaIsdK.buNYbnjkhFHCfLGFGE4CjN
 7lNL7vHNqouDHCUqdfv4HppaXPgl_roexuiu8q1oyHoqVmzFlsRYgHoBNN0v9AmEyH4Cto1JE4vh
 Kk7YIoKOE3NeMwgHtJ6pdxfo_niBaQOqi82_7hWo6gf4E6MnbS2EyalQ4RfqJ.kohiCbRVijeP7S
 djh_Kr3.q_cL0oPS87DvsmB6hSJGOCoV0f1ff.nOyjUPBS620deNcQaDIuszkjBL1CZ7piBqIrKF
 znuvzb2RFCTLXiVnb.il14B2PfX04d0WFC55lZmHUaO35F7pPepiUNlyYNvpXXar0JiDZtnfGMVx
 CVrkes1nfMgj8RWRLu8UHalMT4i72jJ3Pbs_jHJcSYDahztRrCeJ67wgfAwsEMe3Z8QggybyYZfh
 VCtgsWv5J9rs_49msIdkj0N3hoT3UxTSB_ioy
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Mar 2020 08:20:10 +0000
Received: by smtp409.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0cf8867b50cd90ab07bcd9ca49924ad3; 
 Tue, 24 Mar 2020 08:20:05 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Li Guifu <bluce.liguifu@huawei.com>,
 Li GuiFu <bluce.lee@aliyun.com>
Subject: [PATCH] erofs-utils: avoid using old compatibility type uint
Date: Tue, 24 Mar 2020 16:19:49 +0800
Message-Id: <20200324081949.26355-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200324081949.26355-1-hsiangkao.ref@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This should fix the following buildroot autobuild issues
with some configration on ARM platform [1]:

compress.c: In function 'vle_compress_one':
compress.c:209:10: error: unknown type name 'uint'
    const uint qh_aligned = round_down(ctx->head, EROFS_BLKSIZ);
          ^~~~
compress.c:210:10: error: unknown type name 'uint'
    const uint qh_after = ctx->head - qh_aligned;
          ^~~~
compress.c: In function 'z_erofs_convert_to_compacted_format':
compress.c:313:8: error: unknown type name 'uint'
  const uint headerpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
        ^~~~
compress.c:316:8: error: unknown type name 'uint'
  const uint totalidx = (legacymetasize -
        ^~~~

[1] http://autobuild.buildroot.net/results/842a3c6416416d7badf4db9f38e3b231093a786a
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/compress.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index b14ff17..6cc68ed 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -204,8 +204,9 @@ nocompression:
 		len -= count;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
-			const uint qh_aligned = round_down(ctx->head, EROFS_BLKSIZ);
-			const uint qh_after = ctx->head - qh_aligned;
+			const unsigned int qh_aligned =
+				round_down(ctx->head, EROFS_BLKSIZ);
+			const unsigned int qh_after = ctx->head - qh_aligned;
 
 			memmove(ctx->queue, ctx->queue + qh_aligned,
 				len + qh_after);
@@ -308,11 +309,11 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 					unsigned int legacymetasize,
 					unsigned int logical_clusterbits)
 {
-	const uint headerpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
-							inode->xattr_isize) +
-			       sizeof(struct z_erofs_map_header);
-	const uint totalidx = (legacymetasize -
-			       Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
+	const unsigned int mpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
+							   inode->xattr_isize) +
+				  sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = (legacymetasize -
+				       Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
 	/* # of 8-byte units so that it can be aligned with 32 bytes */
@@ -324,7 +325,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	if (logical_clusterbits > 14)	/* currently not supported */
 		return -ENOTSUP;
 	if (logical_clusterbits == 12) {
-		compacted_4b_initial = (32 - headerpos % 32) / 4;
+		compacted_4b_initial = (32 - mpos % 32) / 4;
 		if (compacted_4b_initial == 32 / 4)
 			compacted_4b_initial = 0;
 
-- 
2.20.1

