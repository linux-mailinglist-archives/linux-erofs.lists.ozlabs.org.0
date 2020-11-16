Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222822B4BA0
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 17:48:30 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZZlG5s39zDqJc
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Nov 2020 03:48:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605545306;
	bh=aFa3AbmripzfPc4zOhydc5jnYmIwZPRqlPY5GfUpLq8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MmXfTS0x1Zn1nTKQCMjbPzMYsuDXplbkCA6fMfr/2Q86fFZn+kzQdLc9Kf5XGkBVH
	 VMbMi4Dclei+q+xlkivryDJwmKgO0OoOEi/9mztmloYhwK6efiSReudYM3QNvhBnyb
	 s3RQmXu9L574A87/+dcLuuHraEGvc87CPe/77vnMYpUGdwDxLxqIte/U/4LpRngAy0
	 WENF8514O7vvbBfYPl0+MTF5fnrz+KJtBa2dsuCfUmbxUnArafZTjbp/GAiQvPryr5
	 1CL8r6C0Vqb8o+Q5Ozyq6hTPckNn5KbbuDKXfPqGb0IWuqQeTGhI+efjvcbLav5eVY
	 6WblP7+d+fXtQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=tyA3MH/w; dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZZky6VD4zDqDh
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Nov 2020 03:48:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605545284; bh=im9O2EujS8yRd+BPSL8jAkxeyxnuDCxaoKWiPUvS8rk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=tyA3MH/wl6rI+ZE9Pf0SfiBEro2ocoJJfdSA+OOjXHUrmK8qsF8MJZtTnyyxBsIWOqz49FfJgkEtNg5rrOPI3gFMwn9WOBFApsbyS/JXUKidThqhzJCZFL+UegaVDugA4WeCNFtJ2sc948OlYifXKh6APIVDQXetAMFEtRehFqgiJYdpYXtvcBiVuJ23Cga4XxiQMGpRnZpcKgwXH/sKHfm6dIoyR06sOP1G16k5350O2zMw9tMRm5HSiFIyukcP9pQryE7Ewj7U3W6cmHOOfMSP8K+Su3xeiGyfcUQujvdrakSCUlo3XysFfuS+/qFoU6sPRjQVLIL708uaePvXsA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605545284; bh=xJM/zw/JEhq7mfLl9iPbzlVDOgc2sGeZhJPEWvQj19P=;
 h=From:To:Subject:Date:From:Subject;
 b=o5hXhLKDKeSu0XtGuoK2fDmRvDvgmrCCUCP3kcmkOaz/kIt0FwLn8kllLN9Uk33htLEGpRcFU3Yte+/IBoCZPnoq1CKXjs2vPpHr8GQHsszN4yNbNCNslGv4U0GHtsOs1xXJd3+z8xz0O1cscNJbV8RulUYJeBVKvR+dbLXiRg8njnIJnjZWYVzesudyk8m/Ns6Dn4AxQszS1MA62/Ssy8lumMijB+lYvYvmiIG+o3A9rVbLIjdPtvpzjS0SiXp4PlVmbpliFp9Uk5A0FBlyxyUFfn2RB/Pvmh3RhiV2iDdWd5TlfugxL6lnCof3rsrmgZ5/o9Mz3Sgd76riJDuynQ==
