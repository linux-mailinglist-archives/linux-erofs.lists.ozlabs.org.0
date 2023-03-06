Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681A6AB9C1
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 10:26:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVY9y34Tlz3c99
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 20:26:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aGpHk5/E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aGpHk5/E;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVY9t3smcz3bym
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 20:26:42 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EF6BE60B2C;
	Mon,  6 Mar 2023 09:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2167C433EF;
	Mon,  6 Mar 2023 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678094799;
	bh=57FrCCZ2Wq+YAZlBEbTVLCXLXyHrbe4LXgxzAP6Rt70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGpHk5/EASsEtl4vKnAkGUaXhtbPzA/d2cXgftsQx8PVrRgVXQNsAAnUOBX1GgX6I
	 G/6gfIFXfw4GETwfv8Vqa+2mueXnJba6vq4doCPeNTZ+42jYFYMi/XGYUBkeA8X/oD
	 ElKS799bOnXufZBGOEBscaDcXEpJHRp87DtATu56G0m7hUhBUbQpW3gm1nxMrdfglF
	 0ZbBUcHJGIkJmz/Hsybihbq8zOv2if13KJ/EEandIpN1dFYg7WzDuihAtyiEKIBsW3
	 NHz3uKORaef+IPel5P8LpgPELeV5dFcgKzByHGHs4b9oIVc5RyT13xsoOqXUWsxf3W
	 aynSxAyBPrijQ==
Date: Mon, 6 Mar 2023 10:26:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Message-ID: <20230306092633.tobpejvw7mwcx22v@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
 <20230201133020.GA31902@lst.de>
 <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201134254.fai2vc7gtzj6iikx@wittgenstein>
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
Cc: linux-unionfs@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 01, 2023 at 02:42:54PM +0100, Christian Brauner wrote:
> On Wed, Feb 01, 2023 at 02:30:20PM +0100, Christoph Hellwig wrote:
> > This version looks good to me, but I'd really prefer if a reiserfs
> > insider could look over the reiserfs patches.
> 
> I consider this material for v6.4 even with an -rc8 for v6.3. So there's
> time but we shouldn't block it on reiserfs. Especially, since it's
> marked deprecated.

So I've applied this now. If there's still someone interested in
checking the reiserfs bits more than what we did with xfstests they
should please do so. But I don't want to hold up this series waiting for
that to happen.

> 
> Fwiw, I've tested reiserfs with xfstests on a kernel with and without
> this series applied and there's no regressions. But it's overall pretty
> buggy at least according to xfstests. Which is expected, I guess.
