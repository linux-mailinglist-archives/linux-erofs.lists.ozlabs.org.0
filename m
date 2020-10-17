Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BAD290F0B
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrsJ1np6zDr0p
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911924;
	bh=epi/kbeAE7wC1SvrLtAqwqUpA4/luQFXSe0KmUGa6h0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Lfx8q5bpp8CyL5wNOqv2DVNb5yVJptJREYz7mitfBGO0UCsmK1pOi/Y/9NTKIhBYD
	 nnilVp+PtEDDs7gwDZU01ZKfH1G2BNLS9Rzlyd8KpOnZH2riuP0QurWIyGgsuaP17Z
	 93NOASy7vO6nEFSEC/yQzLRtlTM3E1joRWaqvKaROTxSpkteyIFMJx/qsrFtp37r57
	 rRZ23EdJSy3uqz7kW0svv8wyNSESb7d+dkD6LG4koMQqF1GW14WwjtjGCNyI5a0jY7
	 tggGSdYViEIoDBwQCocW18PbHA3eMrpphsZv8LcKp3H+2Cky9LEqTwI9uT92VnQ6io
	 p5H7WCMRBGKfQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.32; helo=sonic308-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=gRDr6875; dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrsC0ymBzDqGM
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911915; bh=mRSVNYArdJEo/EYuUfYvpeq0t3j5upKXsb13FiIRe5U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=gRDr6875VbsmAKCBHeHSIRE6t7ebvBR/lBr97cOHKQ15p4KCeooxQ5v4Ry/gp0n1e8OcQRG2AccLd2DxDGHlI5VQhL6U/u05Fd6FIpE+FuxUb5F1zSiI3jlfHmTL30PaE8tNiVObngbFT3GsuZyy1+eZdgkHbkllSXH2thH5MtfrsMr+2TkPa0to3k5Bf4tuPcMeutnhKyIX41iMPP2JATjErTmyHvfan6g+go9Ydj28MRErGpYbSk9wwBZv4ERl7O9f+pbgttVL4AUR9gKFUbVJ5EFr2BBBsvFEdKqaHCuKowS9uxjEIyrKV5dJw3SHSmRl1rjchbfgvDnHIELGUw==
X-YMail-OSG: wJEyq4AVM1mjbgnMzlyIs6dzKvRZtLj3c.FR4H4NlGObECi_IlAnSNi1xUKSfIp
 D31pSgeUmI3gz..rBp4Q1f4oYxRufGHOxpfxTWlaeHb6GzJ9fwDHEgTJDcR7iYV5CKU2Bp2k9gxw
 1uYzPz0Uut_anjSW_R99ozsk1L2tbL_KHrWYbDcTzDC1OoG2Bkd.1kmLzzeAAdwAVr5eKl0XDPqm
 htkq1aAXszkG1WbFzcbbWrKltqsyXdOMOUQKh5HSGulky.iQo2Jcwwz2Vlhc8qbusFR4xkbvLdWa
 WdjFhgQsS2sEJJpCxTNXlHhyMLHfiC6CiHCcq7QGEnHjYcNprbmQpi9lrDq3kiimmNGs3a.X5Rbl
 Hx2AHJP7gS.VqYkfOPhuMryjR6xCtHW3RI_95hGSVLfCxaNR2wYF9bCTzo90sX4ZpjlaRNnw_a5e
 Yf_02KyMHZfYoPsm8CemFt3p..fsNaImIMXwjxSGaufZ0EmO3D5uqQwbB_me..mxV6TB5RV3IiqA
 ZBU6wKm6USlfCrZMp.n05oCBH0BDg19fLnSTy2rvkxsh9m3lJst3iY64odmdyigsQ7K1tkLFdvv5
 trWpgWEnvvqWLI7pN4imCJaR51wUSkrxWqBnCe1d8R702jF0gFi5qb66EvzUVvn4yvg2WllymHoa
 QEA8VhLFDHScZxgkX4fgPppzS6cUrkfr6Gn54kktoiMDYTSOPJ4cPBpqL84voyfZqF2UM3CXkJ9_
 nkU__xHEPd3Bku_GQ_QE5gOJId.ZChl.mpSwBpyegqkmqBRHJtug9VEOsPMVjuipVGVmHV7YHNwB
 2a1D3Qd59a3l8vtm5fNpKGtv59gq6kr_yDIVuWqZu9WmGikZMjp3wG_acBe5ZQc_3aWshpNK7Lxy
 vOMB_iJTka1VKi1NAPVyXQu0vXPpybYwi6SvHa.I7wuNmfLqwiN17xua8EHD_4BMzG1dmQSIpyfe
 sywM4AkMq5oUaby3sibm5l3TsUSc68GP7NQESykcEqA2b7K9rnJYuf6Ngo3pylYgt9Zj1v8IwgYk
 YqEBpbvP7Ls2r3DngYtdo.V5r95qhNti.ZFTvP_8M9eUsbef08i5_H4VqBsd3o_ZiFP.gUTl8GLs
 F7s.s1H..PgJgHyomDzAhfjfjJvBlqJUI2EUWJctwqPPnCSSAEfJEhv0d2ryIPSwJn7BIq4VwcH1
 Zp_xE2lgLWw_6I.ulmTD4mTXs40377KLZna5f86oWPoo63IckIU0uex1fDPceeYjPBGWDDJTMwSb
 U5yDcp7yGqYZ937CDNP8J7qZ42gFvebQudPlObfJfTRgHTzYWNw1F8T0qMZp4MDHX4uy7ZbYCfz8
 H44fdyPaXGBZmQ56NLx5jaRJLaf7lbXsQBYsZ8qESdYdb2Uw1Kj8Y75g00WrQEcRecPFLmaqzb_4
 HoILBsZec_6hoOu70BK3mid.mRXtOsH7makJW4kaJxNfKYzzSj4fBQvRXkTTsKhLlUJX0Xpc..he
 BlloZooAxg2HzcFle4WJ0.906ZCB2tzYDg82MZ0f2cfH1HPafZjknvQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:35 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:30 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 10/12] erofs-utils: fuse: cleanup
 erofs_read_data_compression()
