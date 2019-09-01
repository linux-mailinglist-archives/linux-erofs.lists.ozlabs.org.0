Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F50A47C0
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7c2mGjzDqtY
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317212;
	bh=v0FQUc4MzpLrqEXlpkq7ilUAHR8+dojvYxQOpB7u8EQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MioBqv8kv/oh/75pGzA1LPD5SHrBsB6dTgZeNAc3wnelD5MQWct6l4Qw+fv/93IcW
	 RwvPVYzRQPcgSXDRUs+S6QeeX4pItq72iSRmsfRfB4bY5UGmGUcPyMSqVM9f+0ASv9
	 HYhzD1ZWeO02KzdTzWOvtJ0q6R4ku7r+ygp5Iows+nvWx4hfuTfs97EmdZL0veW3Ha
	 MJdZtvnTckAfkb2B7SjsybVGLhQ53L+/4kzUTVde/0vALKrJCfEbDMSXj2F5B1/lvK
	 tiI5O5RSDV27pSZFQFHLvt/UE9BXTJY/33QlBcDlkIye9kPaPAMGguBzoN0xVpI62d
	 Q6l6Qth4VY24w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="RqcifwGb"; 
 dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj7746hGzDqst
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:53:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317182; bh=rUAGs0+W5mR7ThahEa9uK1icgbH6GMDmkXBPI98HZmY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=RqcifwGblqRM5RPWHzZEVPs5as3iq/zaYCMLHAJ72p3oZQnuoNG1BbZUVrsovMtZGTlpyg3pwW76fgBDbFDHs0KoloMOUQr75jEQvTDtl6MtkPZAn8YXOqSWCCWRb093Dh072sNz8yMw2v4b6HaURef8r89L0kkDceNlz0NUEks/HG98dcwI2yeerVY7IaCg0lh1vDP857L89CdXRGExivSX9uZ5XoS0cwbrJe1UTtBTT0be/h/q7LzHM9wwEPYDBXl1tgZlIKsf711W35/0fsOiBjZ4HRtNxZMcBT9bdf7TcydpI5lxZBA1UnkCH2+dlZnD4NzQXrIGtWrj7J4lKg==
X-YMail-OSG: Yoy0XagVM1lCtr1wb7bkEnDKL0h2XzGv0sAqutdvx3ZR96KW2hAKgKltfki59bi
 axd7Yy9B9j35MJqJTa18IUY8CX8wCdyl7iI3broYpXa32JeBhANZsZHeQ_4sRe2A6wCzEOzspN9w
 T_0onsfrgMfdlZ6uJ0V_mxLNlYcnhMeBRacuu8GAwiUrl0Xh1aZvZ31.dLL9OGibqyynIyFKZDzP
 QrIOKR9iEmmgkzdnvcnGNsFMAyv10w3Uw7zgt2S5a7W2eytmdVvTEa9czeIdygQKgmJUOh8fO3Ye
 tk.BlrWC7JHX6XWEjm4j4h07BcT7Yxj7PUhHqudrNEaiEPAzoqvOtfuF8CKCNjae53u9uRPV.kk6
 kI3dFBmNfQ2IORUa8nPbKX7Dj2Ks.WKP7LjhDqZwj5PZnPz6ep5ULgWXnEH._8WhxFVLFNp4Y02_
 K9wNnYOEGSqPNIfvpuNKKhfBZIsdkolfxiy1w4._7HthTQ.xl.rHO6FrRbHxY8o0PzvmxoH_ELL9
 m450yKCmdQWDM8FDFzKX_HXGRJ_P2qOWFsZ2hEsAVqciLkJAeTnJQREgASruJ31MYYsnWDN7XaJZ
 niplK39jxS7z6Kc3ImfMRTYhctLbntHqzUHxofOo2SnWNncsSHdaQmEzLSDhH_bepPFNqWr4cwxP
 hsUhZF3ztz6Is2B6kLcYB.PTuTmBFApiOtugP5W86Bm9d5cQDGrONFsSjNPuzyqOguYR8czseGbu
 SNRaN2wZOwWjQrxWViHSb45al0d1BXsps8djPz5JGelXOOL1advo1pvzIfxSmI4iJ16L56Ffi_ho
 pla1nbWbpndNPO2nWqlSRxXxZhz1fBy2MkgIfHHD52zVE2vIz6TVMnXlMYIHhoPh9k6THdMb4gUL
 mTf6p1exTCpVSX8wa0CPygj9Q1IFzaVewTaZwSdbnBkzHLRI_Xgc77oB24hx5N_jXUrqw4xB2GH3
 OQUy4Y5WK0_BTL0iX8FXjs.etfUOmZxru_1ewCxmItt4bfRUk8pquOBNUmPyJ1Gp2vgh.0iammhG
 JVsk6n0DDsnAqYhQnBsMG18TGULSDId_PvjwIjQWGVjbXyn9Fi_vVcsr7DaHudIdFLB4VzQQ_W53
 9_MaSbTcI8o6P2DVG6RmoQJ35Gm8j5ZyZ1df7khaaynZ_5ZZjh5fpeY3KFJNH8HocRMoeKX1jA5K
 96dzcwAw04cArRJa.ZLEltDlpGPNQ9arQzDR6Biylo196efOnlSWKBWHxotg9qJviNErIhtKCV8h
 QX5aYpf8W.p8StzQg7CD8ajUVhw8M0D12Yev7kxylcVZD8Mt_Yg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:02 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:59 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 14/21] erofs: kill prio and nofail of erofs_get_meta_page()
