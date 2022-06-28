Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC26855BF1E
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRj6LV5z3bx5
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401329;
	bh=fqDh39Eux/iXUNBq/dB1wZRAl5zZcXfXHaBWI4ElYTI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Le3U1clKLqo8yEqPX35wO3VPEUF9Qf53v1hCxld3VTOYNmdJ9pRySQOszWh6eDx6o
	 e5Ohan4ECH06JSZA9mENKswe/5VEwfF408iybcKG5zHHDSGaRzR9WNJmPSeYeSIPG/
	 VhKQBb2Z/H3erKXR3i+I7lsp5S3FHOLMc+VE1Hjrd4vHI6if1FONOS8WEiJ+cP0ACS
	 2pvQaekNN9BHrttJBtPNXK8HljTnMdlqy1LGGlqYK/uPwqmXm/ri4O04X0squIcyFs
	 a6eLFf42gRvpGq5//HhpirJ/YaPv56QO5Xb60G5dXNU3Y6HZzWLZCNgBzgmne46KLc
	 CT3m1z+0v+K5A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Lif/iwWm;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRb1fmtz3cBm
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:43 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCC681FB3C;
	Tue, 28 Jun 2022 07:28:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E4CB139E9;
	Tue, 28 Jun 2022 07:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ULBZCqatumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:38 +0000
To: u-boot@lists.denx.de
Subject: [PATCH RFC 4/8] fs: ext4: rely on _fs_read() to pass block aligned range into ext4fs_read_file()
Date: Tue, 28 Jun 2022 15:28:04 +0800
Message-Id: <d001706f1471ca0d4e98b7de9f9080188ddd2252.1656401086.git.wqu@suse.com>
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

Since _fs_read() is handling the unaligned read internally, ext4 driver
only need to handle block aligned read.

Unfortunately I'm not familiar with ext4 and its driver, thus not
confident enough to cleanup all the unaligned read related code.

So here we will have some dead code, and any help to clean them up is
appreciated.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/ext4/ext4fs.c | 11 +++++++++++
 fs/fs.c          |  2 +-
 include/ext4fs.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 4c89152ce4ad..be2680994d8b 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -71,6 +71,10 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 
 	ext_cache_init(&cache);
 
+	/* Higher layer has ensured to pass block aligned range here. */
+	assert(IS_ALIGNED(pos, blocksize));
+	assert(IS_ALIGNED(len, blocksize));
+
 	/* Adjust len so it we can't read past the end of the file. */
 	if (len + pos > filesize)
 		len = (filesize - pos);
@@ -183,6 +187,13 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	return 0;
 }
 
+int ext4fs_get_blocksize(const char *filename)
+{
+	struct ext_filesystem *fs = get_fs();
+
+	return fs->blksz;
+}
+
 int ext4fs_ls(const char *dirname)
 {
 	struct ext2fs_node *dirnode = NULL;
diff --git a/fs/fs.c b/fs/fs.c
index 30696ac6c1a3..e69a0968bb6d 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -236,7 +236,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ext4fs_get_blocksize,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c0..cc40cfedd954 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -146,6 +146,7 @@ int ext4fs_create_link(const char *target, const char *fname);
 struct ext_filesystem *get_fs(void);
 int ext4fs_open(const char *filename, loff_t *len);
 int ext4fs_read(char *buf, loff_t offset, loff_t len, loff_t *actread);
+int ext4fs_get_blocksize(const char *filename);
 int ext4fs_mount(unsigned part_length);
 void ext4fs_close(void);
 void ext4fs_reinit_global(void);
-- 
2.36.1

