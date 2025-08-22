Return-Path: <linux-erofs+bounces-872-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A9B3125F
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 10:55:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7Ytk0QkWz30RK;
	Fri, 22 Aug 2025 18:55:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755852942;
	cv=none; b=M2td58GUyrddWoBUqQRl68E/gmf4uSQpcm8neD4F5y0ugaT2mj9Dq/EUNVb+z5OEqTqB+7iZ/tEwzwPXMWJKX4msWs5E86YFtqa0PzpxSuMyeFlFuRtewhVpQwlLYoCLJOOstumSUFzEzweSQol4CgejUWoT1LHkNqpRlGfZBnmFN7HZv8K88/oBc9HLNpK80UuCADKDS31yTxHkJlNM93fI6jbjoP3MyjhUcGb66wJQbmWFJwme+FoiV1IIA6TSQj2M5wHI8ZZ2zv20QvHSJHA3HqTlQ2ciWfCkDmkItO2aDAew+yt7zDIdMBwoytVlY/Jb6s5/qcZudMFjhcRS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755852942; c=relaxed/relaxed;
	bh=YU1ZIJmMa+xQUz77EyVQ81HeMRN9Ii6TroMmjSf6Ks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXadVt6MxtGa+8ZYfP051lorUA/w5CychM6n+k5BX+2TKMHuS1nhcZefSx0D5O7sybvFR6tYYFR1o3a8snZElkDo0DcaRCp3vFjQ9FSbIWqN7kaV844rnMfkYT4Jj1euahF2Xz5uqMp9ux7vTmqoZN4T5oTvFMsMJY+2gM9rNovrHZ+TyJ7EuNH6fPXa8ThhiEw1jc91yTFvSU9B96Lt2JHHm+QnAtwjgmjEr91I0Ul5eqOotNjgXFEJ29wlNuo4iL6gsAMr+geoJfkr6l97MuVupK06ntqwqL9SS5Xrumu6ukEA3DEU8m0iS6Y0Gq5XH1nMIrHxLyBldvKeiYOj3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=II6EJAdz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=II6EJAdz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7Ytg73Hbz30Ff
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 18:55:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755852934; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YU1ZIJmMa+xQUz77EyVQ81HeMRN9Ii6TroMmjSf6Ks4=;
	b=II6EJAdz98FEh0CMNguj1Rev6ZQgoRrFIqS8felJ57aZriiCK4YbZegl/Zs6wgzStBIqd9/NJdMvi/Y5myBkeDGrBRZww4owc8MUN9Krg6VdJ6hN4rh5vigokzNetnaJFSPqWgKjjAuLcQWffFZ8TJVYO2gqns96iqzmU3+hcIs=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmJFmG7_1755852932 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 16:55:32 +0800
Message-ID: <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
Date: Fri, 22 Aug 2025 16:55:31 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: Friendy Su <friendy.su@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250822084241.170054-1-friendy.su@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Friendy,

On 2025/8/22 16:42, Friendy Su wrote:
> Set proper 'dsunit' to let file body align on huge page on blobdev,
> 
> where 'dsunit' * 'blocksize' = huge page size (2M).
> 
> When do mmap() a file mounted with dax=always, aligning on huge page
> makes kernel map huge page(2M) per page fault exception, compared with
> mapping normal page(4K) per page fault.
> 
> This greatly improves mmap() performance by reducing times of page
> fault being triggered.
> 
> Considering deduplication, 'chunksize' should not be smaller than
> 'dsunit', then after dedupliation, still align on dsunit.
> 
> Signed-off-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>   lib/blobchunk.c  | 15 +++++++++++++++
>   man/mkfs.erofs.1 | 15 +++++++++++++++
>   mkfs/main.c      | 13 +++++++++++++
>   3 files changed, 43 insertions(+)
> 
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index bbc69cf..e47afb5 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -309,6 +309,21 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>   	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
>   	interval_start = 0;
>   
> +	/* Align file on 'dsunit' */
> +	if (sbi->bmgr->dsunit > 1) {

It should be

	if (sbi->bmgr->dsunit >= 1u << (cfg.c_chunkbits - g_sbi.blkszbits)) {

	}

?


> +		off_t off = lseek(blobfile, 0, SEEK_CUR);
> +
> +		erofs_dbg("Try to round up 0x%llx to align on %d blocks (dsunit)",
> +				off, sbi->bmgr->dsunit);
> +		off = roundup(off, sbi->bmgr->dsunit * erofs_blksiz(sbi));
> +		if (lseek(blobfile, off, SEEK_SET) != off) {
> +			ret = -errno;
> +			erofs_err("lseek to blobdev 0x%llx error", off);
> +			goto err;
> +		}
> +		erofs_dbg("Aligned on 0x%llx", off);

Could we combine these two debugging messages into one?

> +	}
> +
>   	for (pos = 0; pos < inode->i_size; pos += len) {
>   #ifdef SEEK_DATA
>   		off_t offset = lseek(fd, pos + startoff, SEEK_DATA);
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 63f7a2f..9075522 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -168,6 +168,21 @@ the output filesystem, with no leading /.
>   .TP
>   .BI "\-\-dsunit=" #
>   Align all data block addresses to multiples of #.
> +
> +If \fBdsunit\fR and \fBchunksize\fR are both set, \fBdsunit\fR will be ignored
> +if it is bigger than \fBchunksize\fR.
> +
> +This is for keeping alignment after deduplication.
> +If \fBdsunit\fR is bigger, it contains several chunks,
> +
> +E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=4096
> +
> +Once 1 chunk is deduplicated, the chunks thereafter will not be aligned any
> +longer. In order to achieve the best performance, recommend to set \fBdsunit\fR
> +same as \fBchunksize\fR.
> +
> +E.g. \fBblock-size\fR=4096, \fBdsunit\fR=512 (2M), \fBchunksize\fR=$((4096*512))
> +
>   .TP
>   .BI "\-\-exclude-path=" path
>   Ignore file that matches the exact literal path.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 30804d1..fcb2b89 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1098,6 +1098,19 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * once align data on dsunit, in order to keep alignment after deduplication
> +	 * chunksize should be equal to or bigger than dsunit.
> +	 * if chunksize is smaller than dsunit, e.g. chunksize=4k, dsunit=2M,
> +	 * once a chunk is deduplicated, all data thereafter will be unaligned.
> +	 * so ignore dsunit under such case.
> +	 */
> +	if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
> +		erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore dsunit !",
> +				1u << cfg.c_chunkbits, dsunit);

One tab is not 8 spaces here? it seems indent misalignment.

Thanks,
Gao Xiang

