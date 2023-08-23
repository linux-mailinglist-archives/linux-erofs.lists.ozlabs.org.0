Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A27855D3
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 12:49:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=21w4FoOZ;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uzg4W9UM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW2yj3fcXz3c3M
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 20:49:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=21w4FoOZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uzg4W9UM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW2yR2W2Wz3bwJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 20:49:02 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10AA520752;
	Wed, 23 Aug 2023 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692787739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgUNyIPDqYp3LYCC5+mNZ2FCjGJLNbuM1N9RZ9x6eOg=;
	b=21w4FoOZ5IPLezdWegn4c6m1GrnbMjdEorE6NFhPjJUZbzf3CJ461210BnmamikSsMpra+
	N05DswsBPtMl5UWhneuiGT/Y9s2O3t41RjWHHxVjynC7VrbEtaRrf6ZnnnPJfiaQkW8vFn
	tmN7GQHcORTHyr2ZqiRPsILazMvp+wI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692787739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgUNyIPDqYp3LYCC5+mNZ2FCjGJLNbuM1N9RZ9x6eOg=;
	b=uzg4W9UM/y0bf6h8Y1AW3k7w9hX1RmXcIZmZmHeS+b+GYiX42KhRKYG3axZyfNng6Z8cRl
	WYJMWo8OLyySntBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F371413592;
	Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZaFyOxrk5WRpIAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 820E5A0797; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 21/29] erofs: Convert to use bdev_open_by_path()
Date: Wed, 23 Aug 2023 12:48:32 +0200
Message-Id: <20230823104857.11437-21-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3389; i=jack@suse.cz; h=from:subject; bh=4IVdwN+Q5zXieS6CXQNwhh7/CLqTEj/id+l4gyBHh4Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eQALuGGKaLBFGTZ6muYDbIFD8tkFlOWm8ShbuQz c+NJZHqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXkAAAKCRCcnaoHP2RA2eR9B/ 9C5ILJpLtXoW/fhxe/C4WFplhU60G60DIc6BjWz3oiSflcIHd2p8+9oS0CEiN+sSCh/CxXcjajnjki TZw6FGnVl8nvwEx4/cKEzsUOtf7IbZAxZLCsitjMMY7v4mf0y4KdEPQVlRdHvWMuvNC+5ERkUB1gIG s+EK2kjmsGYhWW85cYf7LGYbuC8xs+tmb5mxALbZhBxhEuGx2anc/3/1aDjMHBvOnJCIk8NAPUOg1g 0BEun/ehoc5La/eqVt0C2X88wFH1kQVJSvlygKkbpGtldoKZ0yZ+99ImqV/o2VblHcfhAJcjs9K3o8 J0bVRZUb/zFNsG+qH3L3rH2wkjY2Jx
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
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Convert erofs to use bdev_open_by_path() and pass the handle around.

CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-erofs@lists.ozlabs.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/erofs/data.c     |  4 ++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db5e4b7636ec..1fa60cfff267 100644
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
index 36e32fa542f0..fabd3bb0c194 100644
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
index 566f68ddfa36..366a46fe7fdc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -230,7 +230,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -254,13 +254,13 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
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
@@ -815,8 +815,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
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

