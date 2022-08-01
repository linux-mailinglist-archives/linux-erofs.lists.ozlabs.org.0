Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1616586BEF
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 15:27:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxJnp4nD6z2yZc
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 23:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=ueo+nPet;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=ueo+nPet;
	dkim-atps=neutral
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxJnh38Q8z2xHb
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Aug 2022 23:27:19 +1000 (AEST)
Received: from LT2ubnt.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 020163F12A;
	Mon,  1 Aug 2022 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1659360434;
	bh=Jf3f1LsziBMGNH2c3lSnJkzNKdy5jX6pNCEz92ERB+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=ueo+nPetjkmLJXMUNq8bXv/sI3CCbT7zYSK/MeSMdBjXayA49DDDzovB9fr9XRMdK
	 d6cP7gJvbEOFpDql8XvGtfPfYfGLC2DUXYKxf22GL5CVF8rdegmckZHYTAdB5IDS7h
	 JhXSF7Uah82ihk7yCU8cvau9QGCKq1jolNVxmARCp+5B8IwHLl1iWAtI3rTdjsbUym
	 rQ8Y617gDeOi/eLTfTsW195qm5g06h0Z2kLflx65aTaB29l5emueZ+1R1aStXO8+uj
	 ci93HkJCF3H9+jfOHdYdV4dgZPHLgqSJsOnB4jM4vGJ0QuoOlR7NzIMgQD95ypR0fr
	 ocsLyb+gz4OkQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: [PATCH 1/1] fs/erofs: silence erofs_probe()
Date: Mon,  1 Aug 2022 15:27:11 +0200
Message-Id: <20220801132711.353837-1-heinrich.schuchardt@canonical.com>
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
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, linux-erofs@lists.ozlabs.org, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

fs_set_blk_dev() probes all file-systems until it finds one that matches
the volume. We do not expect any console output for non-matching
file-systems.

Convert error messages in erofs_read_superblock() to debug output.

Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	keep erofs_err() for block size mismatch
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4cca322b9e..8277d9b53f 100644
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
 
-- 
2.36.1

