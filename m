Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75098592E5D
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 13:46:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M5stQ23KCz3bdy
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 21:46:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660563966;
	bh=pa2DMiG9S3CyUHkRL/8ty/NybH2uIbDVUCnFXp2wS5k=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BebvU1FKuJiIuELgDjJk8kdGc0ZIM8AzNliNd9pL4qo2d31VqD0Z6ZNRh37papQHC
	 itJ94PBIgITQ7t+tPS2En4ocBHMGIVP6wP+jGXdNIo1YQCAqzinRXi5J4Vq557FqLL
	 t+doxYTy3uZai169N+nz421G8j++JTNo/180u7mkQW8xyr2xA0g7nrZZzSzFI0DhLp
	 ph86rBsT3NbPnuVclkumSPZdHr5iJ0VPfFdRc4v5o3q9XsS/v0aND4RaXNvP7w5Vw0
	 ccKnhnpdl4cHpjgZz0u5vt/ix+v9f0WJaeH40wa+BnTNjvY0NMmRGQTtllOO7JL5eQ
	 TJvjLbv0F6CvQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=OMHmcLzH;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M5stB36Hbz2ywc
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Aug 2022 21:45:54 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A29DE20873;
	Mon, 15 Aug 2022 11:45:50 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30D7713A93;
	Mon, 15 Aug 2022 11:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UOeYOeox+mLsGAAAMHmgww
	(envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:46 +0000
To: u-boot@lists.denx.de
Subject: [PATCH v3 3/8] fs: btrfs: fix a crash if specified range is beyond file size
Date: Mon, 15 Aug 2022 19:45:14 +0800
Message-Id: <ff312a9000f93c0b785a148854a1550d291557d7.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
References: <cover.1660563403.git.wqu@suse.com>
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
From: Qu Wenruo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qu Wenruo <wqu@suse.com>
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[BUG]
When try to read a range beyond file size, btrfs driver will cause
crash/segfault:

 => load host 0 $kernel_addr_r 5k_file 0 0x2000
 SEGFAULT

[CAUSE]
In btrfs_read(), if @len is 0, we will truncated it to file end, but if
file end is beyond our file size, this truncation will underflow @len,
making it -3K in this case.

And later that @len is used to memzero the output buffer, resulting
above crash.

[FIX]
Just error out if @offset is already beyond our file size.

Now it will fail properly with correct error message:

 => load host 0 $kernel_addr_r 5m_origin 0 0x2000
 BTRFS: Read range beyond file size, offset 8192 file size 5120

 Failed to load '5m_origin'

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 309cd595d37d..74a992fa012d 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -252,6 +252,12 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return ret;
 	}
 
+	if (offset >= real_size) {
+		error("Read range beyond file size, offset %llu file size %llu",
+			offset, real_size);
+		return -EINVAL;
+	}
+
 	/*
 	 * If the length is 0 (meaning read the whole file) or the range is
 	 * beyond file size, truncate it to the end of the file.
-- 
2.37.1

