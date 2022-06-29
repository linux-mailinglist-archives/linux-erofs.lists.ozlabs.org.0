Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCB55FECD
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzyL6yVNz3cDT
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502763;
	bh=wXQ4qMn+ticj0iPGhu85Jvjm1dYOWe0zcD/jlqeT4LM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kK7YlYZ60kB0q7K+FF+4fqBXpBic+LA2CLNtRdyYRwZPZgrJM0PIJUhBJv0+0v0Uk
	 e3djyqW0SlwDBnqxR5mIEcCQevvjs3zTT37SSyB35LTfpVkznXEshSMczBpAANDoQo
	 WOclIaCrlms1GrTGqHH4Ozb2GzWn/NmiyGe9OQyYpzRe29o4U2VZQfb0R9BZVmHzwj
	 Q/hxICRl5NrW/l0W09tRbOwZ6tolNjTWWy4Sn6Kr5ZMGnKVPDb9HExibefMgs2NqMn
	 TdkDcUM8KElg71jU1mv5K0idsacXS7/5FIxM92Ey7csgmufW6+xE5/O9FCF7XTIdzj
	 HkkyunRhV4t1A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=VbMmREBN;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzy62tszz3cgR
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:39:10 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBA461FE7B;
	Wed, 29 Jun 2022 11:39:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F700133D1;
	Wed, 29 Jun 2022 11:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cI/fFtk5vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:39:05 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 7/8] fs: ubifs: rely on higher layer to do unaligned read
Date: Wed, 29 Jun 2022 19:38:28 +0800
Message-Id: <5936704d6640d93c1188b569d4f8573f65ed5be0.1656502685.git.wqu@suse.com>
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

Currently ubifs doesn't support unaligned read offset, thanks to the
recent _fs_read() work to handle unaligned read, we only need to
implement ubifs_get_blocksize() to take advantage of it.

Now ubifs can do unaligned read without any problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Unfortunately I can not test ubifs, as enabling UBI would cause compile
failure due to missing of <asm/atomic.h> header.
---
 fs/fs.c               |  2 +-
 fs/ubifs/ubifs.c      | 13 ++++++++-----
 include/ubifs_uboot.h |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 09625f52e913..61bae1051406 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -311,7 +311,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ubifs_exists,
 		.size = ubifs_size,
 		.read = ubifs_read,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = ubifs_get_blocksize,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index d3026e310168..a8ab556dd376 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -846,11 +846,9 @@ int ubifs_read(const char *filename, void *buf, loff_t offset,
 
 	*actread = 0;
 
-	if (offset & (PAGE_SIZE - 1)) {
-		printf("ubifs: Error offset must be a multiple of %d\n",
-		       PAGE_SIZE);
-		return -1;
-	}
+	/* Higher layer should ensure it always pass page aligned range. */
+	assert(IS_ALIGNED(offset, PAGE_SIZE));
+	assert(IS_ALIGNED(size, PAGE_SIZE));
 
 	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
 	/* ubifs_findfile will resolve symlinks, so we know that we get
@@ -920,6 +918,11 @@ out:
 	return err;
 }
 
+int ubifs_get_blocksize(const char *filename)
+{
+	return PAGE_SIZE;
+}
+
 void ubifs_close(void)
 {
 }
diff --git a/include/ubifs_uboot.h b/include/ubifs_uboot.h
index b025779d59ff..bcd21715314a 100644
--- a/include/ubifs_uboot.h
+++ b/include/ubifs_uboot.h
@@ -29,6 +29,7 @@ int ubifs_exists(const char *filename);
 int ubifs_size(const char *filename, loff_t *size);
 int ubifs_read(const char *filename, void *buf, loff_t offset,
 	       loff_t size, loff_t *actread);
+int ubifs_get_blocksize(const char *filename);
 void ubifs_close(void);
 
 #endif /* __UBIFS_UBOOT_H__ */
-- 
2.36.1

