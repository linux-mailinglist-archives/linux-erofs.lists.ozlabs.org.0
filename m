Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7CE46A58C
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 20:20:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J7CvK5L3dz2yZh
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Dec 2021 06:20:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Dd4+cOj5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ihPCMU7n;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=alex@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=Dd4+cOj5; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=ihPCMU7n; 
 dkim-atps=neutral
X-Greylist: delayed 387 seconds by postgrey-1.36 at boromir;
 Tue, 07 Dec 2021 06:20:42 AEDT
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J7CvG0c7nz2xCW
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Dec 2021 06:20:41 +1100 (AEDT)
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638818047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WaDQYw8cNKT0RaZEtm3VO4WOsSt06Fm4JfXUoC+u/ck=;
 b=Dd4+cOj51iD1AV+O+bvjQ4ueXoXIxK8YNsf0wXY3IpeG71WGuGOBJCspHC/pBmu/at5sy5
 MpRHeooJ74KG084tIHKvqfay+u/9lOquP+LLysraNQOA0P4mdWGOGpu85BvrjI9ZNtbPoK
 RMdrf7zceKY82SK0cv6lgYwqOqLOplUuuMu9twG7W1pFTPRbmZk+J+z+4U0ZVcHG4xi31j
 wXbGoVsBMTqc1MJQhqiHZe/SGbBlowOMhyobYeTjZXKfCuC/kCVodBe+Z6bEUNrmYSN8fF
 JF/ukf7NPFFxKLPVSpf0DOx++JTk/SWylU4PLsPGv8xHW+ADOkMQfoKz6jHaew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638818047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WaDQYw8cNKT0RaZEtm3VO4WOsSt06Fm4JfXUoC+u/ck=;
 b=ihPCMU7nDiNpjlZ4bEZl+TMMH7YkNOIqkY/j3Qq9SU0dOC/Q68IiyynK5XnVVpE1xQM+RF
 BRshDc2CQIEKvsAQ==
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH] fsck/main.c: add missing include
Date: Mon,  6 Dec 2021 20:14:03 +0100
Message-Id: <20211206191403.1435229-1-alex@linutronix.de>
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
Cc: Alexander Kanavin <alex@linutronix.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise musl C library builds fail with missing S_IFMT/S_IFDIR
definitions.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 fsck/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/main.c b/fsck/main.c
index aefa881..ad48e35 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/decompress.h"
-- 
2.20.1

