Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D29C8005
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 02:34:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XpjNn0BD9z2ysZ
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 12:34:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731548040;
	cv=none; b=lYARbQOtSEuU6dtPyq/BgN/+/KJ+Jrd37rZG3Or5IHxFzGO63RqMBNCptybu5O5Cx0vKCNeErqvLiJAWArviPQiVYniGxNoLVtt13+FeXUHR8B4XiJpwxrOAsF+alk43JS9ZXae5sd6HkPPyfN6RCMCqO8z139uAep2Ct2W3YsBJm8vnyiaGhaq5kudI0thPsWkMPUHJGy+lSAw/mWUnuln239YI6i0KjbouAcgCXnFgMestDPrWJj53zdCss6JlCEeRgZAyf9e8XWXKLa/AfzWuJyqOI+w60lPpw9Tw4AzQkFyeTHnmzo/KoCFEQWc0L8/1Af/gn4bi4w+4QdU3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731548040; c=relaxed/relaxed;
	bh=AwT/xsQdOK1ErrtmBGR2Ev8dEqXwL9El7iE9kODgv/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBTRdgT97ECvqPy2tNAnULiD9eYDwL5umPzs9JlKUXUrWWMY7iEOEIiUm16wtXV5ra3zM7TtY/i4njW5unAdyayzzhuUC8Ukxs2nIhZ344qtubL5/JSlT7h2aiZaPPKRCJnf6OvHW2LDuflNl9dk2H0EVQBjkYMBI9rbtQWV2s/NSF2MMPWokq9kRUg1W+BgS6k2So2KACrsdULGOpq8eEti2niIsMY695m0sS3XmN+pUF0SRgRSrXVl0Zn+nDywUQCm3EgZ3G3+AjhoFM3wRPJHmaUKsh2gKQH2Q81m8LojjcKHiHqKykH4QDF5BbDSRUdt6ZUTRsdnJUyNDaCBQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=g/v4M0GF; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=g/v4M0GF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XpjNj5bSVz2y3Z
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 12:33:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731547974;
	bh=AwT/xsQdOK1ErrtmBGR2Ev8dEqXwL9El7iE9kODgv/w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=g/v4M0GF2oJeMjNN7MXekNm3KzLOlp8TRDQ7ZPETO7G3kOC1AsBpfc6Tutb5UQm3W
	 vFvogZ67P2SWGkR3t1gCOVZO11iVuyzRy0O8Kas6UjVlvuSG+DNP2z6mP+N83fpkjk
	 +eWB9ibhuiJPVWjUTrsm6TtJi3dWh4G0wwLTbAXU=
X-QQ-mid: bizesmtp82t1731547969t9md095l
X-QQ-Originating-IP: loctKRkCEdTne9wB4ucN+gum6+Bu5hoPIGsSy+eNflk=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Nov 2024 09:32:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14376911624389434776
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V3] erofs: simplify definition of the log functions
Date: Thu, 14 Nov 2024 09:32:47 +0800
Message-Id: <20241114013247.30821-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: Nb3zvKU22AlHj27GfFdnWr0ypu4580MAOeU2CkcQtK1XpQEskr0jgL6J
	tO2tz1NOEm/Lv5uV54kU9fPwxsyYnXjSMsF0JmlIbDtcDDT5Wq23DUcUwbTX/HxaNHhG95w
	Xw6RZvlLGj8pxV1JfPuuMIq5H85x1nYNj1yr1+ezhrLNZrvGbdoj25s8MGYte4GVM4/BjX6
	prrWvgLWccqF7mGFRUcK33z4OGhk8/IK87jAESpsKLMaS/OaC2NsvVEGRG08ZxaHQvT/dyX
	kVhbMt0oh6LYj8fnNc8h6Rg3pJ7W0gWljDxYmi+UC0BDfww7uAPEQUyrV52TOP7wYPYML5O
	lBoFW24PhHChH/bKUyCnoCBE52eo1MarwvvBipiY4dO0dZo6SB70+R8m4nBV3netJQDBGWp
	y+L7JBVEvamGEsmJf5vghfh72KIV5TMML70lEVm1egsY4mjSc7LqlBSJmfB31Heo3KkLK1h
	usJDDgdCNXJyJSYw256Mb8GOA4bcsVgF246Xw1AxT3vH7Jln5bQgBPJdHUFhbf5FmKkumTD
	Uum+UuNFJBR1eun1TsjAW2upSGCXnjR3siBLKZi6J5RDnyyX65ahtI8NungQ9g9NifS46Q/
	PU03N3wXjxPAHt3SZfF++jvQYK2UCDg7IjkiIGBItT7zkqgLnVhvmZEf5p0IlhQXJLGoqHE
	fC51QkgdSTNjWbq4ij0+UnKSqSSXUDRpQCoPuB6bn1a3b62tBkh3I8IyGj6XcLzNsMSUmd2
	VqbERtu7d4xxjEeD1KCaX7IyS+NIK3wYexkDdhuOqAuYqM+O2Dakdm0aavxBj6hGkH1rU2q
	NHmbaNLsfJYSYpyRUvVToi5/h3XfXKNgHWiVvwuI6vum9iuLABixwFjUwWlxC6BDIsxDS7X
	JAy1PXf271fj9gcA5+KdFPWlZrVFcFeu4GjPskHTa4WBbhT+x+jPlqZVU+9FmP8t0K07bX4
	NSNgBHONfCKNRs4J2vMWS2LN9IfzZb6/4Ln7cEw1LEulZKokJwA4XWAOKq3NoqYZyt3W3S6
	NxJjOdtQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
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
Cc: gouhaojake@163.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use printk instead of pr_info/err to reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 14 ++++----------
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 31 deletions(-)

Changes:
V3:
- optimize the printing format of device

V2:
- remove 'const char  *function' from _erofs_printk
- remove pr_fmt macro, put 'erofs' prefix into printk

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..116c82588661 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -20,18 +20,12 @@
 #include <linux/iomap.h>
 #include "erofs_fs.h"
 
-/* redefine pr_fmt "erofs: " */
-#undef pr_fmt
-#define pr_fmt(fmt) "erofs: " fmt
-
-__printf(3, 4) void _erofs_err(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+__printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
 #define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
 #define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..8dcd543df0b8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,37 +18,23 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
+void _erofs_printk(struct super_block *sb, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
+	int level;
 
 	va_start(args, fmt);
 
-	vaf.fmt = fmt;
+	level = printk_get_level(fmt);
+	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
 
 	if (sb)
-		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
+		printk("%c%cerofs (device %s): %pV",
+				KERN_SOH_ASCII, level, sb->s_id, &vaf);
 	else
-		pr_err("%s: %pV", func, &vaf);
-	va_end(args);
-}
-
-void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sb)
-		pr_info("(device %s): %pV", sb->s_id, &vaf);
-	else
-		pr_info("%pV", &vaf);
+		printk("%c%cerofs: %pV", KERN_SOH_ASCII, level, &vaf);
 	va_end(args);
 }
 
-- 
2.43.0

