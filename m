Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDDB7519A5
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 09:19:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1mFK2GT4z3c1q
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 17:19:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1mFD3y9kz3bcD
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 17:19:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnG-pYM_1689232733;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnG-pYM_1689232733)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 15:18:53 +0800
Message-ID: <2c0b941b-e679-d773-34b6-fd55d765dd00@linux.alibaba.com>
Date: Thu, 13 Jul 2023 15:18:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] erofs-utils: introduce tarerofs
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230711061240.23662-1-jefflexu@linux.alibaba.com>
 <20230711061240.23662-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230711061240.23662-2-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/11 14:12, Jingbo Xu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Let's try to add a new mode "tarerofs" for mkfs.erofs.
> 
> It mainly aims at two use cases:
>   - Convert a tarball (or later tarballs with a merged view) into
>     a full EROFS image [--tar=f];
> 
>   - Generate an EROFS manifest image to reuse tar data [--tar=i],
>     which also enables EROFS 512-byte blocks.
> 
> The second use case is mainly prepared for OCI direct mount without
> OCI blob unpacking.  This also adds another `--aufs` option to
> transform aufs special files into overlayfs metadata.
> 
> [ Note that `--tar=f` generates lots of temporary files for now which
>    can impact performance since the original tar stream(s) may be
>    non-seekable. ]
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> change log:
> 1. don't return prematurely for special device files (in
> erofs_mkfs_build_tree()).  Otherwise erofs_mkfs_build_tree() may
> mistakenly return a positive integer number returned from
> erofs_prepare_xattr_ibody(), and mistakenly make it as the pointer to
> the root inode, which will cause mkfs.erofs segmentation fault.
> 2. automatically create parent directory if it's not included as an
> entry in the tarball stream. (refer to tarerofs_init_default_dir())


struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *s)
{
	struct inode *inode;

	inode = erofs_new_inode();
	if (IS_ERR(inode))
		return inode;

	inode->i_mode = S_IFDIR | 0755;
	inode->i_parent = dir;
	inode->i_uid = getuid();
	inode->i_gid = getgid();
	inode->i_mtime = sbi.build_time;
	inode->i_mtime_nsec = sbi.build_time_nsec;
	tarerofs_init_empty_dir(inode);

	d = erofs_d_alloc(pwd, s);
	d->type = EROFS_FT_DIR;
	d->inode = inode;
	return d;

}
?


Otherwise it looks good to me.

Thanks,
Gao Xiang
