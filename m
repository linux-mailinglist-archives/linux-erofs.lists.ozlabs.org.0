Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6496D2AD
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725526924;
	bh=b59GKcsLdMKSUDdBMs/OXE1Ar2yXLPVSnOK7wV+PWwg=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=X9bAPxzmCmISCnGRdxCdrhu77D6m95HbkodbXNSbKaBJ9wdVC2hgiV61NvgLTqRVe
	 twsrGssF0EyLjF0n5aGuleaHCbKSq3VRQrpNFSE7NoK3TZcBQq8cbkm524i+mSK78U
	 IUTjQ7k5fYr2MA1KotEi+ADm7Nq6EnnfcQpSbd2xm8pN24WjxgvTLeRKysOtbObyVc
	 XrD2Z0kwEldJHTUHlu4UYT7dHV2LBQXizAIwTUOxNkpgaVuwKK1mJJCWiQXvPd9P8i
	 6jEH3kP3naPFOIe7LI9WX+QnpFORdtvE3xkrAeEnMIqRR+kCsX20KR39y+7XBMgu8D
	 ixWJamLrk4T6A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wztf46YZzz2ytg
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:02:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725526922;
	cv=none; b=WWCXl8qDS03VCb2YpSmbTqPU1wyrgAPb0tvGBjswboja4CByUoo4PttM9GeyBIyKFgZtm9F6EhtNoXHafGY6aTIqFpbDziXnbAX+2YTfjuyekNHQIfeNKv7xyNUU8pxI3vo319s7zoq9wnuIrdTCUxgAs3Qb0t7gkXeDex2KI335qPRT17I4yp94PrtWhLnZIE3Bb7gffSObX2pMlSLaZIR+RUzNixOFsj1j6e8HPDbHULxtb6lvHng4eoeErNjeHkt9xTJ/VRLo++qvt6dU2WG8EDwi0cFXfxUcB8PPu5yANj87pZOQDCt4D39RWyMmG0OeYHv3Bpcb8SHglvrvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725526922; c=relaxed/relaxed;
	bh=b59GKcsLdMKSUDdBMs/OXE1Ar2yXLPVSnOK7wV+PWwg=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=RM32a+CPFbtpCoShgSE9iHea/7NRs86AZbmPprygj01gHUgmNOjkjg5aaFkHKh7fpqhAL9ru4tGuAuFEflKac45nDaTC0boQb9zOgpfUg9KJMxnIgUIT4lcqKO2VYLMm5kOxi/G9vPotBfqjRYAiEp8iBPW8tvxXqwb55JTApvwyw13s2s4BpH3b7Lanla+sHL3gI2g8ZfS7XEnUeuZmGtfe2izvzr72vP3aoRFfrLp+Wd3PBi2Gf2+dzUnPdqnZJh0so3YMSho3lSvCeTjXbk6vYokB/wWnCL0JihztrN/ztZy0A4KIZ39ABUnfsUSp+pWF8Cs5Vx0X5lLbuYiC/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o1OrZjpb; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o1OrZjpb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wztf14bNtz2xnc
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:02:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D98125C431C;
	Thu,  5 Sep 2024 09:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC9BC4CEC3;
	Thu,  5 Sep 2024 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526919;
	bh=9eLCwQNtlK46nPt5gDq1OgBgEmNnuWgHpS7qPp3OJfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1OrZjpb5XQac/QIYhlv7Qvy9CXoBCug0CHfzhBvi6KWkTb65Y2H87Q+mQnvEyBxp
	 +WxWgSTaTi9JieenyKR/W4LA7TRg86PJyCmpBGrysOappYXZPPYn+/QFAOFDCQ1FzE
	 t+Gcm2SD2zDricftyBT2AOZ3JjIqMxHrYC25rR3rCk6ip5FwXheJrBZ9DBUWrNqTWY
	 pj05r6/RjMI4obW1eLvwSUUc4oqFjet9NhPbqvC4dzn4TNEWy8iHF2dgC4L/MX+5g6
	 1einkL/q4CcWfmNySuhFCIjxlQKVBpvJs1opttqeSSgun+PG5hF18oeIXuGkHwZm/i
	 rsWFW517xytoQ==
