Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CB49144F
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 05:21:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46B2Qq2PfvzDqXL
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 13:21:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566098499;
	bh=TH5OErQtWlRQi3QEPUM008YSuCHMrERpcENfLwCgVQU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jgD7+ufVC5lU+xad5VUFZMkc61Dz7LVd1Wbys5s2wKO1s/+tKNte8jkfpz5Plmsq+
	 sIFMh80b1VKM5HLzR7tWOsZ1JpPI3xQNUSBpAFy755jl1y7PDqjnIn0VBBoXUUW+EO
	 almEPa/CyJAJL/eixo4BG4FyVvjuQC4aKMlH/R/OVXqd7MLFGfKVKIHmIslQmk2nfX
	 UEqDzNg4hpsAYXBA/9pSpX3SzqnHw/tiF6KkvJ/3ME8UKmxVX7myZiE6NkVW8O2KT+
	 T5XvEk8fXSNI1QenrdNdusipOrNpIqJViF2aXv0ddeLECpiDXcAcRvH1cXXzPGxFH+
	 Z8nXg2i0v9n/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.200; helo=sonic303-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="kIAGp1nW"; 
 dkim-atps=neutral
Received: from sonic303-19.consmr.mail.ir2.yahoo.com
 (sonic303-19.consmr.mail.ir2.yahoo.com [77.238.178.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46B2Qj1QWrzDq7d
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 13:21:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566098486; bh=VL+r3q3bHO+kJBlNK0FTX8eiBkYwN0lcRePyte3rpuA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=kIAGp1nWCsOw/k1KQomjIlaawsK4/bzOKoPFXUuxOhrXsklJYDZTMJi7uvE6MLOTPshKvgHpyFORD0P8Pj/Y4hNa0GHJkp2+hux7HpgPz4ZD3AAelvoELwScdVvYU7KYbu06vro5Q8UbI1gIgpbdrhHPWrKdZjv8MyGKzG50oVdzBjTy83FMsTEKhjx8+iFksCV81IK+AY0e8V23nElUVFoedmdzwQnOtHxzoF3BkcPpLoXi9w/amKOxNq4+7+01UcrbBFDjOCwA13rzAtfVNwJLPMfYgMFLDTZc7W0Jwa2WBgjRRLOhfR50JhdoNZzNOg82vNLpJLhTcIujmDDC2Q==
X-YMail-OSG: FWrmF6YVM1mMpmZFRk31_RjMumU2B_19tQBXJCiF5Ki4d2DlaFsT48GMCYHchpz
 6RWe9ncYWNB0H2A_wQhORs.IU_QWsEcm3TarLOAwAOcbD_FKNMFLMJFKt_KkSF_0X6lOWS0evqbZ
 fCv27pkzrcpxeEOiY0rjb7naSkkUSGPuQ2dts8.AoH630jNE.v_P5KzgDtUN2qnh6sIobFhitSiu
 .7v65zhtoX.3MgL5Adig2bsjrhELEB3OgseTuv5DCf4xTPjFHnepCamxTuMe2im.AuXRYg_HL6gk
 ovJORNWL4vKUSTwhzzfTCdNMid0cx.Bc1HAUEg7zKTAPtqpp9vgp2raCCOMsFWhNn9QHNGX2sWd9
 62T._m9ltqNgp1MH0g9zDhLAjdTrgS8NbyqO0yhbtbAbZlvHFtY2r5pWrzhR6sMi7HxZ0atzwlzK
 xqXOs0vGYLUI9dRr_mjRkNKljMXIqD30vcb1BrV6gYYN68XEWcUFZH9F4RBnP8.5RMzPWrdpzHUw
 TmRHMACUU4gnp3qcQkTfZ_CBsHsvXwxPQVNAaoNyeCaApYoyUe0oGD5Mvtjei5i48R3wvFqNBCkg
 FXZVrrWWD2ieh5g_SZZcjAFlG5LO087IjQ9vxGON0j.x9TdCQ2gaSdJZGW5mqG1A7maQYWWkfRkB
 sq_jecK1qeV3WqBzAZVhMRa6T6K9DTLxBhjITgtjWDM_CmBvILQ70OMorTa8uu4zt5hckpymANAY
 ES2cm3ZwB9gS8.jkT7q_GaqF2oRUTLmQuP84EW171mdybzwATfXZwsPVlL6j9V36OCyyo5QbGtKP
 3MCO1vaa_5g3Kz0sQEEigyIGXqigw8mVg8mIfKtknC9DiivY6wg77QKWPdxFMuuXn6McCiq8QZoe
 FXBJD.xai6iwdA6WkHeSpwHP2MG4mIHBzkjS4.tzoALwvrt7xyicM2jQnvFtvhOVCXBRzdi1bw47
 hhEcZTMSw0Vp48eXXk5tVYPwRGy0hBGk8M9UbSFdrCePl6_qtcgrCKa2Ga_r7P8K0UZBaH8dRxC_
 EGd8h.2q1bq9tGtsB3a05CCzoyNaSt6dFT9ZbifDF.DLzToZNlR4hJWpgoKwXTkz6oODPKkYb9CP
 RC1KQ90QMjgiae99qSLe84w0lKgQV5gwiJWDfMbXc.Y2LDBVN1BINoQCkhlSTGsMqvPncaO3Xr23
 ALaxLwowm4PRQtPjUDBs0lZWjsIYzwp1eHUWa5FOZJU8ZrBiK7YmOqVN5Kp3QnqWMv1YKqv55dZV
 Jz0cMAHHRIKk4aJ76MKwuDs2_mv3rMj0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Aug 2019 03:21:26 +0000
Received: by smtp408.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID d0778e91ef06b470a11982e764e03f0c; 
 Sun, 18 Aug 2019 03:21:25 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>, Richard Weinberger <richard@nod.at>,
 Matthew Wilcox <willy@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 RESEND] staging: erofs: fix an error handling in
 erofs_readdir()
Date: Sun, 18 Aug 2019 11:21:11 +0800
Message-Id: <20190818032111.9862-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818030109.GA8225@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190818030109.GA8225@hsiangkao-HP-ZHAN-66-Pro-G1>
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
 stable@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

Richard observed a forever loop of erofs_read_raw_page() [1]
which can be generated by forcely setting ->u.i_blkaddr
to 0xdeadbeef (as my understanding block layer can
handle access beyond end of device correctly).

After digging into that, it seems the problem is highly
related with directories and then I found the root cause
is an improper error handling in erofs_readdir().

Let's fix it now.

[1] https://lore.kernel.org/r/1163995781.68824.1566084358245.JavaMail.zimbra@nod.at/

Reported-by: Richard Weinberger <richard@nod.at>
Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
[RESEND] --> add the missing v3 version in subject, no logic change.

changelog from v2:
 - transform EIO to EFSCORRUPTED as suggested by Matthew;

changelog from v1:
 - fix the incorrect external link in commit message.

This patch is based on the following patch as well
https://lore.kernel.org/r/20190816071142.8633-1-gaoxiang25@huawei.com/

and
https://lore.kernel.org/r/20190817082313.21040-1-hsiangkao@aol.com/
can still be properly applied after this patch.

 drivers/staging/erofs/dir.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 5f38382637e6..eb430a031b20 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -82,8 +82,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		unsigned int nameoff, maxsize;
 
 		dentry_page = read_mapping_page(mapping, i, NULL);
-		if (IS_ERR(dentry_page))
-			continue;
+		if (dentry_page == ERR_PTR(-ENOMEM)) {
+			errln("no memory to readdir of logical block %u of nid %llu",
+			      i, EROFS_V(dir)->nid);
+			err = -ENOMEM;
+			break;
+		} else if (IS_ERR(dentry_page)) {
+			errln("fail to readdir of logical block %u of nid %llu",
+			      i, EROFS_V(dir)->nid);
+			err = -EFSCORRUPTED;
+			break;
+		}
 
 		de = (struct erofs_dirent *)kmap(dentry_page);
 
-- 
2.17.1

