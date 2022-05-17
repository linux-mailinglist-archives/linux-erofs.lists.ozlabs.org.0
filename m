Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8E529F7D
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 12:32:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2XVv1094z3bxp
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 20:32:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2XVp5lNWz3bcc
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 20:32:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0VDUBXsC_1652783528; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VDUBXsC_1652783528) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 May 2022 18:32:09 +0800
Date: Tue, 17 May 2022 18:32:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <YoN5pwgj340Ct4Ye@B-P7TQMD6M-0146.local>
References: <20220517073210.3569589-1-chao@kernel.org>
 <20220517090622.4wrtrjmzknh66bci@wittgenstein>
 <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
 <20220517092203.6dlcxynvpokqrfzg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517092203.6dlcxynvpokqrfzg@wittgenstein>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao.yu@oppo.com>, fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 17, 2022 at 11:22:03AM +0200, Christian Brauner wrote:
> On Tue, May 17, 2022 at 05:15:02PM +0800, Gao Xiang wrote:
> > Hi Christian,
> > 
> > On Tue, May 17, 2022 at 11:06:22AM +0200, Christian Brauner wrote:
> > > On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> > > > This patch enables idmapped mounts for erofs, since all dedicated helpers
> > > > for this functionality existsm, so, in this patch we just pass down the
> > > > user_namespace argument from the VFS methods to the relevant helpers.
> > > > 
> > > > Simple idmap example on erofs image:
> > > > 
> > > > 1. mkdir dir
> > > > 2. touch dir/file
> > > > 3. mkfs.erofs erofs.img dir
> > > > 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> > > > 
> > > > 5. ls -ln /mnt/erofs/
> > > > total 0
> > > > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > > > 
> > > > 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > > > 
> > > > 7. ls -ln /mnt/scratch_erofs/
> > > > total 0
> > > > -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> > > 
> > > Your current example maps id 0 in the filesystem to id 1001 in the
> > > mount. But since no files with id 0 exist in the filesystem you're
> > > illustrating that unmapped ids are correctly reported as overflow{g,u}id.
> > > 
> > > I think what you'd rather want to show is something like this:
> > > 
> > > 5. ls -ln /mnt/erofs/
> > > total 0
> > > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > > 
> > > 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > > 
> > > 7. ls -ln /mnt/scratch_erofs/
> > > total 0
> > > -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> > > 
> > > where id 1000 in the filesystem maps to id 1001 in the mount.

Yeah, I just manually tested, although some steps assume user 1000
and some steps assume the root user. But it works.

I will rephrase such commit messages when applying later...

Thanks,
Gao Xiang
