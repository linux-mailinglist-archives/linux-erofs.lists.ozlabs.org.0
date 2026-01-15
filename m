Return-Path: <linux-erofs+bounces-1887-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 89891D26BC9
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVnd6lh2z2yFm;
	Fri, 16 Jan 2026 04:48:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499285;
	cv=none; b=VyfK4IPTX/E8OH/2MR0u6EMu6A1ViCHUBb6A4JjYjXtcHXl1efUPaAWpHEiSqIk40IZ4gRyMcQg/OUFCXu8zcvLuv7D+ND2yPvrMVNu2jHLwu+1uKL9GE+ZpFH+EwK8gaXCo4Te1P6Izrf5pt2iuRPE3C33eF+U7NNdTFzwDP6yl0ndHz/POa7rJ65tBtbifkjTLRNXlfMyIPrMpZJJbXOn8d8EaxwEHCPdgtoYGjVN3urHhFii/7UcadqK/AIpZ8KbtBBcZMjT+fkiqSA75MRYVWr81Xte90ApwYTgKV6LULIyBTAnm2JbLZflDwq4gssIEZ/6vQOhpfuI0tB5k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499285; c=relaxed/relaxed;
	bh=vvXSkSgvuvBAdCYEw/mOnChggvFl3hZbp3O+rIZGmKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A4TT7AsUsxtxtoeC94k99sG77ZSXjP0KnFcnudX/9o9T0r1Ql1eO2bRleW9wk3BDtSIKft4QwJ+KKIShavR8e/cevky0gACQUkRg5CDMh0tc9Uc9MDJeq49oEWinE/LdTNKLhsBszIU/38Eq/4kC1nRfX/LibQ78EG2YJGU1aBak3ekRI9crTW94CrQjv5xbFY2x2JKC0T1ZtIemetajXs+O0rJIaTtzpsim1NCgJteybr1t5C3RAk/pweX4WO9PTnIzHXgt9kFIj/iScJYF7vkcQGyNEQnBHpygVEIiq6WtnoeiMAUSHZvtDhqjR/E0XWwkcUV4KVAQemJO2RfbEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sv2wZs8W; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sv2wZs8W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 101198 seconds by postgrey-1.37 at boromir; Fri, 16 Jan 2026 04:48:04 AEDT
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVnc6xSdz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B75441B3A;
	Thu, 15 Jan 2026 17:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A44C16AAE;
	Thu, 15 Jan 2026 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499282;
	bh=Jgrg+43s0ldgv37NKbEktTlLcn8JlZ4Z62/aDsJl2fE=;
	h=From:Subject:Date:To:Cc:From;
	b=sv2wZs8WpKeI0wpddsdCzx5FPuJfiv0htyo+0abzJrCCFK9q4146ZE28BG441jorg
	 Qo1tIee7N/1MnShJaAey62z4lfLsmhIXMLkZMLSEMlmEhDwdr2qsSYaFrVZPxb77cF
	 i3aSCJl0gIo+M7JBkTxdAg7VvCpYnqzbG7R2Ohvdin1j12CbILNcI3w/DNWL7f9jbe
	 DBukUrRoDDoNluFnmhgrGDxPlIkvSUMcrjLUpjjJ1T7VqZOaz0YENa8tKyKu6CaX47
	 KOmCoEsEsYyGz5wli5gj5MnM7JWLaAPtkHWHG4sSZOBoGuAC5psY5ECRaP4FTl6A5n
	 5/8prxsy2NgBw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/29] fs: require filesystems to explicitly opt-in to nfsd
 export support
Date: Thu, 15 Jan 2026 12:47:31 -0500
Message-Id: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBMcyaKuEi0kx5qNhhMRiHdPW
 r7F/wWEMpPA0hXI9LBwig3Yd7CfLh6k2DeD0WbUiIOi90r5DqJiEK/QWLR6MjS7GVpzZQr8/r9
 1q/UDI1yMc18AAAA=
