Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652255BF1B
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRX2pfFz3c8W
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401320;
	bh=mr46B25ZUmI7GGQ5t6X0E3WzxzV6Pf3dl/rRvmfxgMo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=POUD7qTBo0ILQe+94JZbhf9ijwcGKdsbnrcsAwT3TwGRUQAu/JK8jKF+czDFjnQPM
	 ysWbxVuNs8MOwC2Eyk5vxAI3h7uSDIDkgjKkWUi+EqJWDw1ey1N3JhMcJb8cG9WQn9
	 uKbo08mwNylQK1wIHuwfVliA4tDoOfcaVrIADmL08/MKLWzS+ghwvXXQ99MA9p0JoZ
	 4MnEF3DohlL/Ze4mjfruCIgMS6REyWbmQeiW1v5wihsVeYCFWI8phY413z68+hSUgj
	 qeEzoTiu9gDlbgUKuxARxnaoYLSQCQK1XNUDvtWUg4ZkHBeAyMiwJOJ4tA80h17Qu3
	 5tIZ7RFpElpFA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=DAVGg4XD;
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRR0Glrz306Y
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:34 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4138C21DAF;
	Tue, 28 Jun 2022 07:28:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B77E8139E9;
	Tue, 28 Jun 2022 07:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WOcYIJ2tumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:29 +0000
To: u-boot@lists.denx.de
Subject: [PATCH RFC 1/8] fs: fat: unexport file_fat_read_at()
Date: Tue, 28 Jun 2022 15:28:01 +0800
Message-Id: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
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

That function is only utilized inside fat driver, unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fat/fat.c  | 4 ++--
 include/fat.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index df9ea2c028fc..dcceccbcee0a 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1243,8 +1243,8 @@ out_free_itr:
 	return ret;
 }
 
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread)
+static int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
+			    loff_t maxsize, loff_t *actread)
 {
 	fsdata fsdata;
 	fat_itr *itr;
diff --git a/include/fat.h b/include/fat.h
index bd8e450b33a3..a9756fb4cd1b 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -200,8 +200,6 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
 int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread);
 int file_fat_read(const char *filename, void *buffer, int maxsize);
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
-- 
2.36.1

