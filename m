Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB71FF06B
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 13:20:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nfcT3xgSzDrF0
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 21:20:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592479225;
	bh=nmGWLYIoTiOR389ymmuTw4JzsF3C/iv+eBNRQulMoIQ=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=cNxHuuz8s79H5NfkTYUCAhgmNSw+ukDEkRqjkunkFF1zEXmd6LnHFF8evgDtEXolh
	 dempmV056x9AG6FgyTXXADXT+9+bdCMFL1rvojU9U9PpJJ5bW05oJrr87Ktk7rOAmF
	 u3p8+cC0VQOY6Y5Rn6UVSZs6TmHDLnHcBVLmsILE7F526zB2pZFb4ao0DCWCxsjiV5
	 ROl9Zq8I1AYEj70/SVB+CdDSnOklCqCtPQYZdB7tzRGZvBiKaQzGTMV+JNSXiVnC3d
	 WzvT1EtF+xLKsCHNv/bIYJC9a1CKC2cel5tsLVImb8BAi/ScqWtF0yL5g5XypszBEy
	 xjUmkMl/8HlfQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.32; helo=sonic316-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=IdjASJHx; dkim-atps=neutral
Received: from sonic316-8.consmr.mail.gq1.yahoo.com
 (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nfcL0KpDzDrB0
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2020 21:20:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1592479203; bh=dxLr5Sac0lejPsIBqUUe96IPZz24J89p+FcMiUYdm/s=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=IdjASJHxuiD+tymW+DPVdxsWgbi1J+uj+R5xOg+aU3JxynB/ukTsVvnGq7fS2cXF+jHlic8ZgBxFwsm4H3CEooTFyAzO+rN5gc0td0Wol0JDZKSRYprje1yXoCqYwSk2Fcrwt7wXG5envMuRS49yvtY8SKB/rKcLqLzx7G0UKMY/TpACRpSCYkGZAJMSa+eIKU3tNhSjlfN3EQlCvKA5tBroNUCg6zeLVZcF0gofL6u4h788UeFndVAJwRon1uQuRcrRkd01iRVrlCRV/lEjiGMnSXNnIODAJ3BIQMXmc+KhSOXMmW8p3zsTbJspZiZGpKSfEeOf4e0mSi0A6JCZ+w==
X-YMail-OSG: B22.dV4VM1kVZzmBsXXUQgjdYN358GoSAxGLH_QYMWwz_W0kwgJe1fpVoD1On37
 NUPN84WnwyO_peJQbJ4l.f8xHladpKR76K.GgSb7fSeZKoDewHuPCebf3Z_2mS1oekR.HbaVFrVz
 5S62sP2lrLQUV32hMb_CMGf5LgxLBydZCr1_LC_s4rvjtIDUTvw7bxwh.t6qYghuSldy88Y2BIe3
 TfYbbmaTqEztLRENPoK26sLYlILdvBn6qWJDODoP_4QHmVdZQ8SMSM2E22q_hQX9pNkOY9FYl69P
 Mj.HJQG7YAgxydLXDd9VxhLYWkrJ433fgaQx8dnftPVYtZHMwrpj1Oaq480lWvgUTUNHfx34Kl8L
 5oeWjRFiv3ZhNKfSoT5CpjzPF4RtODvC0moYOO2z9gkdFunuR.liqknL3bdmwPJELOhqlbfjguFZ
 my7ENcBXQmD8VdtLJfBhOCvyeMfD5lwZD1dNeaWNxiMTAsnIc96gWeTbEWGhsnT0XcKk68wR5tQM
 PDofUkv90IQYlx.E0moQCt7TEJ.P66vuGLCNJU.fk570vq2MMC61NbIKQMd4BKtEGVgPP.kwvXlV
 ONecITZhZYreKuwafqQnzIY38Q2NmVVFahTfgCXttiUf.ykOTFAMgmGQ5f40_bfQkeLTKk8DJPwK
 i8b8jqWuFI34R45wfeDSGwNFgpwaFQBr3yTkrAe9wP3wZPz2L94gZFZW81IfEDMqmmWpAb9FC.Kh
 vGE0bGAY69giUGQNEj1wtsR9k3PIh.CLtnTHM_1hP6dSewAUwFpMxGllNTXU1s7FZSrXIc160anO
 uR89DT6hLLOG.4RRuAmiA.SDLKqw0oIJKwuXrzCzgCFHNAzl_YCPlOLQNgEOrWBOGkHqDBC5vt_S
 7BwYfw.M7wjhvjfORXsS.ibeSTVNRM_BDL62U.gao7Nhw4HGKQNP4jWQ2xXnXf.RkVh59V77kXVa
 xJO_VSl6wrmLhxrPwRS59vFSCeYD5wQjKEacsFhNYB7WoJEVp4jQaWFDxi5OSU17t7ibvsEkm5YK
 0o8mwe2TJUUKGYvnHIBbdtg.clpFi6tJFp6Xf_dxkaB_lyx.dSbSRYZWD54Usba19RlCU_zTJrZl
 82f01LA7zkFae8p.MxLzjIDZtMyffycGmFaQPzNoaZmaqaAGc3LaDgQWMgEElzyrtXV5zYhwYeGV
 RwIqVvrWmlYNXykFoC4lwoiF49V6Aguoy.hdBh23ECjIGdzNypbe.ldq3hkoWeh7VqZo0JcjJuJr
 mfYlsUAKl7rAz6as0jOb3rI46rK3VVsGgO_WZWjX.WyE9I599Q1gQsSN.ZM8T2vWBN0LFdw7rJH.
 Is2HPYM9WTtu8PuiikhPaB_dq_S70ulOxgUiOsLxBF2BnBBtCb0o75nw0lx8X580tm3Oz8OT3U2p
 QlVg6esQqKR5sFRozNt60f4FUWouCa7I.
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 18 Jun 2020 11:20:03 +0000
Received: by smtp416.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID be5fb830dad37ee084f7e0af79317143; 
 Thu, 18 Jun 2020 11:20:01 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: fix partially uninitialized misuse in
 z_erofs_onlinepage_fixup
Date: Thu, 18 Jun 2020 19:19:36 +0800
Message-Id: <20200618111936.19845-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200618111936.19845-1-hsiangkao.ref@aol.com>
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
 fs/erofs/zdata.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 7824f5563a55..92fbc0f0ba85 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -144,22 +144,24 @@ static inline void z_erofs_onlinepage_init(struct page *page)
 static inline void z_erofs_onlinepage_fixup(struct page *page,
 	uintptr_t index, bool down)
 {
-	unsigned long *p, o, v, id;
+	union z_erofs_onlinepage_converter u;
+	int orig, orig_index, val;
+
 repeat:
-	p = &page_private(page);
-	o = READ_ONCE(*p);
+	u.v = &page_private(page);
+	orig = atomic_read(u.o);
 
-	id = o >> Z_EROFS_ONLINEPAGE_INDEX_SHIFT;
-	if (id) {
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

