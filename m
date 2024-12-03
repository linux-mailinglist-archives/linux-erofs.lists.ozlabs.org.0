Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E539E10D9
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 02:39:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2Nbb1XP4z301J
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 12:38:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733189929;
	cv=none; b=VFq7jVEu5aJowNkGybEZhGCKrpZ/6aaQ48OMKvAPMuy7yucuD4f3oKVHgfAWxGyi9v5U4cORyvUTkEJ77/OroZTtbSbqsgrYp4CfezDaKDsVfaD5q9DKQfaic+hPsQqytIjvCB/p6aZMesQQnpY/NhgU0mj1xSIjzfCAaOR3x8C2M7gU85E6HGA6T7V/rIKqjJgXis9UhD3mYutlc4DmkGm/F4icEi8sAu4qmDmbbIWKkM57qx8KSJqXSFTKSk6eeihZM+yPO5FME+H2q99uLCrw44nwHNIsziID5uSSfeb5QkT7vk0lT/nCe8HW6kHWj+woIXAcBcatdn1AUYZYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733189929; c=relaxed/relaxed;
	bh=j4utOig9Y2oB2z0SYv1vuIgtuxYi1bssmtaauIdlJiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSVWU49vv/PERuS9iY1enUwjctB+FTKO8kfLLHyN/ig4Qhzs0pLYJ2nLrH/+PyJqPbxI7dDXCxUiiq/19Ly+artIrjGOpdxbpcvr9efQOnIyoBxZ+VE6TX3PgwDCKHtuQg1nabNN04sv/WiIKoKKMLkUHUV/ir7WfrHHItKTUzvC9cKfA30F5FS10StHNvSApmgBxUiaqFsS1wYpGSPoBzQC4Lzemp/OpM8G1sO3ur6/syWCJUyo+xHTXR8HaGBZ0vs4X0ooNGUaOCt/9TEaGilUSWn1jDzTmeB/WIfLffH/w10a4/La2/cVc8sNCNn0n10BCsD7a6ETcjpGJ6rFSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A2U/QaoK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A2U/QaoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2NbS3QLpz2yLB
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 12:38:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733189913; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j4utOig9Y2oB2z0SYv1vuIgtuxYi1bssmtaauIdlJiw=;
	b=A2U/QaoKZmV5aikGmlkImh4CeD2TfM28+MimOhlLVDqYQ4ybDJGd2IMQH8miCpR9656LcVwuCINVSYpw4Hgkzic9O1JpqJCXEOmqwcxObsGTH2LS1l6e0Ev2n6QpjHhdrF7kon5u7kccSr+Kf9mZrDzAEnb+3S7mSxpUuC0MJP0=
Received: from 30.221.129.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKkpBAR_1733189910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 09:38:31 +0800
Message-ID: <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
Date: Tue, 3 Dec 2024 09:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: Jooyung Han <jooyung@google.com>, linux-erofs@lists.ozlabs.org
References: <20241203002720.3634151-1-jooyung@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241203002720.3634151-1-jooyung@google.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jooyung,

On 2024/12/3 08:27, Jooyung Han wrote:
> The iteration order of opendir/readdir depends on filesystem
> implementation. Hence, even with the same contents, the filesystem of
> the input directory affects the output.
> 
> In this change, opendir/readdir is replaced with scandir for stable
> order of iteration. This produces the same output regardless of the
> filesystem of the input directory.
> 
> Test: mkfs.erofs ... inputdir(ext3)
> Test: mkfs.erofs ... inputdir(tmpfs)
>    # should generate the same output
> Signed-off-by: Jooyung Han <jooyung@google.com>

Thanks for the patch.  I haven't tested the current behavior (1.8.2),
but EROFS will sort all dirents in a directory in
erofs_prepare_dir_file(). And then dump all subdirs in
erofs_mkfs_dump_tree().

It seems both dirents and inodes are sorted in the alphabetical
order, could you give more hints about this?

Thanks,
Gao Xiang

> ---
> 
> v1: https://lore.kernel.org/linux-erofs/20241202232620.3604736-1-jooyung@google.com/
> change since v1:
>   - modify commit msg (no change-id/bug/typo)
>   - rename the label to err_cleanup
> 
>   lib/inode.c | 39 ++++++++++++++-------------------------
>   1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index f553bec..097deef 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1422,37 +1422,25 @@ static void erofs_mkfs_flushjobs(struct erofs_sb_info *sbi)
>   static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   {
>   	struct erofs_sb_info *sbi = dir->sbi;
> -	DIR *_dir;
> -	struct dirent *dp;
> +	struct dirent *dp, **dent;
> +	int i, num_entries;
>   	struct erofs_dentry *d;
>   	unsigned int nr_subdirs, i_nlink;
>   	int ret;
>   
> -	_dir = opendir(dir->i_srcpath);
> -	if (!_dir) {
> -		erofs_err("failed to opendir at %s: %s",
> +	num_entries = scandir(dir->i_srcpath, &dent, NULL, alphasort);
> +	if (num_entries == -1) {
> +		erofs_err("failed to scandir at %s: %s",
>   			  dir->i_srcpath, erofs_strerror(-errno));
>   		return -errno;
>   	}
>   
>   	nr_subdirs = 0;
>   	i_nlink = 0;
> -	while (1) {
> +	for (i = 0; i < num_entries; free(dent[i]), i++) {
>   		char buf[PATH_MAX];
>   		struct erofs_inode *inode;
> -
> -		/*
> -		 * set errno to 0 before calling readdir() in order to
> -		 * distinguish end of stream and from an error.
> -		 */
> -		errno = 0;
> -		dp = readdir(_dir);
> -		if (!dp) {
> -			if (!errno)
> -				break;
> -			ret = -errno;
> -			goto err_closedir;
> -		}
> +		dp = dent[i];
>   
>   		if (is_dot_dotdot(dp->d_name)) {
>   			++i_nlink;
> @@ -1466,17 +1454,17 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   		d = erofs_d_alloc(dir, dp->d_name);
>   		if (IS_ERR(d)) {
>   			ret = PTR_ERR(d);
> -			goto err_closedir;
> +			goto err_cleanup;
>   		}
>   
>   		ret = snprintf(buf, PATH_MAX, "%s/%s", dir->i_srcpath, d->name);
>   		if (ret < 0 || ret >= PATH_MAX)
> -			goto err_closedir;
> +			goto err_cleanup;
>   
>   		inode = erofs_iget_from_srcpath(sbi, buf);
>   		if (IS_ERR(inode)) {
>   			ret = PTR_ERR(inode);
> -			goto err_closedir;
> +			goto err_cleanup;
>   		}
>   		d->inode = inode;
>   		d->type = erofs_mode_to_ftype(inode->i_mode);
> @@ -1484,7 +1472,7 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   		erofs_dbg("file %s added (type %u)", buf, d->type);
>   		nr_subdirs++;
>   	}
> -	closedir(_dir);
> +	free(dent);
>   
>   	ret = erofs_init_empty_dir(dir);
>   	if (ret)
> @@ -1506,8 +1494,9 @@ static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   
>   	return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
>   
> -err_closedir:
> -	closedir(_dir);
> +err_cleanup:
> +	for (; i < num_entries; free(dent[i]), i++);
> +	free(dent);
>   	return ret;
>   }
>   

