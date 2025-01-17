Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57783A14BB2
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 10:00:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZDG35Zr6z3clL
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 20:00:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.169.211.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737104411;
	cv=none; b=aqk/hqwWbC/EHAmrwbqLwLnkcTGXmbFL5JbjX7GQOjIoHmnTNFMHV7PRvn/+EE12CdizBRgdnYRq0bbIb6Easy0rnbwmi5/knbfAGAHwKrsGNV3G6M4ptecNL0iL0SZ1Q6OHNL5ayOLG9YjtzJrPjlqFapkXTa0I4TyQI+Teh+T5wGQOsFCOwm68GSTCElsJFy3TEa3QL1HnOUX1sxu/ffq56EIK/Gc/xQaDQO+SXRpbfhEZOMAidqX/i81WxSJV8mTn/DbuShz4tZVtI6vvy4vWpQx9VkJqcMsVzJ/w7huCzgFs7r8NJAIVyq/o+QIlCW2OrnzsqzGkB4QZR3ySJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737104411; c=relaxed/relaxed;
	bh=oyD4OSv7s0u4v1dOVzIZ2eviXQch5B04ZycYDqMw16A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfZihciLLq4lbPBNbN6Ni0NqkB759HdEnU3yJm2wuRIcq1uvQkHwCIJJIA8YDu0aZK9OR9umeKvfpCaKM6Vt1h+W0nsSd+r4Yd5UKHtZbDeoI8FHiqLO1KABRg+Z9G550L0m2CwnYXmywasjZr0m/1YHOQvP08PFqX6m71pf/nkfm8Uvc9wvNXdMage63cDfrOnJLbXm2Vg8PkfpJfZHP0UFONMUSG1m5JPkZClSG/7bFznpie/oeosDF6EMitrPCB5zeX0M5U4FVQ8VntAtSeJUoZyi4Kk2O4/cWPrzi4gtyrr2yG+PC+rRYaJbngrOEZQdtYDLl9z0SiPD9Hk3OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=OP60OA3Z; dkim-atps=neutral; spf=pass (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=OP60OA3Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZDFz6V9dz3chF
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 20:00:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737104394;
	bh=oyD4OSv7s0u4v1dOVzIZ2eviXQch5B04ZycYDqMw16A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=OP60OA3ZB0jL1MjhGWFX9mR5idQzTqgzfmh9G3OyuyqEscsI1OnOrvXdUq+e8H8YF
	 jiEhz5BPaYc96wJEN5zgi6GpiBrqUIMPfb/ooTDDuxyA0c6AmD3hUFl4+bSEWVjfLc
	 juSRy7gACGZwFjTuykTzTdrDF59NHo0gdVx7HfFY=
X-QQ-mid: bizesmtpsz13t1737103973t7vb19
X-QQ-Originating-IP: qKpG5HBEqo6FNixDU+IuHskNOHZjC+NebJ2qydNITTI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 16:52:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7382260033576977185
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH] erofs: add error log in erofs_fc_parse_param
Date: Fri, 17 Jan 2025 16:52:43 +0800
Message-ID: <F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NAtipnnbTPeaJjHGkzlkw8m+Z4LIeNwi0YzRAxvpFwyjgUcrmUktkdfs
	gL+6APIvdd0ivj1NYYz0ljzZFzNJpy7xvJs8AO244ckFO+KPWF1LQqx71ZQ/ECn8e0Xm8fl
	PThowwvriu2Ybz1lpOOLJ4ihqC77jMU4/KBcf8qVq+fzzq44+k7E8/8ic5pFnapwJKe3Sgx
	y56cFk8ji0dvGQ4Ek2UJIUwneX9NM92mg7QNW4pkczsifty6eNGOkvoaED5I773vH3M9qJS
	ShGMtQb6xeR3SSon9I+JCD6sgEnSg+JGfTycqbIb6Bf8DQGUdHghocBN+JBijRJiJ/cdilp
	RntrSouUjccd2aZJJLUIJlyuTeWAqKfVdvCW2nQHihNhk6oG3Tt5L6gkC8dFNzt5KxrybZk
	KIBY0wypN5+gSThcJncyYZ1xysFwQWCdLYG9yqeGNUGusWGsawE5sMgaLmjE/p86FKw7tNg
	xh4V9jS/C7IF2YHfIdXU3rrKEe64GZeOIAWNlzRBaxly69/PD7jcPHUT8aplfT1YFwWMXiR
	wqF6VsbZu5Ak1y0JAxM6Js3O1Q9d06ITkpaRCAGiaszdQjb716W1V4vxz/nC3WDlUq4qqks
	xI+ijT6QSRazWdcqjTiUHM9IPzne/INFiLoNaLAkHs8f4pW3fzix9aOKQDdWf/Emdd26rNS
	dSJZ+qb9itdSqFy2JOiHjZi66sJBno5GeKMAOgVu4+LkbdSQXCopKp2wMZ19KzpQhbXVnte
	ittgnWMBSeuP6NY3UTm0/Yfh2sVRlGjbFJzZrDGSboa09ACrF/v41a/nM1Tl0psprlE6dGP
	+DXFM0Zhg5kf1QmeGXtN1kPMlgmGKrc16p40HY/rvHD+/9q4KTJ0xuzxO5IAnKAR4dw4xw5
	4xAyG15Vha9+ZWe6T8JG56BbjSO91gJ8yz4yspD1v0v15PJ4zPmOZ/wAfwGy4oAJaXMBhCH
	v7lsHXvgQZYw2Tz7Y2clTbxgPMRgrfDotoUvtNIuw5CwVGQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, Chen Linxuan <chenlinxuan@uniontech.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

While reading erofs code, I notice that `erofs_fc_parse_param` will
return -ENOPARAM, which means that erofs do not support this option,
without report anything when `fs_parse` return an unknown `opt`.

But if an option is unknown to erofs, I mean that option not in
`erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
which means that `erofs_fs_parameters` should has returned earlier.

Entering `default` means `fs_parse` return something we unexpected.
I am not sure about it but I think we should return -EINVAL here,
just like `xfs_fs_parse_param`.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/erofs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1fc5623c3a4d..67fc4c1deb98 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -509,7 +509,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 #endif
 		break;
 	default:
-		return -ENOPARAM;
+		errorfc(fc, "%s option not supported", param->key);
+		return -EINVAL;
 	}
 	return 0;
 }
-- 
2.43.0

