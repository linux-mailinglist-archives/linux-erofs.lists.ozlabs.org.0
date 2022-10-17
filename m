Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 477DC600558
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 04:43:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MrLsm13Jpz3blY
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Oct 2022 13:43:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=AjAh7xg1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=103.149.242.128; helo=lf01128.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=AjAh7xg1;
	dkim-atps=neutral
X-Greylist: delayed 614 seconds by postgrey-1.36 at boromir; Mon, 17 Oct 2022 13:43:47 AEDT
Received: from lf01128.bc.feishu.cn (lf01128.bc.feishu.cn [103.149.242.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4MrLsb4Z0gz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Oct 2022 13:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1665973896;
  h=mime-version:from:date:message-id:subject:to;
 bh=aa7ZbcPAITsIwB8iOtdx9UwpkNwd+Ecu9WDD5rQlsZU=;
 b=AjAh7xg1aZi7uH9GG3gqJKDBTB8YmgJdeh5UuCXL5yYwVw+QkjYjhuUbQVzOUFuUuMs6Zd
 Ftj841KnSvcy0qSkGOciBgJyj2DGxyDUXclprp7YAcj0E8GLj7PzY0ZkE89PNLSgY3tIiw
 vvmo9i5wqikXKSkjIxjbq661wtD9Wjx4NpZOCCeUNmyv37PUfxuf7UiSTxx+Xp26I4ie9y
 uS9X91ux0javTlXuDssg7X/JrjwcMeCHr1fnVo+oC318G/vxqR8ju6RIp13F+ClqkWPIl8
 R0idYuXjFoQ4EYshgWxryvvOMuwQnmTUdoe4rCCAkqAxudGEaAMaRmYB/famtw==
To: "Dawei Li" <set_pte_at@outlook.com>
Content-Type: multipart/alternative;
 boundary=8966b223f2fa0fd80858cd4008e67c73b6508b705b589c5f65226384dec5
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Message-Id: <20221017103439.00003b29.huyue2@coolpad.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2634cbe7e+503c0c+lists.ozlabs.org+huyue2@coolpad.com>
From: "Yue Hu" <huyue2@coolpad.com>
Date: Mon, 17 Oct 2022 10:31:26 +0800
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--8966b223f2fa0fd80858cd4008e67c73b6508b705b589c5f65226384dec5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon, 17 Oct 2022 09:55:53 +0800
Dawei Li <set_pte_at@outlook.com> wrote:

> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
>=20
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
>=20
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TY=
CP286MB2323.JPNP286.PROD.OUTLOOK.COM/
>=20
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
>=20
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  fs/erofs/fscache.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 998cd26a1b3b..fe05bc51f9f2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_cookie(=
struct super_block *sb,
>  	struct super_block *psb =3D erofs_pseudo_mnt->mnt_sb;
> =20
>  	mutex_lock(&erofs_domain_cookies_lock);
> +	spin_lock(&psb->s_inode_list_lock);
>  	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
>  		ctx =3D inode->i_private;
>  		if (!ctx || ctx->domain !=3D domain || strcmp(ctx->name, name))
>  			continue;
>  		igrab(inode);
> +		spin_unlock(&psb->s_inode_list_lock);
>  		mutex_unlock(&erofs_domain_cookies_lock);
>  		return ctx;
>  	}
> +	spin_unlock(&psb->s_inode_list_lock);
>  	ctx =3D erofs_fscache_domain_init_cookie(sb, name, need_inode);
>  	mutex_unlock(&erofs_domain_cookies_lock);
>  	return ctx;

I will make clear that this change is fscache related in title.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
--8966b223f2fa0fd80858cd4008e67c73b6508b705b589c5f65226384dec5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>On Mon, 17 Oct 2022 09:55:53 +0800
<br>Dawei Li <set_pte_at@outlook.com> wrote:
<br>
<br>> s_inodes is superblock-specific resource, which should be
<br>> protected by sb's specific lock s_inode_list_lock.
<br>>=20
<br>> v2: update the locking mechanisim to protect mutual-exclusive access
<br>> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as t=
he
<br>> reviewing comments from Jia Zhu.
<br>>=20
<br>> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA26=
9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
<br>>=20
<br>> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
<br>>=20
<br>> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
<br>> ---
<br>>  fs/erofs/fscache.c | 3 +++
<br>>  1 file changed, 3 insertions(+)
<br>>=20
<br>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
<br>> index 998cd26a1b3b..fe05bc51f9f2 100644
<br>> --- a/fs/erofs/fscache.c
<br>> +++ b/fs/erofs/fscache.c
<br>> @@ -590,14 +590,17 @@ struct erofs_fscache *erofs_domain_register_coo=
kie(struct super_block *sb,
<br>>  	struct super_block *psb =3D erofs_pseudo_mnt->mnt_sb;
<br>> =20
<br>>  	mutex_lock(&erofs_domain_cookies_lock);
<br>> +	spin_lock(&psb->s_inode_list_lock);
<br>>  	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
<br>>  		ctx =3D inode->i_private;
<br>>  		if (!ctx || ctx->domain !=3D domain || strcmp(ctx->name, name))
<br>>  			continue;
<br>>  		igrab(inode);
<br>> +		spin_unlock(&psb->s_inode_list_lock);
<br>>  		mutex_unlock(&erofs_domain_cookies_lock);
<br>>  		return ctx;
<br>>  	}
<br>> +	spin_unlock(&psb->s_inode_list_lock);
<br>>  	ctx =3D erofs_fscache_domain_init_cookie(sb, name, need_inode);
<br>>  	mutex_unlock(&erofs_domain_cookies_lock);
<br>>  	return ctx;
<br>
<br>I will make clear that this change is fscache related in title.
<br>
<br>Reviewed-by: Yue Hu <huyue2@coolpad.com></p><meta data-version=3D"edito=
r_version_1.2.11"/><div data-zone-id=3D"0" data-line-index=3D"0" data-line=
=3D"true" style=3D"white-space: pre-wrap; margin-top: 4px; margin-bottom: 4=
px; line-height: 1.6;">------=E6=9C=BA=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=
=E5=AD=90=E9=82=AE=E4=BB=B6=E6=89=80=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=
=B8=BA=E9=85=B7=E6=B4=BE=E6=9C=BA=E5=AF=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=
=B8=94=E5=8F=97=E5=88=B0=E6=B3=95=E5=BE=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=
=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=
=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=
=94=B6=E8=80=85=EF=BC=8C=E6=82=A8=E4=B8=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=
=8C=E4=BD=BF=E7=94=A8=EF=BC=8C=E4=BC=A0=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=
=E6=88=96=E5=A4=8D=E5=88=B6=E8=AF=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=
=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E5=B7=B2=E7=BB=8F=E8=AF=AF=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=
=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=
=9F=A5=E6=88=91=E4=BB=AC=E5=B9=B6=E5=88=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=
=90=E9=82=AE=E4=BB=B6=E3=80=82 CONFIDENTIAL: This e-mail message contains i=
nformation of Coolpad that is confidential and which is subject to legal pr=
ivilege.If you are not the intended recipient as indicated above,you must n=
ot peruse,use, disseminate,distribute or copy any information contained in =
this message.If you have received this message in error, please notify us a=
nd delete the original message immediately.
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
--8966b223f2fa0fd80858cd4008e67c73b6508b705b589c5f65226384dec5--
