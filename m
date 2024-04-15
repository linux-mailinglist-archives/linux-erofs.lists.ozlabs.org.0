Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E938A519F
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 15:38:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c1Gx9/7H;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJ7Xy4r0wz3dVm
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Apr 2024 23:38:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c1Gx9/7H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJ7Xp5NMxz3d2x
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Apr 2024 23:38:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 735EB60D14;
	Mon, 15 Apr 2024 13:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B1C2BD10;
	Mon, 15 Apr 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188295;
	bh=D5lnOS4BaZn4Qhbk5HBYMUjuMcVsr7Tg9EDh+w5m3oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1Gx9/7HrR7qcEPgR+1Gf7UVgaJwyZJ3Vt3Jt92x6Ap36pWHyJQPiko8+8rfYwOHB
	 6lf//ROsKkm+Vv2WeATEHf0gQyzXcpvNZ5NAM5UMBNA3QuQFbByK+hIdRuJJhTJE/t
	 QTur5cx7RJRyPOPcJEUNgKN+AMiG9x0kGkU9L8OkhAU4EdvrC+eqtCoRITVtbqYJW7
	 K7dwUoT3Pf5zwYxG71dJOS8ejhMMoSuYkh0obmKVGXta/80keaAWvRI5CbXLl6kIor
	 cA3ib1p9RDty4OhcjwV1yjVLmnh1ZMaipYA3PUCeLy7Xo6BNW0I0PNFsRngLao8MXH
	 cBkT9G504KWdw==
Date: Mon, 15 Apr 2024 15:38:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Message-ID: <20240415-betagten-querlatte-feb727ed56c1@brauner>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240415121746.1207242-1-libaokun1@huawei.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
> be mistaken for fscache mode, and then attempt to free an anon_dev that has
> never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>  <TASK>
>  erofs_kill_sb+0x81/0x90
>  deactivate_locked_super+0x35/0x80
>  get_tree_bdev+0x136/0x1e0
>  vfs_get_tree+0x2c/0xf0
>  do_new_mount+0x190/0x2f0
>  [...]
> ============================================
> 
> To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
> parsing the fsid, and then the superblock inherits this flag when it is
> allocated, so that the sb_flags can be used to distinguish whether it is
> in block dev based mode when calling erofs_kill_sb().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/erofs/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index b21bd8f78dc1..7539ce7d64bc 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>  		if (!ctx->fsid)
>  			return -ENOMEM;
> +		fc->sb_flags |= SB_NODEV;

Hm, I wouldn't do it this way. That's an abuse of that flag imho.
Record the information in the erofs_fs_context if you need to.
