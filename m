Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CAC1FFEDB
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 01:44:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nz705HgbzDrN8
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 09:44:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592523868;
	bh=6yDMfWv9i+zZQZGDtJwu1LqyRzLs+a1LvxCqhIx5USw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XdJnBXuMgZABDxSFwdCBM8C5gqghQ5dXD2rl9VMjcl70u/M3+W6TLeFRBQ+1Oz1Fz
	 kvGIklzkgtkp0GyFBWKqmEj6O5lwj6r5WRIPSqoASrPpFsxnQ/XE4+cB/yYqmZ8ifm
	 BserIEvnIoe5T5GAXuHAKcJ2qSskBHXnAMXbI73/57F1LKZfyvXEMAtUpIWKfRQ4h4
	 q7PsvsnDhap1Es8LeWrmFhz6O7QRqDk9k24SkcvhO/H78lGIxCUIQz3WgYZJ2qEHi2
	 USZBnvDQc2EoCKKzF3FRx1EKDQFGuZrtMvbwjpu3bBVi3jZi/nphmsrKX+En9vqm7T
	 rJ16btZU99Gyg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.31; helo=sonic315-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=srQl0r5z; dkim-atps=neutral
Received: from sonic315-55.consmr.mail.gq1.yahoo.com
 (sonic315-55.consmr.mail.gq1.yahoo.com [98.137.65.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nz6l2M0gzDrMb
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 09:44:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1592523844; bh=Asfu5Z94gNQ7XaBROjojNrJwo7jut1Y+OrjYRXVMET0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=srQl0r5zFsbvovsydZAvPTnpNHBid90kLOrvipT+G4JOHT7xyss9yq/OGWsLZHH3V+en8ziRtU4Jgp8jr5JE+yj/tn0otaQ1ASsK2x07JCbTMqrfcg/tNrjBp4NHdVgKcYvQmEdpCvw3msv62bkryEFKiRNqvHYgvMOG6L/2sweyJsTUHuphfD0Q6SwQit+hqy7eQERz8RqtcCkrZ5L9zop/lw0PUVHNngf5Q42p7/i552YzI7p/rOmW8hjBOA58qRQYldWTxzEKk22er/xovfRDsh/UrfykROEJOvqIXsa4Xbp9DJWS24lB2exyazxrNtx2B3akos/ixRaGqB8Uqg==
X-YMail-OSG: xSrhU.cVM1kUcfO5gY9kaoFHyQgqMiRLrSfI43yWnRiOQ84HFNbvqWDF97fSYc6
 J0b9moHnopLgeZqs10Gj9apJlSZ8PME8dk4y_4DEzI0u3h5TbRXLXPCBsTGySxOj9VX.2bijtAcG
 Etxzk6UVXRZxla6mnU0tLic1Z2EdVwsmPdmv2BhAKUCTNG_FbzwUzd_eXtOBzE627deivbH2EBu7
 MknW9WsFn86JXrT18crQ2ZKDO5ulpmSp1QDhe2rBaZijH9fvGKg2.4AVn8OESeMaHjA7XzRvvT3x
 wZKrCemArwEZizKcPaROXH8_Lyw4_z51Liw_W4keitkIAAeOE9XKdBe_XGeAOAi12jDRjS8A1Mx4
 le01xyRQlnFNwNLruU3ibw4gOSb5ipPxK6CZbrsnc9zuMVilP5D2c45_uYImg9rMvHDy75VsJcUj
 owigH5ficrVcSz7EBhtNNDUFPNcta10hFqN4FBm431nUrCkEvRKceMXNVyhnSr12UKam_mGZDldP
 EwkMympLIwMpTK2YR0w5qvVtm1XzKYe0BPmsuHdpFxqG62kqkECX5f257A7qW17G9WaaovnJoDTs
 EhVtVjkAzazvcMcQTDCTaHwMFjF0m3R10DyDsLUER9mFdGu.ehlPRHou4mExSFJb8CuoN6qiwvsH
 t7GB6AwKm99sO7Gldr6tmreKwkICXv9USLfxNsOWIAJOhdaZoPxuIpVoMqW77AJK05ofwZAjHyQX
 g86udCo5C5v.UsImQdCAb5G5622jr1VVyBRlRf7Yxq440ZF0Gj7MqbGbx8VsuNOF8Om3R1EWlNya
 5Ep0B6Tg5RN6rFnrokSKCerl60NVBPFv1I5Agm_9A0gfzHhL_DlqSXz1z1MlTPQFiTBUFBO60xau
 ddp9WSy7rhLqteqVA9pmPJb5jlyriXw024VUzYiYSEuA..wX2sXDjbHyW51nR5cb9jQjhn804ogw
 K6nggt1vFkKvJMsRN22oIMw6SRqEAOl2YBhnwXwIORgigq9Nh._P98kLFDxsEzTEfvfb6ekLJlSg
 Me7eovZdHPKQC.AGufahuruA1WX_6jH22yqJ2_k_ZA__Qw8Z_CqJZpJAfzuwqbe61xasnQzrhWZM
 0gLDr3Zpt_T2g0XSAtNQ4TccIihInWLxcXn.VGgweJaJ_SRW2_mJBRYIc7VaVS0aHrHKeaOYyb7U
 9LKxbyAikoJj1b7uqf3O9mm3MlEB6uo.esGagHbVStjT_c.qFZoV82V6O1lO8Jtc8NRb2WAjTTXD
 6bz5hd4shQxwToxgBVHEerPNABVSha6ud4MTk15UKmLrqEEm5Zx1WusyWfphH7rkR1C6SZqS9sLG
 7sK25m0pldGL7P5oIAkCyxydCHC4KKDlxZi3Cx.LqlQqAzzHBvbePG_PTrdgsQZC.wPVHUT3grAE
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 18 Jun 2020 23:44:04 +0000
Received: by smtp415.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID d13ff620e5f9d81f37a1475971f3080d; 
 Thu, 18 Jun 2020 23:44:01 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] erofs: fix partially uninitialized misuse in
 z_erofs_onlinepage_fixup
Date: Fri, 19 Jun 2020 07:43:49 +0800
Message-Id: <20200618234349.22553-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200618111936.19845-1-hsiangkao@aol.com>
References: <20200618111936.19845-1-hsiangkao@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Hongyu reported "id != index" in z_erofs_onlinepage_fixup() with
specific aarch64 environment easily, which wasn't shown before.

After digging into that, I found that high 32 bits of page->private
was set to 0xaaaaaaaa rather than 0 (due to z_erofs_onlinepage_init
behavior with specific compiler options). Actually we only use low
32 bits to keep the page information since page->private is only 4
bytes on most 32-bit platforms. However z_erofs_onlinepage_fixup()
uses the upper 32 bits by mistake.

Let's fix it now.

Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
change since v1:
 move .v assignment out since it doesn't need for every loop;

 fs/erofs/zdata.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 7824f5563a55..9b66c28b3ae9 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -144,22 +144,22 @@ static inline void z_erofs_onlinepage_init(struct page *page)
 static inline void z_erofs_onlinepage_fixup(struct page *page,
 	uintptr_t index, bool down)
 {
-	unsigned long *p, o, v, id;
-repeat:
-	p = &page_private(page);
-	o = READ_ONCE(*p);
+	union z_erofs_onlinepage_converter u = { .v = &page_private(page) };
+	int orig, orig_index, val;
 
-	id = o >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
-	if (id) {
+repeat:
+	orig = atomic_read(u.o);
+	orig_index = orig >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
+	if (orig_index) {
 		if (!index)
 			return;
 
-		DBG_BUGON(id != index);
+		DBG_BUGON(orig_index != index);
 	}
 
-	v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
-		((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
-	if (cmpxchg(p, o, v) != o)
+	val = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
+		((orig & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
+	if (atomic_cmpxchg(u.o, orig, val) != orig)
 		goto repeat;
 }
 
-- 
2.24.0

