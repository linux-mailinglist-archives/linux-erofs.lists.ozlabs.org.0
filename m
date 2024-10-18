Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A99A3365
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 05:36:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XV9N71dJ5z3bmY
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 14:36:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729222565;
	cv=none; b=ofTGFJ0waM2lGKPzNfbCkWb/G6zMbvqWbAP/g34B20VlcW5/uAdxrfcymLUZTw+sdir8dMubK4JD4FAnoNTpt3hbremyQswTAuZ0FyRUbeVOUxn4JkXxHFe7eWfk7/Mi7VfDHAcfwB0kUq8sD71eWVgiSHcUF0blaPmsw6nUsl94qoGfpqCp4ruVi3ZQME19Gul96EskyamVkA3JTSbU89xE/Lf8L8DipX6vlRd2aOR1R+FUAAkwnoH1hdOn5GLQy+io3oJit9hsXnOpJOs2bbC0foV0BzirIpulyehpgqvnbAZi+7kwAB/0FwlJHIi88z0FtJaYJNXZyE8DYw4b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729222565; c=relaxed/relaxed;
	bh=dJt0LZgs1we73SmL7597byDoDeUoixIoLW4Jf9xhQ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itnUPWoiE++1G6WswTaGJcVskqnK9MMZp9MtJlKu8kLKqQ8FJv7jnJPct9s5KaIvFUT/ECZWd6ET3aBUZCGRjXTnj3XvvZcwntrEuUFqeSHsUIYTs7Zi4UyixcVu8AlHrxUocRluogLfKZb+22DGPB1uycnCGKMl00B1Vg6FQL6e9HB8YvoOHMNnatGp/heggXpFLMf27jRCoyy5YuIp9EbVIDiHnWutc4fzmV10b1MdWWSGv+EM+nJ8CvAGlyD+/Fw5VWn3YWk6+8sBFOoZdNJh6mA9JJkGbxko0FCQsfYxfkCS4wFv/AcoeA6o2gFAf17elJbIyf7Sbh7ZbhHzpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=U9YT4aHz; dkim-atps=neutral; spf=pass (client-ip=43.154.197.177; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=U9YT4aHz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.154.197.177; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XV9N10x8dz3bhs
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Oct 2024 14:36:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729222514;
	bh=dJt0LZgs1we73SmL7597byDoDeUoixIoLW4Jf9xhQ1w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=U9YT4aHztTFvJDbjXKHF3AstQ9Mns9MAcKxxQAw42sTi1nntUyYt9e23DmAQBYF+2
	 7Od3zBHbP3duCjHczD5RovqQY08wEtk+DaB850M5KuGeN2K+m8TZt4yW8/LDKU3wFh
	 v1TCDCwqq8He7TaFs+2Q/AXqcS5E3yWj80VJAi00=
X-QQ-mid: bizesmtpsz9t1729222508t4opddc
X-QQ-Originating-IP: N9SNgAW4on53IO1biD0K/z4f73woKuokm0dUG5+ll/s=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 11:35:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14635534401801183075
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: simplify definition of the log functions
Date: Fri, 18 Oct 2024 11:35:00 +0800
Message-Id: <20241018033500.13833-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NDtUtlvFer7v2yh8T/W30O4bU1VmTNB0ZMtiFoIKuaiGGibea+vvG4yg
	0Vk9rJ3Tv7TTELH4YK38jQV8UNMc08bU9VqnyBB2jlxHY6ntLb2B3kxW13oZDft/nriicKe
	7lF77bQKOmXD8Vb5UL+I2qFoiSEtWNu6CEidytx9fwcvB95++wUdB3q8+CmuyT0NGaCpbn3
	YAp55ErMSAGtnOY9JU2lPMGJ00HZp/Es2UaemDNWlncm6yqCfy8US57IsJfAXlIp4L8GpJB
	eZzCHQrfn/MaF8bdnFOWDRgOfkip/cKDV609eI+Hl5spZNI7vhn9MbgUzMqjPUlna4YUNfS
	Yyr/FxkTJcK/TCnHkgzAjR4+aG3OoOyxOy+wX+A7Q6dq8FI9WfmIyTy2aGjE/wXTR3fbZ46
	fZ26zy6ZNqUv5qcMN7AATviCggaB+f9AKzGqu6p3KR1xq+hJeYR/SsYX4yFMVqlTG6OwMt2
	xNjZNzQFRFbhLC5eHymxQYtRnR7maWPRfFpNvsgSGoVPdhP0rZdfj/JbTRgGzU6knmU1UnW
	JO3Znv3U2iH9sYHQgpfR8CoUmQAzfV4t6LM2hGXRAi/Y6Yus1CZmsEuRVt//SYFfXgyVsS7
	Oq7am9iuiRhhrjEY4Otx4EPiyRtrBElUfeKkgFFj61q1jMyOlagmg4EAE+mQs8oqEedK9gn
	Ep5xU5fP6V5mpj1KzaEbr4j0YnNcDJqNtydQ2zBxHijKwAmJvipUurWRFSuMoSUKHRGRv52
	qNpjwjJywoPilQ/4077cNwtKAGqkcxcgc+CNJJ/Gb48Ekgm2X+4aNGtHuZA8yf3mE+Sf+fG
	PaD4S21ogawPw5nBfXAfaZlVM97X1Yd01kp1mTMbbq+irnhjMwhNQ3V9roIdKaL5CeZsavJ
	0P+B6akDwWJXEGcN2Jr3FuZYzpChRtvGQwe7e9JGYihR6SXcpkrVN5cjQqpQ2zY7cMiEPPV
	KRS5O8JZoi6vFx27yRupmP7h1
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

using printk instead of pr_info/err, reduce
redundant code.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h |  9 ++++-----
 fs/erofs/super.c    | 28 +++++++---------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..ae87e855e815 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -24,14 +24,13 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
 
-__printf(3, 4) void _erofs_err(struct super_block *sb,
+__printf(3, 4) void _erofs_printk(struct super_block *sb,
 			       const char *function, const char *fmt, ...);
 #define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
+	_erofs_printk(sb, __func__, KERN_ERR fmt "\n", ##__VA_ARGS__)
 #define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+	_erofs_printk(sb, __func__, KERN_INFO fmt "\n", ##__VA_ARGS__)
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..64c3258ddf9a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,37 +18,23 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
+void _erofs_printk(struct super_block *sb, const char *func, const char *fmt, ...)
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
+		printk("%c%c(device %s): %s: %pV",
+				KERN_SOH_ASCII, level, sb->s_id, func, &vaf);
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
+		printk("%c%c%s: %pV", KERN_SOH_ASCII, level, func, &vaf);
 	va_end(args);
 }
 
-- 
2.43.0

