Return-Path: <linux-erofs+bounces-1287-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D06C099E6
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Oct 2025 18:41:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cv5BZ1Gd2z2xnk;
	Sun, 26 Oct 2025 03:41:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761410486;
	cv=none; b=kyoCOr6UqkbsjXN3CrIrKR2CTGMMII+Sm1wGrbm0NGGuk+abTys9zo9YcimFEu+K6OG2NED/HeCN2w3pQzyplj0yge36QnK9jNmPBSzDo5Lhki0Nt/ZVmGABLHKc8sNLjutl5jspcvXJVHX0o5kTXOtxv4nEzuykn0XzygXegR55mhZOoVBVfba8hlJBXuDFJy0QEknyw/gDlW4F1b8xpHgx1pfyXMrFNs93Ly9Ahi/Dq+KwK0bOmrA+Sxij1ATQM8SONFIcW8pTirbO61QSkqR0K1d0FSrYlLVXfg3qZn8fqGOyHd9r60H2OyG/eX3RUXERo31bX+6B38XlL66xwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761410486; c=relaxed/relaxed;
	bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2fChPjOQsPfH0zb/amuRj16xhwOAzR+kE9761Mmsv8bXnEs4UN9wxzSFGDE3dXj4ucf8Jx2xgj0g0XV7pPPnnZ39aXGw26By9Vrj5Kc3mSKyMdilI82tWec2IWo5wIGRIeR279HPS7GZvgHLSaukah0a4KuRaf+JC6jCkWuDgLG2JcB4wal4H2uRrDT29VXDYGAX0BRpI8JCn45gTRwsCb9wloLVufi10Mt+SJ+L6hZ4Q9AQqaEs4JfjL2hvkJj9GJk3TOBVcpuIJDOBbTXVP2g9xHsI23pjEHjwZhE95W4JnGj0DYDcdzqzx0GoMerk4H+PZVV4R820kCXy1UduA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BvqO9qbV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BvqO9qbV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cv5BY24LMz2xnM
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Oct 2025 03:41:24 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4eb861a8e66so26223731cf.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Oct 2025 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410481; x=1762015281; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=BvqO9qbVGrj/3UjILOPCfmIiY2fyD/ZfmVDDLbSnjR19DxAhiDhVLXoWUxTQfPokQu
         XoyrBwwcf+8CtPGfsvG6/jVKzah4/jMyhHZ7IesceJMpVTAUv80lTKd43SqYJv07bQRe
         bThoBLlRaYINxdu9qqNI10aNv1PkfPYWNaipUky8xYKICzSRw18tw+Cp6TJqomdk+1Nq
         wLg6TDc77lmIt/4yiySfRbJMkAVSEdNAByEoPLKusFZfftl79PVkj7d+X2UYMUab97ZG
         j2ockfUD1PuuB5JgDw4UhSXv0+WHf11d6Iw2w21we9jDdXuw/gYMqreJJFh4P/pG1DjD
         P6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410481; x=1762015281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=KrM6W+W/EhOhx9S8fYHbtMaYLSkhmtDQAy5BLj+IyO8p+DWbLsvETTf8iHCYKRSSw7
         CqN+V7r1c5HHROu9A3dmVtOa5O4Pn7IPbF0GR/lRVWqjSOuNm2a5JAuYBBlD2R92abz4
         0g4M6Wpb0EptYAdIWM/p/CDH+jn7P7mHlCFFpBEsqJ5EKORhcJ9M4ZKd7a77n2q740yM
         9WHA+7G+u6GxvPEjm3eFO9jvg2qc/NEdx4KZgtQWCiA1Jszyf0dZN57eYl6iZqDKjLK/
         h6j7Vaorhyi0SMsZxa+dhbAsdyDi5DYpzZLQrNfTVuLqsOgYeWIncYrP8bEUqeJFjqaZ
         QGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHnXYcIf4QXsrnnMGKQagUX50uybtVXEk6oLvbtKN06iv/21Vp5axkzJTrtXsfi5myefyrfs5pPONquw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAesDkuGcmaji7aDleEICKx9RaPjcaxIlLWqIEaJGnI3J9nPih
	yvR9bEcJMBujvwxVjztsrtgFyXwtpCenJPnjXhJcCMLGQJMgOkz1GX5z
X-Gm-Gg: ASbGncsZnFtDQnrkk0mHJg3Py5S+DfQkrLc6D6mPZSLD885l7m6q6fuOm9mlbLhdZ4q
	RgwsdcvKh8JLMIk4rj9qV4OJy+lezh1XtoIWX1SHid5yR4uiKqNo7dTj0AuQx24BzXY82UEdvQE
	YUx4yFWIoiqTNxdqyMU+g2HOdLEsE95VWg7AMovaMfds4+7zCZuxASZIKIkxn7jzFlIyXYmA5QR
	3Pfv+MG2ygiMeglt/0xW8bNAL7MCWe0YHkijKEhbl/L/58TuDjXEv7jPfzlzdt+wsNsrIpoKcR6
	315eBixpQiHoFDX5CSTLmzAFVnQ1nBx0vEUWAz+Ed5atCYDspjFIrw77hG4hE5KuZ7pP74d3qd0
	asL2lGvC53ZzdzHtOop67itDEgA1VQZSb2sbgC5lDZdDqn9HfriN/YEJZ1eYt8lg/x4jDLIuy
