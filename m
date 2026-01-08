Return-Path: <linux-erofs+bounces-1722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F8D04C3C
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:13:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBMF69Vqz2xGY;
	Fri, 09 Jan 2026 04:13:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892425;
	cv=none; b=KbfKD8tIvRoj3msc1/5sBZSpgROlYT9IlZIrQmTmqRSdckm/T2Lz//vG0macm4Lvdvebb+Y2RrXoUoZq4rpoBqrPuDe1Or6VAoAf9apFnRrwwYLzn0Ylh1t0DDLN8QJX9fl2gEUX1EyEtlvsFxCZC8gSYiLDc8wFaNq+o2vRXDBBrDXWwQqUj/MxjnZgU9+yiz5fVUB59sTxu6OdBj/mbJtMtX+5rnUhBg6ay4rYKShTOasrZGZSQJ/UAGcEUl4epkyQwiyXmpvc6FVLXxk00VHllgWAWINdRYqx+ju+xcZgZ+kksDSB+rzUlqHDAV0XfcF3R32Ds8fQkcmg/oxG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892425; c=relaxed/relaxed;
	bh=UORsbIn2DznlIyVO6qJ4lZnfdd6OvlDWHFK9Nh7h01Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JUVANeTep9lhFBS+cv4JUFy9a4zxaQU/zgQB6577e9Trm423RYNZaWjapbrsgHY/TyD+WTu1H2tD0VjLc3JWrCNnujJ3lvw8df1IckBxOxk4zQM10wQIFGQbQALj+VpFEwQ+1RkLbzAoHAbOlQamo8q7uNdMcFX3+4rFy07o5udJBp1Ct41ZWW3jLtw/x0nPsDLf3QnN9LcHu0Fppn519ZWEUmgRO7ehJfBINeKObX5WoaEU/1VSfQtx4PGlLX1iquC980b+YurIjQWa8xLeQ4IbMtovjbKShszYNrDyg4r72cY12K/iRzL3X1O0zbqFYWl3u5cyKjRI1Fev1Ql1Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sMLaSOnD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sMLaSOnD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBMF0cylz2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:13:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C545434D8;
	Thu,  8 Jan 2026 17:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D4C116C6;
	Thu,  8 Jan 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892422;
	bh=Oo05LcV8B4ObeCq3rrJEiTXLheQXnmVPy6EWKbJpWYY=;
	h=From:Subject:Date:To:Cc:From;
	b=sMLaSOnD+Lb34DqAv4+l1KIbr+z8ayCyntGOlgw1db2MmJQhOdIkWIrWeRcdIdKWS
	 S/zZ1aldQOEJt+M4gNNpgwr8njA+kY57ueYyzw69x62DB2y8ZdsNP0n7O2v8cGXFpi
	 Rqu92gjEkqK5VGOhWZChnPJ4VjzfqdTkQ5Pb550IY/fptv7JSzPczGvy4XqdhjJ5sA
	 l0a72cVjGZa+Jo45PjkXSM0qO0LbjExULNMK8lG/BaoQzQWxdDW9x19wy15yv5tDSd
	 cgmarBCaj12d1puK7fN4kFXY72IDiwfR7r7m0gQbOzLxetlMXGRug7hJ9c8PA8IU9d
	 DvLLUdQgizFew==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Date: Thu, 08 Jan 2026 12:12:55 -0500
Message-Id: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBRG4VfRXbs1pmY0XkUWgx+3hOZKSt7dZ
 PktznlIkQRKTfFQwiUq+5ZRlQUNS9xmsIzZZI31pjI1K84VUcGerWEbAnrngxtcpNwcCZPc/6/
 t3vcDWdlQRF8AAAA=
X-Change-ID: 20260107-setlease-6-20-299eb5695c5a
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Oo05LcV8B4ObeCq3rrJEiTXLheQXnmVPy6EWKbJpWYY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+WzBv3HT+d1Fmmb4WJNh3VjXhmOx5cl7E+0X
 98Wl1lzspuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lswAKCRAADmhBGVaC
 FYaFD/49dAmx6k9hJ/TPfTiX5MGWuIm/Bb6hiQ3wYU8z7D5mM7bDA0JzI4uNC4IC4k7DtSaeW+t
 HW0GXcfmOc/2RNtvIURgrbNIKtr02nzAYWch3n94PXAZNhcygbpjjekIxTTpfmIp6Q3JR0VXmgj
 FPOGz1G9+W5jTp8JkJCS7rK3QI1nR+/TS195gfflVDsyGMEA252ZaGAWOXQucH8aMmL3SmL4Sw3
 SQIvSgZPcin8ppqmJM+SMqpJjims+KsIvBeiZ5RAX2koRTuCEpaimiM9mi7uvZTjn9qDUXstfCl
 j6vVSQyDrhB6qaSgIjGD31+J/UHY4GmSW7EXpo9hwYld6pajZ7JmgvQYyorZSADZQ1buPawi578
 2S+AKCmbogE/0eu1rDPfSf7+pgKL0PHCFCUHmNfl5kyVzMdQ5fEfhZa0HY103UgMpyn9CWEA426
 pzh9DY5Q7TVq+/Ml0m/iauvJ1NRfOvo1XZ6qodWqnFZEO7/lzreoUi45cpyDZzLiSQuca/VsCjV
 6m4pCflt/f0Ao2+yx3/gP9YDsugBwKA59y5BZvauge564wraKaWFFPDoPNSNY9aww3L7L1579eX
 mhWasindF/bS2ZuJ3k3obfEbzGrzZnRus+vFi5LvzlZIlOMMPaJ/pY9IJPoJjhxxacuSawLXV7W
 2iGXbdzTGfcW99w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Yesterday, I sent patches to fix how directory delegation support is
