Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B5766B38
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jul 2023 13:01:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lUHncmkL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RC4SW047Gz3cKC
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jul 2023 21:01:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lUHncmkL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RC4SM5Ncwz3c3s
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jul 2023 21:01:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 70293620F0;
	Fri, 28 Jul 2023 11:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71689C433C8;
	Fri, 28 Jul 2023 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690542063;
	bh=OHILmmeiUht8a/iNB32Wqo6p3CZSNTmmXf/wqdU8eyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUHncmkLN11wgaMD1KR1Gy5if09x5xh0KGyx50ZGUuC2fBx+ijTW2wECE/sOye+rG
	 qDHl4LIc5ruyg2PAO1VZI95ZW/5j7Q0Vo/saVvtDVwvUJlMtgeQjFVYzjalCOIixt6
	 gEQ+u8asPVZluAxs1HoSNgHXPJA0QhMWBw4NywwMFrjIj9j61U5pX9yO+iEoVUAfbu
	 mdakOz70WJL7rxDzg7P00Ji6kHPu+xHi68+/TquTtcuasIukOIAL/+DVn48WGku6nx
	 2ORenDwB3jD7HGc7jH1b/evq7YZ9RS2gsMH8Qjv3EgEZjMk8pxaawj3uGeQKo/zCuQ
	 +lMRyzmoHCobQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: (subset) [PATCH v6 0/7] fs: implement multigrain timestamps
Date: Fri, 28 Jul 2023 13:00:37 +0200
Message-Id: <20230728-unrecht-ersichtlich-cfa7d0c703d1@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=brauner@kernel.org; h=from:subject:message-id; bh=4DjYiXolHUh8qQu1N+OzbWT4vtvmgyT4c+N7Ht8XGtY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQcnsy9IaFu+ZP9z1N8rj/+PH2Pm5FLY6hTmXAw+6xpv069 EIk93lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARMyFGhh2xp3MqP+WJ6kre7E0z/m vxVuf2tOrqbz/KOXZnbdld4czI8C9ly15G/weVYRsOZM6bEHF4077Al0vcwkM2vDFrTz89nQsA
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-mtd@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, Tyler Hicks <code@tyhicks.com>, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Hugh Dickins <hughd@google.com>, Luis Chamberlain <mcgrof@kerne
 l.org>, codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, coda@cs.cmu.edu, Iurii Zaikin <yzaikin@google.com>, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, devel@lists.orangefs.org, Bob Peterson <rpeterso@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Kees Cook <keescook@chromium.org>, Anthony Iliopoulos <ailiop@suse.com>, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, ocfs2-devel@lists.linux.dev, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Theodore Ts'o <tytso@mit.edu>, Chris Mason <clm@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundati
 on.org>, v9fs@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 25 Jul 2023 10:58:13 -0400, Jeff Layton wrote:
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

Survives xfstests (tmpfs, ext4, overlayfs) and the fs portions of LTP.
Let's keep our eyes open for any potential issues. Past suspects has
been IMA interacting with overlayfs. We'll see. Picked everything minus
the tmpfs-writepage patch that was contentious.

---

Applied to the vfs.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.ctime

[1/7] fs: pass the request_mask to generic_fillattr
      https://git.kernel.org/vfs/vfs/c/0a6ab6dc6958
[2/7] fs: add infrastructure for multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/d242b98ac3e9
[4/7] tmpfs: add support for multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/1f31c58cf032
[5/7] xfs: switch to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/859dd91017dd
[6/7] ext4: switch to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/093af249eab4
[7/7] btrfs: convert to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/b90a04d1c30c