X-Google-Smtp-Source: AGHT+IEbSTHOPYn/ssbsalfndo2SE/aquOPMKCRUcU70dpCWt75EhJinxXayNqNWEpmv6XMRvXc8Dg==
X-Received: by 2002:a05:622a:48f:b0:4e8:aad2:391c with SMTP id d75a77b69052e-4e8aad23e00mr349567941cf.1.1761410481317;
        Sat, 25 Oct 2025 09:41:21 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3858f1esm15257191cf.29.2025.10.25.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:20 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrei Vagin <avagin@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 19/21] fs: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:18 -0400
Message-ID: <20251025164023.308884-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

GENMASK(high, low) notation is confusing. FIRST/LAST_BITS() are
more appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/erofs/internal.h      | 2 +-
 fs/f2fs/data.c           | 2 +-
 fs/f2fs/inode.c          | 2 +-
 fs/f2fs/segment.c        | 2 +-
 fs/f2fs/super.c          | 2 +-
 fs/proc/task_mmu.c       | 2 +-
 fs/resctrl/pseudo_lock.c | 2 +-
 include/linux/f2fs_fs.h  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..6e0f03092c52 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -250,7 +250,7 @@ static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
 	 * Note: on-disk NIDs remain unchanged as they are primarily used for
 	 * compatibility with non-LFS 32-bit applications.
 	 */
-	return ((nid << 1) & GENMASK_ULL(63, 32)) | (nid & GENMASK(30, 0)) |
+	return ((nid << 1) & LAST_BITS_ULL(32)) | (nid & FIRST_BITS(31)) |
 		((nid >> EROFS_DIRENT_NID_METABOX_BIT) << 31);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 775aa4f63aa3..ef08464e003f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -416,7 +416,7 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 {
-	unsigned int temp_mask = GENMASK(NR_TEMP_TYPE - 1, 0);
+	unsigned int temp_mask = FIRST_BITS(NR_TEMP_TYPE);
 	unsigned int fua_flag, meta_flag, io_flag;
 	blk_opf_t op_flags = 0;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..42a43f558136 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -524,7 +524,7 @@ static int do_read_inode(struct inode *inode)
 			fi->i_compress_level = compress_flag >>
 						COMPRESS_LEVEL_OFFSET;
 			fi->i_compress_flag = compress_flag &
-					GENMASK(COMPRESS_LEVEL_OFFSET - 1, 0);
+						FIRST_BITS(COMPRESS_LEVEL_OFFSET);
 			fi->i_cluster_size = BIT(fi->i_log_cluster_size);
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..64433d3b67d4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5425,7 +5425,7 @@ static int do_fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		wp_block = zbd->start_blk + (zone.wp >> log_sectors_per_block);
 		wp_segno = GET_SEGNO(sbi, wp_block);
 		wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
-		wp_sector_off = zone.wp & GENMASK(log_sectors_per_block - 1, 0);
+		wp_sector_off = zone.wp & FIRST_BITS(log_sectors_per_block);
 
 		if (cs->segno == wp_segno && cs->next_blkoff == wp_blkoff &&
 				wp_sector_off == 0)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index db7afb806411..96621fd45cdc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4501,7 +4501,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sbi->error_lock, flags);
-	if (sbi->stop_reason[reason] < GENMASK(BITS_PER_BYTE - 1, 0))
+	if (sbi->stop_reason[reason] < FIRST_BITS(BITS_PER_BYTE))
 		sbi->stop_reason[reason]++;
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 }
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..71de487b244c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1845,7 +1845,7 @@ struct pagemapread {
 
 #define PM_ENTRY_BYTES		sizeof(pagemap_entry_t)
 #define PM_PFRAME_BITS		55
-#define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
+#define PM_PFRAME_MASK		FIRST_BITS_ULL(PM_PFRAME_BITS)
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 87bbc2605de1..45703bbd3bca 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -30,7 +30,7 @@
  */
 static unsigned int pseudo_lock_major;
 
-static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
+static unsigned long pseudo_lock_minor_avail = FIRST_BITS(MINORBITS + 1);
 
 static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
 {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6afb4a13b81d..9996356b79e0 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -356,7 +356,7 @@ enum {
 	OFFSET_BIT_SHIFT
 };
 
-#define OFFSET_BIT_MASK		GENMASK(OFFSET_BIT_SHIFT - 1, 0)
+#define OFFSET_BIT_MASK		FIRST_BITS(OFFSET_BIT_SHIFT)
 
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
-- 
2.43.0


