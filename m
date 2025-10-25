Return-Path: <linux-erofs+bounces-1286-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C38C09888
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Oct 2025 18:33:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cv51f6pCCz2xgQ;
	Sun, 26 Oct 2025 03:33:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761410022;
	cv=none; b=nWSzNMVnMHB8dMUUhCyHonKuQ6ZeswiojftbymHTNkkaVWygbJWImLzvSZ9WFroBKOqFpXEvEcHX1luI3UG8lkcoVyZXtq/qdVopqMFRpdfQa5FCuxnd7RcdpMJam3KSEl3LiYmqFiAVn9slLsZdiapHZeprn1ftSdwIGmMOiuJOv1/1VKRfmxtOaq05xyL3I7L4tDHo3Kt4DVCCehtHcw8za0qzK7t3YH1pkKrQb7CWCz0o+ZhiKcdaJ1mbbBlndK2hRRIDbgF0cIg2he/BYIPcFrtc1PnbNU8Sq7as4uogsn6hQOVHJWfOcAbnHsx04k5uVE3+ljN/+YUKg8Bx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761410022; c=relaxed/relaxed;
	bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxokXHu7rxUJzcqRHhHSxxPRwKzOK1Hvq+HISpMIopYRaai/Ow19JsrU0dK9Y7pkuu7HMcCNceRR2ISQQ7QAsD76BpWilFLVqqmilJ49pNWMpXOF0gPpeCeultVLz72iYsWo3f04c4KVzcGE1SLCIZq1IHi2JqJg/+y9jyioGSAOkzvV86QyZLAsUPZVoV/woNgqbAVxhxgR4wBo+FtJtXMyANTXHF5SV4d410qUjZdWJFyNdm/xJXGRS+B67+U465wC3EF0thG2Lgo0RlmLNaB+mSeLX67C9/oPNGInSZncVqt2vsAThdnwXQUCtRdtNem/pQs95+14lob6ErZMbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XnM7KUDh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XnM7KUDh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cv51d2MNLz2xdg
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Oct 2025 03:33:40 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-87dfba1b278so34241336d6.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 25 Oct 2025 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410016; x=1762014816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=XnM7KUDho5xG9RXtz//9xw15eZllAMgfxUU4QTucDYptJ1XUwKfLtrANyU7qvzI4jz
         Dn7ik//oiGjycCVnTVoquEE7eyBUeq//s7lTZt4Sd7IVhe2iEq3Ktc+xU8pDYpCvwZgO
         z/m0JzKtkUtZbeoUCqRAB6V/HyuWuwkpIDJCzKRQ1ZYmJcaAwBmhNX7j+9FlgdUyPNT2
         ze2CxnOWa2HsG3WgJlGLSbvw556WNV2n3853p9zfyE1VxRO4SNnz0CuvqKnAlRHI21WM
         4PbGaEJW1nWostnwztXI08JSEQ36BJHrDndIWsItK90hB+mJtfPjWWox87wpG0oRGFFM
         DXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410016; x=1762014816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+kdgwxqgLpSk+BXagyhyh0KizQR0PlmXlxRpNRvoio=;
        b=ftyv1FRayPRoJvztvPxMADhUa+fhzGJIKOCTwIcnXa8WAO8B8Pz5nrqN/UATsshbxT
         faN55kuC5qhtBS2I32I3y/QUR2iy5/1seVhFiQu8swdjIOVJTBmxay7a2C//CIWjxZRe
         YcIkulJSCT848vzb3akr0ayQGXjZbJPrumzW9PE14YpaOBMe6d0fuji9GeZW/9FZraIu
         4VFBYZ1cSF8cOg1OJ5xwOehIOY/eTqvF8zBQU7sreilAJx4mreB+q44DTz3XWJxOznGZ
         fLKQKsBiJl3iZEZywLI0p+PTQ54qPiSKT2HN5nM97G8aSWyLAa9CDTSXb/7yp2SRoBOT
         2bHA==
X-Forwarded-Encrypted: i=1; AJvYcCW+iX9vtiy9bfTVCFyrLnbSviz0AmFiT66KVfTXbROBdrr8VXZKWkdp5B4ZDxXm0GdgRS9J+PrTtWkMLA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLm19j6wDrdXJUTuZUTOt4lxoybsQpnYUlRCnHGTaeIVXcn1wU
	QGcMgXkbP8DVfJP2ZQgXVS3PbXKPk19NbrM6E9fUBI/24e1JWNmiYNoD
X-Gm-Gg: ASbGncvnykZm019/tg4vbjuFKzDQfYnapoBqVYOv8EbPts7z5EYZfGjt37ssxjFHC3t
	4GMbsdXNigfVEcAoEnN40FVWo5zRl4MgxLOrMasgAMf4VKWEkEdVsyFPKMcP178KmN8/nCGfoOa
	J59MfGrShwaTf2lFwDo546Dz34zPglYi+X4+V2ABchRzBeolzg41lZfdhzniLMUgb+AzEBdprV9
	8G8zvTYQUmeN15et5friOrcvom9Hl/wLZpyXb4S0cpWoZGOG0lhdkYoHMBVi99vPVBohR3cMLzv
	Vqt1GT556ZLPY8rUFcMljHCOhCjKxF24XY99NnYNslEz7b7B8LG9FRoK8BRPpcf1UzphP1k881o
	UA4EprzjDACFpUnNWp9QqGzzPSgv20kGDvF/h+heUN5QuSY/xTW/b8pHpv5mQy/iGvmH6Qfxt
X-Google-Smtp-Source: AGHT+IFUNq9E9F5tkFvF4iIGRPUJo2bGn0CXF3o3/vXLG4KH0hAs0g3n//wSNOK/rhmKbOn3qmKqqg==
X-Received: by 2002:a05:6214:f6d:b0:87c:1032:e849 with SMTP id 6a1803df08f44-87f9edc81b9mr140672916d6.30.1761410016037;
        Sat, 25 Oct 2025 09:33:36 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8bc4sm16252346d6.7.2025.10.25.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:35 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
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
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 19/21] fs: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:01 -0400
Message-ID: <20251025163305.306787-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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


