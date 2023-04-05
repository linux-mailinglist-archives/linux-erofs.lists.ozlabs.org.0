Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED66D81BD
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 17:26:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps7lf3qjnz3c9K
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 01:26:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sandeen.net (client-ip=63.231.237.45; helo=sandeen.net; envelope-from=sandeen@sandeen.net; receiver=<UNKNOWN>)
X-Greylist: delayed 506 seconds by postgrey-1.36 at boromir; Thu, 06 Apr 2023 01:26:47 AEST
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps7lW6B3dz2xHT
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 01:26:47 +1000 (AEST)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id D4AD84DCA1C;
	Wed,  5 Apr 2023 10:18:17 -0500 (CDT)
Message-ID: <fb3c14f3-00b7-2a5e-3c76-bd90705224b8@sandeen.net>
Date: Wed, 5 Apr 2023 10:18:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-21-aalbersh@redhat.com>
 <20230404162730.GB109974@frogsfrogsfrogs>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH v2 20/23] xfs: add fs-verity support
In-Reply-To: <20230404162730.GB109974@frogsfrogsfrogs>
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 4/4/23 11:27 AM, Darrick J. Wong wrote:
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d40de32362b1..b6e99ed3b187 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -30,6 +30,7 @@
>  #include "xfs_filestream.h"
>  #include "xfs_quota.h"
>  #include "xfs_sysfs.h"
> +#include "xfs_verity.h"
>  #include "xfs_ondisk.h"
>  #include "xfs_rmap_item.h"
>  #include "xfs_refcount_item.h"
> @@ -1489,6 +1490,9 @@ xfs_fs_fill_super(
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  #endif
>  	sb->s_op = &xfs_super_operations;
> +#ifdef CONFIG_FS_VERITY
> +	sb->s_vop = &xfs_verity_ops;
> +#endif
>  

Hi Andrey - it might be nicer to just do:

        fsverity_set_ops(sb, &xfs_verity_ops);

here and use the (existing) helper to avoid the #ifdef.  (the #ifdef is handled by the helper)

(ext4 & btrfs could use this too ...)

Thanks!

-Eric