X-Change-ID: 20260114-exportfs-nfsd-12515072e9a9
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Jgrg+43s0ldgv37NKbEktTlLcn8JlZ4Z62/aDsJl2fE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaSg9V9dGf/ZUraP4b1Pq5RtyBLPKPHN6qkaxn
 8S9nULay2GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoPQAKCRAADmhBGVaC
 FU2HEACr1dom+IcUewiIOnk7xEbGWbqcKSzh/u8bfD7LubFnaY7GNt5n6p3PgjmIFAgE/Lfk2v+
 Do5G648LuI9AgNBffpq3Rou0EGw9+wxjXyRaSItdEWDshxbLnMS5D2dtmXeB4x2mF6Xo8wPho9c
 ncOUEwjZL61T/UOLGxpSOojluUsBXenixeUCTgPYWeDSKZSd1PrbfIIvNT3wwmmIpQAv0lasork
 Zl4qe+BiG1G0IPtketcJGFYIgXNp76Hnll+P8/EqVrDG+4nPn8MGAy3xqMQyq4+dCzENDy0DmS3
 AJMlGepQMU/y0tAmS4R1R2P27jpCMwpBj8HhdNo0JThYFgmCYeGwPxsTOTNG8XmrWn4zye1BAl9
 Oz/kXfQnSFwMzweZ9J7fT16IxYVpb12aXvYdwcnZ+IE/Suh66Nx8n52d4tuSwNkKYQf6d05G1bU
 I+lA7kAnXjIh/p4o4pNnALEld2Rn49OAx/yxtN5VOYrjpBIK6yRyYTXjz0PnCRFsn3V65+xhhPM
 CJTSVK9ZzU4nspmDSK5hdCvs1pnGqYR9dLF7QV60eUBpiDYnfsiOG+KZmrsLuWOd2/7/8V8giqf
 SBbuLOXJmeBQ1IbyaaZbzwsaK+7PAPY92+HTJ8jsZ6+vQhAXLJ40Y1ug6UAG1bGirhSbW+Ru3JH
 SgoO6jBDoISNHpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In recent years, a number of filesystems that can't present stable
filehandles have grown struct export_operations. They've mostly done
this for local use-cases (enabling open_by_handle_at() and the like).
Unfortunately, having export_operations is generally sufficient to make
a filesystem be considered exportable via nfsd, but that requires that
the server present stable filehandles.

This patchset declares a new EXPORT_OP_STABLE_HANDLES flag, adds it to
all of the filesystems that have stable filehandles, and then adds a
check in nfsd to ensure that that flag is set for any filesystem to
which it has been presented a handle. When a filesystem doesn't have
this flag, it will treat the filehandle as stale.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (29):
      exportfs: add new EXPORT_OP_STABLE_HANDLES flag
      tmpfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ext4: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ext2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      erofs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      efs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      xfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ceph: add EXPORT_OP_STABLE_HANDLES flag to export operations
      btrfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      befs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ufs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      udf: add EXPORT_OP_STABLE_HANDLES flag to export operations
      affs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      squashfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      smb/client: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
      orangefs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ocfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ntfs3: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      jfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      jffs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      isofs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      gfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      fuse: add EXPORT_OP_STABLE_HANDLES flag to export operations
      fat: add EXPORT_OP_STABLE_HANDLES flag to export operations
      f2fs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nfsd: only allow filesystems that set EXPORT_OP_STABLE_HANDLES

 fs/affs/namei.c          |  1 +
 fs/befs/linuxvfs.c       |  1 +
 fs/btrfs/export.c        |  1 +
 fs/ceph/export.c         |  1 +
 fs/efs/super.c           |  1 +
 fs/erofs/super.c         |  1 +
 fs/ext2/super.c          |  1 +
 fs/ext4/super.c          |  1 +
 fs/f2fs/super.c          |  1 +
 fs/fat/nfs.c             |  2 ++
 fs/fuse/inode.c          |  2 ++
 fs/gfs2/export.c         |  1 +
 fs/isofs/export.c        |  1 +
 fs/jffs2/super.c         |  1 +
 fs/jfs/super.c           |  1 +
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/nfsfh.c          |  4 ++++
 fs/nilfs2/namei.c        |  1 +
 fs/ntfs3/super.c         |  1 +
 fs/ocfs2/export.c        |  1 +
 fs/orangefs/super.c      |  1 +
 fs/overlayfs/export.c    |  2 ++
 fs/smb/client/export.c   |  1 +
 fs/squashfs/export.c     |  3 ++-
 fs/udf/namei.c           |  1 +
 fs/ufs/super.c           |  1 +
 fs/xfs/xfs_export.c      |  1 +
 include/linux/exportfs.h | 16 +++++++++-------
 mm/shmem.c               |  1 +
 29 files changed, 45 insertions(+), 9 deletions(-)
---
base-commit: c537e12daeecaecdcd322c56a5f70659d2de7bde
change-id: 20260114-exportfs-nfsd-12515072e9a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


