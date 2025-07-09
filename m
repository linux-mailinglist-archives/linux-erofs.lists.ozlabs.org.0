Return-Path: <linux-erofs+bounces-572-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4DAFE803
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 13:45:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcbkK2Y0gz30Pn;
	Wed,  9 Jul 2025 21:44:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752061497;
	cv=none; b=hp4AENt1gUWLSLd6w4IrspOmPq7k71KEjzwvqkruxGJCI4vvYQ/IHd1xgSnY5IFD9PDE/4/e6DvJ3wjoL6VdQe9RRRWG9ZTw0gpw+Vim8+9kayNWkFwLSSSHsK+yfYtZMyZGjUJp8NekXX63/+zwaWwkXVUQuYRcn72DxBAjowxdtNNMvZ1CInrkR7MTF9UoYx6KxLl2tci7hy1qUmpmRogdg7D9z3siRr/YORYuZjrsMSr9p2uQXpDh4L8HZ+y+KHl6WwKb+ewRB9wYw39VjixE/Tu1ZtBeugYRXuH7JyiURAWZkuizewL3tIHNSaBUsUuUb2Ni7woh2o5ulIhY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752061497; c=relaxed/relaxed;
	bh=CW4pMFx0alGvhCB6t2+HrC1tH+ESAAvatnqofP0tSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUWiDJtRFKof/lOxm0yGvF9QH+IjBBWXLNj8YHiAwU1VuVF8m+8DaljuwPclHUd8aumoA37pEoYedkFpLT7aOiVo66hcirD+CyPaAW7Q2y2Ody3sfcERDf+tvl1C6ea0htEj2+g5rqbXVc9xfaKYMc6T6Mk/udbN24OYpkSAG+YtuU5kS3mJGTrRuKBZjY/arADqu1p2coQsdTJeg5wU4NMCaq9OouSrseZvpMWlQK30EIvtT3bTC9e1l2dL4zcKG6triEA6JdlZFmXr/5+/9rDrIxYm64g71iS0m2/n4XDqHwp5Cd7Ij4ZRB3FTCv9p2EKWLp4ljpnG+gtfr0eznA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=s.kerkmann@pengutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1124 seconds by postgrey-1.37 at boromir; Wed, 09 Jul 2025 21:44:53 AEST
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcbkF5twKz2ynh
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 21:44:53 +1000 (AEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uZSw5-0007Dx-Mg; Wed, 09 Jul 2025 13:26:01 +0200
Message-ID: <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
Date: Wed, 9 Jul 2025 13:25:58 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Gao, Hi Jan,

On 7/9/25 5:46 AM, Gao Xiang wrote:
> Flush the D-cache before unlocking folios for compressed inodes, as
> they are dirtied during decompression.
> 
> Avoid calling flush_dcache_folio() on every CPU write, since it's more
> like playing whack-a-mole without real benefit.
> 
> It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
> is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
> for new page cache folios.  However, certain ARM boards are affected,
> as reported.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
> Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Jan and Stefan,
> 
> if possible, please help test this patch on your arm devices,
> many thanks!  I will submit this later but if it's urgent you
> could also apply this locally in advance.
> 

Thank you for the fix and great work, it solved the issue I was seeing 
locally!

> Thanks,
> Gao Xiang
>   fs/erofs/data.c         | 16 +++++++++++-----
>   fs/erofs/decompressor.c | 12 ++++--------
>   fs/erofs/fileio.c       |  4 ++--
>   fs/erofs/internal.h     |  2 +-
>   fs/erofs/zdata.c        |  6 +++---
>   5 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 221e0ff1ed0d..16e4a6bd9b97 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -214,9 +214,11 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   
>   /*
>    * bit 30: I/O error occurred on this folio
> + * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
>    * bit 0 - 29: remaining parts to complete this folio
>    */
> -#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
> +#define EROFS_ONLINEFOLIO_EIO		30
> +#define EROFS_ONLINEFOLIO_DIRTY		29
>   
>   void erofs_onlinefolio_init(struct folio *folio)
>   {
> @@ -233,19 +235,23 @@ void erofs_onlinefolio_split(struct folio *folio)
>   	atomic_inc((atomic_t *)&folio->private);
>   }
>   
> -void erofs_onlinefolio_end(struct folio *folio, int err)
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   {
>   	int orig, v;
>   
>   	do {
>   		orig = atomic_read((atomic_t *)&folio->private);
> -		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
> +		DBG_BUGON(orig <= 0);
> +		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
> +		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
>   	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>   
> -	if (v & ~EROFS_ONLINEFOLIO_EIO)
> +	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
>   		return;
>   	folio->private = 0;
> -	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
> +	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
> +		flush_dcache_folio(folio);
> +	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>   }
>   
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index bf62e2836b60..358061d7b660 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -301,13 +301,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		cur = min(cur, rq->outputsize);
>   		if (cur && rq->out[0]) {
>   			kin = kmap_local_page(rq->in[nrpages_in - 1]);
> -			if (rq->out[0] == rq->in[nrpages_in - 1]) {
> +			if (rq->out[0] == rq->in[nrpages_in - 1])
>   				memmove(kin + rq->pageofs_out, kin + pi, cur);
> -				flush_dcache_page(rq->out[0]);
> -			} else {
> +			else
>   				memcpy_to_page(rq->out[0], rq->pageofs_out,
>   					       kin + pi, cur);
> -			}
>   			kunmap_local(kin);
>   		}
>   		rq->outputsize -= cur;
> @@ -325,14 +323,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
>   			DBG_BUGON(no >= nrpages_out);
>   			cnt = min(insz - pi, PAGE_SIZE - po);
> -			if (rq->out[no] == rq->in[ni]) {
> +			if (rq->out[no] == rq->in[ni])
>   				memmove(kin + po,
>   					kin + rq->pageofs_in + pi, cnt);
> -				flush_dcache_page(rq->out[no]);
> -			} else if (rq->out[no]) {
> +			else if (rq->out[no])
>   				memcpy_to_page(rq->out[no], po,
>   					       kin + rq->pageofs_in + pi, cnt);
> -			}
>   			pi += cnt;
>   		} while (pi < insz);
>   		kunmap_local(kin);
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index fe2cd2982b4b..91781718199e 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   	} else {
>   		bio_for_each_folio_all(fi, &rq->bio) {
>   			DBG_BUGON(folio_test_uptodate(fi.folio));
> -			erofs_onlinefolio_end(fi.folio, ret);
> +			erofs_onlinefolio_end(fi.folio, ret, false);
>   		}
>   	}
>   	bio_uninit(&rq->bio);
> @@ -154,7 +154,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   		}
>   		cur += len;
>   	}
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>   	return err;
>   }
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a32c03a80c70..0d19bde8c094 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -390,7 +390,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>   void erofs_onlinefolio_init(struct folio *folio);
>   void erofs_onlinefolio_split(struct folio *folio);
> -void erofs_onlinefolio_end(struct folio *folio, int err);
> +void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
>   struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>   int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		  struct kstat *stat, u32 request_mask,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index d80e3bf4fa79..6f8402ed5b28 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1090,7 +1090,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
>   			tight = (bs == PAGE_SIZE);
>   		}
>   	} while ((end = cur) > 0);
> -	erofs_onlinefolio_end(folio, err);
> +	erofs_onlinefolio_end(folio, err, false);
>   	return err;
>   }
>   
> @@ -1195,7 +1195,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
>   			cur += len;
>   		}
>   		kunmap_local(dst);
> -		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
> +		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
>   		list_del(p);
>   		kfree(bvi);
>   	}
> @@ -1353,7 +1353,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
>   
>   		DBG_BUGON(z_erofs_page_is_invalidated(page));
>   		if (!z_erofs_is_shortlived_page(page)) {
> -			erofs_onlinefolio_end(page_folio(page), err);
> +			erofs_onlinefolio_end(page_folio(page), err, true);
>   			continue;
>   		}
>   		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {

Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

Best regards,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |


