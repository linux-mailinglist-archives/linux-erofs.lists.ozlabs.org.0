Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2837698AE
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 15:58:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GfpV3AHB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RF0F74bKsz301V
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 23:58:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GfpV3AHB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RF0F34TgHz2ymV
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 23:57:59 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6A561138;
	Mon, 31 Jul 2023 13:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21BBC433C8;
	Mon, 31 Jul 2023 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690811876;
	bh=75UoLt2odqW/ibvFDWeID4RRBL3oJ0UWvU1rniIL4WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfpV3AHBwj3d+4lAwHWFmFZHE7nx7W75+3JKO9zZ6etU3ciYUnH6G6h4l/IfDlP2n
	 OHOz4Et2ua3NAcqrM9oKAUdf44nuTwUNjwNYfBga+Wuvx2N368MKCWmhRsLpnd8df9
	 j+OpiCKdwowcaiUHzPBeYbT77aFn3J5BD8qwTAyvoXKGwRXEnOp8BPK5DJR7SSkUrt
	 kK9gY2tlPYwM1Qog5Sh2yPO9bdCNqgPPelJDUOBKi+CbQay48O9GSVHFz7jJ+H23QC
	 Xre+/rMjaiFq873h/G6M5diNcjdO2qwTo5kyFI4T9/1FZTzMVhJsxbp/ezg+zRIIc3
	 v5ANPBfib1qYw==
Date: Mon, 31 Jul 2023 15:57:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731-deswegen-chatten-4ff6c45563ad@brauner>
References: <000000000000f43cab0601c3c902@google.com>
 <20230731093744.GA1788@lst.de>
 <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
 <20230731111622.GA3511@lst.de>
 <20230731-augapfel-penibel-196c3453f809@brauner>
 <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
 <20230731135325.GB6016@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731135325.GB6016@lst.de>
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
Cc: jack@suse.cz, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, linkinjeon@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 31, 2023 at 03:53:25PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 03:22:28PM +0200, Christian Brauner wrote:
> > Uh, no. I vasty underestimated how sensitive that change would be. Plus
> > arguably ->kill_sb() really should be callable once the sb is visible.
> > 
> > Are you looking into this or do you want me to, Christoph?
> 
> I'm planning to look into it, but I won't get to it before tomorrow.

Ok, let me go through the callsites and make sure that all callers are
safe. I think we should just continue calling deactivate_locked_super()
exactly the way we do right now but remove shenanigans like the one we
have in erofs_kill_sb().