Date: Sun,  1 Sep 2019 13:51:23 +0800
Message-Id: <20190901055130.30572-15-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph pointed out [1],
"Why is there __erofs_get_meta_page with the two weird
booleans instead of a single erofs_get_meta_page that
gets and gfp_t for additional flags and an unsigned int
for additional bio op flags."

And since all callers can handle errors, let's kill
prio and nofail and erofs_get_inline_page() now.

[1] https://lore.kernel.org/lkml/20190830162812.GA10694@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 24 ++++++------------------
 fs/erofs/inode.c    |  2 +-
 fs/erofs/internal.h | 18 +-----------------
 fs/erofs/xattr.c    | 13 ++++++-------
 fs/erofs/zmap.c     |  4 ++--
 5 files changed, 16 insertions(+), 45 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 621954d4fb09..837b07cd2761 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,25 +38,20 @@ static inline void read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-/* prio -- true is used for dir */
-struct page *__erofs_get_meta_page(struct super_block *sb,
-				   erofs_blk_t blkaddr, bool prio, bool nofail)
+struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
 	struct inode *const bd_inode = sb->s_bdev->bd_inode;
 	struct address_space *const mapping = bd_inode->i_mapping;
 	/* prefer retrying in the allocator to blindly looping below */
-	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS) |
-		(nofail ? __GFP_NOFAIL : 0);
-	unsigned int io_retries = nofail ? EROFS_IO_MAX_RETRIES_NOFAIL : 0;
+	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS);
 	struct page *page;
 	int err;
 
 repeat:
 	page = find_or_create_page(mapping, blkaddr, gfp);
-	if (!page) {
-		DBG_BUGON(nofail);
+	if (!page)
 		return ERR_PTR(-ENOMEM);
-	}
+
 	DBG_BUGON(!PageLocked(page));
 
 	if (!PageUptodate(page)) {
@@ -69,14 +64,11 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 			goto err_out;
 		}
 
