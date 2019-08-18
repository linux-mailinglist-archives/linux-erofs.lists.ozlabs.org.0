Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C6191620
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 12:29:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BCwG3fNjzDqt3
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 20:29:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566124158;
	bh=BjOtOPKLIFOt8tI/p5AzbakhV658wxT85VGMRlXl9Ao=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IVCbAs6mcAn6NXIGwTNEc+twi7iD4YZEJY1rV0yZ4hPwVnZveo/L1ummkq0eeNnmq
	 pct8KxvTcc1XDXrJfI1yBZg17NLdgDOQ5BBcL7f0QrUu5kCAEB8+QUzjIgKSMUgRku
	 KxucMEYjr/H10XtlAtWWfH0yxpUXCzAeVi3oMiQjUCYxrv0inUrAolc9cPWxCnZoPB
	 YclGJi5AX3mUPUAjNG7KnmzgBkKpOCLmVK429qqOYrpOM8BgXvKbjAf0GSrsf45MKG
	 2m1wntaWkdcn2dbTzgVRAfY2dGLMg/PtnyO9aNx2GRqMqFZ11HimEW6FtADPp8QQCe
	 drq2r1ynan9aQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="T8LPYUxi"; 
 dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BCwB63yNzDqn4
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 20:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566124146; bh=Kq3kG4vAUTdrMObVCPRyVFAuMwHfmEs/ZHn6FCCJbTg=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=T8LPYUxiK2xlJg2Fy5rLX2tujh8JLR7y/ZFfzKeBxK5Vqv6MzRURmAYMLgjzqwOnlJG9qLVt7NIDAtD3hkjmy1iOnMPlsnr9kdKJwFNilXyMkQJhVAmBAHcctzr3xumZm9qZS/9zA/3Um5TAvwbxqmW2UINFuvklkEwYG7RCcPETJ8autuhTRwpWCP6SNjcGGZ53KnV83avOWr8DADUmBf9Oc9vbdFj25cTMKjOMR8oUHDizDE4KkpqlSBPIX/VrNiiNNvNz43ZoPjN020c6aYnIJAXyEy/1PPQEADD5Z/z9WFRcHbS/OABwwUxWx5nXBqt/d/o3RBmUYnvtWyKd4w==
X-YMail-OSG: R9wyiRIVM1nJGeM4ooCmnAtiGCARjGMIdIm1Jn9dPh1eVJPW3qpdky8oSNJjDE0
 HOyc0knEDE2TAjq.rXJlci4YH6wD6ru6hIgqrxW0y77V1j7q0IwYyn2Bv_ZskOT9XG2MQ2Jt4MG0
 wQ07vLlF4HlH9vX5A91rdH8hCNhHfckm6iMibhglR91BAvJqqDeJSjwHkhG4O1yA_ndTdVxV2u1N
 lF40I1bKXwa0hf5O4JzyCVNd5Zm3pXntP8NW9qbe.kaOQQ.m.RadUdcJXJ2S76C.lHoR9sev4oOQ
 TBVrro.QpBPJ0DCno41OSjXUkYAvV.6KRpsl.gsPMuDDfUU38I3F7UKUxsCJMRQdMeNqXiDmlMcW
 zTw8e6NWn7iCXClk_HUJUY4LTw7pxDECUTRDdpbpSY0xd7G9FFBEyEdZcq8te2MvIRXOmPtFtGcK
 rL0_i2APUkb0gh9y9_rVx8Do2Z_UzN.ppZfupcCteCt9WKYf80oxz_NgooLH2kEQ0ydjgdxgxauj
 rh7o2OG.pMEAtaIy2KK5_gfRvtHJnhxgMscNJfPf9Nnz3x8L39NUHJDybtHlZ3X7LhcYNJYhyeiz
 NdbVvYUuz6HcXFyomsAocpVLOXgQQGXwqPskUQ4kXnRUyFKZxSDH9Y1M0MNxQ3fE_de6.hTrE6Ho
 Y_MKIH.PzIzwqVDGcOFeAzv5R2ALfzW4bOf_Ra1WJoiTsMYhYJufwKR712tFj0DzuJoEhPoMhd2I
 dsJV_JolkLNvu5fVpVYetPXe1NCDqKVXnViveAt2_0OR3r5KH3ivFNFxS.G_Gma9xt1flbC8Ne5z
 zqgYaY1LjvMEGa0DMzL_JVumpxecmMTZIYjPNHQIuHL2axCE_E63PKkZyS3IBZ.6kvgS5e7XQw7M
 p_0GpOoC9IpfatckJlUYcXK1fDxy0tWaCpWMdajCBQJ..rP7c5kHc_FR4mu8RikCGw3UQC.BrRyf
 Si.zmdQPpf6pUrj._60UCeLL873ryJHA1zldmGduuw1y3VDW.CVGJkxJdaRrrT7KPkz_xjgYiVc.
 HvIkE0iFlJ2U_3wqNKhDSt6qJsLCx.dZDTnoQppqmzjlwV1mSJm1wkwh2PdTdmpzb2yByPgcLzeG
 wVe8vniVbvuyv2EjzIM8tPAU.LFD_ij6ttz.e.kvDouRrHk1Dd3nYHy4HQJNRTC3qbtDG7Gh07rp
 VAhd.0QU1mvNr17rB4F23WcQaBguJDpr15LzAXQjRC5I8iSqiil6mON10eiqI81Op97Wrs0w_O7R
 WeWtgvLl4yXNq98DmdQyQfa0qjtCxEqz0c6asPnA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 10:29:06 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 2725d0128178f453485924e8f1102a96; 
 Sun, 18 Aug 2019 10:29:05 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>, Richard Weinberger <richard@nod.at>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] staging: erofs: refuse to mount images with malformed volume
 name
Date: Sun, 18 Aug 2019 18:28:24 +0800
Message-Id: <20190818102824.22330-1-hsiangkao@aol.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Richard reminder [1], A valid volume name should be
ended in NIL terminator within the length of volume_name.

Since this field currently isn't really used, let's fix
it to avoid potential bugs in the future.

[1] https://lore.kernel.org/r/1133002215.69049.1566119033047.JavaMail.zimbra@nod.at/

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index f65a1ff9f42f..2da471010a86 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -131,9 +131,14 @@ static int superblock_read(struct super_block *sb)
 	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
 
 	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
-	memcpy(sbi->volume_name, layout->volume_name,
-	       sizeof(layout->volume_name));
 
+	ret = strscpy(sbi->volume_name, layout->volume_name,
+		      sizeof(layout->volume_name));
+	if (ret < 0) {	/* -E2BIG */
+		errln("bad volume name without NIL terminator");
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ret = 0;
 out:
 	brelse(bh);
-- 
2.17.1

