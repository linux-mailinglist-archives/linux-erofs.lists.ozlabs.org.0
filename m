Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117321A8587
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2020 18:46:24 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491rwY1KPBzDqt3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 02:46:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1586882781;
	bh=CC9sPx5kuYI+4obK+mzZ1xRtjL5x6J0vtulyoT0943Y=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QWhPTmPnZa0/+HVDjyhsgGHWWXcKoB+FGBpab0sIqDkilM0ryA5+B1PEA7BxAvpWQ
	 tjh1feVVjNVh8rU+iuKT5MAIjHYpmY54QNP1GdhB/DeeHqg5pEOod4xA9yuOFGQRft
	 KrAcw/7DO+VRsOwZIcozgOhnudiueJPNrcUpBZf6BswWu+QdJjFTqVYIjLZ3L6xids
	 Y8X6hsUqCTyqvr71O0/YHz41WyqsCZn29saasJt+2aSbN4LsjsZyHp4VxPaWwYC7BV
	 n5InQ6wlM5CLhfmTT+jGm60akmKIvzcWPAsddIuF9t7o4sBjrAT81zq37W9lgKHnRL
	 2BcG4SUeepH4A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.184.240; helo=sonic301-7.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=oDWILhSM; dkim-atps=neutral
Received: from sonic301-7.consmr.mail.ne1.yahoo.com
 (sonic301-7.consmr.mail.ne1.yahoo.com [66.163.184.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491qSz1r43zDqkB
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 01:40:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1586878846; bh=Kzk/B2k8gvh56nCGUpeglOwucVUleHp5shUd46bUrvY=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=oDWILhSMH/Rki8Ogg+4JRognt3AvtOd48K93bpcGWe5H8J6ngkT6UTTzmbVvHk2/6JlC28gEVOLl+wjx3XhJijrYNGUHE1Mq/Sja0iDdXYdVTkgJEGhGXEaUGt7PRIIokE5GepJhaomVtDnpBJmZObnP+gEPUSn5PdXLNJkb2T6E2oLTubq8m4qJ+WpjpMk79K2epspdyrg7wcC3zRMFu87xNl/LuZG7qM7Y2BUyDQ3DcNGiWS/Ct0Abqh0kca+2w+pUfxEx9WMVLB5iNLxXkc7/p96j36AEC8f66XpC10DuwodZWvJQkdzFOHGG8FfZ6Oh7xPlhw8qhgHq0YE//aQ==
X-YMail-OSG: mPRSk1sVM1nBbV6WJyJzUCVqvN7XgC6YooBJcMAbl2Tv1mzFqMRt5uQjH_YEWoL
 RLNyvVMMqUtrWf.LygeY7.UUvgyrdgEwccJpW7ENJ6bprxRghXdtGjxt0x0mRShazxdB8ISKvrug
 HDLFRg.JH_E6SWIx_WmvseitS7eUqPbO8SngzdI_g.pYoBexczmenklC.o.21oubqrc9b6xaKNx1
 3eBBqW9CgjaCixeJ21JmJbwhCp7i9ScQFbIk.tTGtQ9DX0pkfxehCg3svxlF3pUmHQOsjL9Z88Cn
 Z5UE3GdWzvKiDwP7H0lmWkbAHPAq6AUjdYe8IBq7UgIcYITZ_u89Rab9ufVXk3W9ox9glFaLZ64M
 O2ZBqcZoUR6OfZldLqPtA0UJ7RScteWvvQ7pFAVEn.0gZMvYUsLIKfO7YmIB1zhXBsjMD0P3fmCY
 grV9lbkeBG0TxwtkA9PfMfHZkHOEH4376HJmAW8xmwPujqO4DtM7jNhsS4w6Zfcf96GWFvOwsM5H
 VCIM6jl6MQLddi0VPfyu2Ph5nltpKZM_nYRhC2I5mKlQvfyWLSiOvSWnvBSWDJ72stLK4s9eVT.8
 8ps0DRU9riy778sMh9d_2nomhW_7aiupkazHxovUIGNEDJgOYVnMYLmV32Ul1pBCdbPuOFHgZ4K9
 Gb5PNC6vsKUskPkLnsjjv6II.O4gjERx3j.Pgse05PGUMLv59u4JkwbzCCD9Jb4q5DH7JU5EKhGf
 dpEl7OCojMTxWYr3MbIauipcR4wvD2C2vwXcYUAtoCmtkjDnDEPQvc5nsproWThGESilNbnl5ZY6
 CEgbzmFyROxSFR.KUgbxsRSBpacL2q1FlvdStpt.Pm5BRgsaJv.tKM2UiXQfnRr7LrkmO7IkrRUW
 EhQTkoI2lRze8NeW4SKKSrArJtBx8.7JXxzTooF30cRYl9KWepHCEhJVUxNDyoOxzwO7DbhlyEg2
 FPvoP8WDblzwpZxf9VX0nd6rcCwaY6x3KMMDp3vH6K2S2M1JxEQ9eqBrBhhV1uTjAg0Y7sffNz9r
 2ncrprypmC8nE6TE3yhpXMcnfsMy0mLPFtfO4VRrdACkMb3g9T73HgM7FX4D5Q04A3TMAfYfWrwt
 C26OHMID8B8MdYivavbdE91Ix.c5N._RvKHPI8caGsPSLFFAfIH8y7tF6EZbSBt_Lvf.BcUi10mP
 EtTHHP1e5QiWSPL06di5eslPaDqlD4L_q395YtAdNvM8fMNZkhTNPYJTfESXVNsIKUK7j.5okr9c
 GELie2gLCnQLTnNVGKavr9MgE_xMhzwHYv0eLTh9nftXWzRSWZq0vxzm8wpUiQ8x6Bj_Bk3SLKzC
 TntIbfraRiosksOuzu3O_9Xq.o9V3Qv.Pr_ldKlAm64ShYsM22jxj4_dX_dirmSUC3BAj4j004BX
 5Ycb_0_FmwQ0TGzxUa.bxU9O2NdFrFPdxMddJLy8uXnVb_qO1QqZ3AOD_RaEYTA24u82uzAgG3NL
 kNovGaw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Apr 2020 15:40:46 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 833075de5be8af0018533abaf51d3ac9; 
 Tue, 14 Apr 2020 15:38:44 +0000 (UTC)
To: stable@vger.kernel.org
Subject: [PATCH 4.19.y] erofs: correct the remaining shrink objects
Date: Tue, 14 Apr 2020 23:38:20 +0800
Message-Id: <20200414153820.29012-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200414153820.29012-1-hsiangkao.ref@aol.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

commit 9d5a09c6f3b5fb85af20e3a34827b5d27d152b34 upstream.

The remaining count should not include successful
shrink attempts.

Fixes: e7e9a307be9d ("staging: erofs: introduce workstation for decompression")
Cc: <stable@vger.kernel.org> # 4.19+
Link: https://lore.kernel.org/r/20200226081008.86348-1-gaoxiang25@huawei.com
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

trivial adaption, build verified.

 drivers/staging/erofs/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 2d96820da62e..4de9c39535eb 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -309,7 +309,7 @@ unsigned long erofs_shrink_scan(struct shrinker *shrink,
 		sbi->shrinker_run_no = run_no;
 
 #ifdef CONFIG_EROFS_FS_ZIP
-		freed += erofs_shrink_workstation(sbi, nr, false);
+		freed += erofs_shrink_workstation(sbi, nr - freed, false);
 #endif
 
 		spin_lock(&erofs_sb_list_lock);
-- 
2.24.0