Message-ID: <64a8c756-3cca-4e34-b907-b737569d7cec@kernel.org>
Date: Thu, 5 Sep 2024 17:01:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] erofs: support compressed inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240830032840.3783206-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/30 11:28, Gao Xiang wrote:
> Use pseudo bios just like the previous fscache approach since
> merged bio_vecs can be filled properly with unique interfaces.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/fileio.c   | 25 +++++++++++++++++++++----
>   fs/erofs/inode.c    |  6 ------
>   fs/erofs/internal.h |  8 ++++++++
>   fs/erofs/zdata.c    | 27 +++++++++++++++++----------
>   4 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index eab52b8abd0b..9e4b851d85c0 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -23,7 +23,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   			container_of(iocb, struct erofs_fileio_rq, iocb);
>   	struct folio_iter fi;
>   
> -	DBG_BUGON(rq->bio.bi_end_io);
>   	if (ret > 0) {
>   		if (ret != rq->bio.bi_iter.bi_size) {
>   			bio_advance(&rq->bio, ret);
> @@ -31,9 +30,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   		}
>   		ret = 0;
>   	}
> -	bio_for_each_folio_all(fi, &rq->bio) {
> -		DBG_BUGON(folio_test_uptodate(fi.folio));
> -		erofs_onlinefolio_end(fi.folio, ret);
> +	if (rq->bio.bi_end_io) {
> +		rq->bio.bi_end_io(&rq->bio);
> +	} else {
> +		bio_for_each_folio_all(fi, &rq->bio) {
> +			DBG_BUGON(folio_test_uptodate(fi.folio));
> +			erofs_onlinefolio_end(fi.folio, ret);
> +		}
>   	}
>   	kfree(rq);
>   }
> @@ -68,6 +71,20 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
>   	return rq;
>   }
>   
> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev)
> +{
> +	struct erofs_fileio_rq *rq;
> +
> +	rq = erofs_fileio_rq_alloc(mdev);
> +	return rq ? &rq->bio : NULL;
> +}
> +
> +void erofs_fileio_submit_bio(struct bio *bio)
> +{
> +	return erofs_fileio_rq_submit(container_of(bio, struct erofs_fileio_rq,
> +						   bio));
> +}
> +
>   static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   {
>   	struct inode *inode = folio_inode(folio);
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 4a902e6e69a5..82259553d9f6 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -260,12 +260,6 @@ static int erofs_fill_inode(struct inode *inode)
>   	mapping_set_large_folios(inode->i_mapping);
>   	if (erofs_inode_is_data_compressed(vi->datalayout)) {
>   #ifdef CONFIG_EROFS_FS_ZIP
> -#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> -		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> -			err = -EOPNOTSUPP;
> -			goto out_unlock;
> -		}
> -#endif
>   		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
>   			  erofs_info, inode->i_sb,
>   			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9bc4dcfd06d7..4efd578d7c62 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -489,6 +489,14 @@ static inline void z_erofs_exit_subsystem(void) {}
>   static inline int erofs_init_managed_cache(struct super_block *sb) { return 0; }
>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
> +void erofs_fileio_submit_bio(struct bio *bio);
> +#else
> +static inline struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev) { return NULL; }
> +static inline void erofs_fileio_submit_bio(struct bio *bio) {}
> +#endif
> +
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>   int erofs_fscache_register_fs(struct super_block *sb);
>   void erofs_fscache_unregister_fs(struct super_block *sb);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 350612f32ac6..2271cb74ae3a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1618,10 +1618,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   			if (bio && (cur != last_pa ||
>   				    bio->bi_bdev != mdev.m_bdev)) {
>   io_retry:
> -				if (!erofs_is_fscache_mode(sb))
> -					submit_bio(bio);
> -				else
> +				if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +					erofs_fileio_submit_bio(bio);
> +				else if (erofs_is_fscache_mode(sb))
>   					erofs_fscache_submit_bio(bio);
> +				else
> +					submit_bio(bio);
>   
>   				if (memstall) {
>   					psi_memstall_leave(&pflags);
> @@ -1637,10 +1639,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   			}
>   
>   			if (!bio) {
> -				bio = erofs_is_fscache_mode(sb) ?
> -					erofs_fscache_bio_alloc(&mdev) :
> -					bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
> -						  REQ_OP_READ, GFP_NOIO);
> +				if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +					bio = erofs_fileio_bio_alloc(&mdev);

It seems erofs_fileio_bio_alloc() can fail, it needs to handle NULL bio
here?

Thanks,

> +				else if (erofs_is_fscache_mode(sb))
> +					bio = erofs_fscache_bio_alloc(&mdev);
> +				else
> +					bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
> +							REQ_OP_READ, GFP_NOIO);
>   				bio->bi_end_io = z_erofs_endio;
>   				bio->bi_iter.bi_sector = cur >> 9;
>   				bio->bi_private = q[JQ_SUBMIT];
> @@ -1667,10 +1672,12 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>   	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
>   
>   	if (bio) {
> -		if (!erofs_is_fscache_mode(sb))
> -			submit_bio(bio);
> -		else
> +		if (erofs_is_fileio_mode(EROFS_SB(sb)))
> +			erofs_fileio_submit_bio(bio);
> +		else if (erofs_is_fscache_mode(sb))
>   			erofs_fscache_submit_bio(bio);
> +		else
> +			submit_bio(bio);
>   		if (memstall)
>   			psi_memstall_leave(&pflags);
>   	}

