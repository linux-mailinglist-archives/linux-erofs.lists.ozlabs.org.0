Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1D7F8BEE
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Nov 2023 16:07:57 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6m/Q3m2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ScwFl4p8hz3cS5
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Nov 2023 02:07:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6m/Q3m2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (unknown [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ScwFg3KwLz3bt2
	for <linux-erofs@lists.ozlabs.org>; Sun, 26 Nov 2023 02:07:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id DCD7AB80E91;
	Sat, 25 Nov 2023 15:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46699C433C8;
	Sat, 25 Nov 2023 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700924856;
	bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6m/Q3m2C9dv/x1IrvMwUpR8bpLlJNc24Gp3v/Vc2ovKIDlh0vNRu2OEmZtSizOKf
	 PAy35UaIxh08a5Mu13pW51gdbl7Re9EVHipdFS+kl4oAmzE1dXWBIgu6HAFPzX/TaA
	 qnZk21Rr/tFPxpjYcqN+Eoti28DB6PsoSLwwW3oOowf+guc95M96Jx0ov5G0Sfebd0
	 6bEE6s8dIZ6RyzqH10Yp1Fiwr1wUzq5TW1uaosYT0s0qxlMhrQXFCfpnV/wq+Gb3kG
	 luMgV2ANlxx46DG1bGRPoHSg7bbeUKi4uzW98rmnQbJt1sZaDQuHRWAvB0udThpC9E
	 ps6nvUJ51ysGQ==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH V6 RESEND 0/5] cachefiles: Introduce failover mechanism for on-demand mode
Date: Sat, 25 Nov 2023 16:06:34 +0100
Message-ID: <20231125-latschen-bierkrug-d3bad5531859@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=brauner@kernel.org; h=from:subject:message-id; bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQm8Va+zrfe2JXb8Ig7bXpieu4x03bGd/5nbIKfnvP9d yv7TvbNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkI72JkOPD/TmjayXeu3hn3 mrh/1vBJrpO1NHA1emn49sWU2YuX8jAy7Itw154XdWgxD/tLWUb93q6V7DYMQVIF575kt51ZJdP BCQA=
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 20 Nov 2023 12:14:17 +0800, Jia Zhu wrote:
> Changes since v5:
> In cachefiles_daemon_poll(), replace xa_for_each_marked with xas_for_each_marked.
> 
> [Background]
> ============
> In the on-demand read mode, if user daemon unexpectedly closes an on-demand fd
> (for example, due to daemon crashing), subsequent read operations and inflight
> requests relying on these fd will result in a return value of -EIO, indicating
> an I/O error.
> While this situation might be tolerable for individual personal users, it
> becomes a significant concern when it occurs in a real public cloud service
> production environment (like us).  Such I/O errors will be propagated to cloud
> service users, potentially impacting the execution of their jobs and
> compromising the overall stability of the cloud service.  Besides, we have no
> way to recover this.
> 
> [...]

Applied to the vfs.fscache branch of the vfs/vfs.git tree.
Patches in the vfs.fscache branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fscache

[1/5] cachefiles: introduce object ondemand state
      https://git.kernel.org/vfs/vfs/c/357a18d03314
[2/5] cachefiles: extract ondemand info field from cachefiles_object
      https://git.kernel.org/vfs/vfs/c/3c5ecfe16e76
[3/5] cachefiles: resend an open request if the read request's object is closed
      https://git.kernel.org/vfs/vfs/c/0a7e54c1959c
[4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
      https://git.kernel.org/vfs/vfs/c/b817e22b2e91
[5/5] cachefiles: add restore command to recover inflight ondemand read requests
      https://git.kernel.org/vfs/vfs/c/e73fa11a356c
