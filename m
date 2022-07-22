Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3957D8CD
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 05:02:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LpvP61PKzz3cCC
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 13:02:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=26akv9Lw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=103.149.242.19; helo=s01.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=26akv9Lw;
	dkim-atps=neutral
X-Greylist: delayed 618 seconds by postgrey-1.36 at boromir; Fri, 22 Jul 2022 13:02:09 AEST
Received: from s01.bc.feishu.cn (s01.bc.feishu.cn [103.149.242.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpvNx2SQQz30LC
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 13:02:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1658458188;
  h=mime-version:from:date:message-id:subject:to;
 bh=ln6Ge4KsCedTGfIon0VhW7uyiwXXJmqyBlYrfqXHSII=;
 b=26akv9LwCUsaCL/NyWiQu1fGOnKQhZVv/blhmjNqHULyqrBBIpIjjyEqVWqyl1atrWA0DL
 lenfJb2XNR921qxihazbBruB8rs6+avDLGG/sP4DKCvtu7LWDPZXlvneDeSUqSWgy3SSkg
 GASDWycyEXORHf0Xm5TSH3YHk8xdyAP8SNgNCXJ7/kaq9ksUTh2vAlbxjffVIC8bqyjMJB
 dzhsbh7qdAwsqBMHSondlsMVP+P2EkpCy0i8zLGRqUYw51bfctTON+Lay5RAfVxHovU7LL
 JRUnNqDPtg2EcWzbkgWZEJGstbEByMydzjLoFhSKUtDKlJPOtb4vRhQviQcjxQ==
X-Lms-Return-Path: <lba+262da1041+06eac4+lists.ozlabs.org+huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
Content-Type: multipart/alternative;
 boundary=796b8263731b123ca9078707550b578f1630649eb2b6414e5d8b6ad13509
From: "Yue Hu" <huyue2@coolpad.com>
Date: Fri, 22 Jul 2022 10:49:37 +0800
Message-Id: <20220722024903.21550-1-huyue2@coolpad.com>
To: <linux-erofs@lists.ozlabs.org>, <huyue2@coolpad.com>, <zhangwen@coolpad.com>, <zbestahu@gmail.com>
Subject: [PATCH] erofs-utils: fix a memory leak of multiple devices
Mime-Version: 1.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--796b8263731b123ca9078707550b578f1630649eb2b6414e5d8b6ad13509
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

The memory allocated for multiple devices should be freed when to exit.
Let's add a helper to fix it since there is more than one to use it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c              | 7 ++++---
 fsck/main.c              | 7 ++++---
 fuse/main.c              | 5 +++--
 include/erofs/internal.h | 1 +
 lib/super.c              | 6 ++++++
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 40e850a..c9b3a8f 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -615,7 +615,7 @@ int main(int argc, char **argv)
 	err =3D erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
=20
 	if (!dumpcfg.totalshow) {
@@ -630,13 +630,14 @@ int main(int argc, char **argv)
=20
 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
 		usage();
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
=20
 	if (dumpcfg.show_inode)
 		erofsdump_show_fileinfo(dumpcfg.show_extent);
=20
-exit_dev_close:
+exit_put_super:
+	erofs_put_super();
 	dev_close();
 exit:
 	blob_closeall();
diff --git a/fsck/main.c b/fsck/main.c
index 5a2f659..a8f0e24 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -813,12 +813,12 @@ int main(int argc, char **argv)
 	err =3D erofs_read_superblock();
 	if (err) {
 		erofs_err("failed to read superblock");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
=20
 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
 		erofs_err("failed to verify superblock checksum");
-		goto exit_dev_close;
+		goto exit_put_super;
 	}
=20
 	err =3D erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
@@ -843,7 +843,8 @@ int main(int argc, char **argv)
 		}
 	}
=20
-exit_dev_close:
+exit_put_super:
+	erofs_put_super();
 	dev_close();
 exit:
 	blob_closeall();
diff --git a/fuse/main.c b/fuse/main.c
index 95f939e..95f7abc 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -295,11 +295,12 @@ int main(int argc, char *argv[])
 	ret =3D erofs_read_superblock();
 	if (ret) {
 		fprintf(stderr, "failed to read erofs super block\n");
-		goto err_dev_close;
+		goto err_put_super;
 	}
=20
 	ret =3D fuse_main(args.argc, args.argv, &erofs_ops, NULL);
-err_dev_close:
+err_put_super:
+	erofs_put_super();
 	blob_closeall();
 	dev_close();
 err_fuse_free_args:
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 6a70f11..48498fe 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -318,6 +318,7 @@ struct erofs_map_dev {
=20
 /* super.c */
 int erofs_read_superblock(void);
+void erofs_put_super(void);
=20
 /* namei.c */
 int erofs_read_inode_from_disk(struct erofs_inode *vi);
diff --git a/lib/super.c b/lib/super.c
index f486eb7..913d2fb 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -109,3 +109,9 @@ int erofs_read_superblock(void)
 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return erofs_init_devices(&sbi, dsb);
 }
+
+void erofs_put_super(void)
+{
+	if (sbi.devs)
+		free(sbi.devs);
+}
--=20
2.17.1
--796b8263731b123ca9078707550b578f1630649eb2b6414e5d8b6ad13509
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>The memory allocated for multiple devices should be freed when to exit.
<br>Let's add a helper to fix it since there is more than one to use it.
<br>
<br>Signed-off-by: Yue Hu <huyue2@coolpad.com>
<br>---
<br> dump/main.c              | 7 ++++---
<br> fsck/main.c              | 7 ++++---
<br> fuse/main.c              | 5 +++--
<br> include/erofs/internal.h | 1 +
<br> lib/super.c              | 6 ++++++
<br> 5 files changed, 18 insertions(+), 8 deletions(-)
<br>
<br>diff --git a/dump/main.c b/dump/main.c
<br>index 40e850a..c9b3a8f 100644
<br>--- a/dump/main.c
<br>+++ b/dump/main.c
<br>@@ -615,7 +615,7 @@ int main(int argc, char **argv)
<br> 	err =3D erofs_read_superblock();
<br> 	if (err) {
<br> 		erofs_err("failed to read superblock");
<br>-		goto exit_dev_close;
<br>+		goto exit_put_super;
<br> 	}
<br>=20
<br> 	if (!dumpcfg.totalshow) {
<br>@@ -630,13 +630,14 @@ int main(int argc, char **argv)
<br>=20
<br> 	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
<br> 		usage();
<br>-		goto exit_dev_close;
<br>+		goto exit_put_super;
<br> 	}
<br>=20
<br> 	if (dumpcfg.show_inode)
<br> 		erofsdump_show_fileinfo(dumpcfg.show_extent);
<br>=20
<br>-exit_dev_close:
<br>+exit_put_super:
<br>+	erofs_put_super();
<br> 	dev_close();
<br> exit:
<br> 	blob_closeall();
<br>diff --git a/fsck/main.c b/fsck/main.c
<br>index 5a2f659..a8f0e24 100644
<br>--- a/fsck/main.c
<br>+++ b/fsck/main.c
<br>@@ -813,12 +813,12 @@ int main(int argc, char **argv)
<br> 	err =3D erofs_read_superblock();
<br> 	if (err) {
<br> 		erofs_err("failed to read superblock");
<br>-		goto exit_dev_close;
<br>+		goto exit_put_super;
<br> 	}
<br>=20
<br> 	if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
<br> 		erofs_err("failed to verify superblock checksum");
<br>-		goto exit_dev_close;
<br>+		goto exit_put_super;
<br> 	}
<br>=20
<br> 	err =3D erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
<br>@@ -843,7 +843,8 @@ int main(int argc, char **argv)
<br> 		}
<br> 	}
<br>=20
<br>-exit_dev_close:
<br>+exit_put_super:
<br>+	erofs_put_super();
<br> 	dev_close();
<br> exit:
<br> 	blob_closeall();
<br>diff --git a/fuse/main.c b/fuse/main.c
<br>index 95f939e..95f7abc 100644
<br>--- a/fuse/main.c
<br>+++ b/fuse/main.c
<br>@@ -295,11 +295,12 @@ int main(int argc, char *argv[])
<br> 	ret =3D erofs_read_superblock();
<br> 	if (ret) {
<br> 		fprintf(stderr, "failed to read erofs super block\n");
<br>-		goto err_dev_close;
<br>+		goto err_put_super;
<br> 	}
<br>=20
<br> 	ret =3D fuse_main(args.argc, args.argv, &erofs_ops, NULL);
<br>-err_dev_close:
<br>+err_put_super:
<br>+	erofs_put_super();
<br> 	blob_closeall();
<br> 	dev_close();
<br> err_fuse_free_args:
<br>diff --git a/include/erofs/internal.h b/include/erofs/internal.h
<br>index 6a70f11..48498fe 100644
<br>--- a/include/erofs/internal.h
<br>+++ b/include/erofs/internal.h
<br>@@ -318,6 +318,7 @@ struct erofs_map_dev {
<br>=20
<br> /* super.c */
<br> int erofs_read_superblock(void);
<br>+void erofs_put_super(void);
<br>=20
<br> /* namei.c */
<br> int erofs_read_inode_from_disk(struct erofs_inode *vi);
<br>diff --git a/lib/super.c b/lib/super.c
<br>index f486eb7..913d2fb 100644
<br>--- a/lib/super.c
<br>+++ b/lib/super.c
<br>@@ -109,3 +109,9 @@ int erofs_read_superblock(void)
<br> 	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
<br> 	return erofs_init_devices(&sbi, dsb);
<br> }
<br>+
<br>+void erofs_put_super(void)
<br>+{
<br>+	if (sbi.devs)
<br>+		free(sbi.devs);
<br>+}
<br>--=20
<br>2.17.1</p><meta data-version=3D"editor_version_1.2.11"/><div data-zone-=
id=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"white-space: pre=
-wrap; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">------=E6=9C=
=BA=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=89=80=
=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=B8=BA=E9=85=B7=E6=B4=BE=E6=9C=BA=E5=
=AF=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=B8=94=E5=8F=97=E5=88=B0=E6=B3=95=E5=
=BE=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=
=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=
=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=94=B6=E8=80=85=EF=BC=8C=E6=82=A8=E4=
=B8=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=8C=E4=BC=
=A0=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E8=AF=A5=
=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=
=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E5=B7=B2=E7=BB=8F=E8=AF=
=AF=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=9F=A5=E6=88=91=E4=BB=AC=E5=B9=B6=E5=
=88=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E3=80=82 CONFI=
DENTIAL: This e-mail message contains information of Coolpad that is confid=
ential and which is subject to legal privilege.If you are not the intended =
recipient as indicated above,you must not peruse,use, disseminate,distribut=
e or copy any information contained in this message.If you have received th=
is message in error, please notify us and delete the original message immed=
iately.
</div><div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" styl=
e=3D"white-space: pre-wrap; margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;">------ =E7=94=B3=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E7=8E=B0=E5=86=85=E5=AE=B9=EF=BC=8C=E4=BB=85=E4=BD=9C=E4=B8=BA=E6=88=
=91=E4=BB=AC=E4=B9=8B=E9=97=B4=E5=B0=B1=E5=90=88=E4=BD=9C=E7=9A=84=E4=BA=8B=
=E5=AE=9C=E8=BF=9B=E8=A1=8C=E7=9A=84=E4=BA=A4=E6=B5=81=E3=80=81=E6=B2=9F=E9=
=80=9A=E3=80=81=E6=B4=BD=E8=B0=88=E3=80=81=E5=95=86=E8=AE=AE=EF=BC=8C=E4=B8=
=8D=E4=BD=9C=E4=B8=BA=E5=8D=8F=E8=AE=AE=E6=88=96=E6=89=BF=E8=AF=BA=EF=BC=8C=
=E4=B8=80=E5=88=87=E5=8D=8F=E8=AE=AE=E5=8F=8A=E6=89=BF=E8=AF=BA=E5=BF=85=E9=
=A1=BB=E4=BB=A5=E4=B9=A6=E9=9D=A2=E6=96=87=E6=9C=AC=E7=9B=96=E7=AB=A0=E4=B8=
=BA=E5=87=86=E3=80=82 DECLARATION=EF=BC=9AAll contents of this E-mail ,are =
only regarded as the cooperation we have had between the exchanges, communi=
cation, negotiation and deliberation, not as a agreement or promise. All co=
ntracts and commitments must be  sealed shall prevail.
</div>
--796b8263731b123ca9078707550b578f1630649eb2b6414e5d8b6ad13509--
