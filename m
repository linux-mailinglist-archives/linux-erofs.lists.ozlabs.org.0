Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 158381922AB
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 09:30:16 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nLsK41PhzDqYk
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 19:30:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585125013;
	bh=kys10NOD3v9XfQm+Nw8qWQZY+82FLIiXRu1f/5mO5nc=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=PRkdDotkvaTOdClGeePS7PC1uVaZv7BMa23IdvHPp1h39H4SON9a8qTjb9uEWIZlT
	 vDnFcuwz0UiN1GXIjqiNUb3Zjjg6Oe1PU64V6PH3rRd30+OMIZm0dArReb7u/w5MiM
	 Tf8lLMqfoQ1P8YTfjkoqiVSIMcFqvnUY6l6sRmdX2pNr346L/1pYlnjbgYePdIXioc
	 MMohpY7xKrczMMIIe5pgmltWcYQvUdcXZVPfi+IpBix9MS18Gpj0VeRj5e/AqqnzR7
	 MWa8S7uaJAXMrJQvknFxFvjpMHelZ8dR1r3g4y8o/TdLUOOc9EmpgMt1kfiXsNO16e
	 FgWefALYb4ddg==
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
 header.s=a2048 header.b=nC2dT3R6; dkim-atps=neutral
Received: from sonic310-23.consmr.mail.ne1.yahoo.com
 (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nLs74b7YzDqMb
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 19:30:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1585124996; bh=VscBPrzEAmQQmG2FXLAo/UMaScyOyCp6mtduvOD/3xQ=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=nC2dT3R65aocW7CoXqJ4xd98NtR/bPA1rhsqqLjFaE20O+8MzC1R9Ay2o/aYIPsNUF6H/MyqUM14iX6ng8fYSpOYmIUJOklVVJ7VAscPxJ4lv0s++UIv/WnRG9sNyG31YRwBEuwqGHMyWo1WBAC3gcqgPk3DsKhAiS2LMgFZ4cfq3WcpVRM2NrD1T674f3Vd6Pl2g+ll8Ryv4EnbSM9vtojKEJueiEwHIr01Kh4rmHmGtUSHVKYa95C7Bz4GabpvP2/1z/+IuSdftXumJFOhp/8pGBb2UYcjj+L3X8AbHe62i2KTddbikzQQyXCwKFamBSaZGofoTml5WrxwJyZMUg==
X-YMail-OSG: I48nu9cVM1n4hBUQiNwiHej9oiPGUQ1zWH347_RM6xwlqGFyCK.bUv1MVh04jYO
 OkA6kymcn1Km5fanehq1LXBOmDV.kiE661yqSMUG2BSl8a2Ztp3A3sEBUzPEl8UqwCCIzop4idD2
 vRlnK6TK5OVmDOtQdb3zJ_5Dtw48L_dD6F2V2cSyayZ5d2BC48HK.cL7ICTyq5fgB2xFuk9dC2s2
 OHQLonitge0YG5O.0SwBPFWL6qZKAGJbvOMSOAQuYpLGtyLXYkSWAnxJv0czY0.u2eHrk3pM_Pa8
 WN2EB7xmcItAk9Vg3eDonpwVFRBhqitzkq0r35jl9aHT1v1kj5PYoJgHXKeZyCO6Z4bFzm7pS0cw
 96nfPhtvQUssHoqpAB_E3q5INB.d_MD.079wHy3NM5lZbtZbE1TMZGCNxSU9ZOFphOO7JCp.Z1m5
 _WmzMxUAM89kEs5WXAqXaW.pt6qmID__SUcN7sGU0tzJGWzk6IVrqDngavuaf9NsM5xAkvSS.1WQ
 bJ_.CB2agVTRpLhz7qwa9C8tE.0GZ.opWWxaZyMLn8JEdkxawkMG6F.Lhq.8WygBaBObtPolRPU7
 3qNUtIQdRaX_ke1i0gW3LFEO6sd.XHzhRjz.M7P0QyYsj_gpjf8kArRcMG51DT0ed84gC76FO1M2
 FvooSmjBGdQb0K_hzsZpMtZ33YD5UlaluJlDCfK2OkRKW.4WXULpLEpYCQz8eFNa9MB6EyZ85QcM
 1.MmJETnktTeTXju5LeP2YnHQDcqrNPwk1uFjsy.hj8BRRL6j654FpijXzgvoTvCkNpfkxUVJzJ1
 fX0WuH_Ch_KLivHtZmQMZ2qdFCMZkfYgL2EzHHp3bkLRGclf4bvuRZ6Fu6BBfXZE9xv0slpGZI14
 pTu8U7EbuGTxFPZ_FjZA6.2G9htlrecNrzxuFiVuNOpT7JKBK3QpvUTM7moYjLeUf8lVV66Y00vD
 R54FIr_vT7RVNnJUf2P7QUgZsWwZ7FecipTWnKV5ZaIXblgi9P4tUdg1_tf1H53Y3nZhB9fJwa6d
 E.DITqJkzQzJIrOr19jQvzmUBpeW304psvYyH34RepFpbOgY9lFZrHuyjDlgGJHlczR5g4HUpgfu
 BwiGtBqu22IsnB3dkNV7svaTlySGnSmNDiMT1CvN4RWmIxdlO4fk0xLjRYVASjkUeK6Fant_XY59
 bUglwhF029qxwE2mMgCwFZu3qL6aG0LuW7byyiB4zNEjeY._w2XsYoY2oZbsOtg8DXaMIC6wGQlF
 VmA3SgzTvlt7cfK1NwkbFr9HIquWfWr0sE1sheOuL.gzOfhGH.Xt39sR79ZZOtwqSRJBJkqbT5mt
 CDVhwiNmKWW9QlHttjYfanxPDtsuTVMTBTqEOR_HdSF1IKwtvQRkQva3X1hNI5fv.kGwg4LegQL3
 HmdoMGMqble2Lsvrcbx.oFfMS.s8qq2tT
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Mar 2020 08:29:56 +0000
Received: by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 6a2e30364f31f59960160cd79beebb87; 
 Wed, 25 Mar 2020 08:29:54 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Li Guifu <bluce.liguifu@huawei.com>,
 Li GuiFu <bluce.lee@aliyun.com>
Subject: [PATCH] erofs-utils: avoid PAGE_SIZE redefinition
Date: Wed, 25 Mar 2020 16:29:30 +0800
Message-Id: <20200325082930.2025-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200325082930.2025-1-hsiangkao.ref@aol.com>
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

Buildroot autobuild reported a PAGE_SIZE redefinition with some
configrations on i586 toolchain [1] (I didn't notice such report
from erofs-utils travis CI or distribution builds before.)

In file included from config.c:11:
../include/erofs/internal.h:27: error: "PAGE_SIZE" redefined [-Werror]
 #define PAGE_SIZE  (1U << PAGE_SHIFT)

In file included from ../include/erofs/defs.h:17,
                 from ../include/erofs/config.h:12,
                 from ../include/erofs/print.h:12,
                 from config.c:10:
.../sysroot/usr/include/limits.h:89: note: this is the location of the previous definition
 #define PAGE_SIZE PAGESIZE

cc1: all warnings being treated as errors

Fix it now.

[1] http://autobuild.buildroot.net/results/340b98caa45bafd43f109002be9da59ba7f6d971
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/internal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e7d5a64..41da189 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -23,8 +23,18 @@ typedef unsigned short umode_t;
 #define PATH_MAX        4096    /* # chars in a path name including nul */
 #endif
 
+#ifndef PAGE_SHIFT
 #define PAGE_SHIFT		(12)
+#endif
+
+#ifndef PAGE_SIZE
 #define PAGE_SIZE		(1U << PAGE_SHIFT)
+#endif
+
+/* no obvious reason to support explicit PAGE_SIZE != 4096 for now */
+#if PAGE_SIZE != 4096
+#error incompatible PAGE_SIZE is already defined
+#endif
 
 #define LOG_BLOCK_SIZE          (12)
 #define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
-- 
2.20.1

