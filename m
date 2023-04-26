Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A456EFDDD
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 01:07:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q6DzY6NJsz3f4F
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 09:07:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=huemn0yp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=huemn0yp;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q6DzK23j9z3ccl
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Apr 2023 09:07:25 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 852E463993;
	Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2946C4339B;
	Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682550440;
	bh=EzrAzHGqX33HLlqpfsl59P+BWciRL4LLNL4FJ5YxYiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=huemn0yp2XzRUtzI1j/YWNYRt1QKV1SVDVfajDMru9/LkNbnuOgXFP3lMOAewzkEw
	 SFF3oLTNxd72taeJdoC8laOtlFG8z9pxPaFk08isrDw/5LQ+gUxIpqOwd2IOZSFHNw
	 4HYKoKLprsc12RNLmO3wSw8omR8cHmCcDPa7+6xfQmB55f1oTV8EE1H27j6Pls93PV
	 Vp8gC4W2lzsIGyOAAPyzt57VCNGwzu0LHwHQBJ7Pg0/TaE/8XeLwZP00zH/DE2R/VR
	 NQgC/FuN1OP8CVZJl+9K/8e1+I0LNNqhbulyDD+LaQvunkEVwhC25NS9T0BTLO3FNI
	 B6MP2MQraMVWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB86DE5FFC8;
	Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/8] acl: remove generic posix acl handlers
 from all xattr handlers
From: patchwork-bot+f2fs@kernel.org
Message-Id:  <168255044069.16014.2458183090274454828.git-patchwork-notify@kernel.org>
Date: Wed, 26 Apr 2023 23:07:20 +0000
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
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
Cc: reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, hch@lst.de, sforshee@kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner (Microsoft) <brauner@kernel.org>:

On Mon, 30 Jan 2023 17:41:56 +0100 you wrote:
> Hey everyone,
> 
> after we finished the introduction of the new posix acl api last cycle
> we still left the generic POSIX ACL xattr handlers around in the
> filesystems xattr handler registered at sb->s_xattr for two reasons.
> First, because a few filesystems rely on the ->list() method of the
> generic POSIX ACL xattr handlers in their ->listxattr() inode operation.
> Second, during inode initalization in inode_init_always() the registered
> xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
> inode->i_opflags.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,6/8] fs: simplify ->listxattr() implementation
    https://git.kernel.org/jaegeuk/f2fs/c/a5488f29835c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


