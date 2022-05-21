Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C852FD32
	for <lists+linux-erofs@lfdr.de>; Sat, 21 May 2022 16:20:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L55Mq6pzSz3bll
	for <lists+linux-erofs@lfdr.de>; Sun, 22 May 2022 00:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VjN6WIbg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VjN6WIbg; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L55Mh4g6Bz3bkm
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 May 2022 00:20:00 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5FD7FB80683;
 Sat, 21 May 2022 14:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE7BC385A5;
 Sat, 21 May 2022 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653142795;
 bh=Gc4Avdshwpks385AtLygPfS1bHzClZtOPNgr+bgDVUY=;
 h=Date:From:To:Cc:Subject:From;
 b=VjN6WIbg6eUzq4McdKDLjQDNJiftVYYEPduZHVFzFKcqwL8WvYA9x/yD3cPtA1w/A
 4h5U6lpKWaMb3ie4oGLLSii200dIX/eBLfzRJDs2w2NDT70C2c+qIB06+RQZPdSrVi
 bcPqpaaR1rpBaJsrCPYWZVUNeZUtR+izl5NU4HxuxnzC7zF6VdTls1DC0LL0M0l423
 +SgOj1NOpv+gbWgE3VofeselK9y9WymhPEmqRDKMmeKgkfFD5touRbzLteY//0cpi4
 SqoRZSCH+AcoQkGUcuk64OM5p7tzQRe7ZVb7GMyYojudsxKhg5AjHjMBiw7hVWxTxW
 RutTPI0Y/hTQA==
Date: Sat, 21 May 2022 22:19:45 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.19-rc1 (fscache part inclusive)
Message-ID: <Yoj1AcHoBPqir++H@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, David Howells <dhowells@redhat.com>,
 Chao Yu <chao@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Wilcox <willy@infradead.org>, tianzichen@kuaishou.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 zhangjiachen.jaycee@bytedance.com, gerry@linux.alibaba.com,
 Liu Bo <bo.liu@linux.alibaba.com>,
 Yan Song <yansong.ys@antgroup.com>,
 Xin Yin <yinxin.x@bytedance.com>,
 Peng Tao <tao.peng@linux.alibaba.com>,
 Zefan Li <lizefan.x@bytedance.com>, Tao Ma <boyu.mt@taobao.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: tianzichen@kuaishou.com, Yan Song <yansong.ys@antgroup.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 zhangjiachen.jaycee@bytedance.com, Zefan Li <lizefan.x@bytedance.com>,
 Tao Ma <boyu.mt@taobao.com>, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Once the merge window opens, could you consider this pull request for
5.19-rc1?  (Since we're in the weekend so I have some extra time to
actually calm down, sort out and write down the whole story for the
pull request itself. Thus it's a bit earlier than usual this time if
there is no another extra -rc8. )

After keeping working on the mailing list for more than half a year,
we finally form "erofs over fscache" feature into shape.  Hopefully it
could bring more possibility to the communities.

The story mainly started from a new project what we called "RAFS v6"
[1] for Nydus image service almost a year ago, which enhances EROFS
to be a new form of one bootstrap (which includes metadata representing
the whole fs tree) + several data-deduplicated content addressable
blobs (actually treated as multiple devices).  Each blob can represent
one container image layer but not quite exactly since all new data can
be fully existed in the previous blobs so no need to introduce another
new blob.

It is actually not a new idea (at least on my side it's much like a
simpilied casync [2] for now) and has many benefits over per-file blobs
or some other exist ways since typically each RAFS v6 image only has
dozens of device blobs instead of thousands of per-file blobs.  It's
easy to be signed with user keys as a golden image, transfered
untouchedly with minimal overhead over the network, kept in some type
of storage conveniently, and run with (optional) runtime verification
but without involving too many irrelevant features crossing the system
beyond EROFS itself.  At least it's our final goal and we're keeping
working on it.  There was also a good summary of this approach from the
casync author [3].

Regardless further optimizations, this work is almost done in the
previous Linux release cycles.  In this round, we'd like to introduce
on-demand load for EROFS with the fscache/cachefiles infrastructure,
considering the following advantages:

 - Introduce new file-based backend to EROFS.  Although each image only
   contains dozens of blobs but in densely-deployed runC host for
   example, there could still be massive blobs on a machine, which is
   messy if each blob is treated as a device.  In contrast, fscache and
   cachefiles are really great interfaces for us to make them work.

 - Introduce on-demand load to fscache and EROFS.  Previously, fscache
   is mainly used to caching network-likewise filesystems, now it can
   support on-demand downloading for local fses too with the exact
   localfs on-disk format.  It has many advantages which we're been
   described in the latest patchset cover letter [4].  In addition to
   that, most importantly, the cached data is still stored in the
   original local fs on-disk format so that it's still the one signed
   with private keys but only could be partially available.  Users can
   fully trust it during running.  Later, users can also back up
   cachefiles easily to another machine.

 - More reliable on-demand approach in principle.  After data is all
   available locally, user daemon can be no longer online in some use
   cases, which helps daemon crash recovery (filesystems can still in
   service) and hot-upgrade (user daemon can be upgraded more
   frequently due to new features or protocols introduced.)

 - Other format can also be converted to EROFS filesystem format over
   the internet on the fly with the new on-demand load feature and
   mounted.  That is entirely possible with on-demand load feature as
   long as such archive format metadata can be fetched in advance like
   stargz.