handled on filesystems where the should be disabled [1]. That set is
appropriate for v6.19. For v7.0, I want to make lease support be more
opt-in, rather than opt-out:

For historical reasons, when ->setlease() file_operation is set to NULL,
the default is to use the kernel-internal lease implementation. This
means that if you want to disable them, you need to explicitly set the
->setlease() file_operation to simple_nosetlease() or the equivalent.

This has caused a number of problems over the years as some filesystems
have inadvertantly allowed leases to be acquired simply by having left
it set to NULL. It would be better if filesystems had to opt-in to lease
support, particularly with the advent of directory delegations.

This series has sets the ->setlease() operation in a pile of existing
local filesystems to generic_setlease() and then changes
kernel_setlease() to return -EINVAL when the setlease() operation is not
set.

With this change, new filesystems will need to explicitly set the
->setlease() operations in order to provide lease and delegation
support.

I mainly focused on filesystems that are NFS exportable, since NFS and
SMB are the main users of file leases, and they tend to end up exporting
the same filesystem types. Let me know if I've missed any.

[1]: https://lore.kernel.org/linux-fsdevel/20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (24):
      fs: add setlease to generic_ro_fops and read-only filesystem directory operations
      affs: add setlease file operation
      btrfs: add setlease file operation
      erofs: add setlease file operation
      ext2: add setlease file operation
      ext4: add setlease file operation
      exfat: add setlease file operation
      f2fs: add setlease file operation
      fat: add setlease file operation
      gfs2: add a setlease file operation
      jffs2: add setlease file operation
      jfs: add setlease file operation
      nilfs2: add setlease file operation
      ntfs3: add setlease file operation
      ocfs2: add setlease file operation
      orangefs: add setlease file operation
      overlayfs: add setlease file operation
      squashfs: add setlease file operation
      tmpfs: add setlease file operation
      udf: add setlease file operation
      ufs: add setlease file operation
      xfs: add setlease file operation
      filelock: default to returning -EINVAL when ->setlease operation is NULL
      fs: remove simple_nosetlease()

 Documentation/filesystems/porting.rst |  9 +++++++++
 Documentation/filesystems/vfs.rst     |  9 ++++++---
 fs/9p/vfs_dir.c                       |  2 --
 fs/9p/vfs_file.c                      |  2 --
 fs/affs/dir.c                         |  2 ++
 fs/affs/file.c                        |  2 ++
 fs/befs/linuxvfs.c                    |  2 ++
 fs/btrfs/file.c                       |  2 ++
 fs/btrfs/inode.c                      |  2 ++
 fs/ceph/dir.c                         |  2 --
 fs/ceph/file.c                        |  1 -
 fs/cramfs/inode.c                     |  2 ++
 fs/efs/dir.c                          |  2 ++
 fs/erofs/data.c                       |  2 ++
 fs/erofs/dir.c                        |  2 ++
 fs/exfat/dir.c                        |  2 ++
 fs/exfat/file.c                       |  2 ++
 fs/ext2/dir.c                         |  2 ++
 fs/ext2/file.c                        |  2 ++
 fs/ext4/dir.c                         |  2 ++
 fs/ext4/file.c                        |  2 ++
 fs/f2fs/dir.c                         |  2 ++
 fs/f2fs/file.c                        |  2 ++
 fs/fat/dir.c                          |  2 ++
 fs/fat/file.c                         |  2 ++
 fs/freevxfs/vxfs_lookup.c             |  2 ++
 fs/fuse/dir.c                         |  1 -
 fs/gfs2/file.c                        |  3 +--
 fs/isofs/dir.c                        |  2 ++
 fs/jffs2/dir.c                        |  2 ++
 fs/jffs2/file.c                       |  2 ++
 fs/jfs/file.c                         |  2 ++
 fs/jfs/namei.c                        |  2 ++
 fs/libfs.c                            | 20 ++------------------
 fs/locks.c                            |  3 +--
 fs/nfs/dir.c                          |  1 -
 fs/nfs/file.c                         |  1 -
 fs/nilfs2/dir.c                       |  3 ++-
 fs/nilfs2/file.c                      |  2 ++
 fs/ntfs3/dir.c                        |  3 +++
 fs/ntfs3/file.c                       |  3 +++
 fs/ocfs2/file.c                       |  5 +++++
 fs/orangefs/dir.c                     |  4 +++-
 fs/orangefs/file.c                    |  1 +
 fs/overlayfs/file.c                   |  2 ++
 fs/overlayfs/readdir.c                |  2 ++
 fs/qnx4/dir.c                         |  2 ++
 fs/qnx6/dir.c                         |  2 ++
 fs/read_write.c                       |  2 ++
 fs/smb/client/cifsfs.c                |  1 -
 fs/squashfs/dir.c                     |  2 ++
 fs/squashfs/file.c                    |  4 +++-
 fs/udf/dir.c                          |  2 ++
 fs/udf/file.c                         |  2 ++
 fs/ufs/dir.c                          |  2 ++
 fs/ufs/file.c                         |  2 ++
 fs/vboxsf/dir.c                       |  1 -
 fs/vboxsf/file.c                      |  1 -
 fs/xfs/xfs_file.c                     |  3 +++
 include/linux/fs.h                    |  1 -
 mm/shmem.c                            |  2 ++
 61 files changed, 116 insertions(+), 42 deletions(-)
---
base-commit: 731ce71a6c8adb8b8f873643beacaeedc1564500
change-id: 20260107-setlease-6-20-299eb5695c5a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


