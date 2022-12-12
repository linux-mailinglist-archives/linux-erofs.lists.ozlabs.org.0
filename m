Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A97364991A
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Dec 2022 08:01:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NVsx63Sksz3bfN
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Dec 2022 18:01:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RD2iWcGq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RD2iWcGq;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NVswz3Rhzz2xVr
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Dec 2022 18:01:23 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EBD5960EA9;
	Mon, 12 Dec 2022 07:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FE2C433EF;
	Mon, 12 Dec 2022 07:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670828479;
	bh=kEC/bBy/GTyYEBCgbPrMyXtSHdKJIlAGnQpUleGGwZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RD2iWcGqSwJ8Vjn1J3j24lv892KhzL/IAalLN+QOQ1WVvw23cy9x2JaZ0l607yhQd
	 POvOefa211GYpDgCOtGThvdeL3HaSj+bstUvxTiWmp5ncG2/W+NkFx7UJa5Sl18XSk
	 kqXd4r+kwsad4y/mMWV7yAG6Dpl9gz1Mx0tzdf6dt/uX22gXBMa/ZZnnWD59Usn2A5
	 pFKMcNghokirApjflY9VinSikE+czRVUdbqOgAjmIORST8uAjTaA64qcO9v0H3Wiqq
	 fYgWe50UaadU5C2MqFOWXQrMK330OPVodLqgKxRjh/i00txk4nMRVXb/lEY77cpDD2
	 B+m0Gxi0PKBmA==
Date: Mon, 12 Dec 2022 15:01:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] erofs updates for 6.2-rc1 (fscache part inclusive)
Message-ID: <Y5bRuDiEwUAK1si1@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
	LKML <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
	Hou Tao <houtao1@huawei.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Jia Zhu <zhujia.zj@bytedance.com>
References: <Y5TB6E77vbpRMhIk@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5TB6E77vbpRMhIk@debian>
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
Cc: Yue Hu <huyue2@coolpad.com>, Chen Zhongjin <chenzhongjin@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, Hou Tao <houtao1@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

On Sun, Dec 11, 2022 at 01:29:21AM +0800, Gao Xiang wrote:
> Hi Linus,
> 
> Once the merge window opens, could you consider this pull request for
> 6.2-rc1?
> 
> In this cycle, large folios are now enabled in the iomap/fscache mode
> for uncompressed files first.  In order to do that, we've also cleaned
> up better interfaces between erofs and fscache, which are acked by
> fscache/netfs folks and included in this pull request.
> 
> Other than that, there are random fixes around erofs over fscache and
> crafted images by syzbot, minor cleanups and documentation updates.
> 
> Note that there could be a trivial conflict between erofs and vfs
> tree according to linux-next report [1].
> 
> Happy Holidays!
> Gao Xiang
> 
> [1] https://lore.kernel.org/r/20221205092415.56cc6e19@canb.auug.org.au/
> 
> The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:
> 
>   Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1
> 
> for you to fetch changes up to c505feba4c0d76084e56ec498ce819f02a7043ae:
> 

Sorry for bothering again.

Just having seen v6.2 pull request requirements together with
Linux 6.1 announcement.

Comparing with the latest -next on the last Thursday, there was one-liner
addition on
commit 927e5010ff5b ("erofs: use kmap_local_page() only for erofs_bread()")
as below:

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 85932086d23f..5b3a793103af 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -268,6 +268,7 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
 		inode->i_fop = &erofs_dir_fops;
+		inode_nohighmem(inode);
 		break;
 	case S_IFLNK:
 		err = erofs_fill_symlink(inode, kaddr, ofs)

since I found erofs_lookup() could break on x86 platform with HIGHMEM
enabled this weekend and I made all dirs inode_nohighmem() and folded
into the original patch since it's no needed to keep dirs in HIGHMEM.
I don't find other strange other than this.

Because there is no -next version on Monday, if you would like to
take all commits in -next you could take
  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.2-rc1-alt

instead (the top commit is e5293c693d68f705787480159c4cd332c09c5e67.)

In that way I will send another patch to fix the issue above later,
but if it's possible, it'd be better to apply "tags/erofs-for-6.2-rc1"
directly...

The diffstat of tags/erofs-for-6.2-rc1-alt is:

Chen Zhongjin (1):
      erofs: Fix pcluster memleak when its block address is zero

Gao Xiang (5):
      erofs: update documentation
      erofs: clean up cached I/O strategies
      erofs: use kmap_local_page() only for erofs_bread()
      erofs: fix missing unmap if z_erofs_get_extent_compressedlen() fails
      erofs: validate the extent length for uncompressed pclusters

Hou Tao (1):
      erofs: check the uniqueness of fsid in shared domain in advance

Jingbo Xu (5):
      erofs: enable large folios for iomap mode
      fscache,cachefiles: add prepare_ondemand_read() callback
      erofs: switch to prepare_ondemand_read() in fscache mode
      erofs: support large folios for fscache mode
      erofs: enable large folios for fscache mode

 Documentation/filesystems/erofs.rst |  38 ++--
 fs/cachefiles/io.c                  |  77 ++++---
 fs/erofs/data.c                     |  10 +-
 fs/erofs/fscache.c                  | 408 ++++++++++++++++--------------------
 fs/erofs/inode.c                    |   1 +
 fs/erofs/internal.h                 |  13 +-
 fs/erofs/super.c                    |   2 +-
 fs/erofs/xattr.c                    |   8 +-
 fs/erofs/zdata.c                    |  80 +++----
 fs/erofs/zmap.c                     |  15 +-
 include/linux/netfs.h               |   8 +
 include/trace/events/cachefiles.h   |  27 +--
 12 files changed, 343 insertions(+), 344 deletions(-)

Thanks,
Gao Xiang
