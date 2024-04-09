Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626B89D5AD
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 11:36:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bkbNjof0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDLSz0hpbz3dTr
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 19:36:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bkbNjof0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDLSt42JGz3bX3
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 19:36:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712655399; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IihCW7ee09bCmiskyKydryQQZ6Rl3F+Bzk9wIUWO258=;
	b=bkbNjof053DkzhhsqKxCjvOGUTZBVYj+yteNE2HadtgacDoeWpy5TK1oEY29/6Z+o98gZy8z57AUjtgx7dGgCkScX2DYLv3r49TeX3DcarJgq37d7riji4o/24mFBY+jjD+BZ3jwUq3TsYtLSDTFw1Bqe4nmd4SUcdGp8yBUggY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4E4IXT_1712655383;
Received: from 30.221.148.154(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4E4IXT_1712655383)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 17:36:38 +0800
Message-ID: <46253829-689c-4f06-8d08-a999c0ddbd1b@linux.alibaba.com>
Date: Tue, 9 Apr 2024 17:36:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if
 possible
Content-Language: en-US
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/9/24 4:11 PM, Hongzhen Luo wrote:
> Use the superblock's UUID to generate the fsid when it's non-null.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..83bd8ee3b5ba 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = 0;
> -
> -	if (!erofs_is_fscache_mode(sb))
> -		id = huge_encode_dev(sb->s_bdev->bd_dev);
>  
>  	buf->f_type = sb->s_magic;
>  	buf->f_bsize = sb->s_blocksize;
>  	buf->f_blocks = sbi->total_blocks;
>  	buf->f_bfree = buf->f_bavail = 0;
> -
>  	buf->f_files = ULLONG_MAX;
>  	buf->f_ffree = ULLONG_MAX - sbi->inos;
> -
>  	buf->f_namelen = EROFS_NAME_LEN;
>  
> -	buf->f_fsid    = u64_to_fsid(id);
> +	if (uuid_is_null(&sb->s_uuid))
> +		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
> +				huge_encode_dev(sb->s_bdev->bd_dev));
> +	else
> +		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);

How about

	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);

which looks cleaner.

Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>



-- 
Thanks,
Jingbo