Date: Sat, 17 Oct 2020 13:16:19 +0800
Message-Id: <20201017051621.7810-11-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ let's fold in to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/read.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fuse/read.c b/fuse/read.c
index 46be5cc64a90..f3aa628945e3 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -80,10 +80,10 @@ finished:
 }
 
 size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
-		       size_t size, off_t offset)
+				   erofs_off_t size, erofs_off_t offset)
 {
 	int ret;
-	size_t end, count, ofs, sum = size;
+	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
@@ -91,8 +91,8 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 	unsigned int algorithmformat;
 	char raw[EROFS_BLKSIZ];
 
-	while (sum) {
-		end = offset + sum;
+	end = offset + size;
+	while (end > offset) {
 		map.m_la = end - 1;
 
 		ret = z_erofs_map_blocks_iter(vnode, &map);
@@ -100,7 +100,7 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 			return ret;
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			sum -= map.m_llen;
+			end = map.m_la;
 			continue;
 		}
 
@@ -117,28 +117,28 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 		 * larger than requested, and set up partial flag as well.
 		 */
 		if (end < map.m_la + map.m_llen) {
-			count = end - map.m_la;
+			length = end - map.m_la;
 			partial = true;
 		} else {
 			ASSERT(end == map.m_la + map_m_llen);
-			count = map.m_llen;
+			length = map.m_llen;
 			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
 		}
 
-		if ((off_t)map.m_la < offset) {
-			ofs = offset - map.m_la;
-			sum = 0;
+		if (map.m_la < offset) {
+			skip = offset - map.m_la;
+			end = offset;
 		} else {
-			ofs = 0;
-			sum -= count;
+			skip = 0;
+			end = map.m_la;
 		}
 
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
-					.out = buffer + sum,
-					.decodedskip = ofs,
-					.inputsize = EROFS_BLKSIZ,
-					.decodedlength = count,
+					.out = buffer + end - offset,
+					.decodedskip = skip,
+					.inputsize = map.m_plen,
+					.decodedlength = length,
 					.alg = algorithmformat,
 					.partial_decoding = partial
 					 });
-- 
2.24.0

