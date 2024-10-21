Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE08F9A684E
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 14:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729513638;
	bh=9SezcXW1UUL1mXDP69mmZCgSGrjE4rd90UsEDXQMDOI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CsT7AuHCDpPqhm3I6dTfyoKO9Cb/27VmnlqkwXfmReeo9/HsBHjBHSQnCg4Y2jpIQ
	 AuvmZX4V4JSbCrCUIB8KKz6yjdtFbsYeqngWWd/ninf5dQiFMEcvi9MyZpeA9hnPT0
	 k3sbko3vAEKMBsY+q+WxWk8tjc+qbL4DDK/iItTNPXxfC/Iit9xD9fZcJUdskbiluB
	 WZ44v+xvx4Z7YFRsag3yyqHU6ve0ufo6+IrA2T0h0dzcAlaxRPPcBVoMxUea2fE5mA
	 8fZdeSxQiiXW806Yi4tZwRzHLXiYs9h+hF9BXNY7763SKWAb9nz1MpBOPNmOF/zGDf
	 y6FdlBqzWYHng==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XXF1f3t3Vz2ygy
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Oct 2024 23:27:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729513636;
	cv=none; b=Ne8KyMGuM41SrL+DRbeUwEyRNakoo3/id6IKpwG3gw1KUIkDBe4okrmSFZvuuHYvRxqjsCoBUwoW/hVW6GZvOCyI9CdvWGtHj93/eD6MM5GDjVPtCAsxoGCrEIuxQUg4hHTNKQzUJnKkC1+i1PzT43NRHnTc7wn5/sTd/kcO27cSOjwB/CJ+FpxD3NmLJQF6y2fU17EF5zOfLqhCYBNJ/oOlLrUjiyEIJLoVLYTnw5/GI8qn1YGDYlDrA25UkjTSljYFb2CKG3MH0fM6c30Suq/gkvmiEs+Au9WlV1+eexJV1r/e0xYYe6K5aTn7gKczHUJHZroMf+opBj2k4peK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729513636; c=relaxed/relaxed;
	bh=9SezcXW1UUL1mXDP69mmZCgSGrjE4rd90UsEDXQMDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnmohNxT6zmQS7l/TW1Lxybe8MErU6iHbxqhEGzaVSty9Igogw0T+2R3m70QnBTwzic+2xLb1kNIqtIbpagryJTLgaxHSS2FdpVmTWL8h1zr077gdLlYCPjumD5Fqhjpm5EYeZZRh77aEDWNdGEie2xWFGB9KG5Drr6fsQALEgvMyHEKsEXGPIVoztS35/WAnbt8mwNS2SYWShcxCIoa+ZgJfqNdll0v5fRDxkgkLDHF+WCJGwsXeFq9r/bwOLx8b1jLkmlbM1SaOR6zv4md+/CgdfaDJFKzGVC0pgGppa8bClLO22HueMtyT2J5HV3jcT2ndfx9aRBCZq4f+6K2pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzyRfExx; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzyRfExx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XXF1b3D55z2yLT
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Oct 2024 23:27:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ADC38A427B3;
	Mon, 21 Oct 2024 12:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FCCC4CEC3;
	Mon, 21 Oct 2024 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513632;
	bh=kYjiKbopU3nHCtbQJu6rvBASdvuKeELUFFKYISpb/sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzyRfExx3I0AZj3W96QbCWdo+ZGE2EjZ8RlagAj7q+gzmFRpr7587s5qGTcTc1vLF
	 w+Y4Xkw4dWz9a0v9moVieSSsVe8gAtZtp5Istt76SlYVdntv9iH7ffR5XJMMs1mBYI
	 02X7TCA2HhqdjHJelBwHcGzqUke+V7oUHRUCFlU2/BU+Cz1DdjKIYApBo9yR017Wgv
	 duMFtTfLw8ZGEOCA+sJX8kWpUQHoP+R5RrH/CHwzrlavPFR7AWxxnTCOZZkYAvkOad
	 bwfdzj8CsLUEWzbRT7E9MdwrGE38aOHK0Pt8XwttpveHlLXtD+zTIUMHqleSU4k3hJ
	 CVQRhVIRHAa9w==
Date: Mon, 21 Oct 2024 14:27:07 +0200
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Message-ID: <20241021-geldverlust-rostig-adbb4182d669@brauner>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
 <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab1a99aa-4732-4df6-97c0-e06cca2527e3@linux.alibaba.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 21, 2024 at 03:54:12PM +0800, Gao Xiang wrote:
> Hi Christian,
> 
> On 2024/10/10 17:48, Christian Brauner wrote:
> > On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
> > > As Allison reported [1], currently get_tree_bdev() will store
> > > "Can't lookup blockdev" error message.  Although it makes sense for
> > > pure bdev-based fses, this message may mislead users who try to use
> > > EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> > > then.
> > > 
> > > Add get_tree_bdev_flags() to specify extensible flags [2] and
> > > GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> > > since it's misleading to EROFS file-backed mounts now.
> > > 
> > > [...]
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> > 
> > [1/2] fs/super.c: introduce get_tree_bdev_flags()
> >        https://git.kernel.org/vfs/vfs/c/f54acb32dff2
> > [2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
> >        https://git.kernel.org/vfs/vfs/c/83e6e973d9c9
> 
> Anyway, I'm not sure what's your thoughts about this, so I try to
> write an email again.
> 
> As Allison suggested in the email [1], "..so probably it should get
> fixed before the final release.".  Although I'm pretty fine to leave
> it in "vfs.misc" for the next merge window (6.13) instead, it could
> cause an unnecessary backport to the stable kernel.

Oh, the file changes have been merged during the v6.12 merge window?
Sorry, that wasn't clear.

Well, this is a bit annoying but yes, we can get that fixed upstream
then. I'll move it to vfs.fixes...
