Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F74580ACF
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 07:23:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LsQKp5Wzrz3c3L
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 15:23:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1658812990;
	bh=Uq70NWCgKNoYyVM47N8p/bv3HKKY5s4pX/Il0N4z2PQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=a9E0uyr/iXDPyakRmhqsXyRYhMQkrnyKlWB6qLpv5V9s0GhPvCmCmMQkbkhPK/JwW
	 wxuARl5XvlDTcTNvMQqi0DVECLOqYmSgPf4dvw45X8WXv+bB0Dfhwn8TJLHyLJ7bET
	 U8EqYNJDKlAGpBRr5rXeCq6B3i4hY3Zp2XEUYJd6todMOuS6rsqnOWgbOa3CLw2qwc
	 HiS/5he3sua1TyqGQhZXkH0nQhPIbER1TsDNhp8a8sMBOtRwD+9wuCQ7RXYiKHjnL9
	 ZHFvxKpmXiWJc9kKyV8uXd2Lv3jdpGBO6s/Hl9nEYWCF5cERNSYAo8xMg2y+XpxdCx
	 CnnhbJkuWnl2Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Uyylh7kW;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LsQKY3pS1z3bvl
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Jul 2022 15:22:57 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDDA81F9C3;
	Tue, 26 Jul 2022 05:22:54 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3243B13A12;
	Tue, 26 Jul 2022 05:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IJ+oASx632IFOwAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 26 Jul 2022 05:22:52 +0000
To: u-boot@lists.denx.de
Subject: [PATCH v2 6/8] fs: fat: rely on higher layer to get block aligned read range
Date: Tue, 26 Jul 2022 13:22:14 +0800
Message-Id: <70c34636e605f0cbcdaa2183bcc7fb1d5de2cb6d.1658812744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658812744.git.wqu@suse.com>
References: <cover.1658812744.git.wqu@suse.com>
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
index 3d6cc6b38b26..3eb540c5fe30 100644
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
2.37.0

