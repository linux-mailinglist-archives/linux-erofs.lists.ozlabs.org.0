Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148694C8322
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 06:28:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K75PQ100jz3bd2
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 16:28:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K75PG29N8z3bd2
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 16:28:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V5shsqM_1646112472; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V5shsqM_1646112472) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Mar 2022 13:27:54 +0800
Date: Tue, 1 Mar 2022 13:27:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use mtime to seed ctimes
Message-ID: <Yh2u2Iab7BjUg3ZH@B-P7TQMD6M-0146.local>
References: <20220301041139.2272220-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301041139.2272220-1-dvander@google.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Tue, Mar 01, 2022 at 04:11:39AM +0000, David Anderson via Linux-erofs wrote:
> Currently mkfs.erofs picks up whatever the system time happened to be
> when the input file structure was created. Since there's no (easy) way for
> userspace to control ctime, there's no way to control the per-file ctime
> that mkfs.erofs uses.
> 
> Switching to mtime allows this tuning, which is important when the
> timestamp of files is used to detect staleness.

Yeah, I agree I should think more when I planned to store `ctime' at the
first time [my original thought was to keep metadata time (including
uid, gid, etc..), so I selected `ctime' instead of `mtime'].

Should we change what's described in 'Documentation/filesystems/erofs.rst'
and even rename i_ctime to i_mtime?

Also should we introduce a new compat feature to indicate that new mkfs
records mtime instead?

Thanks,
Gao Xiang

> 
> Change-Id: I9cab662398bedc43d6d68ae798912f33360814e3
> Signed-off-by: David Anderson <dvander@google.com>
> ---
>  lib/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 461c797..f0a71a8 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -806,12 +806,12 @@ static int erofs_fill_inode(struct erofs_inode *inode,
>  	inode->i_mode = st->st_mode;
>  	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
>  	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
> -	inode->i_ctime = st->st_ctime;
> -	inode->i_ctime_nsec = ST_CTIM_NSEC(st);
> +	inode->i_ctime = st->st_mtime;
> +	inode->i_ctime_nsec = ST_MTIM_NSEC(st);
>  
>  	switch (cfg.c_timeinherit) {
>  	case TIMESTAMP_CLAMPING:
> -		if (st->st_ctime < sbi.build_time)
> +		if (st->st_mtime < sbi.build_time)
>  			break;
>  	case TIMESTAMP_FIXED:
>  		inode->i_ctime = sbi.build_time;
> -- 
> 2.35.1.574.g5d30c73bfb-goog
