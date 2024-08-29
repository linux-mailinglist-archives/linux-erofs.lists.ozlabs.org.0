Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3C964048
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 11:36:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wvbl93hwkz30Wf
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 19:36:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724924194;
	cv=none; b=nG9njqvCpW5EK7O57+1zOnfqsm1PknunoY2uNbyAWoceAZbr1kcRedQwkfFz4vPVzeT074kogzwsSDPLKsO9O75C1YdX2Dq4EU+7KotVm69WxMHlBmpJTVkRTMYBqndAr3fR3X+M2fZJH03FjURsCN6ErIkQ88FuliD6vELqnwIVs5Z6lO+hvRj1ulLirKQy7+kSYGMPms++FH+7hNHdGFC1pe5X2uNWKYxnw8tjIAKX8p5wi7sQgBzHjDkpjPAnhFzdvUMCAeDsw4txCncWzEmUxO27T1PAT8RyAP2FgFo1yh8V6CbtBu6GrduHDk+rf2DQNsIsomt+QfbKBAFzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724924194; c=relaxed/relaxed;
	bh=+KYMFXlqlUBPY+PML64VVWpiuYOErjUusBKS06cHwT8=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Q+MFdw7AKanDIcPNu6kEyLPS1eETpvMZeNphSelYxAszW2VXCvABvyvSlGVAveX1s/0vvh6nLqo6uharUwRvnpJBZQTMtYlez9gIzYL7ebFkdNh8DDtRBB5bAGalszfzf8Nmcn2wSiZeiSjhkgLmIq9sr/n/FAgv00mCLinXXT05osqhbnuCG5+caFK1+BiW0CUhVQNSkWUlTxL+UyHibA5ck6QW8im1cxjaX7U5a3TcFP1ZziJzzOmtikJIU/LVeLzrAXo5+KKIMLhP5ZDABkOxGPaY/U3X2zQ4+Yt9CtSUIKiidAFJ8nZBOpVR1/ICnizd7qspTOknhMpw8Kvw9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SAdypQNC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SAdypQNC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wvbl55kzMz2ynr
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 19:36:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724924190; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+KYMFXlqlUBPY+PML64VVWpiuYOErjUusBKS06cHwT8=;
	b=SAdypQNC3so9IIEfqoS/pZ9rjW69ZAsYEKKouqrkJWC5Rr6iAknd3KvDEhwm9rVzKN8ICkWpJZV+r28Fet2Td5IsZjWNxS2+4cnx6Qe09ZE/Q5mumN44T1NP0NwWNvzgX7mjgjFwCte6xJ93KbyzpgH9ksmizkrCVt5AU7A2rz4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsbb0z_1724924188)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 17:36:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RESEND 4/4] erofs: mark experimental fscache backend deprecated
Date: Thu, 29 Aug 2024 17:36:17 +0800
Message-ID: <20240829093617.2396538-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
References: <20240829092614.2382457-1-hsiangkao@linux.alibaba.com>
 <20240829093617.2396538-1-hsiangkao@linux.alibaba.com>
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

