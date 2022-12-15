Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8F64D817
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:55:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXmKc3LWXz3bWV
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:55:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.3; helo=out199-3.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXmKW4C2hz2x9C
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:55:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VXMHvrb_1671094532;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXMHvrb_1671094532)
          by smtp.aliyun-inc.com;
          Thu, 15 Dec 2022 16:55:34 +0800
Date: Thu, 15 Dec 2022 16:55:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH v3 2/3] erofs: replace [l]stat64 by equivalent [l]stat
Message-ID: <Y5rhBAUIBbWSrIto@B-P7TQMD6M-0146.local>
References: <20221215064758.93821-1-raj.khem@gmail.com>
 <20221215064758.93821-2-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215064758.93821-2-raj.khem@gmail.com>
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

On Wed, Dec 14, 2022 at 10:47:57PM -0800, Khem Raj wrote:
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 10 +++++-----
>  lib/xattr.c |  4 ++--
>  mkfs/main.c |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index f192510..38003fc 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -773,7 +773,7 @@ static u32 erofs_new_encode_dev(dev_t dev)
>  
>  #ifdef WITH_ANDROID
>  int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> -			       struct stat64 *st,
> +			       struct stat *st,
>  			       const char *path)
>  {
>  	/* filesystem_config does not preserve file type bits */
> @@ -818,7 +818,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  }
>  #else
>  static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> -				      struct stat64 *st,
> +				      struct stat *st,
>  				      const char *path)
>  {
>  	return 0;
> @@ -826,7 +826,7 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  #endif
>  
>  static int erofs_fill_inode(struct erofs_inode *inode,
> -			    struct stat64 *st,
> +			    struct stat *st,
>  			    const char *path)
>  {
>  	int err = erofs_droid_inode_fsconfig(inode, st, path);
> @@ -910,7 +910,7 @@ static struct erofs_inode *erofs_new_inode(void)
>  /* get the inode from the (source) path */
>  static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
>  {
> -	struct stat64 st;
> +	struct stat st;
>  	struct erofs_inode *inode;
>  	int ret;
>  
> @@ -918,7 +918,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
>  	if (!is_src)
>  		return ERR_PTR(-EINVAL);
>  
> -	ret = lstat64(path, &st);
> +	ret = lstat(path, &st);
>  	if (ret)
>  		return ERR_PTR(-errno);
>  
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 71ffe3e..fd0e728 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -467,7 +467,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
>  {
>  	int ret;
>  	DIR *_dir;
> -	struct stat64 st;
> +	struct stat st;
>  
>  	_dir = opendir(path);
>  	if (!_dir) {
> @@ -502,7 +502,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
>  			goto fail;
>  		}
>  
> -		ret = lstat64(buf, &st);
> +		ret = lstat(buf, &st);
>  		if (ret) {
>  			ret = -errno;
>  			goto fail;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d2c9830..5279805 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -581,7 +581,7 @@ int main(int argc, char **argv)
>  	struct erofs_buffer_head *sb_bh;
>  	struct erofs_inode *root_inode;
>  	erofs_nid_t root_nid;
> -	struct stat64 st;
> +	struct stat st;
>  	erofs_blk_t nblocks;
>  	struct timeval t;
>  	char uuid_str[37] = "not available";
> @@ -609,7 +609,7 @@ int main(int argc, char **argv)
>  			return 1;
>  	}
>  
> -	err = lstat64(cfg.c_src_path, &st);
> +	err = lstat(cfg.c_src_path, &st);
>  	if (err)
>  		return 1;
>  	if (!S_ISDIR(st.st_mode)) {
> -- 
> 2.39.0
