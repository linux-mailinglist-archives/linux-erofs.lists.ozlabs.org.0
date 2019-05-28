Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC012BCD7
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 03:24:46 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Cbjl3d0bzDqJc
	for <lists+linux-erofs@lfdr.de>; Tue, 28 May 2019 11:24:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Cbjg3M3vzDqHx
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 May 2019 11:24:39 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CDBE6741DB59E7908D31;
 Tue, 28 May 2019 09:24:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 28 May
 2019 09:24:26 +0800
Subject: Re: [PATCH 2/3] mm: remove cleancache.c
To: Juergen Gross <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
 <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-btrfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-mm@kvack.org>
References: <20190527103207.13287-1-jgross@suse.com>
 <20190527103207.13287-3-jgross@suse.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8f69d56d-3fdd-a160-9574-f81bd066e5ac@huawei.com>
Date: Tue, 28 May 2019 09:24:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190527103207.13287-3-jgross@suse.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Fasheh <mark@fasheh.com>,
 Josef Bacik <josef@toxicpanda.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 ocfs2-devel@oss.oracle.com, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/5/27 18:32, Juergen Gross wrote:
> With the removal of tmem and xen-selfballoon the only user of
> cleancache is gone. Remove it, too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  Documentation/vm/cleancache.rst  | 296 ------------------------------------
>  Documentation/vm/frontswap.rst   |  10 +-
>  Documentation/vm/index.rst       |   1 -
>  MAINTAINERS                      |   7 -
>  drivers/staging/erofs/data.c     |   6 -
>  drivers/staging/erofs/internal.h |   1 -
>  fs/block_dev.c                   |   5 -
>  fs/btrfs/extent_io.c             |   9 --
>  fs/btrfs/super.c                 |   2 -
>  fs/ext4/readpage.c               |   6 -
>  fs/ext4/super.c                  |   2 -
>  fs/f2fs/data.c                   |   3 +-

For erofs and f2fs part,

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>  fs/mpage.c                       |   7 -
>  fs/ocfs2/super.c                 |   2 -
>  fs/super.c                       |   3 -
>  include/linux/cleancache.h       | 124 ---------------
>  include/linux/fs.h               |   5 -
>  mm/Kconfig                       |  22 ---
>  mm/Makefile                      |   1 -
>  mm/cleancache.c                  | 317 ---------------------------------------
>  mm/filemap.c                     |  11 --
>  mm/truncate.c                    |  15 +-