X-YMail-OSG: NAD2ZbEVM1nVA2zOVPXNoSK4SwzejfDTFH68VQ5rog6rUoBOaC48L4RsLsNP22x
 G9j.XdVo8_Wekf5Gv5afiRIW1cFjHLlA7M9PE8aOkvhlQSkoECtr4cdIcoXMrqxHw0TPhL5aFKIq
 BbtGPmxAOQ6iwuJ739Bh0fCS5qPB9XalC5x3G.55cauyI1cmiRHXxGM9UDBsA_p3vY7OE8A_OMqN
 5RU.eNsv3DiSOinckfJg1zvx0DGr9l448t8ocMegGwChifYL81gUgBsyre_QQDVholqV7oCgadnv
 bULsiz33Yph1OcsNFUw2PyBuiBGdoCEEbBF86qWoZNK_RFzJcJ5WCTTmals_DMg71Nagirvm5qgV
 FaYZHCISladkwb2caNZc20JURCx.27_Mt2EbE5mW1sXM8aumgYjpGOhEe7fjqw3xwR_PAaxUBt4q
 qhXG0yFZBU61T5S4qHR29DHsf.SBarlzbZ3hqJkwMmZoZR11qhHJM7pe4LoOviERBpWcbE.ZNtx4
 ItlNb9eR6XHt3_JLusLCXzTMvXhmx6b5RYKIu6miX6obgu_vYLOsDTMnAhY3.DstrgAYlVltRx5W
 Xb4FvudPgkwD4N.g7.wdfxjGEagdfN5Ke.oEAVN7SK7903VYQ_l7uNiSqNoBzcl48_zr66Qa4O5b
 .34Yy_q178zvQBMILEdfZFxlcLdZMxNGI2fhlm.zj3Fi2GPYKAQ8Q1shsnvx0Q.0rn4q_37nD.ZU
 N8sFwrafal4sp.bpDmZjvmlPu8B1kk0J3LnEHZBz_dl9d2GDTrkUPtiT6BMC2p.5rHF1.hWe4A0E
 T91KMCkb2wlVgszkOus6iCbDIduCGRvKTsPfc6ofcbzZn7w9uoH9Z7G1_ukRSPU8WXhGydXj2hmE
 oHcetjotUGuQ7aFWq0YDt9zuY2c1JqbTNFTrrfaAvABGURMogRW9XEJG5N2X_5aFrXWcOmIlDeXZ
 EicG7ZMWYBVNBEBOkDuUa9fUfxRshuCz1KO7y93VyEhtR3lG5X3q.6MQwFNX9VuUj_IZgmuBZyE4
 CzA15FPrT1wtuTqw0o8qSfzrNzboi069xo8nvHNrelv7uMNIlJ4pdyAv.lHKOq4WJZtQR1tGOhqr
 bKDlUtWvqhf99s8hPC.8XGWzbiS5d_ajVrtRbnzzvyOLXy9jSgRSwnGZRyDiUlpaOxUwlgYSMnqP
 _gC6NVxLoZ0QxyPbjCcbOjidV1DY3qeeBtqhYjpduizG1G9buAT_rzjenw0flYH9InA.LWF_sMLF
 cm7mBz2ma1JO21SDKa22BOaU9qym0PyjFfPjIz89yqiMWXHLrwJArN2uDkasijjwlfpwwRwRQgRd
 364o9XOxX77OzagziUo9nRPIXZUfwD8NhZ0gTvjRQMCWCqhfLwWXYC03HYrcDXUueFSwbefI8JVt
 gzYjI2ytYGoI6NfabPMnxj99nG6MfRTZHftKok2KrtGBS7wimIvnKRnC4I3TXqMDqlFPss1Uz64o
 ZLig_G3owgz.ZAHOXhjJF7cwAWfcQpEOypPOpt8_gWUPeUA8nnkle.NEdPhpkpoe1pwSRDfdnyoy
 qXXGprNUZ8PRi86QdogXuVaWVc1pT7sUlgzs9gyi9PpmW9qqVrz69ngy0rvfcVhlhB7XGgjjMtiM
 H9A2Xf6krkxmOvRXTuXr.jFahmlR0JY13sYC79Nm9yThXAUWoVt5wsMhURamCawcxGfjCzxRyGAL
 LPSuQXn3NSGfLraMmi59s09o_oYo9qKc15509zZAKdicE4mAjyZklmBJyO2WgP9Bifb0Em5Q72Dr
 uX2QzbULIgVE5Ue7XfJNDiZeL1lrqIZY.cqnjZoKCs4dNbRZTY81E1cH9et_nhsBkl07wNGlD4nO
 yzNCaWJocu5b0jcKf9uQvXjlfgmRawQluJd1RrDhCJX5vT.QhwdWUUUNZXhEJR67N56ngERkTAwe
 HPNAoMvlknlOTZA7PEQXl645jfniOe_jPLCcrEU1h4ZuE5It5tvpZ4lILzsajCl8GwfibBT1QLgH
 79x83DvLpE5HvRPrTzxOOSe8gQoUG8UcVrMaPjAV5bLBYlI.QP_pRNZALO2V5zWJ4jRuNQ03CSIi
 rE0CGDyhLoCWEsO3wldvgxGuevR82Z5_0CdWEYxLURO6NL010NNXXpWULZ8okIH9qBmpFWQ6Wi0J
 5F0uoAnB9vPoocpTDQn1.m.kUQmdCtUTTP8b2kXCpYYmcGXA4E2XbgJSfwVxlBZk682Mog98zq1l
 _enM1Kdtf2UEO8hxtzpWJpBkkLdsR2B_5rLiAEBiqtthuvWUgXXFQTTuhCNpQukCuCuYGk7I6E2I
 iwcUG67X4qMuMCdCta4zFgOKFo3okkUJjgGD1XX0E1krvHIyuQ99Vc3xTqkCIdLNDsxW3163tS35
 IMPT_9CfNTunjMcWugTRyDNEJjO29sS5aodfloa89SjBG7FlM8WuGBH.YedBRnGtub2rGXQ1DYFu
 WEMVU_3y_IFLEpARm2f5aUCkQQGmw_0N6.0VopjqMb_fyfPXT0WLUm1e1gAHjJPLmE8XbAjrDEXL
 XohOLKRo83WlHQOdMjinbsR4aSaNj_soTKAiu9FIbC3DujzOCvXNBSB0xOOjeIlNsX50eAxbX4zM
 qp_n5llK0UCZvRrBZ_0nC3iTJ8XseC0qbVtz33KVqjWZhXdnrzi.HkFGjFt035UIF6NEzCcPu_LM
 UgpE6q4qQstM6jDtPgEpQ5zo4MyzyYKFA8HFIyUAe_zk3a8CafaWHIjLqHF1Z7api3whfZXHwScJ
 VUxU_BIdNfSEa.B_prZb.sZ6zQbA7REMN2LztgCNOpGeIb.vggCaqpGdcITfpn0psJ3VjuCpsEzI
 Fvg274ICMmD..khmuHJo1qCVcanJ90slf3M_f0dxNQ6mKaJuWHQaYBSfu32MGhCY9MDdK.H4kyPG
 bDPSV
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Nov 2020 16:48:04 +0000
Received: by smtp411.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID f765e9696e0a00a38a33ee4c6ca64884; 
 Mon, 16 Nov 2020 16:47:57 +0000 (UTC)
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 4.19.y] erofs: derive atime instead of leaving it empty
Date: Tue, 17 Nov 2020 00:47:37 +0800
Message-Id: <20201116164737.4184-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <160554164363107@kroah.com>
References: <160554164363107@kroah.com>
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
Cc: nl6720 <nl6720@gmail.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

