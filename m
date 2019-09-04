Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABC0A7949
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 05:27:33 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NTlk07HxzDqg4
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 13:27:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NTld6SQCzDq8B
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 13:27:25 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 17F84E5E9B6BD6E5B513;
 Wed,  4 Sep 2019 11:27:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 11:27:12 +0800
Subject: Re: [PATCH v2 00/25] erofs: patchset addressing Christoph's comments
To: Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <52a38cb7-b394-b8a8-7254-aafe47f2caa5@huawei.com>
Date: Wed, 4 Sep 2019 11:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/9/4 10:08, Gao Xiang wrote:
> Hi,
> 
> This patchset is based on the following patch by Pratik Shinde,
> https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/
> 
> All patches addressing Christoph's comments on v6, which are trivial,
> most deleted code are from erofs specific fault injection, which was
> followed f2fs and previously discussed in earlier topic [1], but
> let's follow what Christoph's said now.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Comments and suggestions are welcome...
> 
> [1] https://lore.kernel.org/r/1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org/
> 
> changes since v1:
>  - leave some comments near the numbers to indicate where they are stored;
>  - avoid a u8 cast;
>  - use erofs_{err,info,dbg} and print sb->s_id as a prefix before
>    the actual message;
>  - add a on-disk title in erofs_fs.h
>  - use feature_{compat,incompat} rather than features and requirements;
>  - suggestions on erofs_grab_bio:
>    https://lore.kernel.org/r/20190902122016.GL15931@infradead.org/
>  - use compact/extended instead of erofs_inode_v1/v2 and
>    i_format instead of i_advise;
>  - avoid chained if/else if/else if statements in erofs_read_inode;
>  - avoid erofs_vmap/vunmap wrappers;
>  - use read_cache_page_gfp for erofs_get_meta_page;
> 
> Gao Xiang (25):
>   erofs: remove all the byte offset comments
>   erofs: on-disk format should have explicitly assigned numbers
>   erofs: some macros are much more readable as a function
>   erofs: kill __packed for on-disk structures
>   erofs: update erofs_inode_is_data_compressed helper
>   erofs: use feature_incompat rather than requirements
>   erofs: better naming for erofs inode related stuffs
>   erofs: kill erofs_{init,exit}_inode_cache
>   erofs: use erofs_inode naming
>   erofs: update erofs_fs.h comments
>   erofs: update comments in inode.c
>   erofs: better erofs symlink stuffs
>   erofs: use dsb instead of layout for ondisk super_block
>   erofs: kill verbose debug info in erofs_fill_super
>   erofs: localize erofs_grab_bio()
>   erofs: kill prio and nofail of erofs_get_meta_page()
>   erofs: kill __submit_bio()
>   erofs: add "erofs_" prefix for common and short functions
>   erofs: kill all erofs specific fault injection
>   erofs: kill use_vmap module parameter
>   erofs: save one level of indentation
>   erofs: rename errln/infoln/debugln to erofs_{err,info,dbg}
>   erofs: use read_mapping_page instead of sb_bread
>   erofs: always use iget5_locked
>   erofs: use read_cache_page_gfp for erofs_get_meta_page
> 
>  Documentation/filesystems/erofs.txt |   9 -
>  fs/erofs/Kconfig                    |   7 -
>  fs/erofs/data.c                     | 118 +++--------
>  fs/erofs/decompressor.c             |  76 +++----
>  fs/erofs/dir.c                      |  17 +-
>  fs/erofs/erofs_fs.h                 | 197 +++++++++---------
>  fs/erofs/inode.c                    | 297 ++++++++++++++--------------
>  fs/erofs/internal.h                 | 192 ++++--------------
>  fs/erofs/namei.c                    |  21 +-
>  fs/erofs/super.c                    | 282 +++++++++++---------------
>  fs/erofs/xattr.c                    |  41 ++--
>  fs/erofs/xattr.h                    |   4 +-
>  fs/erofs/zdata.c                    |  63 +++---
>  fs/erofs/zdata.h                    |   2 +-
>  fs/erofs/zmap.c                     |  73 +++----
>  include/trace/events/erofs.h        |  14 +-
>  16 files changed, 578 insertions(+), 835 deletions(-)
> 
