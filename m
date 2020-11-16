Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB82B4F8C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 19:33:57 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZd4x5k6hzDqLr
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Nov 2020 05:33:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=A11HhK2h; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZd2B09c4zDqLj
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Nov 2020 05:31:29 +1100 (AEDT)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AA252231B;
 Mon, 16 Nov 2020 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605551486;
 bh=DSyphZecZaJDLhl3SAn5wJ+988r1JkD9wiG/+WmgEVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A11HhK2hy9ihhEf9vdXQO6XPoFVOKk2oaXr1Z/u+bSRYwPToivMO2QxL73e1Jokcr
 VmweE9rz9yfJX/sUrlUgdiYfZNFES71fmk1HpXQZVOOn2MaZPgtdfcy664RhHwusav
 6hR5v2SMOc7g4sg7h7uyPlAa2HBv73qiv1G7y4Y8=
Date: Mon, 16 Nov 2020 19:32:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 4.19.y] erofs: derive atime instead of leaving it empty
Message-ID: <X7LFsF5+X8nwNhd3@kroah.com>
References: <160554164363107@kroah.com>
 <20201116164737.4184-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116164737.4184-1-hsiangkao@aol.com>
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
Cc: nl6720 <nl6720@gmail.com>, linux-erofs@lists.ozlabs.org,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 17, 2020 at 12:47:37AM +0800, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> commit d3938ee23e97bfcac2e0eb6b356875da73d700df upstream.
> 
> EROFS has _only one_ ondisk timestamp (ctime is currently
> documented and recorded, we might also record mtime instead
> with a new compat feature if needed) for each extended inode
> since EROFS isn't mainly for archival purposes so no need to
> keep all timestamps on disk especially for Android scenarios
> due to security concerns. Also, romfs/cramfs don't have their
> own on-disk timestamp, and squashfs only records mtime instead.
> 
> Let's also derive access time from ondisk timestamp rather than
> leaving it empty, and if mtime/atime for each file are really
> needed for specific scenarios as well, we can also use xattrs
> to record them then.
> 
> Link: https://lore.kernel.org/r/20201031195102.21221-1-hsiangkao@aol.com
> [ Gao Xiang: It'd be better to backport for user-friendly concern. ]
> Fixes: 431339ba9042 ("staging: erofs: add inode operations")
> Cc: stable <stable@vger.kernel.org> # 4.19+
> Reported-by: nl6720 <nl6720@gmail.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> [ Gao Xiang: Manually backport to 4.19.y due to trivial conflicts. ]
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
>  drivers/staging/erofs/inode.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Now queued up, thanks for the backport!

greg k-h
