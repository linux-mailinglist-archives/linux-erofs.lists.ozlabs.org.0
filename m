Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A119A0E17
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 17:25:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTFCw6k1xz3bby
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 02:25:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729092346;
	cv=none; b=eH4/+cqr0BUXXgI++5CX0gXKO0+ygyREZUF9vtQR4LaEH1LqDf3MXzQEr+Rvgs68+GgFWqPqV/YA0pSCfFNHyEYKrQyMuL/hxA+og8VYCTYHYocJdfFhg5fV7NK/DTY6DKKXt6IxU6fBScV9PAlAiPVV+HqZCkpj4a6er4uN6DKFvZKiiuuXT/yqCycGjga5He36kXnILh5Mm9U0CvUKmZeV+474eqr643rqSwxJPQwP64bL6xay/48Wpd2V1BxS5VHV++vA/0LKWxdZiICDJ6CvLuSoThFbMBL64RqBI0izvywuiPSS2seKyywytt7goorGq4gaS8A6x9Of8+vmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729092346; c=relaxed/relaxed;
	bh=vB1hUB3M9LhQsGZAEMAIo3fk/xV7YVlDQIbsTTEu5No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPCNbWd6OSRLr6j4IfsnF6i7kFPRWPI/xcrOhgqhp6oEGORi2wOEoALWS189WdbFn3+nk8lXocIef329Shp/HeZGzpeUMbohrTuo5nJTGwVDPTHgA3O5DjgQ5oU0uA+ouUWwTVZE7rdW80BbdzzZ2iqxV6FoE2nwjewNpRUW1Y7RRU5BrfFLCnVWyYSzOfu2uCvcaU0Zu8eBxRjSOzSe40cUFwQTwYZnZ2W+vL0h7CDP88iPtRGKzxIThblpCWSLAjcSmK65dgg3aPQ62BjwJVK5c75KEIAjyO92ZcIKhXCwv+ZVnI5BXa+dLPZ10+J17amz/yABSvCP1s/HxaEcCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=KIFF3QeQ; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=KIFF3QeQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTFCr4mgLz2xjv
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 02:25:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729092281;
	bh=vB1hUB3M9LhQsGZAEMAIo3fk/xV7YVlDQIbsTTEu5No=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KIFF3QeQHL5UIMFrwynrmzlmd4OlsCI1vfYURgMCW1LJc6S13XvLNdEnoPoDoARdQ
	 oZkQPV5dtgyt0L+/+jXEwCPJR6KbAgIH4ySqM0d1/lMfY6xQ/8eP5ZySvQB2YSCgRF
	 YvYBt7NouT655kEmRi9qVnGIVipEMnYLTsfEm0o8=
X-QQ-mid: bizesmtpsz6t1729092276t1b4xap
X-QQ-Originating-IP: GS+3cUN34jLeckU9KaN79l4tFlKPU7EVSqyZ6w9JNtw=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Oct 2024 23:24:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1428879770323960825
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH 2/2] erofs: simplify declaration of the log functions
Date: Wed, 16 Oct 2024 23:24:30 +0800
Message-Id: <20241016152430.3456-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241016152430.3456-1-gouhao@uniontech.com>
References: <20241016152430.3456-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NamDlXnbz6wMX8l/4JNXYU+tFd8+3B8JtCWbKOmRaN4IQgugLpHG1G9j
	NdtVFbdI0zkpm96PWKWjeVkNexqiFV69jGEU8uSlW+Tqy1+Oh1HMVnBC/PLQt1vqmTfRHZB
	dPN4GhROl5fWvf619QWHFAq3W5HT2D0wCNo4QHLMbE7XA6heO3MSi+ds8JIQHDwxrXEZg39
	9UBJQGeLOYMTKEUAYowyyIPRpkHPXG0KBicMJL8YrvcY2KX3wBD6PxZVAub3dFq+pzWjkzW
	lC8aaa2tm3ZfTqkWd49K1b4Fnvs8CZwovnFkdJbNiP2AzatFI5QEtp2xOKQAXjNm+Wq9rsG
	JDUBtWEkoWzUbIW6NYi49OM+F/Oq7tsQpbSoiEegpfiNmMQHbDCnwOgd0zaq+xHRVwJD1lI
	hh7ElDCunWoLCArVpXTsSkABXePq/f6md4e1ipCmFqRhVwBRNOokm9gN1GHuTExXSZGy3ow
	fUaS2WNwJMzSpjtJbynNEROghk+zfUitOhVOhGkzBjgtJImFB/oA0r3Jq0PxQpXo6/3i3zJ
	wpNVUEQ8EplSRH8FuMqe7KSXoUuFY4mU4Yv8p1qvgKevONse/ggIxm5ya0ds9+PtRJqV7Bh
	vZ7SJgdheZaZYHYoSsXLojQH0uenbMlIFUmwCUtwAeZEM6Pc4rKKsxrHwQKXMNadzSq6Q1+
	lvKnVJuk2j9cz7bKQvZZNXQ7lD/kLj3MdFdmhNmTEpng9/0ks6WQqmVSAnYI7mAnCkz2Npv
	I/Dne7c1znn5J/2ZZ+daw2H68xYMlbrdsW0xw1Pr6jnMo4okBbwpY44/FOX0kHgd+33X+bH
	8keK1reX7qWPNmYYekGAjisjxsh1i1HAlGh5hbcM+2tYmDMNHclBcIzCZmCwM2nSWdSFAzV
	XhwU1NvHrGuw1Chl3QL3ClwRzJKZH62b0BWhOi6y3EkLp4UJAm89Spbwp8l4GYrw6yzrGpH
	ECXhAs9JxbOF5dsCxNuzR9996nG1gk5R+VQZfcPpbOajJBgURy5ObD7EQQCJ79d0InLmH3P
	6WUiOJP/1DhXnL0qVH0BcK5NHSpzo=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

remove the macro of the log declarations.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/internal.h | 13 +++++--------
 fs/erofs/super.c    | 12 ++++++------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..0c3d6b9f85b5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -24,14 +24,11 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "erofs: " fmt
 
-__printf(3, 4) void _erofs_err(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
-#define erofs_err(sb, fmt, ...)	\
-	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
-__printf(3, 4) void _erofs_info(struct super_block *sb,
-			       const char *function, const char *fmt, ...);
-#define erofs_info(sb, fmt, ...) \
-	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
+#define erofs_log_declare(name) \
+	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...)
+erofs_log_declare(err);
+erofs_log_declare(info);
+
 #ifdef CONFIG_EROFS_FS_DEBUG
 #define DBG_BUGON               BUG_ON
 #else
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b04f888c8123..587a56e390ff 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,8 +18,8 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-#define _erofs_log_def(name) \
-	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
+#define erofs_log_def(name) \
+	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...) \
 	{ \
 		struct va_format vaf; \
 		va_list args; \
@@ -30,14 +30,14 @@ static struct kmem_cache *erofs_inode_cachep __read_mostly;
 		vaf.va = &args; \
 		\
 		if ((sb)) \
-			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
+			pr_##name("(device %s): %s: %pV\n", (sb)->s_id, __func__, &vaf); \
 		else \
-			pr_##name("%s: %pV", (func), &vaf); \
+			pr_##name("%s: %pV\n", __func__, &vaf); \
 		va_end(args); \
 	}
 
-_erofs_log_def(err);
-_erofs_log_def(info);
+erofs_log_def(err);
+erofs_log_def(info);
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-- 
2.20.1

