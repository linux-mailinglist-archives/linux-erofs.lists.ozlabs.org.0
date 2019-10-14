Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E50D615A
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 13:31:33 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sGbj65PbzDqkf
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Oct 2019 22:31:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571052689;
	bh=KmoGvK+UCNtHcw3w5HuEoALirfUX+Lblv90qhBkx064=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=i5qUn3/0RYxPc9bKRLk3+6IsEKNaM1tFgRDViCLFF/REeLoAdlqqukjdjAY8CFE97
	 0tBSftmmoVMUU2zyRLRuDDMpzu7XYW9bP8EOd+HWbWqQYn2Q4ddJf0QcM3b/jqOqpw
	 70fcksSgM4dog98JmW6aBADKPH0Miv778hyZBDiU4ePEgt1vnspj2V0fddzNLttRfT
	 cxCK6mUSgYSYTayctP8IUAm4kP+OBc4S5tF0aGHApQiLve00iv57eCwE0mgxSERN5o
	 Z3wfLJWNUYfXmMlG5EMpfSwSSaPMD5ONAvWvlKfN02P/ujD7tSivdcM8uodPXMSpQX
	 ofa4O022CzWFA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.179.82; helo=sonic309-24.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="XVRv5eO2"; 
 dkim-atps=neutral
Received: from sonic309-24.consmr.mail.ir2.yahoo.com
 (sonic309-24.consmr.mail.ir2.yahoo.com [77.238.179.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sGbR0j9FzDqkV
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 22:31:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571052665; bh=aHtjW7GprkGxNHOVS8HXpZMEZxJ+TdUDtbOw/bGE/Yc=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=XVRv5eO2iVfizFisKBWakZuh+zX2dE+R2LHKB1FzTZ4aVPVNMM3TfyhBLUOOQzYQYwy1QrMUzyU07e/zpCV+lrCSgxUrjvMVD/WSfDCikf6NDwvtnwdLPNe11K3Zp2LC4TxB9bzSKMpWDyvg/R0+nwaZOQEPeAldXe47vCmLG77RNKp1dNMgSWI3SQ0A+yTw5F9kmuM0MWdPSfOIY6vBpEHhQ/d5HWutW5G9g7fe9AoNQFhrV/8DptXDcY4pPZZSx9B3spLmm4XQTp/JxV0SN4S0i+YiGpwvWSlO83ioobjHNxfqL+CdEHRylbuu3XeY+qylUP4yDLdqjtvt4+i9vQ==
X-YMail-OSG: P9niX74VM1mNB_tscvnYBQiLh1PjrXutwNq7p9SZRa.6kyPGSO5pQtNJVEOQ3yX
 FY2OIAE5dh8wglffFdSN86KU16lcbY.ZEVM81ySi6hFSAiIiSTwstErNwInpXpC4qYOZl.RD4Vsk
 .la9pJTuLCHe8I.Y8fCauQiQPgXbT__xEPVsMgVEa7OiijDfHWuox9TNmCwKNM7LhIwjssBoKyYx
 ZmyFrbrmJUv1oO6lMHDc3iNgK8o2nauzaFzW_Vf.9neswcUchfSVc2vuuvl_SoYOc2qJgWc2Ww8m
 wvEJ_Rp4CexetuzL2AufbcZNsCAjDPA3.A7eJNZwT6aolrMzaFJYyclRQ5KcOQmcq2HgCCzqp0Ib
 E9gKugLq6lQOVi7hKciXO_FrO_dt_N0MtpzPM9pT_4R8yCeZwfbHdZ4qjw1yCacmHyE_yLVBNN4t
 TQVubKK5t_T7fJ9B8gOBAXlU.h50O5nsBvwTcr5tMN_vcjDEe5xj3AQSt47B3rSsv8Na3u.edQRw
 9qtfCk4YTmZjuvUJ3qg3npLgsrCaX0Sfd7DR8jTI5jIyPWjVQHO68kBflTgpYJ5JyvGXcW0AcR4y
 ayrvjj3bjbss4WnpirU6Vu0oa5zAPXX1BH6xMaN4sL7cNekS6VYyyiZOXedBnaYk8T7uC6gMvjpX
 DnAFmJoe14JPSCRV.Bai5N3yuiqS1Uk40l5dgBmyh7CEZCMGktNjsfWUhb4yJ5xHN3ygbIVeQIeV
 OTI6ca1wsPERyvCeBkkUqDxUPgx3RR1Hj6r0fivGgpxp0_FOwv7NGoXQ8qhSj2lxIRCPyvf2VhVQ
 SIVb6.lDwMWiMNmomnCVRvRWUMae0SW_i_5I1jjZTNETItyLIZHJXkw7XdMqE6soLxGk_97f_thO
 Cno.pt3ffm1EuK4iEEXTU11dn_fsRYMg_yYthqcA3PwZMBX7hvutNlQu433BPck5YcJCXZtF1fpA
 gc_5T1VtUfoW7d3I73H0oKBHbXOsH8F5CunkdPNfV4zQkgc96UN1DjINcePss2h67MAgGP92vYpE
 fnetROljrj7JDaMIFTV.NUs920kxieMyj.tEB0BK77Zt8EGQzEcus62uj5QF8sfkV96cJU19VuOw
 g6FC.y4_LHWX1toIcM2P74tMEUgx5OQ2tsQxR91k0Bumq2_uEDYlX6f_5Ux5Ns.PZGOpaQcKIrSP
 q0G4ct3MTYR23apAkEw397fd5Edt82aK8ST2.5swhGAYcGPP5QZCC2HG.M.9ExXi0GI2PLQTFYPg
 kvyPoiLcb2tDc4m5MkaaiHGYXqbac2iT1rELb3X1ABTnqgTVyWc9DaJod5SNkX739Cq.P_2j3Edd
 l8A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 14 Oct 2019 11:31:05 +0000
Received: by smtp406.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ca30c947bfb9d1aefd5577f222cb1e92; 
 Mon, 14 Oct 2019 11:31:04 +0000 (UTC)
To: Li Guifu <bluce.liguifu@huawei.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use cmpsgn(x,
 y) for standardized large value comparsion
Date: Mon, 14 Oct 2019 19:30:48 +0800
Message-Id: <20191014113048.32067-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
+ incr + extrasize is a unsigned 64bit value and sgn(x) didn't
work properly. Fix it.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/defs.h | 5 +++--
 lib/cache.c          | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 15db4e3..db51350 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -136,9 +136,10 @@ typedef int64_t         s64;
 	type __max2 = (y);			\
 	__max1 > __max2 ? __max1: __max2; })
 
-#define sgn(x) ({		\
+#define cmpsgn(x, y) ({		\
 	typeof(x) _x = (x);	\
-(_x > 0) - (_x < 0); })
+	typeof(y) _y = (y);	\
+(_x > _y) - (_x < _y); })
 
 #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
 
diff --git a/lib/cache.c b/lib/cache.c
index 41d2d5d..e61b201 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -80,9 +80,9 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = sgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
-				    alignsize) + incr + extrasize -
-			    EROFS_BLKSIZ);
+	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
+				       alignsize) + incr + extrasize,
+			       EROFS_BLKSIZ);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 
-- 
2.17.1

