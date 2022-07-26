Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B19580AD1
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 07:23:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LsQKx36w0z3brk
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Jul 2022 15:23:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1658812997;
	bh=3QnjwJOqg2q74dFJjkG5kgqyCneA2BG0g7oVk3bzXxk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QIhank2m7mlL78j810J5YdgXGiIXNwlpf6NQV0HOgSTWHoTbYj/8hlgiky0yuQNOl
	 F3SB7WkhfhngCFdmo/VuPwMevh20DFITnRfJLOAkUKO6gjOjXn5uKAmRMaz7Zjx+PB
	 1J4JtrRdOnxok7O0qvh+wQCTFewoTMrHGhTw/G6MUVamkP0vIPo5wRajVm4BEMPXyv
	 +ZlXbAnyTGn8tvNHUakimNwCwJxI13THL2quYYHK65XkzVxr52DvYUcz2wuWJjRjSX
	 M5S/fQMVQwwKuS1jyPusx4uxOsH1/N7d73th5IN/t7k5XBk9HpzytDd2FwvRKPgpST
	 BB7Z6ZeSlMRWg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=rD1mz95u;
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LsQKj3lydz3c1M
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Jul 2022 15:23:05 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6191C34BB2;
	Tue, 26 Jul 2022 05:23:00 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07B1513A12;
	Tue, 26 Jul 2022 05:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EK/bMjF632IFOwAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 26 Jul 2022 05:22:57 +0000
To: u-boot@lists.denx.de
Subject: [PATCH v2 8/8] fs: erofs: add unaligned read range handling
Date: Tue, 26 Jul 2022 13:22:16 +0800
Message-Id: <e58e82d22e1492b51ad3cc591272462fa5b7ef86.1658812744.git.wqu@suse.com>
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

I'm not an expert on erofs, but my quick glance didn't expose any
special handling on unaligned range, thus I think the U-boot erofs
driver doesn't really support unaligned read range.

This patch will add erofs_get_blocksize() so erofs can benefit from the
generic unaligned read support.

Cc: Huang Jianan <jnhuang95@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Huang Jianan <jnhuang95@gmail.com>
---
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 6 ++++++
 fs/fs.c             | 2 +-
 include/erofs.h     | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4af7c91560cc..d368a6481bf1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -83,6 +83,7 @@ struct erofs_sb_info {
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
 	u32 checksum;
+	u32 blocksize;
 	u16 extra_devices;
 	union {
 		u16 devt_slotoff;		/* used for mkfs */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 4cca322b9ead..df01d2e719a7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -99,7 +99,13 @@ int erofs_read_superblock(void)
 
 	sbi.build_time = le64_to_cpu(dsb->build_time);
 	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+	sbi.blocksize = 1 << blkszbits;
 
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return erofs_init_devices(&sbi, dsb);
 }
+
+int erofs_get_blocksize(const char *filename)
+{
+	return sbi.blocksize;
+}
diff --git a/fs/fs.c b/fs/fs.c
index 2b847d83597b..23cfb1f5025b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -375,7 +375,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = erofs_readdir,
 		.ls = fs_ls_generic,
 		.read = erofs_read,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = erofs_get_blocksize,
 		.size = erofs_size,
 		.close = erofs_close,
 		.closedir = erofs_closedir,
diff --git a/include/erofs.h b/include/erofs.h
index 1fbe82bf72cb..18bd6807c538 100644
--- a/include/erofs.h
+++ b/include/erofs.h
@@ -10,6 +10,7 @@ int erofs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition);
 int erofs_read(const char *filename, void *buf, loff_t offset,
 	       loff_t len, loff_t *actread);
+int erofs_get_blocksize(const char *filename);
 int erofs_size(const char *filename, loff_t *size);
 int erofs_exists(const char *filename);
 void erofs_close(void);
-- 
2.37.0

