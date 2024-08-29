Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B6963FF2
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 11:27:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WvbWz1HNvz30TM
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 19:26:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724923612;
	cv=none; b=KHBj6mbbOvqwPSsRaFxwporByXJL0sW5MVBy34uaOPu/9H5b0tOOzGOMdk3SmLpqFZ3U6PavhYw/Lx0tupcRtNbRmE8AQgV0DpVgydcvflH/EjpJmHbtRR/03IxisPlYiODH/wWS1T+C+9sqmPNeov8i4XeiI08yYY0U5kaJB+NpaTA38j0W5ZPHiYX74k36G3RMCRwEd0mPPZ/no5ic2P2iNoMwszj0EVPGR/COl4UCJiTsSEH1gOhSmz/iH9JgySvOMPEsYo+wAHZZnctgRZMLUcAdocUapdJFHXYISe6D9TFfDF3bE08+n/O0lT38RqmuzrAkMm4cV7vGm+xtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724923612; c=relaxed/relaxed;
	bh=+KYMFXlqlUBPY+PML64VVWpiuYOErjUusBKS06cHwT8=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ccfWYFsFAp6dV3ycNZvl88jg0c/EHW7Y8AZ+gKad3Yi9fwoO1zawa2aQC5uFnKVSCMWwcF7TTUQIeu8HmWFdJq4vSlfUbr6hZpP31Pw+uFJh9FeU4bmKaJFhWAN6eJ2yuW701hDTuSY5lvRTjwDwaLBb8kf0udi1yFYYO8EztSvikCwWT0XcEeJ/GoEdWW738FcOkIaPTsQDqmVXqT9RDuR8lulcDIF0kjHogbms4HCDvRS0oJ1oOsQvAYNA3SjHno6ulhdtwCu81OzJOsYJOJdEbyjwDsvUT8VMbkfwMkj6TOSDur0hiHt43FvqJJuuyGFf/gtoBX/sxXDR0NqY2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aCR2zpDz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aCR2zpDz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WvbWt5KVxz2ytT
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 19:26:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724923606; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KYMFXlqlUBPY+PML64VVWpiuYOErjUusBKS06cHwT8=;
	b=aCR2zpDzp9YI02Bs/PqkeoTUfwtv0+O5WPI0ogJ3O8nkUVWXONKRTO9NDlaFOVoP2N+9WBDxUE323jiJuPbOWTQ3ivQj1kmF32SMzwPJDtspF500exLU6TXTTtV98GTqe+w5PHqtcJEilRVjohfQmUGBpvMiE/Ud26AQIL9bJLA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbXS8_1724923604)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:26:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs: mark experimental fscache backend deprecated
Date: Thu, 29 Aug 2024 17:26:14 +0800
Message-ID: <20240829092614.2382457-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Although fscache is still described as "General Filesystem Caching" for
network filesystems and other things such as ISO9660 filesystems, it has
actually become a part of netfslib recently, which was unexpected at the
time when "EROFS over fscache" proposed (2021) since EROFS is entirely a
disk filesystem and the dependency is redundant.

Mark it deprecated and it will be removed after "fanotify pre-content
hooks" lands, which will provide the same functionality for EROFS.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig | 5 ++++-
 fs/erofs/super.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1428d0530e1c..6ea60661fa55 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -145,7 +145,7 @@ config EROFS_FS_ZIP_ZSTD
 	  If unsure, say N.
 
 config EROFS_FS_ONDEMAND
-	bool "EROFS fscache-based on-demand read support"
+	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
 	select NETFS_SUPPORT
 	select FSCACHE
@@ -155,6 +155,9 @@ config EROFS_FS_ONDEMAND
 	  This permits EROFS to use fscache-backed data blobs with on-demand
 	  read support.
 
+	  It is now deprecated and scheduled to be removed from the kernel
+	  after fanotify pre-content hooks are landed.
+
 	  If unsure, say N.
 
 config EROFS_FS_PCPU_KTHREAD
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8e92ad3fbead..9bee2c06a4cd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -353,7 +353,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_is_fscache_mode(sb))
-		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
-- 
2.43.5

