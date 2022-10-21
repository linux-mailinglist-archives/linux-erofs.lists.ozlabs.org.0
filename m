Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F960706C
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 08:49:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtw6z48dVz3cfQ
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 17:49:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.204.34.130; helo=smtpbguseast2.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=<UNKNOWN>)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtw6v3jffz3c6T
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 17:49:10 +1100 (AEDT)
X-QQ-mid: bizesmtp64t1666334615tni2uq35
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Oct 2022 14:43:34 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000020
X-QQ-FEAT: ALw5QuVtm4X/0YM5+lvhrJReaPTIEBc9vr4q8wcR/6HJkITCVxlTOwM7b3pwJ
	q6tGe6T8hHU5KyoVXw4McKYIYlmbi39Wa4b2eMazmtxBFRCKbUtkz+oeIjJ1N2u8Eg2dKpX
	PGcU8YfMjYEl2QpULLQoaqRygvrEBCHwW3qGUHc7PzRDGqd1gr0xtcc/H++kPwrOxLx8ePW
	D66EUYgCehk+zftAak4AjjvE2KNVKCt79IZIPrEgwvQumRMAZqula+Y2zsUBf0Y3CCdtrS4
	8yl13rM+gbntedqI2XAb6GbXgz8n+lV8oB4HtULu3Gusv2xHHrMefOm0HFd2bPOYukwHbIh
	7om7++MkDd30GkJfaQ2e57XQQj5uvrIDqPy5iuC3+H2fpRz4UFjxoBRkqmv7MysOOGGGhFe
	wfY0C0H2bnx9fMjoeM1cOQ==
X-QQ-GoodBg: 2
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: erofs-utils: lib: fix dev_read
Date: Fri, 21 Oct 2022 14:43:32 +0800
Message-Id: <20221021064332.357316-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
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
Cc: Chen Linxuan <chenlinxuan@uniontech.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using `fsck.erofs` to extract some image have a very large file
inside, for example 2G, my fsck.erofs report some thing like this:

<E> erofs_io: Failed to read data from device - erofs.image:[4096,
2147483648].
<E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
<E> erofs: Failed to extract filesystem

You can use this script to reproduce this issue.

mkdir tmp extract
dd if=/dev/urandom of=tmp/big_file bs=1M count=2048

mkfs.erofs erofs.image tmp
fsck.erofs erofs.image --extract=extract

I found that dev_open will failed if we can not get all data we want
with one pread call.

I write this little patch try to fix this issue.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 lib/io.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 524cfb4..ccd433f 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)
 
 int dev_read(int device_id, void *buf, u64 offset, size_t len)
 {
-	int ret, fd;
+	int read_count, fd;
 
 	if (cfg.c_dry_run)
 		return 0;
@@ -278,15 +278,27 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 		fd = erofs_blobfd[device_id - 1];
 	}
 
+	while (len > 0) {
 #ifdef HAVE_PREAD64
-	ret = pread64(fd, buf, len, (off64_t)offset);
+		read_count = pread64(fd, buf, len, (off64_t)offset);
 #else
-	ret = pread(fd, buf, len, (off_t)offset);
+		read_count = pread(fd, buf, len, (off_t)offset);
 #endif
-	if (ret != (int)len) {
-		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
-			  erofs_devname, offset, len);
-		return -errno;
+		if (read_count == -1 || read_count == 0) {
+			if (errno) {
+				erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
+					  erofs_devname, offset, len);
+				return -errno;
+			} else {
+				erofs_err("Reach EOF of device - %s:[%" PRIu64 ", %zd].",
+					  erofs_devname, offset, len);
+				return -EINVAL;
+			}
+		}
+
+		offset += read_count;
+		len -= read_count;
+		buf += read_count;
 	}
 	return 0;
 }
-- 
2.37.3

