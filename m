Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0900F9EC717
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 09:26:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7TGB49lsz30Qb
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 19:26:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733905585;
	cv=none; b=B/bBvZfPA6AY7hPIOgHKtPw+ovzHwqOAM1uTAOnCyZrH+KZYGkr8PY6vvujQX0wv1T6kUFAkhVewtE/VtkxGtWI8wSN6bw+YB4CQ5aT/3QX649dGkJ4PR4oXmsAjCjyCYJuzkMpIe0JNwRozRuo6PJELfu65oJwd0I2zOwQgxvK1lg+JeqHRW38UAlG86cMydxC24/dpr9u+acDWgKtzM/5AbLyiqpZ/tJ3ICsnj+8Lk8ENdo6Y1O7/96a9I6HMqpmOeWuWrDTvz/gzduRZh3Hq8OlcfW0DPjbQ6WGNYgm3GfvUq+KYdgmytRfq79G+0rbatoXyOv7BWGc84bgLkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733905585; c=relaxed/relaxed;
	bh=mQm1uvjIsSLKX1NCTmzRbVV+Pyt+NBj1qYuWZf6ZoPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wt77SUR/cfQFWTeDFItGxpqYab8S84MTuYc7nUl6+uoUBU+DH9IMCAQozekwskSzQ6FrbDUP+k931dJXT8TYcTdzZ37qc6NtLyd3MMxAN8Wa0584a/l7Kbd2DAjl3UcsUVzI/hcGH4lHQ5xK+BwOmKVaz5iPXUADWRV+IWuOQpZ4RZ2rHVeap7s7J8zTSxImUVqh9Duw1XisUdNnWkx73B5TqQe6C6DuLl3ZRCV/2GTzkZsMRZWaW6NenxK5G6Wv/iQI0EmD8MoPXyKDl6iQOrVk31KuO9rDB5Ldto7N8OyHKw0pP3+x2GQ8TLK/pzZtDRsKAb9W54MFYpM6Gc8tSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cECFL9IM; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=zbestahu@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cECFL9IM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=zbestahu@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 963 seconds by postgrey-1.37 at boromir; Wed, 11 Dec 2024 19:26:21 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7TG56rgDz2yjV
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 19:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mQm1u
	vjIsSLKX1NCTmzRbVV+Pyt+NBj1qYuWZf6ZoPU=; b=cECFL9IM+csblVlU5IZlh
	QdMBbqVWaewIV4RK+oo04dpWynfXscFS14r+GY0Ac9/YKeXoHI0l1Pa7OXDTgymG
	ON7vz7eDxODvHkqlzoYrQIExecorcVYOVbXNX+le10WmRznUpXFEVfOvaKQO4Fdk
	AaOG5Rzxa2bwx8xTnjZNEI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3112xSFlnXyutAA--.20304S2;
	Wed, 11 Dec 2024 16:09:31 +0800 (CST)
From: Yue Hu <zbestahu@163.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: erofs: update Yue Hu's email address
Date: Wed, 11 Dec 2024 16:09:18 +0800
Message-Id: <20241211080918.8512-1-zbestahu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3112xSFlnXyutAA--.20304S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15Cw4DAFyfXw48KF45ZFb_yoWxZwb_Ca
	s7Jrs7Xws8JFsIyw4kGF9rAr4Yqr4kGr4xZan7J3yxXa4qkr45t3sIvr1Sg34DCrs5GrZx
	XF93Jasa9rWaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiiSd5UUUUU==
X-Originating-IP: [112.22.170.115]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBaw+yEWdZP2jd7AAAsf
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <zbestahu@gmail.com>

The current email address is no longer valid, use my gmail instead.

Signed-off-by: Yue Hu <zbestahu@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bdae0faf000c..f57155874eea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8368,7 +8368,7 @@ F:	include/video/s1d13xxxfb.h
 EROFS FILE SYSTEM
 M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
-R:	Yue Hu <huyue2@coolpad.com>
+R:	Yue Hu <zbestahu@gmail.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 R:	Sandeep Dhavale <dhavale@google.com>
 L:	linux-erofs@lists.ozlabs.org
-- 
2.25.1

