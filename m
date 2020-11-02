Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E42A2ECD
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyHG5BXQzDqRh
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332666;
	bh=gaRSG4m8wXe5jhEdbESMsOanngEAldhIzVI5iGnOrzY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=bkyluX7PRTfZmlZ1+/5NHXXTv6cpl7dEShXA5rB7icx7ciknuMfldPQF1kkwG65nY
	 uLmTagE+WGFw9XSQb5OYOXAjxfCcgaJgzfUugfgdxNG6iwUoUn1maY/tbLUdU2jeUM
	 9lrHnAFGQweLuthS3nkrVWlBDqm24esycpJJTEG0+Fw8Hv+8TCVS5rRHPkAeIR7jor
	 hTs1Xl7i8yYvh59ksM72bJL/PwUbhW2rjBBPngZfLfU8oe4/4ipS8jzOltTwlhcz5R
	 cN1nGi3WAQgH7FQBGclGKCPmHja+dyC9cIfFmnYojIU7UphjwLiDNapeCLRX03I0wM
	 mlwUKjeHnsWdw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Axpghm4C; dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGd2hzHzDqRw
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:57:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332630; bh=XgDtYR8gBj2E/UIDsiDlqj+5gzhTOznGeMsXLoJmZoY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Axpghm4CxiBWRKo7TjYkQ2DTVX+W7cST+knFbYnmV4cqwcLQRF0r4wzP7Gh7z3YYvzJYP7jNlgp4TI8IoqADSDUBEuhtwEi6uWCsHC9bkn+dcBFnyB8c4/GRjxHqX407CVkENAY2T97T+ffDR83DeOkzagIwoIR0YOqKw6LdGiwY/++xRMJRngiPEGJ4ZVPkqUxWOkAAR1jVVVscxO+M9NKJEnUhEg7kPYlUIRbwhSoXWIvFA8rp6Cf/crufgEW6gyJpFCht5Tup/RZw5zn8FNZr31rAsnzU7lVEyv52TDh7KdyNqFrDGJs3wqjgukDltNbO6p93h7s2JHT4z24ioA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332630; bh=/62vegw4U47wepyznbZrvRjaOtI/FWscHLqECOexy7p=;
 h=From:To:Subject:Date;
 b=AlcBJH9XaQKuuXcHGBS8AvNNUh/acJn0xMxa4kBXLj28SYmdyXh+lFE3knhtDb5oXU4muRIgbDH3t796T0PGfKYFYqr63y6KDRYwqkTBAfcf16D5k1X1dWVsU6ZVxl9tdXHSXrpQ4r8xoYwABU5WJ+PKySUAyRHJJtFLGmJrgMPWqJnQJMHCxegFTNWHGPmQ8Yu8N8F0/zfAnQq7Obg5XDCFY7VvdwNjHupEFxctd6/JDDUSl6FAJeKnVRoG2RGfClnJtoDgj1u8CJah+35OmzQnvTaYC69Q6BnaEL3IhpCZ4hn5O24q4vHPu1N4CN3+FTcuxldBLyA8lJUV8RxjEA==
