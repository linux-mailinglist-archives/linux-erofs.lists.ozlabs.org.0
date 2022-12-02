Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC763FF51
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 05:06:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNfX93jGCz3bcN
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 15:06:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=wIrXt53E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=coolpad.com (client-ip=101.36.218.32; helo=v03.bc.feishu.cn; envelope-from=huyue2@coolpad.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=coolpad-com.20200927.dkim.feishu.cn header.i=@coolpad-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=wIrXt53E;
	dkim-atps=neutral
Received: from v03.bc.feishu.cn (v03.bc.feishu.cn [101.36.218.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4NNfX03YPLz3bTs
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Dec 2022 15:06:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=coolpad-com.20200927.dkim.feishu.cn; t=1669953871;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=AVdn/rqVP7yQxmmu0si4XRvNz/QvWYFYWEDDXcbgodw=;
 b=wIrXt53EdymOF5BKMWyPV+VrVpXv0H0j9Iff2B8tBSfhmuVyZi0YcLkEpHZeFY79Ic9dbX
 nr9LOT5zPUGgfcQzawa5BRO4tHIvKMsuhYa2U4eeVWuGx0ylCpuUkxdrnW4bbooVnWTP1y
 v+lJStwcgFYVvSUk8gey1BEN/fihcHTlKlgC4Yfpj0jH8xgTYuR13QVMlqoHYcaw8tyumt
 f4/TvmIKG+5NBMxZu41Foc4Uitf2BYR+Vum6BD9WHltM8C33h/Kfl7FV6NWTWOPMNp/mA4
 XDPBCNRPXYxnG4r9FThClKcSzQc/ggrwehS5C6qEldgQLsURadU/7x0t41JZqw==
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
Mime-Version: 1.0
Message-Id: <20221202120835.000070a2.huyue2@coolpad.com>
Content-Type: multipart/alternative;
 boundary=117e39e43e653b277d011467175ee617d32fbfec9d49851605f06844040d
Date: Fri, 02 Dec 2022 12:04:21 +0800
In-Reply-To: <20221202033327.52702-1-hsiangkao@linux.alibaba.com>
X-Lms-Return-Path: <lba+263897945+9b566a+lists.ozlabs.org+huyue2@coolpad.com>
References: <20221202033327.52702-1-hsiangkao@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
From: "Yue Hu" <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: fix inline pcluster memory leak
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
Cc: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--117e39e43e653b277d011467175ee617d32fbfec9d49851605f06844040d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri,  2 Dec 2022 11:33:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Inline pcluster should be freed right after it is decompressed.
> Otherwise inline pclusters will be leaked.
>=20
> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
> Cc: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

Thanks.

> ---
>  fs/erofs/zdata.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index ab22100be861..e14e6c32e70d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -496,7 +496,8 @@ static int z_erofs_register_pcluster(struct z_erofs_d=
ecompress_frontend *fe)
>  	struct erofs_workgroup *grp;
>  	int err;
> =20
> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> +	    !(map->m_pa >> PAGE_SHIFT)) {
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}
> @@ -1114,6 +1115,8 @@ static int z_erofs_decompress_pcluster(struct z_ero=
fs_decompress_backend *be,
>  	/* pcluster lock MUST be taken before the following line */
>  	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
>  	mutex_unlock(&pcl->lock);
> +	if (z_erofs_is_inline_pcluster(pcl))
> +		z_erofs_free_pcluster(pcl);
>  	return err;
>  }
>
--117e39e43e653b277d011467175ee617d32fbfec9d49851605f06844040d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>On Fri,  2 Dec 2022 11:33:27 +0800
<br>Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
<br>
<br>> Inline pcluster should be freed right after it is decompressed.
<br>> Otherwise inline pclusters will be leaked.
<br>>=20
<br>> Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
<br>> Fixes: cecf864d3d76 ("erofs: support inline data decompression")
<br>> Cc: Yue Hu <huyue2@yulong.com>
<br>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
<br>
<br>Reviewed-by: Yue Hu <huyue2@coolpad.com>
<br>
<br>Thanks.
<br>
<br>> ---
<br>>  fs/erofs/zdata.c | 5 ++++-
<br>>  1 file changed, 4 insertions(+), 1 deletion(-)
<br>>=20
<br>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
<br>> index ab22100be861..e14e6c32e70d 100644
<br>> --- a/fs/erofs/zdata.c
<br>> +++ b/fs/erofs/zdata.c
<br>> @@ -496,7 +496,8 @@ static int z_erofs_register_pcluster(struct z_ero=
fs_decompress_frontend *fe)
<br>>  	struct erofs_workgroup *grp;
<br>>  	int err;
<br>> =20
<br>> -	if (!(map->m_flags & EROFS_MAP_ENCODED)) {
<br>> +	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
<br>> +	    !(map->m_pa >> PAGE_SHIFT)) {
<br>>  		DBG_BUGON(1);
<br>>  		return -EFSCORRUPTED;
<br>>  	}
<br>> @@ -1114,6 +1115,8 @@ static int z_erofs_decompress_pcluster(struct z=
_erofs_decompress_backend *be,
<br>>  	/* pcluster lock MUST be taken before the following line */
<br>>  	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
<br>>  	mutex_unlock(&pcl->lock);
<br>> +	if (z_erofs_is_inline_pcluster(pcl))
<br>> +		z_erofs_free_pcluster(pcl);
<br>>  	return err;
<br>>  }
<br>></p><meta data-version=3D"editor_version_1.2.11"/><div data-zone-id=3D=
"0" data-line-index=3D"0" data-line=3D"true" style=3D"white-space: pre-wrap=
; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">------=E6=9C=BA=
=E5=AF=86=EF=BC=9A=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=89=80=E5=
=8C=85=E5=90=AB=E5=86=85=E5=AE=B9=E4=B8=BA=E9=85=B7=E6=B4=BE=E6=9C=BA=E5=AF=
=86=E5=86=85=E5=AE=B9,=E5=B9=B6=E4=B8=94=E5=8F=97=E5=88=B0=E6=B3=95=E5=BE=
=8B=E7=9A=84=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=B8=8D=
=E5=B1=9E=E4=BA=8E=E4=BB=A5=E4=B8=8A=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=
=9A=84=E7=9B=AE=E6=A0=87=E6=8E=A5=E6=94=B6=E8=80=85=EF=BC=8C=E6=82=A8=E4=B8=
=8D=E5=BE=97=E7=BB=86=E8=AF=BB=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=8C=E4=BC=A0=
=E6=92=AD=EF=BC=8C=E6=95=A3=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E8=AF=A5=E7=
=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BB=BB=E4=BD=95=E4=BF=
=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E5=B7=B2=E7=BB=8F=E8=AF=AF=
=E6=94=B6=E6=AD=A4=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=
=82=A8=E7=AB=8B=E5=8D=B3=E9=80=9A=E7=9F=A5=E6=88=91=E4=BB=AC=E5=B9=B6=E5=88=
=A0=E9=99=A4=E5=8E=9F=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E3=80=82 CONFIDEN=
TIAL: This e-mail message contains information of Coolpad that is confident=
ial and which is subject to legal privilege.If you are not the intended rec=
ipient as indicated above,you must not peruse,use, disseminate,distribute o=
r copy any information contained in this message.If you have received this =
message in error, please notify us and delete the original message immediat=
ely.
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
--117e39e43e653b277d011467175ee617d32fbfec9d49851605f06844040d--