commit d3938ee23e97bfcac2e0eb6b356875da73d700df upstream.

EROFS has _only one_ ondisk timestamp (ctime is currently
documented and recorded, we might also record mtime instead
with a new compat feature if needed) for each extended inode
since EROFS isn't mainly for archival purposes so no need to
keep all timestamps on disk especially for Android scenarios
due to security concerns. Also, romfs/cramfs don't have their
own on-disk timestamp, and squashfs only records mtime instead.

Let's also derive access time from ondisk timestamp rather than
leaving it empty, and if mtime/atime for each file are really
needed for specific scenarios as well, we can also use xattrs
to record them then.

Link: https://lore.kernel.org/r/20201031195102.21221-1-hsiangkao@aol.com
[ Gao Xiang: It'd be better to backport for user-friendly concern. ]
Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Cc: stable <stable@vger.kernel.org> # 4.19+
Reported-by: nl6720 <nl6720@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
[ Gao Xiang: Manually backport to 4.19.y due to trivial conflicts. ]
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 drivers/staging/erofs/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 7448744cc515..12a5be95457f 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -53,11 +53,9 @@ static int read_inode(struct inode *inode, void *data)
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
 		set_nlink(inode, le32_to_cpu(v2->i_nlink));
 
-		/* ns timestamp */
-		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
-			le64_to_cpu(v2->i_ctime);
-		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
-			le32_to_cpu(v2->i_ctime_nsec);
+		/* extended inode has its own timestamp */
+		inode->i_ctime.tv_sec = le64_to_cpu(v2->i_ctime);
+		inode->i_ctime.tv_nsec = le32_to_cpu(v2->i_ctime_nsec);
 
 		inode->i_size = le64_to_cpu(v2->i_size);
 	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
@@ -83,11 +81,9 @@ static int read_inode(struct inode *inode, void *data)
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
 		set_nlink(inode, le16_to_cpu(v1->i_nlink));
 
-		/* use build time to derive all file time */
-		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
-			sbi->build_time;
-		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
-			sbi->build_time_nsec;
+		/* use build time for compact inodes */
+		inode->i_ctime.tv_sec = sbi->build_time;
+		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
 
 		inode->i_size = le32_to_cpu(v1->i_size);
 	} else {
@@ -97,6 +93,11 @@ static int read_inode(struct inode *inode, void *data)
 		return -EIO;
 	}
 
+	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
+	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
+	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
+	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
+
 	/* measure inode.i_blocks as the generic filesystem */
 	inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
 	return 0;
-- 
2.24.0