X-YMail-OSG: q.rLvJUVM1kPtlvDl3xGxWNS4Tkq4Hnd.RcTuMGECGmUoUZcXnvevrtCbKV1t6Q
 6wXn.Y1b5POVrsF2OyIVytvU4aNgcK.aVtKoAyT1rmE1664aRqliCmrcx7i7x3gdjprXZtrkMnOx
 K8ynQrZofsYJnTiAFkp47VtQ4y1WUWU.lWqALeqzM4_0KJqO7ZfGEKbPoYR79e1N7VMtXfOyivVY
 gDumsnCGRL.9X_Ha_V8G_G.JiCWUoGq0paNQkNABnBwat3J7vkhbHXDNsjGFAbunML6E7r2DNYhH
 DlL13RJyMsfkfLqXF9yDvRU1Sj0ClomqivGHiy0O_BKdppvNumk5A8TUrX7wtmFtQ7VC6uK5lkTR
 SAGfAcZ9sR_MjYNsAziExCl0PKI6lsaGmkANBn6KThPDf4e6vQmKeccWauY1jnVsE4mQ2_sz3MbN
 azGyT9VQ93jc2gGNm97shDDCgqq3xC22IvY8K4MOYuuPAgseA5DHMKf8kW3TgJqwDQ72ZtU70GDR
 Ayqs6E_CjRJqBcvHMaGta.imXG1vs5Nc76aDx_ePguG42suFKgWPZPS6CAtplM6cmpmtMGKmjl6u
 6VAs4hMiYBlkxsyg7p8s6CND8xAuV7J6Aa5nquzvgJFF0rcTz2CzPRNpJ5CebRvzUhGKtOex_Jz7
 NTBN4UVby8AD69o6d9hSiZFkNLXkvSJ_W.JRkPWO5acmd0uOriSRTgdten3hZp77U1v68wZ9tKng
 E89yfa_XUB10uON98yNv.wpDd74w9mTdYPm9x1MTZ8U_4P1qiwI4FvejyQQuZiuCMe8kUolGWaUD
 R2yrhCXzNpBqTkzZ4uXQOXU3mqLhWB21MqfFSp.EbFNUU1AvOfXM.uHG5aWHdHgLMHFhfiwr1HM0
 iBu63DgZ2dR58zYfQxHew_5MVZX92xp3zQGs1rEMfJEv0IO4fqKOzUCVmn3CPqG.k3mWDkSOdAKh
 5XT3HVtWVMGP7r0rVCsyzQez3ZmT1kT4Mj4fnJEeXOmFBY61YEX19.Oecv5x.Mm4SYPGD1SD1RxS
 e7tML_xSr0u7.AIs4n4uiv6m0bahhONpAgLkCR8h4oN7irL94rWXdACtrTVkVRsYpGaXpeKGpKoC
 74kp8AfrWds7D.fb0zS3EXugMftQpkZvfGvYz7AL07ZIxw9q0JjJv5jfbqVRveoQGifiR5olhsMF
 CRdrOsel2ZA0Go5AGuModhogf30DBQE8MmfAz8FRs_L_UO9OTv5HPHzd7_9Kt8FM_F6Kk8y8pEug
 GyVAVdsBCqSamZKn87c3bBH3TR7za3mq.yACU5w4bR8tJHtRhGL_0XzDVtNF5hV.KCCcs6SrV4J5
 DAIR9ATDvWjUjkiVqSXY6ORuPuFiv0Y9L8_F2y2azsZLfuBx7xXNzB5lAQzGC55pDB..e8vsFxPT
 znPI0vYi4FmYoGh5VKPSiTBY.IHYNAv8WFLAIx1x9BZ4fWYPzGy7LLDdmcSQ9GRoXyaHVmYnytHT
 _A9Vd_4wImkbT01EybQcLrGmTHpV7iTEcKiHzyFfSZQetwFUVOB7aH4Gyfp06um2hXl_SaSiNm5U
 a1HVJ.DW76CIcNKZJIlrM8ekyd1fJrPnX1NC9eARWlJpweP2uDjysR9.0sF9YTkBdyyJm6aV6PSV
 DOD5LVhdCrFWAM4sEeykwAQ.RakdS7Ss_GaUvCIUxFHn8JbV5omZCqEPdCWJv5RDnM8Rtdk8me6v
 IxrVp4VBhAMzcO3KMtMc_y5ph9dg7Wm2jORJivPockV.v9CildAhhpot8iKHun1mx0xye777SSJV
 8N7NW3yxSlmWzxgTHV7trcHWApN3ays9SCGK3pAzQeC9JRgfBjfmqHLcjsxJH8FpcEnCrbg28BAS
 pfFJpbTPC4YKV_iR6DEk.8AKI6isd.6x50eEe.NQSgFODgCoTriKPwdHqD04_02VqAo8wxhdPHgR
 nPTS5iZKgpPvDrH_YYeYC2r1nz7tF4PRPTqvVZF_QuVim3vo.tYTuwuVygBqB9BPcuqKQPuicswp
 nblMxldM4cTdqfxVWcLFuMqRPFnhIVo2KVa8lq8XCgtkmIQBEWAgjKOQ3VXkgh1Wx1pSO99.BL9J
 ovqzi7lfCsIIpEVViXEy_NGge3_5qg8CGn8VcZIlzx2WsOgaab82MuesiEgAIUCuvwOq8bhosz.7
 hsoP3qFk8PbR9yMCR8ll3lSI4n8Ouzlqm3cKIq1u5gQyLzVFheq1ThwCvBSzuujJ2SLpZ_Jt3b3Y
 N85r5Dp_1TsGiaSNcGIs6WGcm7nNDb8tE05HZW7NrG8AUkExyFs_f5Tk9VFv6g44g1_SpHn7JZpA
 ZQUg0aaAi6oMiPqRFUmKpP2QFeE30gELrjpW9fOhm.yBAQtpNuXYPnxPrnca6XyMNCiLeFZjzUvZ
 CW8RsuOlq3qpZXVULvFymcECMSlVl0C4IrinoWL_qWxPAESRDtEinALNfbZmVSI_D2Xv2WRwLaIQ
 BU937O_epxhaqPqRCUsL_ootpNM6TWOcU040QFwXWfLG2W_s.sp92fWgC9GCAplsbct2DhnEqOZT
 SkqNiZIDuCvcN6f479BDaRp7dMMbUwYOW_2f.WgAk7.N7Wg5U5BLDY.VUMsZoyUm0AHes721Zk3Q
 m4WlLHR8ZvcheGfBKxzO.tca6PG_F0x7EV5e4YxbjNjuzkb5rkXRsBh9ZwloQuM0ZzZO_t.sTTTl
 RySYzPOph32dEnljO2V7FmmXRhL.v8N7ddAZVKRbVXKkyT4Oh7g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:57:10 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:57:06 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 07/12] erofs-utils: fuse: kill erofs_get_root_nid()
Date: Mon,  2 Nov 2020 23:55:53 +0800
Message-Id: <20201102155558.1995-8-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/init.c | 7 +------
 fuse/init.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fuse/init.c b/fuse/init.c
index b4089a204409..d67c7f0dd298 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -83,16 +83,11 @@ int erofs_read_superblock(void)
 	return 0;
 }
 
-erofs_nid_t erofs_get_root_nid(void)
-{
-	return sbi.root_nid;
-}
-
 void *erofs_init(struct fuse_conn_info *info)
 {
 	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
 
-	if (inode_init(erofs_get_root_nid()) != 0) {
+	if (inode_init(sbi.root_nid) != 0) {
 		erofs_err("inode initialization failed");
 		abort();
 	}
diff --git a/fuse/init.h b/fuse/init.h
index 4bd48d18b003..f0211707b5ff 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -14,7 +14,6 @@
 #define BOOT_SECTOR_SIZE	0x400
 
 int erofs_read_superblock(void);
-erofs_nid_t erofs_get_root_nid(void);
 void *erofs_init(struct fuse_conn_info *info);
 
 #endif
-- 
2.24.0