In addition, although currently our target user is Nydus image
service [5], but laterly, it can be used for other use cases like
on-demand system booting, etc.  As for the fscache on-demand load
feature itself, strictly it can be used for other local fses too.
Laterly we could promote most code to the iomap infrastructure and also
enhance it in the read-write way if other local fses are interested.


Thanks David Howells for taking so much time and patience on this these
months, many thanks with great respect here again!  Thanks Jeffle for
working on this feature and Xin Yin from Bytedance for asynchronous I/O
implementation as well as Zichen Tian, Jia Zhu, and Yan Song for
testing, much appeciated.  We're also exploring more possibly over
fscache cache management over FSDAX for secure containers and working
on more improvements and useful features for fscache, cachefiles, and
on-demand load.


In addition to "erofs over fscache", NFS export and idmapped mount are
also completed in this cycle for container use cases as well.  Details
are all in the commit messages.


All commits have been in -next for a while (actually recently I only
added Chao's rvbs for most commits) and currently there is only a minor
trivial merge conflict with folio tree [6] which can be easily resolved.


(Btw, I will update EROFS roadmap for the following cycles for folio
 adaption and rolling hash de-duplicated compression (since EROFS
 supports variable length compression) and other pending features. )

Many thanks!
Gao Xiang


[1] https://lore.kernel.org/r/20210730194625.93856-1-hsiangkao@linux.alibaba.com
[2] https://github.com/systemd/casync
[3] http://0pointer.net/blog/casync-a-tool-for-distributing-file-system-images.html
[4] https://lore.kernel.org/r/20220509074028.74954-1-jefflexu@linux.alibaba.com
[5] https://github.com/dragonflyoss/image-service
[6] https://lore.kernel.org/r/20220502180425.7305c335@canb.auug.org.au


The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.19-rc1

for you to fetch changes up to ba73eadd23d1c2dc5c8dc0c0ae2eeca2b9b709a7:

  erofs: scan devices from device table (2022-05-18 00:11:21 +0800)

----------------------------------------------------------------
Changes since last update:

 - Add erofs on-demand load support over fscache;

 - Support NFS export for erofs;

 - Support idmapped mounts for erofs;

 - Don't prompt for risk any more when using big pcluster;

 - Fix buffer copy overflow of ztailpacking feature;

 - Several minor cleanups.

----------------------------------------------------------------
Chao Yu (1):
      erofs: support idmapped mounts

Gao Xiang (3):
      erofs: remove obsoleted comments
      erofs: refine on-disk definition comments
      erofs: fix buffer copy overflow of ztailpacking feature

Hongnan Li (1):
      erofs: make filesystem exportable

Jeffle Xu (22):
      cachefiles: extract write routine
      cachefiles: notify the user daemon when looking up cookie
      cachefiles: unbind cachefiles gracefully in on-demand mode
      cachefiles: notify the user daemon when withdrawing cookie
      cachefiles: implement on-demand read
      cachefiles: enable on-demand read mode
      cachefiles: add tracepoints for on-demand read mode
      cachefiles: document on-demand read mode
      erofs: make erofs_map_blocks() generally available
      erofs: add fscache mode check helper
      erofs: register fscache volume
      erofs: add fscache context helper functions
      erofs: add anonymous inode caching metadata for data blobs
      erofs: add erofs_fscache_read_folios() helper
      erofs: register fscache context for primary data blob
      erofs: register fscache context for extra data blobs
      erofs: implement fscache-based metadata read
      erofs: implement fscache-based data read for non-inline layout
      erofs: implement fscache-based data read for inline layout
      erofs: implement fscache-based data readahead
      erofs: add 'fsid' mount option
      erofs: scan devices from device table

Xin Yin (1):
      erofs: change to use asynchronous io for fscache readpage/readahead

Yue Hu (1):
      erofs: do not prompt for risk any more when using big pcluster

 Documentation/filesystems/caching/cachefiles.rst | 178 ++++++++
 fs/cachefiles/Kconfig                            |  12 +
 fs/cachefiles/Makefile                           |   1 +
 fs/cachefiles/daemon.c                           | 117 ++++-
 fs/cachefiles/interface.c                        |   2 +
 fs/cachefiles/internal.h                         |  78 ++++
 fs/cachefiles/io.c                               |  76 ++--
 fs/cachefiles/namei.c                            |  16 +-
 fs/cachefiles/ondemand.c                         | 503 ++++++++++++++++++++++
 fs/erofs/Kconfig                                 |  10 +
 fs/erofs/Makefile                                |   1 +
 fs/erofs/data.c                                  |  26 +-
 fs/erofs/decompressor.c                          |   7 +-
 fs/erofs/erofs_fs.h                              |  50 ++-
 fs/erofs/fscache.c                               | 521 +++++++++++++++++++++++
 fs/erofs/inode.c                                 |  11 +-
 fs/erofs/internal.h                              |  76 ++--
 fs/erofs/namei.c                                 |   5 +-
 fs/erofs/super.c                                 | 221 ++++++++--
 fs/erofs/sysfs.c                                 |   4 +-
 include/linux/fscache.h                          |   1 +
 include/linux/netfs.h                            |   1 +
 include/trace/events/cachefiles.h                | 176 ++++++++
 include/uapi/linux/cachefiles.h                  |  68 +++
 24 files changed, 1997 insertions(+), 164 deletions(-)
 create mode 100644 fs/cachefiles/ondemand.c
 create mode 100644 fs/erofs/fscache.c
 create mode 100644 include/uapi/linux/cachefiles.h
