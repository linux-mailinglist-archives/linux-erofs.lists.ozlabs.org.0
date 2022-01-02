Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAAD482A8E
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 09:06:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JRWg669GSz2ynk
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Jan 2022 19:06:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JRWg25341z2xKR
 for <linux-erofs@lists.ozlabs.org>; Sun,  2 Jan 2022 19:06:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0Yxpe4_1641110770; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0Yxpe4_1641110770) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 02 Jan 2022 16:06:12 +0800
Date: Sun, 2 Jan 2022 16:06:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/5] erofs: use meta buffers for super operations
Message-ID: <YdFc8jIquSIAG56L@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-4-hsiangkao@linux.alibaba.com>
 <20220102072314.GA40650@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220102072314.GA40650@rsjd01523.et2sqa>
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Bo,

On Sun, Jan 02, 2022 at 03:23:21PM +0800, Liu Bo wrote:
> On Sun, Jan 02, 2022 at 12:00:15PM +0800, Gao Xiang wrote:

...

> > -			ptr = kmap(page);
> > -		}
> > +		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
> > +					 EROFS_KMAP);
> > +		if (IS_ERR(ptr))
> 
> kfree(buffer) is missing.
> 
> > +			return ptr;
> >  		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
> >  		*offset += cnt;
> >  	}
> > -out:
> > -	kunmap(page);
> > -	*pagep = page;
> >  	return buffer;
> > -err_nullpage:
> > -	*pagep = NULL;
> > -	return page;
> >  }
> >  
> >  static int erofs_load_compr_cfgs(struct super_block *sb,
> >  				 struct erofs_super_block *dsb)
> >  {
> > -	struct erofs_sb_info *sbi;
> > -	struct page *page;
> > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> >  	unsigned int algs, alg;
> >  	erofs_off_t offset;
> > -	int size, ret;
> > +	int size, ret = 0;
> >  
> > -	sbi = EROFS_SB(sb);
> >  	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > -
> >  	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> >  		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
> >  			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > @@ -205,21 +174,16 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
> >  	}
> >  
> >  	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > -	page = NULL;
> >  	alg = 0;
> > -	ret = 0;
> > -
> >  	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> >  		void *data;
> >  
> >  		if (!(algs & 1))
> >  			continue;
> >  
> > -		data = erofs_read_metadata(sb, &page, &offset, &size);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			goto err;
> > -		}
> > +		data = erofs_read_metadata(sb, &buf, &offset, &size);
> 
> if PTR_ERR(data) is -ENOMEM, buf needs to be put according to the
> current design.
> 
> > +		if (IS_ERR(data))
> > +			return PTR_ERR(data);
> >  
> >  		switch (alg) {
> >  		case Z_EROFS_COMPRESSION_LZ4:
> > @@ -234,13 +198,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
> >  		}
> >  		kfree(data);
> >  		if (ret)
> > -			goto err;
> > -	}
> > -err:
> > -	if (page) {
> > -		unlock_page(page);
> > -		put_page(page);
> > +			break;
> >  	}
> > +	erofs_put_metabuf(&buf);
> >  	return ret;
> >  }
> >  #else
> > @@ -261,7 +221,7 @@ static int erofs_init_devices(struct super_block *sb,
> >  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> >  	unsigned int ondisk_extradevs;
> >  	erofs_off_t pos;
> > -	struct page *page = NULL;
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> >  	struct erofs_device_info *dif;
> >  	struct erofs_deviceslot *dis;
> >  	void *ptr;
> > @@ -285,22 +245,13 @@ static int erofs_init_devices(struct super_block *sb,
> >  	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
> >  	down_read(&sbi->devs->rwsem);
> >  	idr_for_each_entry(&sbi->devs->tree, dif, id) {
> > -		erofs_blk_t blk = erofs_blknr(pos);
> >  		struct block_device *bdev;
> >  
> > -		if (!page || page->index != blk) {
> > -			if (page) {
> > -				kunmap(page);
> > -				unlock_page(page);
> > -				put_page(page);
> > -			}
> > -
> > -			page = erofs_get_meta_page(sb, blk);
> > -			if (IS_ERR(page)) {
> > -				up_read(&sbi->devs->rwsem);
> > -				return PTR_ERR(page);
> > -			}
> > -			ptr = kmap(page);
> > +		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> > +					 EROFS_KMAP);
> > +		if (IS_ERR(ptr)) {
> 
> Ditto.
> 

Thanks for catching these! I've fixed these as follows,
please help check out again!

Thanks,
Gao Xiang

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 38305fa2969b..9e076303bb24 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -149,8 +149,10 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
 		ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*offset),
 					 EROFS_KMAP);
-		if (IS_ERR(ptr))
+		if (IS_ERR(ptr)) {
+			kfree(buffer);
 			return ptr;
+		}
 		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
 		*offset += cnt;
 	}
@@ -182,8 +184,10 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 			continue;
 
 		data = erofs_read_metadata(sb, &buf, &offset, &size);
-		if (IS_ERR(data))
-			return PTR_ERR(data);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			break;
+		}
 
 		switch (alg) {
 		case Z_EROFS_COMPRESSION_LZ4:
@@ -250,8 +254,8 @@ static int erofs_init_devices(struct super_block *sb,
 		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
 					 EROFS_KMAP);
 		if (IS_ERR(ptr)) {
-			up_read(&sbi->devs->rwsem);
-			return PTR_ERR(ptr);
+			err = PTR_ERR(ptr);
+			break;
 		}
 		dis = ptr + erofs_blkoff(pos);
 
@@ -260,7 +264,7 @@ static int erofs_init_devices(struct super_block *sb,
 					  sb->s_type);
 		if (IS_ERR(bdev)) {
 			err = PTR_ERR(bdev);
-			goto err_out;
+			break;
 		}
 		dif->bdev = bdev;
 		dif->dax_dev = fs_dax_get_by_bdev(bdev);
