Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F86EFDDC
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 01:07:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q6DzS3lLMz3cfH
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 09:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LCsCJGnd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LCsCJGnd;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q6DzK25XLz3cdt
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Apr 2023 09:07:25 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E11696399A;
	Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA025C4339C;
	Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682550440;
	bh=71/XsA8gAmo1yutYZ1cS0twFrW61Rssu2AmOx0Z5eqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LCsCJGnd35MidYfxnMlF2ceb389n1B9U+KnzrgVKwgz5bAx1JzOufQeZ/SGRGVkkX
	 AkwL7o7IUXB84i3Vrp+2dYvTEB2raGyt1bPfIePkPzimyVl0QF0nykjXoFPdK/iGyF
	 xmS+0hcVEEqQ/mzOQIEuWBo+aNi0OdLZoD2sU5j7TMMHl0xiWsv3YDVAgdm/lv4bBl
	 2hkD0FnZL1h9SA7ETWRkHuT5vigtQxRgpaiySgxZcycuzc9OCObp4SvRjW6CqNYxGL
	 A85Yr6YutIEXIGmgBh1OeDzgtzNYHzp8kT1wAHqE0jDNsJNShVauqRfHNLAzt5GYDW
	 hhMvyD5bq6lZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B47F5E270D8;
	Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 00/10] acl: drop posix acl handlers from xattr
 handlers
From: patchwork-bot+f2fs@kernel.org
Message-Id:  <168255044073.16014.8337870090900748986.git-patchwork-notify@kernel.org>
Date: Wed, 26 Apr 2023 23:07:20 +0000
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To: Christian Brauner <brauner@kernel.org>
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
Cc: linux-ext4@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, hch@lst.de, sforshee@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner (Microsoft) <brauner@kernel.org>:

On Wed, 01 Feb 2023 14:14:51 +0100 you wrote:
> Hey everyone,
> 
> After we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handlers around in the
> filesystems xattr handlers for two reasons:
> 
> (1) Because a few filesystems rely on the ->list() method of the generic
>     POSIX ACL xattr handlers in their ->listxattr() inode operation.
> (2) POSIX ACLs are only available if IOP_XATTR is raised. The IOP_XATTR
>     flag is raised in inode_init_always() based on whether the
>     sb->s_xattr pointer is non-NULL. IOW, the registered xattr handlers
>     of the filesystem are used to raise IOP_XATTR.
>     If we were to remove the generic POSIX ACL xattr handlers from all
>     filesystems we would risk regressing filesystems that only implement
>     POSIX ACL support and no other xattrs (nfs3 comes to mind).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,05/10] fs: simplify ->listxattr() implementation
    https://git.kernel.org/jaegeuk/f2fs/c/a5488f29835c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


