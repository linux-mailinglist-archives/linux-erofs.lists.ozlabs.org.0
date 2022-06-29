Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C455FEC9
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzy523XLz3chG
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502749;
	bh=ZoBlzWZfVdqYKCb/B1++pokD0MnUEbdHZIspM4GSiHc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=XvcOH+GJzILvoNIowXcheMhchJrZvYzILG2w6QPIxngvht5riouwsXNm+mRQMkhiu
	 sCJKQCMrhM8QAthS82jJVcPUKg+vD6SV+/AzcGKDndT+rVLw8XMUecMPATmhbk77ut
	 gSa2TnzPasb8yAkWL7of8ITRUCCemUFbUD1uAbzAKSbTxezai3/AyoWkWRvtoZ+KeW
	 9ndY5w1zU/+tnRGLOjD4macd5Pxtlb+FRMeqJwkMwFPXoD7200/ajZJRXdRcekUgUj
	 AUahxraU6WhYAbyMYdM3JDJ7C7TnUImEOBVPrbeXlSpsjfCqHivKDQNo3XdcUsDhCS
	 et5VJuBSFd3Qg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=n48vznRI;
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzxv4YPDz3c9K
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:38:59 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 402AF220C7;
	Wed, 29 Jun 2022 11:38:57 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F29F7133D1;
	Wed, 29 Jun 2022 11:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cK4vL845vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:38:54 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 3/8] fs: btrfs: fix a crash if specified range is beyond file size
Date: Wed, 29 Jun 2022 19:38:24 +0800
Message-Id: <94e08500aa3de95b3516be452b98c46e79fa6621.1656502685.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656502685.git.wqu@suse.com>
References: <cover.1656502685.git.wqu@suse.com>
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
Cc: trini@konsulko.com, jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
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
index 9145727058d4..bf9e1f2f17cf 100644
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
2.36.1

