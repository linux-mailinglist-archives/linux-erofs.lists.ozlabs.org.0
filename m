Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA5591EA8
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 08:18:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M56g14tfdz3bPP
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 16:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TlZu7Bop;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TlZu7Bop;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M56fy1YKVz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Aug 2022 16:18:34 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B7D6660F79;
	Sun, 14 Aug 2022 06:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB7C433D6;
	Sun, 14 Aug 2022 06:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660457910;
	bh=YtPp8P08YsnTDNSDBfvHGZsicESHbR55BInArTyNXNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlZu7BopinHHNl80+pDbIrNQsW7cbNJGBDAvRbzgzEflt+SGoNzePfnvTSy0PTNGV
	 JANTLl2jRVSAcMBBUQsKWGsWN8BPa465cb6rmvuAphwBl/7toxwtUOL9Wmp4+Jlpwm
	 HM3JOrGzS03E1Bny1rlAqOK4WwqPBj3xzHktjaFo5sVjG8edYIMA+jtqkCPvWYtZLk
	 GWlRmN8Ibjhay9ERCMsYCeAhHqBMOTvGB0sBuAmxlx/A9p+zHFVzg8c1HB0gyN4HAo
	 QaIL1OuNsNZd2nW7vvk8cx2xuC908faYUfehlM6hC672H1/SsRysAk4uNoHmPc2poH
	 SFkxIpn0mdg/Q==
Date: Sun, 14 Aug 2022 14:18:24 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH 2/2] erofs-utils: mkfs: updating man to use uid/gid
 offsetting support
Message-ID: <YviTsC6IwGrvl2k3@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
 <20220814022915.7964-2-naoto.yamaguchi@aisin.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220814022915.7964-2-naoto.yamaguchi@aisin.co.jp>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 14, 2022 at 11:29:15AM +0900, Naoto Yamaguchi wrote:
> Previous commit add support uid/gid offsetting.
> This patch add information of these option to man/mkfs.erofs.1.
> 
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> ---
>  man/mkfs.erofs.1 | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index d811f20..cbc4ae2 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -108,11 +108,21 @@ You may give multiple `--exclude-regex` options.
>  Specify a \fIfile_contexts\fR file to setup / override selinux labels.
>  .TP
>  .BI "\-\-force-uid=" UID
> -Set all file uids to \fIUID\fR.
> +Set all file uids to \fIUID\fR. 
>  .TP
>  .BI "\-\-force-gid=" GID
>  Set all file gids to \fIGID\fR.
>  .TP
> +.BI "\-\-uid-offset=" UIDOFFSET
> +Add \fIUIDOFFSET\fR to all file uids.
> +When this option used combine with force-uid, the final file uids sets
> +\fIUID\fR + \fIUIDOFFSET\fR.
> +.TP
> +.BI "\-\-id-offset=" GIDOFFSET

This should be --gid-offset. Also these would be better to be
in alphabet order.

I will update these by hand.

Thanks,
Gao Xiang

> +Add \fIGIDOFFSET\fR to all file gids.
> +When this option used combine with force-gid, the final file gids sets
> +\fIGID\fR + \fIGID-OFFSET\fR.
> +.TP
>  .B \-\-help
>  Display this help and exit.
>  .TP
> -- 
> 2.25.1
> 
