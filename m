Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83793722183
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 10:56:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZSBw1ST1z3dym
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 18:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E9VuCJsc;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E9VuCJsc;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZSBr65VJz3dvt
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Jun 2023 18:56:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 03F5260FA3;
	Mon,  5 Jun 2023 08:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98999C433EF;
	Mon,  5 Jun 2023 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685955378;
	bh=EvMjOmcR0DzI75LU8ZbEStkGi2bPjEetDmC8ubTy+uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9VuCJscetyT57f7B0/jJSX2mOJWUOdJS0+bTsmp2kqSZkS+82WSr1SFDU5eiRxwO
	 00RwJC9XiAKtDmwsfbfgnm5tAQ7s7PSOFGKMuI77sLXN1tcyzXz637jok9ttKRhgwv
	 ihMX4JsLXDpX+U54g3TI30LT6F2JfppkEqkYPC5irp3cdpOkjb0tGnBPGhpaHH/roT
	 umfryHZN3rL2zvfQMGkO6atQn7qXQYydl99YEFUBPDznOjrSqvRWoMf+tNVeP+UqX0
	 LqTofFKTQIb1L8ArbkZdXoG4WDJ/6MPuKrsnTJs/4FKno4h0LyBJRSngnLwstwE5Uo
	 y58vKf9BKp58w==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] cachefiles: Allow the cache to be non-root
Date: Mon,  5 Jun 2023 10:56:07 +0200
Message-Id: <20230605-baumhaus-niemals-e54f42ee6697@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1853230.1684516880@warthog.procyon.org.uk>
References: <1853230.1684516880@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=brauner@kernel.org; h=from:subject:message-id; bh=EvMjOmcR0DzI75LU8ZbEStkGi2bPjEetDmC8ubTy+uM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTULlbM+6vXPafMzOrp0XPGZ58pzNSOPTG1mDs8LHBV9Rbj D4lJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5/Inhf4Cse+Oh38YBL09NOcATlJ 0ZzuxlkmOZcTDpw5KjewykzjD84c+OfJS6ZYfoj/QlC5cffj2Je6bXqnKFC3PzytRbWJ/X8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 19 May 2023 18:21:20 +0100, David Howells wrote:
> 
> Set mode 0600 on files in the cache so that cachefilesd can run as an
> unprivileged user rather than leaving the files all with 0.  Directories
> are already set to 0700.
> 
> Userspace then needs to set the uid and gid before issuing the "bind"
> command and the cache must've been chown'd to those IDs.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] cachefiles: Allow the cache to be non-root
      https://git.kernel.org/vfs/vfs/c/a64498ff493f
