Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6993F3F3
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 13:25:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IwWGtI1B;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WXbdL0zlPz3cXQ
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jul 2024 21:25:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IwWGtI1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WXbdF31zKz3cH2
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jul 2024 21:25:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722252330; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=rKkXWwtR0P7bAR/KJ/aNjz4QTkJmJOMsKv6yCein2yg=;
	b=IwWGtI1Bsp0OFjKaZVEEImnWZ/1772fwl+C3MfFvQZAhkzOXBPntln4+LDvkA2Y4YJNurkeDrvbzjQcQzyjJGU2+i+gYZEZvr8kaAie6yF6IXEYuWGO61EoilJA8euCJThJDu9dYJaoGFhYZ544dBzb7f0gUog+eJJDQDdmdWHw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WBZDIa8_1722252325;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBZDIa8_1722252325)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 19:25:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: uuid: fix compilation error if __NR_getrandom doesn't exist
Date: Mon, 29 Jul 2024 19:25:24 +0800
Message-ID: <20240729112524.930460-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's just use rand() for insecure randomness without getrandom() support
on very old kernels to resolve issues as below:

uuid.c: In function ‘s_getrandom’:
uuid.c:44:32: error: ‘__NR_getrandom’ undeclared (first use in this function); did you mean ‘s_getrandom’?
   44 |   ssize_t r = (ssize_t)syscall(__NR_getrandom, out, size, flags);
      |                                ^~~~~~~~~~~~~~
      |                                s_getrandom

I'm not sure who cares since most users just use `--with-uuid` instead.

Fixes: 5de439566bc5 ("erofs-utils: Provide identical functionality without libuuid")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/uuid.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index ec0f9d9..e6a37fb 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -38,18 +38,29 @@ static int s_getrandom(void *out, unsigned size, bool insecure)
 
 	for (;;)
 	{
+		ssize_t r;
+		int err;
+
 #ifdef HAVE_SYS_RANDOM_H
-		ssize_t r = getrandom(out, size, flags);
+		r = getrandom(out, size, flags);
+#elif defined(__NR_getrandom)
+		r = (ssize_t)syscall(__NR_getrandom, out, size, flags);
 #else
-		ssize_t r = (ssize_t)syscall(__NR_getrandom, out, size, flags);
+		r = -1;
+		errno = ENOSYS;
 #endif
-		int err;
 
 		if (r == size)
 			break;
 		err = errno;
 		if (err != EINTR) {
-			if (err == EINVAL && kflags) {
+			if (unlikely(err == ENOSYS && insecure)) {
+				while (size) {
+					*out++ = rand() % 256;
+					--size;
+				}
+				err = 0;
+			} else if (err == EINVAL && kflags) {
 				// Kernel likely does not support GRND_INSECURE
 				erofs_grnd_flag = 0;
 				kflags = 0;
-- 
2.43.5

