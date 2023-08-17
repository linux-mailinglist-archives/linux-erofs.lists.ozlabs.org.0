Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3177F0CD
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 09:01:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=ahuepS1b;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRGBZ3YXTz3bWQ
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 17:01:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=ahuepS1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.120; helo=smtp-relay-canonical-0.canonical.com; envelope-from=heinrich.schuchardt@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRGBR4ZGLz2yWD
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 17:01:17 +1000 (AEST)
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de [62.143.244.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A6E9B3F213;
	Thu, 17 Aug 2023 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1692255673;
	bh=ZdFV02Z7zTTpGdVtPSIKn1KnXrSIWH+DhPdbHzB5M4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=ahuepS1bzx0+HnubDq0tq4PiBCtIjEIF4b2yPl+Ql4GgS8/4FL+NDAmbz0JGaYBa5
	 A8SO19y0DvlEM5OBuaYofqebcP5sp0hZyqfVVRuSbGJsGEg1vyAbJXic7dNfqcw0Dk
	 L/qbhk1ituCOVUL9vyrxHvwedpoQqy0Els07DrBpfimf201h1FEdjUnK5/1XR+wudz
	 l/dmxexYV8XQzGeHorFVvfq9p82fAldYNK1f0WpZobejhanZBTK6kG2r+WDy46GBd1
	 SUjgPWCNSjWNSiQy2aDI/udYU9HmfjEIRMzUjeHcts8E97ImH84/TUDFMQlRftuSrN
	 I/1wy6y9QR8yg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: [PATCH 1/1] fs/erofs: avoid noisy messages
Date: Thu, 17 Aug 2023 09:01:38 +0200
Message-Id: <20230817070138.44258-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The erofs file system creates noisy messages when it is not used:

    => host bind 0 disk.img
    => part list host 0
    cannot find valid erofs superblock
    cannot find valid erofs superblock

    Partition Map for HOST device 0  --   Partition Type: EFI

If there is not erofs file system, this only deserves a debug message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d33926281b..d405d488fd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -68,14 +68,14 @@ int erofs_read_superblock(void)
 
 	ret = erofs_blk_read(data, 0, erofs_blknr(sizeof(data)));
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
2.40.1

