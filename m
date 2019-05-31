Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2D305F8
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:52:19 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrw5ddvzDqTv
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:52:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263936;
	bh=GDJnRqugkH//pGRbpbmmiqKU6rOciawMbyQVBhX7glU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=aOMY6Ezznrrl1FfDUQ0KBf48AAo/XOWuvtm5wS8+NchSkfinJ+uomD4p4VE6WuQvw
	 PNq2AKGOr6vZr/1c6GLgMau3WyyQGV4CmNUxtNeMfW1icQBD6r0kJ5dVx7h1Q8Jqpr
	 UWgp6zkwq7hgYbF411fyVWlj2OYwkv0sTWUgHoe0yNr+BvrT2H0trio6HInFnTOVh0
	 jbSNKynhGVFEX+XMgyswm0lzGMnBwzIfYqr+AR8mgkMZWPhduQ093y4v7uYgrthXkF
	 Ru7uuegkJhZukV2bpVJwFfk1pHNAU+oHKo/I8fCttLxJUivbgZbadeRuBwJscpR1Qo
	 mlqPkwADlKfng==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.148; helo=sonic310-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="BYcAls9I"; 
 dkim-atps=neutral
Received: from sonic310-22.consmr.mail.gq1.yahoo.com
 (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQrc0Sd3zDqV3
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263918; bh=U9+vf6Os/tMza5y1PDASWfPrfq0VNbS2PdC/Zi4r460=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=BYcAls9IuGuB7maI3JIuPWqb0SqOvCGr4scrlyieK2zv3mfvEUEUyzlYgOGdcZMPnfusvdOaxvTTALHhcocJ7w0Xk38XBhG05g/JXyJBF6sBBdJTnOz0FioETwhHkzLw67/nh4edaB7ycF0DVGMSnp7bqwoubUOpRu1Cxp4iGgwGbisW2SzY+U3U+wlJXJb1wnq+NEpWFAe28qG3frdv4r5N1NiS/qiROV7QQN2bX9YeWIX0FRxQbGxHFG/BpS6MkLedTTXZHRFI6opDjXi8XLFoC2uEe0yp0+oXasgNNdSVzdMocj263vQiYbye+UCC53ZMkTrpRLLxPcBgVnWtBQ==
X-YMail-OSG: Dq2_3Q0VM1lisZ.bWiDWRXf5x0gp38iAHAaiWmT8edL7PhC9yMfT.9gpaR3lTUV
 Lles4viydVXbmG3u8OVu3k_fPUeFkQvzaBQeV2zVbHregKi7J4ebrEhR74tDieQwDs4GiKdZpYG2
 cw6EHUWH_7OOvv4XrcS1JDsqXgPlsGsodk4akDRxMO7WL5RYDfFIJnssEInwxquHqO9GQFXCYjL5
 w_8BoRsjqxZSwD9_z6_xeUgUMGddR8Xqnd8Ds3Qr60.Hw.4aNa2fObRS7BHt0nE7Zh94o.r2yrkG
 yA3b4c8xu5wYm8JZBq4dwV1047eHrulneDJEfqr.o1yLhkfatD1gs4kvlOu61jjUZNcFI93Mf.7i
 1zL3iySyTNrFC1Gq_vrihlVqUJvuPthILzYiLSXYxqY8N6iGjZT1NY4q4K7vK7JsfJe0LWVgy8dT
 L6TJ5oJ5ZE74C_nO7xYzgDG7ezbWm03aavgEWnQ6FF6nNjjPwTj5WRwPtNvazX0RC.cMG43LCA3i
 SPDI6JBllqPWkDfSw3g5XeDYyHHWr22YKMQ7b_xTrl5rO5XuHSKDp3nUynQ.PUb364tugPX6rKyo
 5WzRcBoFQtYoWD556m57sEn0sY1mNYnv.dCPrxmN6Z6poN7P3v7Z4GzMEPwS5KOYxHhUtM5u4PX4
 6_3Qju_J_.KP12tkm77MasXucsyWT_63ZCPQYKbxBLNgAn54JVb4POjiChjAUIpCOmoKgZCLyWDA
 jQblQbUP5U5XvhnKZbIpNN2itkUhrWzBHyQeGzUq_RcgoAiVGE_W6v4Z01aH.KXZbEBc2VPfIFpB
 OcG1_1f_0oOWS4CNZinFExqrCHoNfGTXhDqDDYg_ZtYc3XgCyqDcPmOrj6Bq4sBRxosRtQHYOouA
 Xr7EnJb1XyA9kprETyNSjUvB_Jvbv9RZwKpRkZsE.gjerCetzcqbWwOhLBC10kmMbJjeHSK2RkQE
 dgieht2meNO5Rn.5Ppcn_IgeQvrtkq.yB4F6M0GT8.L2Ebjv1ft9e_Y9wn3FMOKAdarK5_ZmyCfC
 F4RUf4vw6ewrNaOM_4ZiY4wDw0TObmgL4Mvs4EB_wbrgj7C69P4O5VG50hR.TlZFhJx8_Oq4UNrd
 s23gm6KK0vB7_XEM66JHFmvDlaNMZp6RxnkIOL3Ue.KTAebKRw1BWu5ssH3Rbbt5vGB7Z3rAgK2G
 c7ExinLVaYlAUIUi3QQ7bO2eTf1wCBzcHe0pDqC2wHKlzi41fEWfnNKapEg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:58 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:55 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 12/13] erofs-utils: add a README
Date: Fri, 31 May 2019 08:50:46 +0800
Message-Id: <20190531005047.22093-13-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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

From: Gao Xiang <gaoxiang25@huawei.com>

This patch adds a README and some warnings here.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 README | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 0000000..4d509be
--- /dev/null
+++ b/README
@@ -0,0 +1,11 @@
+
+The new erofs-utils introduces a completely new framework,
+which is more cleaner but still under development for now.
+
+Use the old the mkfs-dev branch of erofs-utils temporarily
+to build erofs image instead:
+git clone git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b mkfs-dev
+
+Thanks,
+Gao Xiang
+
-- 
2.17.1

