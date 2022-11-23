Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 746ED634E8E
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 05:04:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NH6vM2PlYz3cMs
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Nov 2022 15:04:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=Ti/T9eYl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=101.36.218.34; helo=v03.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=Ti/T9eYl;
	dkim-atps=neutral
X-Greylist: delayed 612 seconds by postgrey-1.36 at boromir; Wed, 23 Nov 2022 15:04:04 AEDT
Received: from v03.bc.feishu.cn (v03.bc.feishu.cn [101.36.218.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4NH6v82Nsgz3bjW
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Nov 2022 15:04:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1669175509;
  h=mime-version:from:date:message-id:subject:to;
 bh=qB4sMM9OXlw0apugrt9C8ZUC1KdXZ7g4kbh2yZYX8P8=;
 b=Ti/T9eYlJ20+xpMVWbnErYJKusNGqh+SLJYEOjNTJrCvEzg7QFECOqA1AOJNHMOfRevDEk
 LY3VBW8+TPs2UHe6kVkrILRANDo0gnOFOeLUM42tOa1llR2KsBRTTe0ptMPoAVEguAgWB3
 efXElDWX+woCrNJpMECZE86uP6fCb+KiyhsXC1zNiQCk+LKSDwYbT0yd4RYWrEDFpJN2sk
 5oTWtT8ujxDE8PugkqXzfYDEm0JgQ22YI62kpXDIDi8RorZ+FdtoBRFwtW6U32/z4UiWqT
 QU8D0eWSlO3L3NkpRR6p7PyMAYnwsTBv7xMhyoPyoQ1Y9Ipqbu/ayTr6iOqJ4Q==
Date: Wed, 23 Nov 2022 11:51:38 +0800
Message-Id: <20221123115540.000033b3.huyue2@coolpad.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
In-Reply-To: <20221123023034.123095-1-hsiangkao@linux.alibaba.com>
References: <20221122064527.26563-1-hsiangkao@linux.alibaba.com> <20221123023034.123095-1-hsiangkao@linux.alibaba.com>
From: "Yue Hu" <huyue2@coolpad.com>
Subject: Re: [PATCH v2] erofs-utils: lib: fix missing CBLKCNT for big pcluster dedupe
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+2637d98c9+0fbb4e+lists.ozlabs.org+huyue2@coolpad.com>
Content-Type: multipart/alternative;
 boundary=ce9377aee8369dfccf3dad66ab53b7343f7cc28c78b5b01d23b1c5264ac9
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--ce9377aee8369dfccf3dad66ab53b7343f7cc28c78b5b01d23b1c5264ac9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed, 23 Nov 2022 10:30:34 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> CBLKCNT needs to be stored for big pcluster dedupe.  Otherwise,
> the decompression could fail due to incomplete compressed data.
>=20
> Reported-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Tested-by: Yue Hu <huyue2@coolpad.com>

> ---
> changes since v1:
>  - fix potential data corruption of v1
>=20
>  lib/compress.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/compress.c b/lib/compress.c
> index 17b3213..8f4c63a 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -186,12 +186,22 @@ static int z_erofs_compress_dedupe(struct erofs_ino=
de *inode,
>  		if (z_erofs_dedupe_match(&dctx))
>  			break;
> =20
> +		delta =3D ctx->queue + ctx->head - dctx.cur;
> +		/*
> +		 * For big pcluster dedupe, leave two indices at least to store
> +		 * CBLKCNT as the first step.  Even laterly, an one-block
> +		 * decompresssion could be done as another try in practice.
> +		 */
> +		if (dctx.e.compressedblks > 1 &&
> +		    (ctx->clusterofs + ctx->e.length - delta) % EROFS_BLKSIZ +
> +			dctx.e.length < 2 * EROFS_BLKSIZ)
> +			break;
> +
>  		/* fall back to noncompact indexes for deduplication */
>  		inode->z_advise &=3D ~Z_EROFS_ADVISE_COMPACTED_2B;
>  		inode->datalayout =3D EROFS_INODE_FLAT_COMPRESSION_LEGACY;
>  		erofs_sb_set_dedupe();
> =20
> -		delta =3D ctx->queue + ctx->head - dctx.cur;
>  		if (delta) {
>  			DBG_BUGON(delta < 0);
>  			DBG_BUGON(!ctx->e.length);
--ce9377aee8369dfccf3dad66ab53b7343f7cc28c78b5b01d23b1c5264ac9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>On Wed, 23 Nov 2022 10:30:34 +0800
<br>Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
<br>
<br>> CBLKCNT needs to be stored for big pcluster dedupe.  Otherwise,
<br>> the decompression could fail due to incomplete compressed data.
<br>>=20
<br>> Reported-by: Yue Hu <huyue2@coolpad.com>
<br>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
<br>
<br>Tested-by: Yue Hu <huyue2@coolpad.com>
<br>
<br>> ---
<br>> changes since v1:
<br>>  - fix potential data corruption of v1
<br>>=20
<br>>  lib/compress.c | 12 +++++++++++-
<br>>  1 file changed, 11 insertions(+), 1 deletion(-)
<br>>=20
<br>> diff --git a/lib/compress.c b/lib/compress.c
<br>> index 17b3213..8f4c63a 100644
<br>> --- a/lib/compress.c
<br>> +++ b/lib/compress.c
<br>> @@ -186,12 +186,22 @@ static int z_erofs_compress_dedupe(struct erofs=
_inode *inode,
<br>>  		if (z_erofs_dedupe_match(&dctx))
<br>>  			break;
<br>> =20
<br>> +		delta =3D ctx->queue + ctx->head - dctx.cur;
<br>> +		/*
<br>> +		 * For big pcluster dedupe, leave two indices at least to store
<br>> +		 * CBLKCNT as the first step.  Even laterly, an one-block
<br>> +		 * decompresssion could be done as another try in practice.
<br>> +		 */
<br>> +		if (dctx.e.compressedblks > 1 &&
<br>> +		    (ctx->clusterofs + ctx->e.length - delta) % EROFS_BLKSIZ +
<br>> +			dctx.e.length < 2 * EROFS_BLKSIZ)
<br>> +			break;
<br>> +
<br>>  		/* fall back to noncompact indexes for deduplication */
<br>>  		inode->z_advise &=3D ~Z_EROFS_ADVISE_COMPACTED_2B;
<br>>  		inode->datalayout =3D EROFS_INODE_FLAT_COMPRESSION_LEGACY;
<br>>  		erofs_sb_set_dedupe();
<br>> =20
<br>> -		delta =3D ctx->queue + ctx->head - dctx.cur;
<br>>  		if (delta) {
<br>>  			DBG_BUGON(delta < 0);
<br>>  			DBG_BUGON(!ctx->e.length);</p><meta data-version=3D"editor_versio=
n_1.2.11"/><div data-zone-id=3D"0" data-line-index=3D"0" data-line=3D"true"=
 style=3D"white-space: pre-wrap; margin-top: 4px; margin-bottom: 4px; line-=
height: 1.6;">------=E6=9C=BA=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=E5=AD=90=
=E9=82=AE=E4=BB=B6=E6=89=80=E5=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=B8=BA=E9=
=85=B7=E6=B4=BE=E6=9C=BA=E5=AF=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=B8=94=E5=
=8F=97=E5=88=B0=E6=B3=95=E5=BE=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=
=82=E6=9E=9C=E6=82=A8=E4=B8=8D=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=E7=94=B5=
=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=94=B6=E8=
=80=85=EF=BC=8C=E6=82=A8=E4=B8=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=8C=E4=BD=
=BF=E7=94=A8=EF=BC=8C=E4=BC=A0=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=E6=88=96=
=E5=A4=8D=E5=88=B6=E8=AF=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=
=9A=84=E4=BB=BB=E4=BD=95=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=
=A8=E5=B7=B2=E7=BB=8F=E8=AF=AF=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=9F=A5=E6=
=88=91=E4=BB=AC=E5=B9=B6=E5=88=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=90=E9=82=
=AE=E4=BB=B6=E3=80=82 CONFIDENTIAL: This e-mail message contains informatio=
n of Coolpad that is confidential and which is subject to legal privilege.I=
f you are not the intended recipient as indicated above,you must not peruse=
,use, disseminate,distribute or copy any information contained in this mess=
age.If you have received this message in error, please notify us and delete=
 the original message immediately.
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
--ce9377aee8369dfccf3dad66ab53b7343f7cc28c78b5b01d23b1c5264ac9--
