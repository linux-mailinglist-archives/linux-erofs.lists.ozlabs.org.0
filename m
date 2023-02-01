Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C818B68668D
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Feb 2023 14:15:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P6MqQ3DhQz3cgt
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Feb 2023 00:15:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L6kcghG3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L6kcghG3;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P6MqG668hz3c6q
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Feb 2023 00:15:38 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0ABAB6179D;
	Wed,  1 Feb 2023 13:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA1C4339C;
	Wed,  1 Feb 2023 13:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675257333;
	bh=XAJ9eI3svGJuqVTJUnSxvv9YTA0l+xndj1Jw+Z1jagQ=;
	h=From:Subject:Date:To:Cc:From;
	b=L6kcghG3qlSeMxpxJRTGEDsALZmiJfrEU0V/1HEmYbKdW3rFnVUs9UIDGEzRKYWtg
	 tNZzlaYWaIZ/V/zWFYd268DI///8vZp3gH/a3eMLEBUra7aFO5vCuAX3ny4Qg2knsu
	 7SkTsf7m5s+phGrgqngNkAkoJynRpIjDp8j8ze7OkExaens9ORzfEpQk0u7+zU+os7
	 yzrAYpV28OZVUPw87eK7VkGLUZRaFhvqXpHMjCFYujJU0xpJxhkiKFVDQbZEJW5S2X
	 E23YVPr1cktPKIhzi9VOTFNrcHU9h4XmlnPv8G3KBrajxBmW890T7Bup3Dn/V6lTSV
	 PrqccGKzSWKiA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/10] acl: drop posix acl handlers from xattr handlers
Date: Wed, 01 Feb 2023 14:14:51 +0100
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMtl2mMC/52PQQ6CMBBFr0K6dggtlFRX3sO4aMsAjdiaKWkwh
 Ltb2LnU5Z/Mf/NmZRHJYWSXYmWEyUUXfA71qWB21H5AcF3OTFSirriQ0EfQdgLCZ0gIA/rct7D
 oeSbIhW5CitDYHjslpeqUYhlldEQwpL0dd9hTxxmpTG0pgGy7b7wIe7ccIrd7zqOLc6D34ZX4P
 v1RIXGooLU9l9I0Z2Ha6wPJ41QGGth+IYl/qCJTBc//GaWMkd/Ubds+iR28gVEBAAA=
To: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5419; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XAJ9eI3svGJuqVTJUnSxvv9YTA0l+xndj1Jw+Z1jagQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv1oIS8Y+vZS+2+RiV9u2ffcfnlfcMkFr9JtvM2zv/pV
 e8oXdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEeRPDP42QU9NFLmeXcj38M226z9
 yHHdvWpMwS360qvenTKoW1lfsZ/rttUTXnv7b10sa2GD7dbdfYvI9mB9qqrE44tEiQ+fXxRcwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
Cc: "Christian Brauner \(Microsoft\)" <brauner@kernel.org>, linux-unionfs@vger.kernel.org, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hey everyone,

After we finished the introduction of the new posix acl api last cycle
we still left the generic POSIX ACL xattr handlers around in the
filesystems xattr handlers for two reasons:

(1) Because a few filesystems rely on the ->list() method of the generic
    POSIX ACL xattr handlers in their ->listxattr() inode operation.
(2) POSIX ACLs are only available if IOP_XATTR is raised. The IOP_XATTR
    flag is raised in inode_init_always() based on whether the
    sb->s_xattr pointer is non-NULL. IOW, the registered xattr handlers
    of the filesystem are used to raise IOP_XATTR.
    If we were to remove the generic POSIX ACL xattr handlers from all
    filesystems we would risk regressing filesystems that only implement
    POSIX ACL support and no other xattrs (nfs3 comes to mind).

This series makes it possible to remove the generic POSIX ACL xattr
handlers from the sb->s_xattr list of all filesystems. This is a crucial
step as the generic POSIX ACL xattr handlers aren't used for POSIX ACLs
anymore and POSIX ACLs don't depend on the xattr infrastructure in a
meaningful way anymore.

Adressing problem (1) will require more work long-term. It would be best
to get rid of the ->list() method of xattr handlers completely if we
can.

