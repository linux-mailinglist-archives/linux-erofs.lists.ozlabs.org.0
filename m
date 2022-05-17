Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9B7529DDE
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 11:22:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L2Vy74VHtz3bsF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 19:22:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GcicAM+L;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GcicAM+L; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L2Vy02KY8z3bhK
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 19:22:16 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEF561479;
 Tue, 17 May 2022 09:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCE7C385B8;
 Tue, 17 May 2022 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652779333;
 bh=qf2Sjr4YZGduUZZfCuitwrMOqUGbc0ojvfPoMfi/tdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GcicAM+LdmzOG7AdCBhagBkpGqtduvlJB6UfcCbQmAs0FGuBgmd1BfPr2BTCE9NZN
 mcOPupNkPHRL9QCggysS/azMlUFHoEs9p6wnx3P7wL7FJk/Yr7wPSA9NdQqK0SPvSA
 hvLkSBbJNV4u3q1wlF+/VViXALPNufvajeRft7mLFkTZV/hj91dvHg4PI8RtkwZZLJ
 xTKbcL2FgOp6CSo50O7fcb1MeiAPPkYHYtJ0Lze479hVf9jk+7XdUPHAjDReaJA+03
 ELpHBngWc8dmIqNTwD+G3ELzjRxmacyaABEF98A0ApSRhkokd7QJ7U+xb5VWo7jMa7
 aNJjD9bZBFA2Q==
Date: Tue, 17 May 2022 11:22:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: support idmapped mounts
Message-ID: <20220517092203.6dlcxynvpokqrfzg@wittgenstein>
References: <20220517073210.3569589-1-chao@kernel.org>
 <20220517090622.4wrtrjmzknh66bci@wittgenstein>
 <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoNnlpGBFm7dh6yD@B-P7TQMD6M-0146.local>
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

On Tue, May 17, 2022 at 05:15:02PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On Tue, May 17, 2022 at 11:06:22AM +0200, Christian Brauner wrote:
> > On Tue, May 17, 2022 at 03:32:10PM +0800, Chao Yu wrote:
> > > This patch enables idmapped mounts for erofs, since all dedicated helpers
> > > for this functionality existsm, so, in this patch we just pass down the
> > > user_namespace argument from the VFS methods to the relevant helpers.
> > > 
> > > Simple idmap example on erofs image:
> > > 
> > > 1. mkdir dir
> > > 2. touch dir/file
> > > 3. mkfs.erofs erofs.img dir
> > > 4. mount -t erofs -o loop erofs.img  /mnt/erofs/
> > > 
> > > 5. ls -ln /mnt/erofs/
> > > total 0
> > > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > > 
> > > 6. mount-idmapped --map-mount b:0:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > > 
> > > 7. ls -ln /mnt/scratch_erofs/
> > > total 0
> > > -rw-rw-r-- 1 65534 65534 0 May 17 15:26 file
> > 
> > Your current example maps id 0 in the filesystem to id 1001 in the
> > mount. But since no files with id 0 exist in the filesystem you're
> > illustrating that unmapped ids are correctly reported as overflow{g,u}id.
> > 
> > I think what you'd rather want to show is something like this:
> > 
> > 5. ls -ln /mnt/erofs/
> > total 0
> > -rw-rw-r-- 1 1000 1000 0 May 17 15:26 file
> > 
> > 6. mount-idmapped --map-mount b:1000:1001:1 /mnt/erofs/ /mnt/scratch_erofs/
> > 
> > 7. ls -ln /mnt/scratch_erofs/
> > total 0
> > -rw-rw-r-- 1 1001 1001 0 May 17 15:26 file
> > 
> > where id 1000 in the filesystem maps to id 1001 in the mount.
> > 
> > > 
> > > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > > ---
> > 
> > Overall this is currently the smallest patch to support idmapped mounts.
> > 
> > Is erofs integrated with xfstests in any way?
> > For read-only filesystems we probably only need to verify that {g,u}id
> > are correctly reported. All the writable aspects are irrelevant.
> 
> Currently most generic xfstests test cases are unsuitable for erofs.
> 
> Instead we have regression testcases for EROFS specific since it needs
> to generate images with care,
>  https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests
> 
> Also we have an erofsstress to do long time random stress workloads,
> https://github.com/erofs/erofsstress
> 
> But yeah, it's some awkward that fstests idmapped mount testcases may
> be unsuitable for EROFS for now. I will add some new testcases to build
> images and test for this behavior.
> 
> > 
> > Looks good,
> > Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 
> Thanks for your review!

Thanks for supporting this in erofs!
Christian
