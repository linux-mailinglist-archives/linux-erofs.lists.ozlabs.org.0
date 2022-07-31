Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947B585E42
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 11:10:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lwb804Gwrz2yjC
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 19:10:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=kxZJlDCf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.121; helo=smtp-relay-canonical-1.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=kxZJlDCf;
	dkim-atps=neutral
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lwb7q4WNHz2xGS
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 19:10:30 +1000 (AEST)
Received: from LT2ubnt.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2DB3E3F3D5;
	Sun, 31 Jul 2022 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1659258624;
	bh=ZYITxB6qJdVbTaH6uRUHZyxmH7u+8MycV97iKVyQWBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=kxZJlDCf5XV6RouYZJLUIDs3uZI/JgTdP2q+BDx4k5J7dJUti13k5eimjHSCfueOS
	 F4Q3JicoPcH+QBlqHWoYht4jAhClJhZ0ynUBQJFXpaHJwOahX172Onby/iAuaIdcQ3
	 VgXvP1x/COm0dsSgaCT8ih5SgFan5Ibjsm8+ElrTIG5pJ2rKHX1Lx02ytTePnf9EnJ
	 KXIqgFzDA0TlfeqqZn41k7iSUir35LapUbo+DgcLU/EEkcCxUdD7e6o3xPp2bZ/ll5
	 GXvtvpGlAENIlM6DvgcdNoVypk/J4d+kvMhGZddWwuqhWyVWzn2GTlpoR0kWAg/u+Y
	 VbmbMIeQNHqXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: [PATCH 1/1] fs/erofs: silence erofs_probe()
Date: Sun, 31 Jul 2022 11:10:06 +0200
Message-Id: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.36.1
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

fs_set_blk_dev() probes all file-systems until it finds one that matches
the volume. We do not expect any console output for non-matching
file-systems.

Convert error messages in erofs_read_superblock() to debug output.

Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/erofs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4cca322b9e..095754dc28 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -65,14 +65,14 @@ int erofs_read_superblock(void)
 
 	ret = erofs_blk_read(data, 0, 1);
 	if (ret < 0) {
-		erofs_err("cannot read erofs superblock: %d", ret);
+		erofs_dbg("cannot read erofs superblock: %d", ret);
 		return -EIO;
 	}
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
-		erofs_err("cannot find valid erofs superblock");
+		erofs_dbg("cannot find valid erofs superblock");
 		return ret;
 	}
 
@@ -81,7 +81,7 @@ int erofs_read_superblock(void)
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err("blksize %u isn't supported on this platform",
+		erofs_dbg("blksize %u isn't supported on this platform",
 			  1 << blkszbits);
 		return ret;
 	}
-- 
2.36.1