For erofs, ext{2,4}, f2fs, jffs2, ocfs2, and reiserfs we keep the dummy
handler around so they can continue to use array-based xattr handler
indexing. The series does simplify the ->listxattr() implementation of
all these filesystems.

This series decouples POSIX ACLs from IOP_XATTR as they don't depend on
xattr handlers anymore. With this we can finally remove the dummy xattr
handlers from all filesystems xattr handlers.

All filesystems with reasonable integration into xfstests have been
tested with:

        ./check -g acl,attr,cap,idmapped,io_uring,perms,unlink

All tests pass without regression on xfstests for-next branch.

Since erofs doesn't have integration into xfstests yet afaict I have
tested it with the testuite available in erofs-utils. They also all pass
without any regressions.

Thanks!
Christian

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
- Decouple POSIX ACLs from IOP_XATTR.
- Allow vfs_listxattr() to function without checking for IOP_XATTR
  making it possible to list POSIX ACLs for filesystems that only
  implement POSIX ACLs and no other xattrs.
- Give reiserfs a set of dedicated inode operation for private inodes
  that have turned of xattrs completely.
- Link to v2: https://lore.kernel.org/r/20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org

Changes in v2:
- Please see changelogs of the individual patches.
- Christoph & Christian:
  Remove SB_I_XATTR and instead introduce IOP_NOACL so filesystems can
  opt out of POSIX ACLs for specific inodes. Decouple POSIX ACLs from
  IOP_XATTR.
- Keep generic posix acl xattr handlers so filesystems that use array
  based indexing on xattr handlers can continue to do so.
- Minor fixes.
- Link to v1: https://lore.kernel.org/r/20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org

---
Christian Brauner (10):
      xattr: simplify listxattr helpers
      xattr: add listxattr helper
      xattr: remove unused argument
      fs: drop unused posix acl handlers
      fs: simplify ->listxattr() implementation
      reiserfs: rework ->listxattr() implementation
      fs: rename generic posix acl handlers
      reiserfs: rework priv inode handling
      ovl: check for ->listxattr() support
      acl: don't depend on IOP_XATTR

 fs/9p/xattr.c                   |   4 --
 fs/btrfs/xattr.c                |   4 --
 fs/ceph/xattr.c                 |   4 --
 fs/cifs/xattr.c                 |   4 --
 fs/ecryptfs/inode.c             |   4 --
 fs/erofs/xattr.c                |  12 +---
 fs/erofs/xattr.h                |  20 ++++---
 fs/ext2/xattr.c                 |  25 ++++----
 fs/ext4/xattr.c                 |  25 ++++----
 fs/f2fs/xattr.c                 |  24 ++++----
 fs/gfs2/xattr.c                 |   2 -
 fs/jffs2/xattr.c                |  29 +++++-----
 fs/jfs/xattr.c                  |   4 --
 fs/nfs/nfs3_fs.h                |   1 -
 fs/nfs/nfs3acl.c                |   6 --
 fs/nfs/nfs3super.c              |   3 -
 fs/nfsd/nfs4xdr.c               |   3 +-
 fs/ntfs3/xattr.c                |   4 --
 fs/ocfs2/xattr.c                |  14 ++---
 fs/orangefs/xattr.c             |   2 -
 fs/overlayfs/copy_up.c          |   3 +-
 fs/overlayfs/super.c            |   8 ---
 fs/posix_acl.c                  |  61 +++++++++++++++-----
 fs/reiserfs/file.c              |   7 +++
 fs/reiserfs/inode.c             |   6 +-
 fs/reiserfs/namei.c             |  50 ++++++++++++++--
 fs/reiserfs/reiserfs.h          |   2 +
 fs/reiserfs/xattr.c             |  55 +++++++++---------
 fs/xattr.c                      | 124 ++++++++++++++++++++--------------------
 fs/xfs/xfs_xattr.c              |   4 --
 include/linux/posix_acl.h       |   7 +++
 include/linux/posix_acl_xattr.h |   5 +-
 include/linux/xattr.h           |  19 +++++-
 mm/shmem.c                      |   4 --
 34 files changed, 292 insertions(+), 257 deletions(-)
---
base-commit: ab072681eabe1ce0a9a32d4baa1a27a2d046bc4a
change-id: 20230125-fs-acl-remove-generic-xattr-handlers-4cfed8558d88

