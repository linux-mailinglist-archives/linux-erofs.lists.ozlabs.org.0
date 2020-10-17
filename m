Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAA290F09
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrs01wBszDr0R
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911908;
	bh=0Sbq/pFHwAkDLkgZE+2YotTcS2N2Yy7n+R2PLorHY5w=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Km37YWIdXfj9fMHvgtjE3VFEELcjn0fkS4A/91IcF+ie8SP8ZLsPhXqtrNKgOfZbj
	 BtwaI8uFa1XlhwPybYYlR5r3vfgt62DeIPP72UZz5uptpc9+ZRGmKpQVE8h+yyi87V
	 wn8PJUZesXCp+2ElBpzfMT7Yn6IdWFJ3GhfQWY44C/hv+MCHSJIRocC1kaOqBNzxDF
	 Y46MSvv3iBAdud6Ow596JoABpt81ORaoMqIb7OKKpNQoTpSCRZNSN45DzYdsljDqOx
	 262sgbtlBhJq9M0efzxLCgXA5h5QzJDX4/J5WFyzpL7Cg67Fb6uszkumUdlUqLVXY3
	 U+f3neQtfa5ww==
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
 header.s=a2048 header.b=OiyLPXcf; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrrw3BSCzDqN1
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911898; bh=HXAmOWmVt2QNpYvGfGNFWxL/KkXP9I+thdKYnsABVqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=OiyLPXcfNMcv8oib1snpcgu/reOkRhaC2cYdL15BRxLs7nMIAQeWUAoS9OlBQkt9lGRclPKY6hsPKGcstvO9aoKgK4h4vNM86PfxTxv5lcuVRbDorPowD7Xnwd3aXyzOowl8iK5AEDgIwgARZzhR3cOcQnIsIIn7dbPbhKh84vMGoiNiL8+OF23GZ1MNqfOaNZBPka8IpcxIO8pWhGzWmHtJK6aZ1kLc6CF1MPyJvt0Wdvs5A6Hvjfbz6Bv0t8o4NnOI0LTqL3I1u9icMNOu9adgv9a6Ls867M681IYu42Oqc1XrVQQorYKSU7gfYB/sBMrydCt6fHQeLM5j5ibojA==
X-YMail-OSG: JomMCyQVM1mQhmbtjm7a6KDp0LlQCQjzqoy6BsWmO5sEAx4G_6zX3swQuaItHSj
 2eky31DfOATjZ.lqLMJ2LMlyfa0m0xopJQrHeB0tA0sjOFIQQloCe1GzQhDU7RPBB_AbS2_rEUFz
 fC2MNOznhC.62mF1I1bWqpBbNCDrI_mc.E.0BOv9sZ0ns5Lit9SMgmwmAZG6qutVtcsbCnfrQx6x
 r0DZ.QxghaaTqwy5W6PgQc6tSt2_TKLb.ND7JJdQqxN07gXnR1tHeBQUqud.uRffqbDUuYYluPzj
 eaV_UDGdiJfDWBiNpm3Ye_.7LbQ2p963krasA0U0Qa3_V5N4SSSrbxY1KfieDcltezT4XkXr_VN5
 j7GJGT8AD0F8CHUJsl1tZ7vlNtAoikgtPcO5GUQBCfZVzKJ9.G62.U.IT3WXGrsESawT.KV5UeUg
 3VODWXxb9hZVrZ1PoeaLVUlG1eSwS2R5FCpb8DMYeq7zPU46t8fwbEBrhSwasGzXBVPEW_LXB.D9
 nGVhmAzYMUX5NssFA7sCQv6blo7XSCytz8uMHGxQZWAO61pwDmLbtn_6baxYHAHueBLIyuprnW8X
 wlHHI.FYjCSLgPGDTTuiorNmcRp5l8r._5VGenokQUwx118.SCIbrgzL8gNGcVjDcd7TE2A5_PnO
 Y9XUhqRM6gb5oHZqiOQRjSPs3mieRglptTc1I0ZzLBJt8NHvQh76.n0VK4fQsgwrYn1kOtMbk8u2
 iwQbCxg7E615AzmsMXaoCTW50ye1tNbt6ksrXYq0Ifi2ePd4YuXMokY0kF1ZzRdUSWL0isDK_He9
 Q.IT5lSqjdRC4JwgOL4SM3kP43SEXnLc0nwG8xHNFySk8xAONyFW7cD9uU64MckIOX0AuBzcWR7R
 7OzZkzfpwID2UDFdEPCuD8Eb8vccRlqE31.pPuFMDkIOgWQPOKgwnDCnAOS_DGyK4iirBRMoyUMx
 .kmQQmTBVojnr_H2ND61ziUPPNsK1_IOtZVDceeJaOS_ftb64VfLWdMaITGTIYRVZHZ__U7zxbLG
 AHxSUie.hzzhpSPjihB_hZYRQXfEK8p9b5bjdKT1nrj7sU8rDYNkOuENlu8S7sJBKJ45MXd1W_hH
 CxIwNr2NVBNhlpAcSbYz.FhOEbaDQ1e_toIKnjH0lxupZaN0WIq8T01GzWNZ6uGgJAlssBesmBdi
 PS6fhL7F3cks2zQcAKhAdzr_TWJ66nN_OmqlveV6E7WkS1zvCcnLfypCvyIwkgt.GtD.LcqmNaza
 sJ_xv9JyrWnaMmgp9ToTKVoXC4OY9xFqQSJWJEnXr0IBVGMFU6TH6.m1fJtsjL7.3ieRuM7hHC88
 .dWwmTH.hVNmcHNwGd_C0ayvd675NrSDGC2atcXyn75VCYe8ebRd6QzWjls2fX0MPLR_sGY5Q_z2
 KpoGPhy_zahO_A5uXlZ3pC8mfXktviQOuMD0.aWhaepaPNyI6AAvIq.v0y_MEpKEckGLPNvvRMG6
 k.fEJ5vpCb.LWDsPrc1FoIFANw3r1MsjsuKcgmtpldYLkORrETbhx
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:18 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:14 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 08/12] erofs-utils: fuse: drop
 z_erofs_shifted_transform()
Date: Sat, 17 Oct 2020 13:16:17 +0800
Message-Id: <20201017051621.7810-9-hsiangkao@aol.com>
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

clean up as well.

[ let's fold in to the original patch. ]
Cc: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index 4a9f8e7995c1..d3ee3677e9a3 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -13,19 +13,6 @@
 #include "logging.h"
 #include "init.h"
 
-static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
-{
-	char *dest = rq->out;
-	char *src = rq->in + rq->ofs_head;
-
-	if (rq->inputsize != EROFS_BLKSIZ)
-		return -EFSCORRUPTED;
-
-	DBG_BUGON(rq->outputsize > EROFS_BLKSIZ);
-	memcpy(dest, src, rq->outputsize - rq->ofs_head);
-	return 0;
-}
-
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
@@ -81,8 +68,17 @@ out:
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 {
-	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return z_erofs_shifted_transform(rq);
+	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		if (rq->inputsize != EROFS_BLKSIZ)
+			return -EFSCORRUPTED;
+
+		DBG_BUGON(rq->outputsize > EROFS_BLKSIZ);
+		DBG_BUGON(rq->outputsize < rq->ofs_head);
+
+		memcpy(rq->out, rq->in + rq->ofs_head,
+		       rq->outputsize - rq->ofs_head);
+		return 0;
+	}
 
 	return z_erofs_decompress_generic(rq);
 }
-- 
2.24.0

