Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6DA16542
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 02:59:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ybtmn4Gjpz300V
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 12:59:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737338343;
	cv=none; b=ikE+7Y76ljHeOJV72HzbPtdf2EpABijMYerFC9+ZN3mXfsxbqsbl0gVHjtglUovKMQXsM37vwCQe0O9WtGxJgCVoRJnr1yunY6FLZlvY9ufMSij7MbVkniiyN9EYBfmYtTvAST/9zDvZo0piP0GbDV0kdVYqxgSW9m8Ka4kM1pNqsZj+cB0Zc98wXvTnESWdBs7b5rDZT7GhFGBPTQ4syOdB0TxqOIm2vyAJqtHx7dhFIXbQIYs8oOM5gGF7d8DkKtE3YDpEL5OVGa4+2RIMfT4bn3Epa0picNtDq9PSq+slmG/2O6XB0dQLfLKh0JwSHOS1udAGD54VHZXuPrpLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737338343; c=relaxed/relaxed;
	bh=bKkjzTtc14xMB43MEYpBTnpDumvYrd3DHO+qGAQcZ6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUXoDuOnIv3TQUJ1lvWSD6xWSjTc99IkR2OgyTUyMqgVvLDu6CfaU+hTOfnIsOmkdLaVCgijuz5f9WR+9zcikUyNoGJYkyOqUE0qvEW3tmC1dTPCl/SSL/inRsgEz+lu0M+MOn77g4sk+9abeBAuTQBWH0gYCxGXoh/d6k+zQ5/PPQJOX4h084q/PI13MpKcrWDA5EriJfolzL8GUsnoVefkVyyVckfJRbc3Ijp+xPgbPZ9ip3FhOxW2ITsLPxbR+WkK9HH04p6Y8ly33G2CvdeAyN25DmXa4UcJkXxosfpk1sW9VEKnd3yxUqWPpX2ZO7Cf6tMgPBMhE5b+L25TLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=erNM7oGA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=erNM7oGA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybtml0wGlz2yDp
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 12:59:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737338338; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bKkjzTtc14xMB43MEYpBTnpDumvYrd3DHO+qGAQcZ6E=;
	b=erNM7oGAbeQ03GqoeyGp1lEKy36Ra2LlT4syGfs8xqc7HcaZZLdqjmdk0Cg1RGqM/KE/hqBXjlQnysH3Q6FJeW8U9R+1z9QpVPNUpUwB+TLFbzklT60p5uEWEfL921RS3WbYnMywkBWBktCLJcVaUvfenHyfxgQfJawTr7hUkTw=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNvAxcV_1737338337 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 09:58:57 +0800
Message-ID: <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
Date: Mon, 20 Jan 2025 09:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20250115070936.119975-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250115070936.119975-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hongbo,

On 2025/1/15 15:09, Hongbo Li wrote:
> erofs has add file-backed mount support. In this scenario, only buffer
> io is allowed. So we enhance the io mode by implementing the direct
> io. Also, this can make the iov_iter (user buffer) interact with the
> backed file's page cache directly.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c   |  11 +++--
>   fs/erofs/fileio.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..b5baff61be16 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -395,9 +395,14 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	if (IS_DAX(inode))
>   		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>   #endif
> -	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
> -		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> -				    NULL, 0, NULL, 0);
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		if (inode->i_sb->s_bdev)
> +			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> +						NULL, 0, NULL, 0);
> +		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
> +			return generic_file_read_iter(iocb, to);
> +	}
> +
>   	return filemap_read(iocb, to, 0);
>   }
>   
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 33f8539dda4a..76ed16a8ee75 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -10,12 +10,17 @@ struct erofs_fileio_rq {
>   	struct bio bio;
>   	struct kiocb iocb;
>   	struct super_block *sb;
> +	ssize_t ret;
> +	void *private;
>   };
>   
>   struct erofs_fileio {
> +	struct file *file;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev dev;
>   	struct erofs_fileio_rq *rq;
> +	size_t total;
> +	size_t done;
>   };
>   
>   static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
> @@ -24,6 +29,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   			container_of(iocb, struct erofs_fileio_rq, iocb);
>   	struct folio_iter fi;
>   
> +	rq->ret = ret;
>   	if (ret > 0) {
>   		if (ret != rq->bio.bi_iter.bi_size) {
>   			bio_advance(&rq->bio, ret);
> @@ -43,6 +49,17 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>   	kfree(rq);
>   }
>   
> +static void erofs_fileio_end_io(struct bio *bio)
> +{
> +	struct erofs_fileio_rq *rq =
> +			container_of(bio, struct erofs_fileio_rq, bio);
> +	struct erofs_fileio *io = rq->private;
> +
> +	if (rq->ret > 0) {
> +		io->done += rq->ret;
> +	}
> +}
> +
>   static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>   {
>   	struct iov_iter iter;
> @@ -189,7 +206,112 @@ static void erofs_fileio_readahead(struct readahead_control *rac)
>   	erofs_fileio_rq_submit(io.rq);
>   }
>   
> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct kiocb *iocb,
> +				  struct iov_iter *iter)

I wonder if it's possible to just extract a folio from
`struct iov_iter` and reuse erofs_fileio_scan_folio() logic.

It simplifies the codebase a lot, and I think the performance
is almost the same.

Otherwise currently it looks good to me.

Thanks,
Gao Xiang
