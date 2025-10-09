Return-Path: <linux-erofs+bounces-1160-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2DBC7858
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Oct 2025 08:19:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cj08R0qf5z300F;
	Thu,  9 Oct 2025 17:19:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759990775;
	cv=none; b=JFJZQsBAJG48THJ6ycIm4IfQuVOxT4PkP5n1ciuoz3UsoEzjOaFxhZgEa3A4ZWRI97JabyighcObwaEaxeFPF7xXw9vqWJcmUDiCxIgoJWhHS7EoksCaIMuQ6b6YXCoAG7YHwAATA7DIiJyuic2i3qUm0v6GASEie3CcDXHDVSpoHOvVg7kcjiG9m3h4256FtiN2sCjSWofi5F84SHMj0S5JNSnwn9gweYllS8Mmj92PYCYDEeQAlZ9MpvGNXEeDEHBVIbWrypckUAchZr16YZ0MSqLh6iT+ntnpUW/LecXxbNmnk035HnXr8jvI2o2mb6KKBXvGW+mlJH/nDXfn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759990775; c=relaxed/relaxed;
	bh=oMxwKJuGbszaGr1BNmBqaVL1X/EaBbVT5RxTvM3XSdE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=itc7FVQ7FlW3pzoOyGvY3SwS92Zwq0xt1jC3ZdicFEzr6Iqqq8tqSNaLlZByhBqn1uWIqSlxhBi8S95WqOTs1jUMyEpAD2Mx10zSZHx8xkWSS1yAPePj9VFoA4nk5w7bfNAqNEE/fWVgRoNddLlLLHnXAmmgLR5gys+9cFOfj01OMpdBdFqXaMYbmhDMd+y4WhLXE7XkRt73thRB8g4u6xcaxMVaSIa5nLTVKE4d4HNZ/VQA6d+WtApU1ph6RQJSoi2KBZdQOXs/+ZzpQX/7Y8Cwmlcfp+PxeRevRJc1rXdKl/IVNjx05QaXbEGdumboCtmv69bqgATNSgdLMhEceQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.66; helo=out28-66.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.66; helo=out28-66.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-66.mail.aliyun.com (out28-66.mail.aliyun.com [115.124.28.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cj08P5tJkz2xPy
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Oct 2025 17:19:30 +1100 (AEDT)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.evt6iYX_1759990763 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 14:19:24 +0800
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] erofs-utils: mount: don't overwrite layer_index with -1
 again
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <20251007032220.1860559-1-hsiangkao@linux.alibaba.com>
Date: Thu, 9 Oct 2025 14:19:13 +0800
Cc: linux-erofs@lists.ozlabs.org,
 Chengyu Zhu <hudsonzhu@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A16A658-944E-4EBE-80C7-06836CC4115B@cyzhu.com>
References: <20251007032220.1860559-1-hsiangkao@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Reviewed-by: Chengyu Zhu <hudsonzhu@tencent.com>

Thanks,
Chengyu
> 2025=E5=B9=B410=E6=9C=887=E6=97=A5 11:22=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Initialize ocicfg only when nbdsrc.type changes to
> EROFSNBD_SOURCE_OCI.
>=20
> Fixes: 6a7cfdb9cd66 ("erofs-utils: oci: add support for indexing by =
layer digest")
> Cc: Chengyu Zhu <hudsonzhu@tencent.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> mount/main.c | 13 +++++--------
> 1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/mount/main.c b/mount/main.c
> index eb0dd01..e2443f8 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -83,10 +83,6 @@ static int erofsmount_parse_oci_option(const char =
*option)
> 	char *p;
> 	long idx;
>=20
> -	if (oci_cfg->layer_index =3D=3D 0 && !oci_cfg->blob_digest &&
> -	    !oci_cfg->platform && !oci_cfg->username && =
!oci_cfg->password)
> -		oci_cfg->layer_index =3D -1;
> -
> 	p =3D strstr(option, "oci.blob=3D");
> 	if (p !=3D NULL) {
> 		p +=3D strlen("oci.blob=3D");
> @@ -147,10 +143,6 @@ static int erofsmount_parse_oci_option(const char =
*option)
> 			}
> 		}
> 	}
> -
> -	if (oci_cfg->platform || oci_cfg->username || oci_cfg->password =
||
> -	    oci_cfg->blob_digest || oci_cfg->layer_index >=3D 0)
> -		nbdsrc.type =3D EROFSNBD_SOURCE_OCI;
> 	return 0;
> }
> #else
> @@ -191,6 +183,11 @@ static long erofsmount_parse_flagopts(char *s, =
long flags, char **more)
> 			*comma =3D '\0';
>=20
> 		if (strncmp(s, "oci", 3) =3D=3D 0) {
> +			/* Initialize ocicfg here iff !=3D =
EROFSNBD_SOURCE_OCI */
> +			if (nbdsrc.type !=3D EROFSNBD_SOURCE_OCI) {
> +				nbdsrc.type =3D EROFSNBD_SOURCE_OCI;
> +				nbdsrc.ocicfg.layer_index =3D -1;
> +			}
> 			err =3D erofsmount_parse_oci_option(s);
> 			if (err < 0)
> 				return err;
> --=20
> 2.43.5
>=20


