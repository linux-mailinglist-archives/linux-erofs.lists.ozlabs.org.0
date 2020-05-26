Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B38A1E1E40
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 11:20:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WT2G5XW7zDqM6
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 19:20:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=163.53.93.243;
 helo=sender2-op-o12.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.a=rsa-sha256 header.s=zohomail header.b=YUI5ylJt; 
 dkim-atps=neutral
X-Greylist: delayed 926 seconds by postgrey-1.36 at bilbo;
 Tue, 26 May 2020 19:19:58 AEST
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn
 [163.53.93.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WT2614JLzDqLj
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 19:19:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1590483849; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=USeBVu/bvtGeDkg026uWCUMZrI3edwrWG7z34M6iP5hCtv2BElyaIHSU8+TVQgnMYDNRuRvKt3KPZN08p1qR6UqsTdICr5g/7bz1C15H96I+zmTH4LVNBg49BYjP1Yjih+0LkkutqaZawSnzrNI1rmjceHop8wvy83iZwj8I3nY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1590483849;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=xlBwhwKGwlsqxx/x/kwyFFMnXB0dbMpYLqHLYq6ZhQA=; 
 b=L5W03+B6rKn+F+5kI79B3Kang8HrRHoWJWVT9xlfIZskvtUaplyJvh5hV/2yDjF5bhQaorAnrUhjTa/Ex9/MV3nvdHNjvIa+d2SIWfn83YwibXdWXE7+JKmrPcgsMvUM1wV01D3hwekMN1EPDqtgT5fLym5Rc6gU2D3fpUUX4fU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=mykernel.net;
 spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
 dmarc=pass header.from=<cgxu519@mykernel.net>
 header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590483849; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=xlBwhwKGwlsqxx/x/kwyFFMnXB0dbMpYLqHLYq6ZhQA=;
 b=YUI5ylJtzDS1tQpj+NO5cAHkORrb4roeZYmY+8pr0aI3tiytzYPtZlGZNicyatfW
 XLTpEtixGM8BvdrgsYPfZgJN6tz/6FYOikJ5ln1BnduXbtlbinIDbLoj11TlkF5EFdn
 dFUOGHUXlJfqkTxi1Ux9rhny0sEAi9JmJlpxjNlo=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 159048384629685.44766971779507;
 Tue, 26 May 2020 17:04:06 +0800 (CST)
From: Chengguang Xu <cgxu519@mykernel.net>
To: xiang@kernel.org,
	chao@kernel.org
Message-ID: <20200526090343.22794-1-cgxu519@mykernel.net>
Subject: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
Date: Tue, 26 May 2020 17:03:43 +0800
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

Define erofs_listxattr and erofs_xattr_handlers to NULL when
CONFIG_EROFS_FS_XATTR is not enabled, then we can remove many
ugly ifdef macros in the code.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
Only compile tested.

 fs/erofs/inode.c | 6 ------
 fs/erofs/namei.c | 2 --
 fs/erofs/super.c | 4 +---
 fs/erofs/xattr.h | 7 ++-----
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 3350ab65d892..7dd4bbe9674f 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -311,27 +311,21 @@ int erofs_getattr(const struct path *path, struct kst=
at *stat,
=20
 const struct inode_operations erofs_generic_iops =3D {
 =09.getattr =3D erofs_getattr,
-#ifdef CONFIG_EROFS_FS_XATTR
 =09.listxattr =3D erofs_listxattr,
-#endif
 =09.get_acl =3D erofs_get_acl,
 };
=20
 const struct inode_operations erofs_symlink_iops =3D {
 =09.get_link =3D page_get_link,
 =09.getattr =3D erofs_getattr,
-#ifdef CONFIG_EROFS_FS_XATTR
 =09.listxattr =3D erofs_listxattr,
-#endif
 =09.get_acl =3D erofs_get_acl,
 };
=20
 const struct inode_operations erofs_fast_symlink_iops =3D {
 =09.get_link =3D simple_get_link,
 =09.getattr =3D erofs_getattr,
-#ifdef CONFIG_EROFS_FS_XATTR
 =09.listxattr =3D erofs_listxattr,
-#endif
 =09.get_acl =3D erofs_get_acl,
 };
=20
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 3abbecbf73de..52f201e03c62 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -244,9 +244,7 @@ static struct dentry *erofs_lookup(struct inode *dir,
 const struct inode_operations erofs_dir_iops =3D {
 =09.lookup =3D erofs_lookup,
 =09.getattr =3D erofs_getattr,
-#ifdef CONFIG_EROFS_FS_XATTR
 =09.listxattr =3D erofs_listxattr,
-#endif
 =09.get_acl =3D erofs_get_acl,
 };
=20
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b514c67e5fc2..8e46d204a0c2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -408,10 +408,8 @@ static int erofs_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09sb->s_time_gran =3D 1;
=20
 =09sb->s_op =3D &erofs_sops;
-
-#ifdef CONFIG_EROFS_FS_XATTR
 =09sb->s_xattr =3D erofs_xattr_handlers;
-#endif
+
 =09/* set erofs default mount options */
 =09erofs_default_options(sbi);
=20
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index 50966f1c676e..e4e5093f012c 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -76,11 +76,8 @@ static inline int erofs_getxattr(struct inode *inode, in=
t index,
 =09return -EOPNOTSUPP;
 }
=20
-static inline ssize_t erofs_listxattr(struct dentry *dentry,
-=09=09=09=09      char *buffer, size_t buffer_size)
-{
-=09return -EOPNOTSUPP;
-}
+#define erofs_listxattr (NULL)
+#define erofs_xattr_handlers (NULL)
 #endif=09/* !CONFIG_EROFS_FS_XATTR */
=20
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
--=20
2.20.1


