Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA36C6837
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 13:26:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pj4MC4lcPz3cj2
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 23:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m6MeQSns;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=m6MeQSns;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pj4M60zqYz3cj2
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 23:26:09 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E389B62656;
	Thu, 23 Mar 2023 12:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8231C433D2;
	Thu, 23 Mar 2023 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1679574366;
	bh=hSIUlO1HxyEpsf7qIxo9KBJ0VL8excdKGJYYFukRPL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6MeQSnsMeVy2O0Vk8RTY0vHNrmj2AIgXtab/TGNOFfzWTZud+JQGikV8JyH/6bL2
	 HXj5AQv7PGMyWu5gO4aQNckaFR7jMxyPlxC/GN/SkGd9UjEckISINsL0GjCLdhE22C
	 5zuGNqdawoE4Z0VJ+MBNSEjFCrSN9mJPfzKZRDpc=
Date: Thu, 23 Mar 2023 13:26:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Message-ID: <ZBxFW5Yi0rwLvTsx@kroah.com>
References: <20230322165830.55071-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322165830.55071-1-frank.li@vivo.com>
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
Cc: rafael@kernel.org, djwong@kernel.org, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, naohiro.aota@wdc.com, linux-nilfs@vger.kernel.org, richard@nod.at, mark@fasheh.com, trond.myklebust@hammerspace.com, josef@toxicpanda.com, huyue2@coolpad.com, dsterba@suse.com, jlbec@evilplan.org, jaegeuk@kernel.org, konishi.ryusuke@gmail.com, linux-nfs@vger.kernel.org, clm@fb.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, anna@kernel.org, linux-fsdevel@vger.kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Mar 23, 2023 at 12:58:30AM +0800, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -convert to inline helper
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h | 13 +++++++++++++
>  lib/kobject.c           |  3 +--
>  2 files changed, 14 insertions(+), 2 deletions(-)

Meta-comment, something is wrong with this email as it is not linked to
the rest of the series.

You can see that by looking at this message in lore.kernel.org:
	https://lore.kernel.org/r/20230322165830.55071-1-frank.li@vivo.com

No 2-10 patches linked there (they show up as a separate series.)

So even if I wanted to take this series now, we can't as our tools can't
find them...

thanks,

greg k-h