-		__submit_bio(bio, REQ_OP_READ,
-			     REQ_META | (prio ? REQ_PRIO : 0));
-
+		__submit_bio(bio, REQ_OP_READ, REQ_META);
 		lock_page(page);
 
 		/* this page has been truncated by others */
 		if (page->mapping != mapping) {
-unlock_repeat:
 			unlock_page(page);
 			put_page(page);
 			goto repeat;
@@ -84,10 +76,6 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 
 		/* more likely a read error */
 		if (!PageUptodate(page)) {
-			if (io_retries) {
-				--io_retries;
-				goto unlock_repeat;
-			}
 			err = -EIO;
 			goto err_out;
 		}
@@ -237,7 +225,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 			DBG_BUGON(map.m_plen > PAGE_SIZE);
 
-			ipage = erofs_get_meta_page(inode->i_sb, blknr, 0);
+			ipage = erofs_get_meta_page(inode->i_sb, blknr);
 
 			if (IS_ERR(ipage)) {
 				err = PTR_ERR(ipage);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d501ceb62c29..19a574ee690b 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -163,7 +163,7 @@ static int fill_inode(struct inode *inode, int isdir)
 	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
 		__func__, vi->nid, ofs, blkaddr);
 
-	page = erofs_get_meta_page(inode->i_sb, blkaddr, isdir);
+	page = erofs_get_meta_page(inode->i_sb, blkaddr);
 
 	if (IS_ERR(page)) {
 		errln("failed to get inode (nid: %llu) page, err %ld",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 01749be24f3d..40d4dd47bb7a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -258,8 +258,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 #error erofs cannot be used in this platform
 #endif
 
-#define EROFS_IO_MAX_RETRIES_NOFAIL     5
-
 #define ROOT_NID(sb)		((sb)->root_nid)
 
 #define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
@@ -428,24 +426,10 @@ static inline void __submit_bio(struct bio *bio, unsigned int op,
 	submit_bio(bio);
 }
 
-struct page *__erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr,
-				   bool prio, bool nofail);
-
-static inline struct page *erofs_get_meta_page(struct super_block *sb,
-	erofs_blk_t blkaddr, bool prio)
-{
-	return __erofs_get_meta_page(sb, blkaddr, prio, false);
-}
+struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
 
 int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
 
-static inline struct page *erofs_get_inline_page(struct inode *inode,
-						 erofs_blk_t blkaddr)
-{
-	return erofs_get_meta_page(inode->i_sb, blkaddr,
-				   S_ISDIR(inode->i_mode));
-}
-
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
 {
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index d5b7fe0bee45..dd445c81c41f 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -87,7 +87,7 @@ static int init_inode_xattrs(struct inode *inode)
 	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
 	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
 
-	it.page = erofs_get_inline_page(inode, it.blkaddr);
+	it.page = erofs_get_meta_page(sb, it.blkaddr);
 	if (IS_ERR(it.page)) {
 		ret = PTR_ERR(it.page);
 		goto out_unlock;
@@ -117,8 +117,7 @@ static int init_inode_xattrs(struct inode *inode)
 			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
 			xattr_iter_end(&it, atomic_map);
 
-			it.page = erofs_get_meta_page(sb, ++it.blkaddr,
-						      S_ISDIR(inode->i_mode));
+			it.page = erofs_get_meta_page(sb, ++it.blkaddr);
 			if (IS_ERR(it.page)) {
 				kfree(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -168,7 +167,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 
 	it->blkaddr += erofs_blknr(it->ofs);
 
-	it->page = erofs_get_meta_page(it->sb, it->blkaddr, false);
+	it->page = erofs_get_meta_page(it->sb, it->blkaddr);
 	if (IS_ERR(it->page)) {
 		int err = PTR_ERR(it->page);
 
@@ -199,7 +198,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
 	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
 
-	it->page = erofs_get_inline_page(inode, it->blkaddr);
+	it->page = erofs_get_meta_page(inode->i_sb, it->blkaddr);
 	if (IS_ERR(it->page))
 		return PTR_ERR(it->page);
 
@@ -401,7 +400,7 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 			if (i)
 				xattr_iter_end(&it->it, true);
 
-			it->it.page = erofs_get_meta_page(sb, blkaddr, false);
+			it->it.page = erofs_get_meta_page(sb, blkaddr);
 			if (IS_ERR(it->it.page))
 				return PTR_ERR(it->it.page);
 
@@ -623,7 +622,7 @@ static int shared_listxattr(struct listxattr_iter *it)
 			if (i)
 				xattr_iter_end(&it->it, true);
 
-			it->it.page = erofs_get_meta_page(sb, blkaddr, false);
+			it->it.page = erofs_get_meta_page(sb, blkaddr);
 			if (IS_ERR(it->it.page))
 				return PTR_ERR(it->it.page);
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index c2dd778ebdd3..fbf6591f69a6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -50,7 +50,7 @@ static int fill_inode_lazy(struct inode *inode)
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
-	page = erofs_get_meta_page(sb, erofs_blknr(pos), false);
+	page = erofs_get_meta_page(sb, erofs_blknr(pos));
 	if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 		goto out_unlock;
@@ -127,7 +127,7 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 		put_page(mpage);
 	}
 
-	mpage = erofs_get_meta_page(sb, eblk, false);
+	mpage = erofs_get_meta_page(sb, eblk);
 	if (IS_ERR(mpage)) {
 		map->mpage = NULL;
 		return PTR_ERR(mpage);
-- 
2.17.1

