Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0A55BF1F
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRm6krQz3bxk
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401332;
	bh=STOFWKhpEtePim/Zo8FzXhxFJxFMKHbFtnaz4ZZx2qA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f1849QmUpSbqHDFchrpxC/+T/KXwSRoliYoy64GSd8zBcGphs+x3KSOe8DCf5bVYE
	 mV2mH0MIpEEPIrigl0KwCFqrJJIPQeB/eqOK7n2xuNV9Db3N4IVWbxvo589Y7OhsQl
	 S5Sx1j/DfqBlqyxbOd0hnmC8SYXjps6af16TTmfTMTr/TEREZklpBmuTnjyWdhQjtl
	 MagW6awkAv6KCiA4HQ752m8OGyoZ+20kbBm+WF0uMmFcZxvI+VkGY/qyao2hzZm2c3
	 1exn2ZMOjy0/cPIo1bbeBAGyzRtu/0NF6Sa2oRN4569kovPOvclD3mYLwK+BC22XhZ
	 vpM+pCSTOFWPQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=OBCKu80f;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRf340sz3c7s
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:46 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABD941FB3C;
	Tue, 28 Jun 2022 07:28:43 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D708139E9;
	Tue, 28 Jun 2022 07:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iCXxAamtumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:41 +0000
To: u-boot@lists.denx.de
Subject: [PATCH RFC 5/8] fs: fat: rely on higher layer to get block aligned read range
Date: Tue, 28 Jun 2022 15:28:05 +0800
Message-Id: <baf6d4c4715b83fabe906e17fffe57934d4d6469.1656401086.git.wqu@suse.com>
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

Just implement fat_get_blocksize() for fat, so that fat_read_file()
always get a block aligned read range.

Unfortunately I'm not experienced enough to cleanup the fat code, thus
further cleanup is appreciated.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fat/fat.c  | 13 +++++++++++++
 fs/fs.c       |  2 +-
 include/fat.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index dcceccbcee0a..e13035e8e6d1 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1299,6 +1299,19 @@ int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 	return ret;
 }
 
+int fat_get_blocksize(const char *filename)
+{
+	fsdata fsdata = {0};
+	int ret;
+
+	ret = get_fs_info(&fsdata);
+	if (ret)
+		return ret;
+
+	free(fsdata.fatbuf);
+	return fsdata.sect_size;
+}
+
 typedef struct {
 	struct fs_dir_stream parent;
 	struct fs_dirent dirent;
diff --git a/fs/fs.c b/fs/fs.c
index e69a0968bb6d..7e4ead9b790b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -207,7 +207,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fat_exists,
 		.size = fat_size,
 		.read = fat_read_file,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = fat_get_blocksize,
 #if CONFIG_IS_ENABLED(FAT_WRITE)
 		.write = file_fat_write,
 		.unlink = fat_unlink,
diff --git a/include/fat.h b/include/fat.h
index a9756fb4cd1b..c03a2bebecef 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -201,6 +201,7 @@ int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
 int file_fat_read(const char *filename, void *buffer, int maxsize);
+int fat_get_blocksize(const char *filename);
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
 
-- 
2.36.1

