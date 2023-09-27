Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C27B0057
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Sep 2023 11:35:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yNLN2znp;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vkt3UFd/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RwWfs2NpGz3c8Y
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Sep 2023 19:35:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yNLN2znp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vkt3UFd/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RwWfd2JB6z2yW7
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Sep 2023 19:34:48 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E878B1FD6B;
	Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOnyti5KClOK/DZ+r1V0hcJlW7O4gjBtUgUcqKUTL18=;
	b=yNLN2znpPx6VmCHUZP4KTq07gSLjhc3gN+54DiugulyavDeRbC7iOb7AEf+SWIMfqYCVyR
	XOjgaE6/WC/ORuonX4TG5roAJsOPqo0jEGiItLInbA3LfOAOfFgVGkjQ3vzQK6fCGUJmQO
	HfNPT4w+FILO8ChJJKGLrmX0jN6CsR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695807284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOnyti5KClOK/DZ+r1V0hcJlW7O4gjBtUgUcqKUTL18=;
	b=vkt3UFd/lQ/W9S7x1bMlwQkpmO/bS1/wHMb2BlnIjl5L5T0Q7KajN0Cp+NmDlUEdVJuSK3
	mJlPW78fNBV5qvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C738413A74;
	Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id H2eiMDT3E2UxEwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85278A07CB; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 21/29] erofs: Convert to use bdev_open_by_path()
Date: Wed, 27 Sep 2023 11:34:27 +0200
Message-Id: <20230927093442.25915-21-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=jack@suse.cz; h=from:subject; bh=tSNAUT0uFbcm9oHwALUFKHxE0ETO4bF9IMenCC0F+F0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cjo+HbOx0LsjyNvizl8EI9YCHUrtEejlIYkdX2 jBM7EHyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3IwAKCRCcnaoHP2RA2UIjB/ 4we2a/ke+Y1w3SDvCVhUCYfQxjQ7yd/lH2XBmVVcS7BRGvzdxSCoLUlJu71xFNN9J3srkid05buJAP zPoefvZ1agttMkroPNJp9RRGlqzaRlp0UKQdF+AcNFphngjIaj+JKjjUH1udxtBm+3LchiWCE84/ff nmUz919TGIQ0J4NPA93Qg2awChYidR63Awk1zGr54gPZw022wP6uwpAGAxQ/g4V0cRx7zOPrLoDs47 Zm40Je2jTX4pTAvNP/BUg4BiJXndKl/RrL63syWFsJNZkYkaDGARQ6a7ZoJYEblNxvzs1ZCPJ+nciA rPz4ZtNyQh3PgjN5J6rf8FipV7Z9nu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
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
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Convert erofs to use bdev_open_by_path() and pass the handle around.

CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-erofs@lists.ozlabs.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/erofs/data.c     |  4 ++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0c2c99c58b5e..f6a0a1748521 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -222,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev;
+		map->m_bdev = dif->bdev_handle->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -240,7 +240,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev;
+				map->m_bdev = dif->bdev_handle->bdev;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ff88d0dd980..cf04e21bfda2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 44a24d573f1f..2bf6dac83025 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -227,7 +227,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -251,13 +251,13 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev = blkdev_get_by_path(dif->path, BLK_OPEN_READ, sb->s_type,
-					  NULL);
-		if (IS_ERR(bdev))
-			return PTR_ERR(bdev);
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
-						  NULL, NULL);
+		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
+						sb->s_type, NULL);
+		if (IS_ERR(bdev_handle))
+			return PTR_ERR(bdev_handle);
+		dif->bdev_handle = bdev_handle;
+		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
+				&dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -806,8 +806,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev)
-		blkdev_put(dif->bdev, &erofs_fs_type);
+	if (dif->bdev_handle)
+		bdev_release(dif->bdev_handle);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
-- 
2.35.3

