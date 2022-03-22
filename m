Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9B4E3ADB
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 09:41:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KN4hV6pn2z2yPj
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 19:41:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=SZnYjRJo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=foxmail.com (client-ip=203.205.221.192;
 helo=out203-205-221-192.mail.qq.com; envelope-from=xkernel.wang@foxmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=SZnYjRJo; dkim-atps=neutral
X-Greylist: delayed 1724 seconds by postgrey-1.36 at boromir;
 Tue, 22 Mar 2022 19:41:04 AEDT
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com
 [203.205.221.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KN4hJ5yTRz2xYn
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 19:40:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1647938450;
 bh=xj3turLHj1+ZCP9WjX9RjyOgZj7/g+f5TXLsbJ08Z6M=;
 h=From:To:Cc:Subject:Date;
 b=SZnYjRJo5AGMwF73cwT3we9Z92r1nR7gNGCYewo/MEOwY49rYTxZeW2voxlfnT6vz
 aYKK5hfZsfOmNLgwMtBEEpZpzkqVVzFEsQMd82vDgsqn3bpz1uDLb0t4JPtqpS2nmj
 25L1+A8hfGLtoMNIm2zrcKhFvgCf7v82BKUKjShI=
Received: from localhost.localdomain ([43.227.136.188])
 by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
 id 2198E433; Tue, 22 Mar 2022 16:08:25 +0800
X-QQ-mid: xmsmtpt1647936505ts0dqrfgq
Message-ID: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0amHFt3Tv8ZnikjPM7gbCsdRyJBbsvvF8MDJx4K0X2JtCTAGGCU0
 USVhMFfAWjMjApTDU0aOobRK8pKYK3+RP3AW3nqaJpQDuEo3v+6XHgfjIidbeMx/M4EjU5yn3OBg
 T1nJpiqqVxcWjX2wgfoZUT4d0K3/3Fn0ijEvxk4UYsL4gjD5JdZq/xB2vVpgTfR7qoaeyyWys8h3
 GIxWb0I7I7iL6FCZfpKxoW+td9hHBy9cxxgmgapMa80vA6nSAuSyuoWnO5VwcirEQxNxDzspaFTc
 Wzu9tf93C7pxlsPW9gYCxOV3rtvgNjp1P/Z1Jp9cktsS/4WE1j0EyR6N3Rw8N9Vq81jRNOqDxyNW
 QsooJ8v+Ve1uqvfFswT+ZlDrIi/nOA5sfc5npycGs0faGzseuP8x+j8gP3C0uv/aGkcRcQ9NMqpr
 ONKu3/KSyHZJKOpn5hM2FDv/AHegPeJPxfb0F1BAnIlUm3Uw4Dm9R0144DjFZQ1KrF4mT2qB6+bU
 V1SsSXP2n6/OTq7FLHWbK2cWqLCMcB0hOxaUfTySxM4ExWp6XWT9DuIiQm8THsHfux+j3TFS/DGQ
 xyo5dXyXvFCp2cLOTiO9r+v4QcU2zV//beLzq6LxW3hLz5TN1tHe64Or2BTg63qLl8o/vFWw8qKM
 FtR1ZHdzjowCuoI5QPr/BkDrdodtZhjsET7o2lU2x9coG97wJYM8SrQZfjY6wghWAcRGx0q3IdjA
 s0wa1nHLCU0GWlrnKN7w1Xp8vP8Ki2+qBF7Fji2KrB91QsrGWps/NIuvvemUGFtW/qTncFAhQi/M
 1QmnJlQFv4lP8HuAjJk337DjfCMwrQQw8AFYhHkM3WbbR4R/y6L4ISkyHjUKjbtmyWHKu89AO8pn
 j8RUABvcj64AYPpaYlnhmxhD/T1XOSZhApA9AxkzHkL9hvz+6Io18NpxRgiXT4EbP9MdGe3vxO
From: xkernel.wang@foxmail.com
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Date: Tue, 22 Mar 2022 16:08:12 +0800
X-OQ-MSGID: <20220322080812.1574-1-xkernel.wang@foxmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Xiaoke Wang <xkernel.wang@foxmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Xiaoke Wang <xkernel.wang@foxmail.com>

alloc_pages() returns the page on success or NULL if allocation fails,
while set_page_private() will dereference `newpage`. So it is better to
catch the memory error in case other errors happen.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 fs/erofs/zdata.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1a..36a5421 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -735,11 +735,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		struct page *const newpage =
 				alloc_page(GFP_NOFS | __GFP_NOFAIL);
 
-		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
-		err = z_erofs_attach_page(clt, newpage,
-					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
-		if (!err)
-			goto retry;
+		if (!newpage) {
+			err = -ENOMEM;
+		} else {
+			set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
+			err = z_erofs_attach_page(clt, newpage,
+						Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+			if (!err)
+				goto retry;
+		}
 	}
 
 	if (err)
-- 
