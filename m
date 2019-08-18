Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D191449
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 05:19:43 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46B2NX4PNyzDrbK
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 13:19:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566098380;
	bh=S48WEQlVMdj/aIDwvWLa0Aokd4kbp1sFrcT9QVPIpfg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jfsZQMRZdxx8PgWtgLubeDe+mzY3abHtUm4aP3L1Tf8c2OBk/AjKhei6laCdU7pny
	 lF5DMsbeHYeq4Y0EV+n4K1pgYSksLSPqMwSZJJuJM9vI7Xz2BxlnoJ+PS4C5V10+wS
	 SDMf05M4HpsAHoLauWZfbGcUl770xr29gYkD+sX+UuIraGLrtc8dO/eieZalD6eBuc
	 x7UyMSGY4+v4dJOLtG8bxg70UjgwuHJ70oqPBw1sfQg3b4XN2V6z0obh08cpI83Lxd
	 ZE6OlHAas/OCzkzHFV+NPa9NE0SOg83bhFlUltoBNpyxkHBlNbn5Uas7OH/keF4Gm3
	 XR0nwR+E1hbew==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="kZV5VM6c"; 
 dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46B2NK5xRpzDrVL
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Aug 2019 13:19:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566098365; bh=kcWMxbdQGZI1Ki+C3vmBFZF1GbOm6oYitbF6P/0gDu8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=kZV5VM6cLvFxjQP2mcKTMF88r23oUK3sIvk4uIGh9vL+rYIBc+N8zN8/KVMR23b6GsuP4tcoujVCCP/QWpvzFbtsr2RSqF/8A8JgN7Mzb8Ap8WoN7L5EupMIa1AvwTabgBLGzADpOLwaBcEqFMQeoSZM1rtMKrDycN7rjATmddF+FyPwaYExdZ+dha4lrJh4MddR8WSqszEXrDXlCna0SQi0kk8k8O19afLlGsUkl3HRFDD9vh4VUY/juqGFScbq0+3yweRxNhZVJoADr9YVcJ8ntY/3vC9zuj5OXR7LuiTu5AhGFIaDdljT25d6lD57O5J0A+GHhIGWCZNnMNqMjQ==
X-YMail-OSG: MuPWzmUVM1liylvvXTnzJSRaYkcnE0k9DYFPaXxZ8EmmejdOiSChLUL9tXFmdtf
 Zgnj7r6chKVz60b3mPqhzQVLH0NFVBOCZgqoR2ZyvvHYeRJsdmwiZ1lwzvyZl_5vR6D4LqbS83VU
 p7Yx_ZJbK0zXg9eIaCdJ_FItdYCe8mBC2ma2GbJNG.m0hzlNrgg3wN4Y2FnitqHHK2Ku6JS9P6pZ
 gpsyAyGZVJGmxGZ6a8KjOGfPK3XPQ9PWsOQKym8I8EZGgpWBnP5rrJghfVDk2DtCQDixEewVzn0s
 NV.DFzno_QcKktpOZdZldBAIf9QDhGwlYGDbEdHslz.T_w8PTlz305TZ6355uCUdo4QxSKMkXFCg
 oqmOCrm7cH7ArmxEE6i4_MHXjbTZJEhHDQ0Kv1LLyR1KgCveX8g7SWywZFMt.we8PQktTqZUEvIs
 zfhIBfQDHryJQDdkzQq1K.zv_ftNitfIZd4OHDlNASa24uezXNrFy8cEmtHOY0jytRzZxJUlHS0D
 pAHhq5L9_85SWzMy8hktdQuRWaJCc0ipX8YxT3ap2qNozAwqKPXKQnpOe_1d7bsoKYWJhkvCOlUh
 1IDOXPIIYVPGBw4d4ZQUckU8qycfXq9mBRmie2Mae5isaAY5lho58NCOd91SorjeeXgQ8kE4.g3n
 KhjYKlsnU.o9wjNR96gMt2lW3yFFXPetK.wovryqwsWmWkFDJvSnXJBwc8dfx3qwnMchKVQu0aQR
 ql.f5ju5a93PA6FHhcIuSQVKyP_rTZyJrTc8PF1xbfbNge60kWwpo0RSIAi1gtnuGNWEEN6wbcbD
 ZCg_yFXw7sRu2FFFXF0BIqLjSi0XwD0FyDzSl4Ymwkto8NWDLWUqhvAGQ41mBeMajhfmBMEHDV5t
 073G2MWQkV4DdrextI2DfgkiYCQNwYu1YjJi8Tw_CDv3nl31uOKPeexl0YSwda1UvZMnzOokYIrZ
 8tdkdnuduz08LFb3N3I_JWnSAslaE14_BqgLkcECpqDT8mpuyLglJBr_f8ugprkPwrs5boE12c8c
 yniou.57ldkNqglV.nqKkU0dVknyebLOFsyX4Kx6uELwvRVNxfwchSaFXKkPlOszJNek12tR9YL8
 Dt4HEdwdngzQPIF_.duAPM5nnxZMbF.6fxWKz97L0rnKr8ofhntdUZ5wS7NnsRz3h8V0P5_MYDvy
 I3lS8GZKeIwgdJeJIO81zGomSoz5PgJu6CCzuNSqArozCx2ATBdN1Hn0yhslaCS7Qp..HIqj_XQd
 r3M_orrz5zM0wvum7KCU89JZG7ey8qTs-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 03:19:25 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a3b7a5fc66b8e7b96dca9858a77755c0; 
 Sun, 18 Aug 2019 03:19:21 +0000 (UTC)
To: Chao Yu <yuchao0@huawei.com>, Richard Weinberger <richard@nod.at>,
 Matthew Wilcox <willy@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix an error handling in erofs_readdir()
Date: Sun, 18 Aug 2019 11:18:55 +0800
Message-Id: <20190818031855.9723-1-hsiangkao@aol.com>
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

