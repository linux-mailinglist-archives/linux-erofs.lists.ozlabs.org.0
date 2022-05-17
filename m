Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0B529DAC
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 11:15:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2Vnw6Fkpz3bYy
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 19:15:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2Vns1PcYz3bYy
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 19:15:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0VDTPyuR_1652778903; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VDTPyuR_1652778903) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 May 2022 17:15:05 +0800
Date: Tue, 17 May 2022 17:15:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
References: <20220517073210.3569589-1-chao@kernel.org>
 <20220517090622.4wrtrjmzknh66bci@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517090622.4wrtrjmzknh66bci@wittgenstein>
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
Cc: fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Chao Yu <chao.yu@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

On Tue, May 17, 2022 at 11:06:22AM +0200, Christian Brauner wrote:
> On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> > This patch enables idmapped mounts for erofs, since all dedicated helpers
> > for this functionality existsm, so, in this patch we just pass down the
> > user_namespace argument from the VFS methods to the relevant helpers.
> > 
> > Simple idmap example on erofs image:
> > 
> > 1. mkdir dir
> > 2. touch dir/file
> > 3. mkfs.erofs erofs.img dir
> > 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> > 
> > 5. ls -ln /mnt/erofs/
> > total 0
> > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > 
> > 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > 
> > 7. ls -ln /mnt/scratch_erofs/
> > total 0
> > -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> 
> Your current example maps id 0 in the filesystem to id 1001 in the
> mount. But since no files with id 0 exist in the filesystem you're
> illustrating that unmapped ids are correctly reported as overflow{g,u}id.
> 
> I think what you'd rather want to show is something like this:
> 
> 5. ls -ln /mnt/erofs/
> total 0
> -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> 
> 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> 
> 7. ls -ln /mnt/scratch_erofs/
> total 0
> -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> 
> where id 1000 in the filesystem maps to id 1001 in the mount.
> 
> > 
> > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > ---
> 
> Overall this is currently the smallest patch to support idmapped mounts.
> 
> Is erofs integrated with xfstests in any way?
> For read-only filesystems we probably only need to verify that {g,u}id
> are correctly reported. All the writable aspects are irrelevant.

Currently most generic xfstests test cases are unsuitable for erofs.

Instead we have regression testcases for EROFS specific since it needs
to generate images with care,
 https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

Also we have an erofsstress to do long time random stress workloads,
https://github.com/erofs/erofsstress

But yeah, it's some awkward that fstests idmapped mount testcases may
be unsuitable for EROFS for now. I will add some new testcases to build
images and test for this behavior.

> 
> Looks good,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Thanks for your review!

Thanks,
Gao Xiang

> 
> >  fs/erofs/inode.c | 2 +-
> >  fs/erofs/super.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index e8b37ba5e9ad..5320bf52c1ce 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -370,7 +370,7 @@ int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
> >  	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
> >  				  STATX_ATTR_IMMUTABLE);
> >  
> > -	generic_fillattr(&init_user_ns, inode, stat);
> > +	generic_fillattr(mnt_userns, inode, stat);
> >  	return 0;
> >  }
> >  
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 0c4b41130c2f..7dc5f2e8ddee 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -781,7 +781,7 @@ static struct file_system_type erofs_fs_type = {
> >  	.name           = "erofs",
> >  	.init_fs_context = erofs_init_fs_context,
> >  	.kill_sb        = erofs_kill_sb,
> > -	.fs_flags       = FS_REQUIRES_DEV,
> > +	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> >  };
> >  MODULE_ALIAS_FS("erofs");
> >  
> > -- 
> > 2.25.1
> > 
