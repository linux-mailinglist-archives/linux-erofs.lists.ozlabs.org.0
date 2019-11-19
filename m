Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D64DE1023A4
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 12:53:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HPP135q7zDqf5
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 22:53:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=124.251.121.247;
 helo=sender2.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.b="HRei90L1"; dkim-atps=neutral
Received: from sender2.zoho.com.cn (sender3-of-o52.zoho.com.cn
 [124.251.121.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HPNr4fNtzDqSJ
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2019 22:53:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574163487; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 l=2406; bh=/8ArbtqDhV7Au/5Cc+zTy1j2h2/Ou6c99jthu04QpZw=;
 b=HRei90L1k8QzHJ08yd0O913RhsZtA69Xp235uxxFllrmAiXRtI1k/+XybCNChLUq
 eEI+dZopyLUfXzFsz/vFYZnupLtStmX0nTLj/zf4s7yaV2y6R1Jp+9eIILVwniGkccZ
 /0F93szSdIlpflgFWbw1rwIGP4nIQZj3efXEwR8c=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 1574163483865672.5481841663604;
 Tue, 19 Nov 2019 19:38:03 +0800 (CST)
From: Chengguang Xu <cgxu519@mykernel.net>
To: xiang@kernel.org,
	chao@kernel.org
Message-ID: <20191119113744.11635-1-cgxu519@mykernel.net>
Subject: [PATCH] erofs: add error handling for erofs_fill_super()
Date: Tue, 19 Nov 2019 19:37:44 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
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
Cc: Chengguang Xu <cgxu519@mykernel.net>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There are some potential resource leaks in error case
of erofs_fill_super(), so add proper error handling
for it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/erofs/super.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e369494f2f2..06e721bd1c8c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -369,7 +369,7 @@ static int erofs_fill_super(struct super_block *sb, voi=
d *data, int silent)
 =09sb->s_fs_info =3D sbi;
 =09err =3D erofs_read_superblock(sb);
 =09if (err)
-=09=09return err;
+=09=09goto free;
=20
 =09sb->s_flags |=3D SB_RDONLY | SB_NOATIME;
 =09sb->s_maxbytes =3D MAX_LFS_FILESIZE;
@@ -385,7 +385,7 @@ static int erofs_fill_super(struct super_block *sb, voi=
d *data, int silent)
=20
 =09err =3D erofs_parse_options(sb, data);
 =09if (err)
-=09=09return err;
+=09=09goto free;
=20
 =09if (test_opt(sbi, POSIX_ACL))
 =09=09sb->s_flags |=3D SB_POSIXACL;
@@ -398,29 +398,44 @@ static int erofs_fill_super(struct super_block *sb, v=
oid *data, int silent)
=20
 =09/* get the root inode */
 =09inode =3D erofs_iget(sb, ROOT_NID(sbi), true);
-=09if (IS_ERR(inode))
-=09=09return PTR_ERR(inode);
+=09if (IS_ERR(inode)) {
+=09=09err =3D PTR_ERR(inode);
+=09=09goto free;
+=09}
=20
 =09if (!S_ISDIR(inode->i_mode)) {
 =09=09erofs_err(sb, "rootino(nid %llu) is not a directory(i_mode %o)",
 =09=09=09  ROOT_NID(sbi), inode->i_mode);
 =09=09iput(inode);
-=09=09return -EINVAL;
+=09=09err =3D -EINVAL;
+=09=09goto free;
 =09}
=20
 =09sb->s_root =3D d_make_root(inode);
-=09if (!sb->s_root)
-=09=09return -ENOMEM;
+=09if (!sb->s_root) {
+=09=09err =3D -ENOMEM;
+=09=09goto free;
+=09}
=20
 =09erofs_shrinker_register(sb);
 =09/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
 =09err =3D erofs_init_managed_cache(sb);
 =09if (err)
-=09=09return err;
+=09=09goto free_root_inode;
=20
 =09erofs_info(sb, "mounted with opts: %s, root inode @ nid %llu.",
 =09=09   (char *)data, ROOT_NID(sbi));
+
 =09return 0;
+
+free_root_inode:
+=09dput(sb->s_root);
+=09sb->s_root =3D NULL;
+=09erofs_shrinker_unregister(sb);
+free:
+=09kfree(sbi);
+=09sb->s_fs_info =3D NULL;
+=09return err;
 }
=20
 static struct dentry *erofs_mount(struct file_system_type *fs_type, int fl=
ags,
--=20
2.20.1



