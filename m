Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FA55FECB
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzyD2nmVz3cj2
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502756;
	bh=sbUxiVYdk6aZy8J7Gm/I8CcZX32AdO9X/hxJuXeK2yU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FXDj0agGIKSvlFYH51WEPdENSTloudYrMxG0aVCh9WE9Z4NJT04myYT+3IHPFltIr
	 fZ0H+9x3FR3rF/CR8V1G1dkMn5XbE8+t0gEMHwaSntH/ukZ1pI15zhcK7Zx/kts7R1
	 zKBpsgx56LHcVZRGyciaBapv/NcQhsjev5MEZpJKEWOeaZIMZfzdvdXKXVLGthpFFE
	 z+g9fojfCSj9w7AxMcEGlkgnnx8eQtykjFigiMI2pLC4VY2WWmP7Cq7aneVvErWaji
	 GSPKikayy5z4921ugT9NBKLCgoH8ilKv+euOo2UCU3KfbSeaLaHDPtW9e+ig2pHjcF
	 YeCDtS1S172JQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Iabo3qhj;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzy06hnyz3cdy
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:39:04 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 863581FE7B;
	Wed, 29 Jun 2022 11:39:02 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44C9E133D1;
	Wed, 29 Jun 2022 11:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8LGpBNQ5vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:39:00 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 5/8] fs: ext4: rely on _fs_read() to handle leading unaligned block read
Date: Wed, 29 Jun 2022 19:38:26 +0800
Message-Id: <e853732016e9e80dfdb2edce8d81d91be1dec15d.1656502685.git.wqu@suse.com>
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

Just add ext4_get_blocksize() and a new assert() in ext4fs_read_file().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Several cleanup candicate:

1. ext_fs->blksz is never populated, thus it's always 0
   We can not easily grab blocksize just like btrfs in this case.

   Thus we have to go the same calculation in ext4fs_read_file().

2. can not easily cleanup @skipfirst in ext4fs_read_file()
   It seems to screw up with soft link read.
---
 fs/ext4/ext4fs.c | 22 ++++++++++++++++++++++
 fs/fs.c          |  2 +-
 include/ext4fs.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4ad..b0568e77a895 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -69,6 +69,8 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	short status;
 	struct ext_block_cache cache;
 
+	assert(IS_ALIGNED(pos, blocksize));
+
 	ext_cache_init(&cache);
 
 	/* Adjust len so it we can't read past the end of the file. */
@@ -259,6 +261,26 @@ int ext4_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 	return ext4fs_read(buf, offset, len, len_read);
 }
 
+int ext4_get_blocksize(const char *filename)
+{
+	struct ext_filesystem *fs;
+	int log2blksz;
+	int log2_fs_blocksize;
+	loff_t file_len;
+	int ret;
+
+	ret = ext4fs_open(filename, &file_len);
+	if (ret < 0) {
+		printf("** File not found %s **\n", filename);
+		return -1;
+	}
+	fs = get_fs();
+	log2blksz = fs->dev_desc->log2blksz;
+	log2_fs_blocksize = LOG2_BLOCK_SIZE(ext4fs_file->data) - log2blksz;
+
+	return (1 << (log2_fs_blocksize + log2blksz));
+}
+
 int ext4fs_uuid(char *uuid_str)
 {
 	if (ext4fs_root == NULL)
diff --git a/fs/fs.c b/fs/fs.c
index f9df8d9ec9a4..3cd2c88a4895 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -236,7 +236,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ext4_get_blocksize,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c0..0f4cf32dcc2a 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -161,6 +161,7 @@ int ext4fs_probe(struct blk_desc *fs_dev_desc,
 		 struct disk_partition *fs_partition);
 int ext4_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 		   loff_t *actread);
+int ext4_get_blocksize(const char *filename);
 int ext4_read_superblock(char *buffer);
 int ext4fs_uuid(char *uuid_str);
 void ext_cache_init(struct ext_block_cache *cache);
-- 
2.36.1

