Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D955FECC
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzyH4Khcz3chG
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502759;
	bh=DvAQagvELUJMYpaLskhgj/PO8ZwZsmLrHWw0DiAfKH8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=N408gqJHKXHMXDkMX0J6zkP6yHjg43v92DRAVuiA3tthCtEx6W+MRaw0ah6aYkRVq
	 K7KSF+V1W86yzDCYyiEj98Q6Ei0ZV1sjrT0t0ZyKdpy9eIzvD9Z59DHldVwKOTR43y
	 gaZvXwK34rRlLBMHXqGdpy0+lRLgexRkqVUNbRmAhKby+muLZ4Wb2Ppk2cLojYWsUr
	 PdP+4wR3oRbIpAiP1EVHPUIANwEf3yQzrYYd9IksabPsUZ6HI+8gKSEGlxdUcMFgAw
	 gCfDkA/kDvRBrj7rI5ANQFaccH1SZqvs4oB0/Ebkovrd226PLGr6Sg0p7FVNo2VueO
	 9ypqjntzRnmsw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=OZD+YGF8;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzy35QT3z3chq
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:39:07 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30C891FE91;
	Wed, 29 Jun 2022 11:39:05 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E63ED133D1;
	Wed, 29 Jun 2022 11:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +A3iK9Y5vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:39:02 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 6/8] fs: fat: rely on higher layer to get block aligned read range
Date: Wed, 29 Jun 2022 19:38:27 +0800
Message-Id: <0a30a7118f69bd0636bc2350d53890b99b8c191d.1656502685.git.wqu@suse.com>
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
index 3cd2c88a4895..09625f52e913 100644
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

