Return-Path: <linux-erofs+bounces-977-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D07B44DD6
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Sep 2025 08:12:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ5c30n0dz3bZf;
	Fri,  5 Sep 2025 16:12:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757052755;
	cv=none; b=QIoyyoQFgMblYSoqJ88IUN8PAgsNB3F/EvTtRWwYwAtQDoBeH1G9nkYQO0I3WhjgHKeJLeJLZ/W+hgb79wdg0go4pjFUTAgEERRoInPhYAMkcSr17bPNp/iFafR7hYLjYIk0nsn9YWvUxlZg8FFSdEUQbY1RnGyYZx5st6G/OvsPLfIXXoH9oZx2tBNmjLvuTN7eIjBOUDnGGMb1dpND4zEGDUk/PRG9xPQ1sh1LZxJWWZHTgEXhErptZV+TqK74ITFG9MYEaVTHLTaIR2ZHW8ExKO3wMoZGK3Z6brS7pKA2N2Q74Nxxot89UqZpAUU/YD6WuPyOeMpB5LKOg8MfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757052755; c=relaxed/relaxed;
	bh=/RHoA5jQKNaA1ttBJs5xVcWO8XCHhyStBpHWG0RiJnE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=auA6dwscxuPWOApkzRCNMHzmF/byVvyCqz77DRSMrybzsSbe+HwAzFsLnADpamvIlfROTWc1Ap6KHd/Mtw67y1PsaN+UYMLBwASAUBDvpR7MlWDteAuFJgZBTmzsd0nfd5EwL8rEZurRK4j02n8NcW5J2j56NR7OWpRD0PbdGSRphHRjSlFjoIMWnH268PYyaGYYrtJX3HN9nHCbIKNVutRM/0FupFIfusseRqUDf+wGSsY31nimeKJIdsEbP5LZObZSwepS1XkrMtMn2AP0Th4VKkkhCneIGEDK2p8xoSW6XQUcaIcdpLykQ9q/+d5jayhti9SOWpQiirlU982kBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.41; helo=out28-41.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.41; helo=out28-41.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ5c155tlz2yGM
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Sep 2025 16:12:30 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eY0pyIT_1757052742 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 14:12:23 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: avoid trailing '\n' in
 erofs_nbd_get_identifier()
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
Date: Fri, 5 Sep 2025 14:12:12 +0800
Cc: linux-erofs@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A170109A-3EFF-4CE0-8AB2-EC65536A08C8@cyzhu.com>
References: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

I have tested this patch and it can fix the autoclear issue when =
executing `mount.erofs -t erofs.nbd erofs.img /mnt`.

Nice patch, Xiang.

Thanks,
Chengyu Zhu

> 2025=E5=B9=B49=E6=9C=885=E6=97=A5 11:39=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The trailing '\n' shouldn't be part of backend.
>=20
> Fixes: 5d3efc9babf3 ("erofs-utils: mount: enable autoclear for NBD =
devices")
> Cc: Chengyu Zhu <hudson@cyzhu.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> lib/backends/nbd.c | 21 +++++++++++++++------
> mount/main.c       | 20 +++++---------------
> 2 files changed, 20 insertions(+), 21 deletions(-)
>=20
> diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
> index b9535dc..2e54814 100644
> --- a/lib/backends/nbd.c
> +++ b/lib/backends/nbd.c
> @@ -183,15 +183,24 @@ char *erofs_nbd_get_identifier(int nbdnum)
>=20
> 	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/backend", =
nbdnum);
> 	f =3D fopen(s, "r");
> -	if (!f)
> +	if (!f) {
> +		if (errno =3D=3D ENOENT)
> +			return NULL;
> 		return ERR_PTR(-errno);
> -
> -	if (getline(&line, &n, f) < 0)
> +	}
> +	err =3D getline(&line, &n, f);
> +	if (err < 0)
> 		err =3D -errno;
> -	else
> -		err =3D 0;
> 	fclose(f);
> -	return err ? ERR_PTR(err) : line;
> +	if (err < 0)
> +		return ERR_PTR(err);
> +	if (!err) {
> +		free(line);
> +		return NULL;
> +	}
> +	if (line[err - 1] =3D=3D '\n')
> +		line[err - 1] =3D '\0';
> +	return line;
> }
>=20
> int erofs_nbd_get_index_from_minor(int minor)
> diff --git a/mount/main.c b/mount/main.c
> index 149bb53..2826dac 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -356,10 +356,7 @@ static int erofsmount_nbd_fix_backend_linkage(int =
num, char **recp)
> 	int err;
>=20
> 	newrecp =3D erofs_nbd_get_identifier(num);
> -	if (!IS_ERR(newrecp)) {
> -		err =3D strlen(newrecp);
> -		if (newrecp[err - 1] =3D=3D '\n')
> -			newrecp[err - 1] =3D '\0';
> +	if (!IS_ERR(newrecp) && newrecp) {
> 		err =3D strcmp(newrecp, *recp) ? -EFAULT : 0;
> 		free(newrecp);
> 		return err;
> @@ -461,16 +458,11 @@ static int erofsmount_reattach(const char =
*target)
> 	if (nbdnum < 0)
> 		return nbdnum;
> 	identifier =3D erofs_nbd_get_identifier(nbdnum);
> -	if (IS_ERR(identifier))
> +	if (IS_ERR(identifier)) {
> +		identifier =3D NULL;
> +	} else if (identifier && *identifier =3D=3D '\0') {
> +		free(identifier);
> 		identifier =3D NULL;
> -	else if (identifier) {
> -		n =3D strlen(identifier);
> -		if (__erofs_unlikely(!n)) {
> -			free(identifier);
> -			identifier =3D NULL;
> -		} else if (identifier[n - 1] =3D=3D '\n') {
> -			identifier[n - 1] =3D '\0';
> -		}
> 	}
>=20
> 	if (!identifier &&
> @@ -596,8 +588,6 @@ static int erofsmount_nbd(const char *source, =
const char *mountpoint,
>=20
> 		if (!err && is_netlink) {
> 			id =3D erofs_nbd_get_identifier(num);
> -			if (id =3D=3D ERR_PTR(-ENOENT))
> -				id =3D NULL;
>=20
> 			err =3D IS_ERR(id) ? PTR_ERR(id) :
> 				erofs_nbd_nl_reconfigure(num, id, true);
> --=20
> 2.43.5


