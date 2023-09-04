Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75909791CB6
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Sep 2023 20:20:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K3gkbkhJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RfcPM0N8Vz3bWy
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 04:20:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K3gkbkhJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=patchwork-bot+f2fs@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 526 seconds by postgrey-1.37 at boromir; Tue, 05 Sep 2023 04:20:02 AEST
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RfcPG1wJfz2yVg
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 04:20:02 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 9BE26CE0F96;
	Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC393C433CA;
	Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693851068;
	bh=KWuluqFF5yFV+lOCkFnoct0phRXw96Jca/CuZaTU2kY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K3gkbkhJRwgpsacHeBsq0A7kucjUSGo8OzMP1ouPw/XPyf9sD5QK/Sf142+usc7ZE
	 C827H7oMTO9xQURopm4EWqGoFioLBjSEY4gmbRDnvHI4L+ywXrxJRVy5ldQmRaAtfj
	 1pffFi8IArgTV4dPuYUPdlhMXVuT7Hb/6kEuD4lj+4NJdrul8tjUb9OXjEUjpGn+jT
	 2ndFdt5oPLx5wHtLQ20DiaB9Xl09djxp9OA/4zW9QgSOHR3JDKxABg9kMIgFr5Ox62
	 wqlEdaiOf1aM8ubxkjKV3yvjnRyA83mc2npN6NfYoiPdtaZLbxGvWm4TgDkfWkglX8
	 L2qkw/qB1Voxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2BE4C04E26;
	Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v7 00/13] fs: implement multigrain timestamps
From: patchwork-bot+f2fs@kernel.org
Message-Id:  <169385106866.19669.14483196627780303129.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 18:11:08 +0000
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
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
Cc: lucho@ionkov.net, martin@omnibond.com, almaz.alexandrovich@paragon-software.com, jack@suse.cz, linux-xfs@vger.kernel.org, djwong@kernel.org, asmadeus@codewreck.org, linux_oss@crudebyte.com, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, dhowells@redhat.com, clm@fb.com, adilger.kernel@dilger.ca, hdegoede@redhat.com, marc.dionne@auristor.com, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, hubcap@omnibond.com, pc@manguebit.com, linux-cifs@vger.kernel.org, ericvh@kernel.org, agruenba@redhat.com, miklos@szeredi.hu, richard@nod.at, mark@fasheh.com, hughd@google.com, bcodding@redhat.com, code@tyhicks.com, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, ntfs3@lists.linux.dev, idryomov@gmail.com, yzaikin@google.com, linkinjeon@kernel.org, trond.myklebust@hammerspace.com, sprasad@microsoft.com, amir73il@gmail.com, keescook@chromium.org, ocfs2-devel@lists.linux.dev, josef@toxicpanda.com, tom@talpey.com, tj@kernel.org, huyue2@coolpad.com, viro@zeniv.linux.o
 rg.uk, ronniesahlberg@gmail.com, dsterba@suse.com, jaegeuk@kernel.org, ceph-devel@vger.kernel.org, xiubli@redhat.com, hirofumi@mail.parknet.co.jp, jaharkes@cs.cmu.edu, brauner@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, sfrench@samba.org, senozhatsky@chromium.org, mcgrof@kernel.org, devel@lists.orangefs.org, anna@kernel.org, jack@suse.com, rpeterso@redhat.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, jlbec@evilplan.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Mon, 07 Aug 2023 15:38:31 -0400 you wrote:
> The VFS always uses coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this coarseness has always been an issue when we're
> exporting via NFSv3, which relies on timestamps to validate caches. A
> lot of changes can happen in a jiffy, so timestamps aren't sufficient to
> help the client decide to invalidate the cache.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7,01/13] fs: remove silly warning from current_time
    https://git.kernel.org/jaegeuk/f2fs/c/b3030e4f2344
  - [f2fs-dev,v7,02/13] fs: pass the request_mask to generic_fillattr
    https://git.kernel.org/jaegeuk/f2fs/c/0d72b92883c6
  - [f2fs-dev,v7,03/13] fs: drop the timespec64 arg from generic_update_time
    https://git.kernel.org/jaegeuk/f2fs/c/541d4c798a59
  - [f2fs-dev,v7,04/13] btrfs: have it use inode_update_timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/bb7cc0a62e47
  - [f2fs-dev,v7,05/13] fat: make fat_update_time get its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,06/13] ubifs: have ubifs_update_time use inode_update_timestamps
    (no matching commit)
  - [f2fs-dev,v7,07/13] xfs: have xfs_vn_update_time gets its own timestamp
    (no matching commit)
  - [f2fs-dev,v7,08/13] fs: drop the timespec64 argument from update_time
    (no matching commit)
  - [f2fs-dev,v7,09/13] fs: add infrastructure for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/ffb6cf19e063
  - [f2fs-dev,v7,10/13] tmpfs: add support for multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/d48c33972916
  - [f2fs-dev,v7,11/13] xfs: switch to multigrain timestamps
    (no matching commit)
  - [f2fs-dev,v7,12/13] ext4: switch to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/0269b585868e
  - [f2fs-dev,v7,13/13] btrfs: convert to multigrain timestamps
    https://git.kernel.org/jaegeuk/f2fs/c/50e9ceef1d4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


