Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3974C82DF
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 06:18:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K759j4plBz3bmf
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 16:18:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K759X0nsMz3bd2
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 16:17:50 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V5ryflJ_1646111859; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V5ryflJ_1646111859) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Mar 2022 13:17:41 +0800
Date: Tue, 1 Mar 2022 13:17:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
Message-ID: <Yh2sc2TOmyBdV3b7@B-P7TQMD6M-0146.local>
References: <20220301041037.2271718-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301041037.2271718-1-dvander@google.com>
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

On Tue, Mar 01, 2022 at 04:10:37AM +0000, David Anderson via Linux-erofs wrote:
> Currently ctime is effectively ignored because most inodes are compact.
> If ctime was set, and it's different from the build time, then extended
> inodes should be used instead.
> 
> To guarantee that timestamps do not cause extended inodes, a fixed
> timestamp should be used (-T).

Thanks for the patch.

How about introducing some option like '-E preserve-time' since
compact inodes are mainly used for reproducible builds, which I think
per-file timestamp is useless...

Also after I checked ociv2-brainstorm, they'd like to avoid timestamp as
well, which can be effective used by EROFS compact inodes...

https://hackmd.io/@cyphar/ociv2-brainstorm

Thanks,
Gao Xiang

> 
> Change-Id: I3d2e5c5ffe2bdcabea6791b5def5973b507aa316
> Signed-off-by: David Anderson <dvander@google.com>
> ---
>  lib/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index f0a71a8..6f36c09 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -730,6 +730,10 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>  		return true;
>  	if (inode->i_nlink > USHRT_MAX)
>  		return true;
> +	if (inode->i_ctime != sbi.build_time ||
> +	    inode->i_ctime_nsec != sbi.build_time_nsec) {
> +		return true;
> +	}
>  	return false;
>  }
>  
> -- 
> 2.35.1.574.g5d30c73bfb-goog
