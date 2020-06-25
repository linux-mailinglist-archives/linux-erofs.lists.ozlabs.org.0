Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A4209960
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2020 07:22:27 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49spL82k7LzDqjb
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2020 15:22:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1593062544;
	bh=IqCdKyDz4PLDzmfpnv/MfScK9aUO22kmZZIcAHAixR8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KDB73N+p/lAzOsC6rZNCnV69IypB/ITtGNsA2glqlMt+17pqX8lyXEZApX4Ulbj1R
	 mi4nQD5XQ1gPTqWkPtOTdd547jtbPgnfFgbu5f5J1IlvRwR982D0sBGk/mvcMtr2mL
	 Nk6ZlLXOsH8kZXPGMH95kes1nEYzoiDlrzUqOcRi5lUk7wt0lRoz5kj82Q8HfBTFNu
	 NexeH6IcjgEEQJ+8LTbZT8cr6MMwAHXBHXDgElSSLkVVZ+BrPCTjfg/V1ns8E7iD/e
	 3xPrKKl/Ha6VN+dE2ARikf03eVtIXpf9YZLGJKIUmmoxutryNimDkA7oMk5EzZoPw4
	 AcHEj4f00DLrA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Bb4C8ESy; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49spL15XGlzDqgb
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2020 15:22:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1593062531; bh=eWxg5wDTW3X7hg6BDoLBlNfZPh+/wNMxRAVo+gKvGyo=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Bb4C8ESyArnddsERuFBM9T8/uJncGv+C8biW+DjuBO9M1Knocei1uzf+E3G70lKsAwh4T98iIEk9jK1kwUr4JJhqGO82f1tsTX6ZTevmanDdxaFf24dcWNuPoMvRO8LcZ6qsPPaQ/rLcCvxrD1Rdhp8TjEJoztush/YA3ndcdSl1J1JG66ydOatjASt34HlpsofF3CbPsVR9hZVV2U7O43io6hCIguC3wrEtsuJTfhHZonY0qb+xzHfjgBL/bdYBSGp/CPuhrzB7nC20vkmOBhPqA1iuVQJvKYbWgJXs6Eaow9B5oCH7wLJT8y6qPka5NKfftAPMC2pGV/cFsyc1Vg==
X-YMail-OSG: Sh.jItEVM1mIwdlDSVPWTqZOrD55TsNpghxm_hDOi2rn6Fb9ZRAFvpxsSxyR5pz
 cWn95piVIUneRb5iLTnH2OBLt9i8xgKqIS5vgzJzfKI8okLIZl.lyjpv9CqBhrUY_YqroDqvEhpo
 k27TDolHRqoyGI3hWFa2LtqmlSluu15mI.Kt.0OIgXEjkLUEBHWjsbk4AMb2KDVGDLTixd2enoFa
 SUgoAzo4AvyzMZweQNejdGqECS1HbgUQOuBQZwS9arJErorkow31JuN7drL_FtVNhVSh8QxXYSOY
 XCTvGh62OMHqwDyJQif7lXbGHjUsJBhYZOA8hP4R57qODUbAphcIvrLpzNBDysaL5IeBuDNJA.P6
 l9Ur22284sZWV3qe4HwgQUT6Cq64uRYCtyctUCxgUSAnPWgVE7QWLQlbGHkmScmnP.lQOPlYxEWt
 R0GSAMIf3xq.KerL5jAJCCqx528s3xQrATFAoXnNeOi6nxuRDXlKCYamksi4.lFWKLdOBWRu5V1H
 UjfMdzZ5q3G1L0Gg2S6LBtvA4YHa1NF8_QCb_yWLMWrw8IekFkJjAmOmigD3jSGMeFSiobXeTRcB
 YbMxkCNsugtFf7bMtY.wRN9T2mQWtfgFSq6yvGx2knVTLq84xWipLXpQsZXCLICVe8Ra6nO4QKmw
 kFZRialJWi8RdxroQGZtsi739muV_MxGRnmZI.XyST9ZR_Ih8C5HldR.B8NyqCUU3ydNwRzUqBn3
 f4lY8_g1PQXzoflWBLifgB1J4x4I.oAz3Qwc7ZbcXtcUpORA0lY1V38638._WDG3gPC8Dr1T7T1P
 wWAM11.CQmB0kvx9548r2QJnFPNbSAI1_SrIkM0Egr_JkSnFDLLwdxlCnvNG8xlogEwIRgxXWKsC
 oYINRq6hnPE4RqApHEYoUoPEURN4NvHMJs.0svy_xkzEiL0834gf9_H_jfpzJRIqpVl1yQdIzXlr
 jxXrLQM1MmM3uHU.gYEh_dWo2.hKV7_7wMcVo0OZaxcVJJ.5rA181PoHEWzkKGQVS0pA2PZk7Z68
 jQUTQ9OJF9GYFl2ChTeVmorsdkrFaTjStwA9P14Bsdjve.MpvmTKBj0BAtGV5QA4YHtrlnaE0t8L
 u2HdC7MwYnhb66VIcyWkPBMuuQNAmd1F2d2sjvr5KuUXVsWXgcwGawDo.vX4oanfTSoM4xLv3q_K
 QIjGdrBHauf5_5stOn3LW9Ck2qZk9.2Od3ryHq4rvGp_0yKQNTuW6JpEzAgbZymHGzGYHLkFNkP3
 dfRhLORnYFnGtg9qaxBfGtO0_widFvhzSWHK7HXkqtRj2Nb.QpuNKA.2WX7W105EyzWApNwQUo_I
 D9gxwsuAGKk.os3gblDhA6R1v4_ZaoeBdo864uJi0.XqvMIPvs7U_LOAyBW0CsOhMYO8qfD1ULA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 25 Jun 2020 05:22:11 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID c5f9560e0b507acc2701276e664e6e1e; 
 Thu, 25 Jun 2020 05:22:10 +0000 (UTC)
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] erofs: fix partially uninitialized misuse in
 z_erofs_onlinepage_fixup
Date: Thu, 25 Jun 2020 13:21:57 +0800
Message-Id: <20200625052157.1197-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200625052157.1197-1-hsiangkao.ref@aol.com>
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
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

commit 3c597282887fd55181578996dca52ce697d985a5 upstream.

Hongyu reported "id != index" in z_erofs_onlinepage_fixup() with
specific aarch64 environment easily, which wasn't shown before.

After digging into that, I found that high 32 bits of page->private
was set to 0xaaaaaaaa rather than 0 (due to z_erofs_onlinepage_init
behavior with specific compiler options). Actually we only use low
32 bits to keep the page information since page->private is only 4
bytes on most 32-bit platforms. However z_erofs_onlinepage_fixup()
uses the upper 32 bits by mistake.

Let's fix it now.

Reported-and-tested-by: Hongyu Jin <hongyu.jin@unisoc.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20200618234349.22553-1-hsiangkao@aol.com
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
This fix has been merged into Linus's tree just now.
The 5.4 backport can be trivially applied, though I sent out
together with 4.19...

 fs/erofs/zdata.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index faf950189bd7..568d5a493876 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -148,22 +148,22 @@ static inline void z_erofs_onlinepage_init(struct page *page)
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

