Return-Path: <linux-erofs+bounces-227-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32CA9A299
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 08:51:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zjmq969T3z2ydv;
	Thu, 24 Apr 2025 16:51:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745477509;
	cv=none; b=mYwrEOhBKryLrJEMyjVVmZIdL1TMfmDF8Dcak56qqdMj3OsvZkiyzu+2QWQh8BbeEm1U+xv/cE2zh5QyDE7CIk9ElwKYerj93QWqL89Oryrsdemet6z3E6X5FeSWVLMOa9PrgLBv8QldmnHJvbIQN3ky9llg6Ul3s35GqsURPM7TR1SwIxtX+zThypA61QWkzN7bNC3w8tW9HUBWDCtbEb/GQeEWtJJLfGNx9ZTi9bH6O/iiwRXBuBhTsl0dJu8oF+ajUxcejqSKuOaHY4W2Z6QiCGwrEVWqN2BQD9lCycKNaIY8ZzsgVrLECA5U0BpcayKoW+D/0jCI86Ce+fa4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745477509; c=relaxed/relaxed;
	bh=UCdBlRSLitkZVgraqiDyH6sqV6PnXuRYUb+hiEOC3cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fReuqcroMM2QZHEl4WkCG3vvlq60JFCHaHGq+yDr7o4On0bgGpwzhlY9z6SpSmc6iekLzGrwNLnHN+ACKd4QZp0NCLsmvjnwx9JqPbuwkyuLVuqZlwJ+nszyBNn4oZj3Xm83N6A3UGjh4ibVefNPNdq3/1GAAfFrxm8f7f5zAKe+qCxA69lOhvzZyAcYEDprOjMyTI+ZdcNhHwnzS47wqnYxNbvo1KH/kcOn/z5ZNckREncVQiB9KkbalxHvorKwM2YTQKCau0HdI/0XDAh70YIv7qPAkKyMA/osM9Qt3SRPXFj6K8cCwYtnFD8Xg+Of5R517NN40aTd0lJjsx+4dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=NzpiRx/N; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=NzpiRx/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zjmq80gqlz2yVt
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 16:51:47 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-acb2faa9f55so76773366b.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745477504; x=1746082304; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCdBlRSLitkZVgraqiDyH6sqV6PnXuRYUb+hiEOC3cY=;
        b=NzpiRx/NsRKYJgbsS7E3BzYqiB6CJgY6xjt/gUrdNRukVpMX2WIcMnWOBmYxDwBi+E
         23eeldVt+07IwSXSo2cO7qNpbsqdvvsMjmyMxfGPhRMXQpLoWOr7Edgp3x1iLUci0eEe
         ydBgbCvngSbRvxWJ4BeaAoWnG1gGswahs+cOu5utTiQeDqjAFzCg1OWk/bxUwaVyATit
         9TduS2JQfAXxJ8IYoGMWJKX3Bke7eKrwU+BWYDUvDQCodoz3cMPz31qc3XdbtqB5luOm
         jbV1VKBVZ/tm3t3LR0G3phDHH4oS0bmgmSVoKtz+62B6VDP2OhUYJG/QgWGUGGwWzzJ8
         Alkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745477504; x=1746082304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCdBlRSLitkZVgraqiDyH6sqV6PnXuRYUb+hiEOC3cY=;
        b=BhVyta33QsXbuJ8IsxtHrMYBNwrlOZf5XDJn7SP7qaXWn2GgUeOYI1VwRkrHCHbq/s
         EIfojdAtGWq62TbQjMVYWrzGwUqwsS3kP/Z6Z0VL26nWxTMxB973/gNBpmJA6UxTUQPe
         nsyWDnq5F0VdkE9A84yyj/D49uQS2sJIX9FsahTr2YsTqbzJtblI78FNGzjmB5Kw9S3Z
         YERaxd97Py89dk+HBLMwRp2+6jJuj961yUuXxFPjNXlVLSPTLmi/ZL9mr7V2bwuMw2dQ
         YkVsZp6HMCWA1VH6wPODZZHie9C7Np6bA3H8K/08sIWQcbA3VOW5isRt7jMwDGCoOxAd
         i80w==
X-Forwarded-Encrypted: i=1; AJvYcCXHU6opDLt+s/2RuiwvwWLp6nN7sR9+Upfw5pl099QzvwiHFr6FrxyQndLLwTp5udSATlV8V86qPpSdVQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwbSmEv4TLStzPIweBvq15r6OkUEAFW5XLWHgeIMuDPb1+xjH0v
	ys8g8FxJ31tp4z9jiWyHPajWsr9+qvTHu2VrRGnXMDfV+XhhEcFCbbfT/bouvhTGlnafaBOdI0+
	eMN+rAsm2ADLoS303FhdgNv1AuqjZBwaOLjm89CBuGD/0sHFtbPTo
X-Gm-Gg: ASbGncsGv6FUwwPOUypSd7EXT/x1ra25e8HIjWNLp1WnHgoe///ubRz3Ti7ZtwSP8Ja
	5q46jWG4UvO2WRjPuqImM8+ftXt5SSTBVMgpTJd4TtjkmNHV+PhmOY/EAZ6gfPzHe2c2+gOA+ef
	AiOi0Sz3seb0x1uuqWRFRXEw==
X-Google-Smtp-Source: AGHT+IHGeyS5GzF1KKHBmTnr0KgYda4bVKubCtgIBqB6yIp5B87N5sZptbz4fHrf3oRXVpVpYibPEFrx+l9TaWOdLT0=
X-Received: by 2002:a17:907:7e8f:b0:acb:86f0:fed8 with SMTP id
 a640c23a62f3a-ace5721fe68mr130762666b.12.1745477504191; Wed, 23 Apr 2025
 23:51:44 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <50dc6bdc-ee62-41f1-b8e5-be64defb07c6@huawei.com>
In-Reply-To: <50dc6bdc-ee62-41f1-b8e5-be64defb07c6@huawei.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Wed, 23 Apr 2025 23:51:31 -0700
X-Gm-Features: ATxdqUFCZEOg52wqG1DDPFBO0bciOIAyOiGm-f5J3gO3y1YmMicJ7X_BAGWYg7g
Message-ID: <CAB=BE-R4uPFeBSt6Z4Khv6_OjAu9=WoJR-VGG8eG0spAaovE1w@mail.gmail.com>
Subject: Re: Maybe update the minextblks in wrong way?
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Apr 23, 2025 at 6:50=E2=80=AFPM Hongbo Li <lihongbo22@huawei.com> w=
rote:
>
> Hi Sandeep,
>    The consecutive chunks will be merged if possible, but after commit
> 545988a65131 ("erofs-utils: lib: Fix calculation of minextblks when
> working with sparse files"), the @minextblks will be updated into a
> smaller value even the chunks are consecutive by blobchunks.c:379. I
> think maybe the last operation that updates @minextblks is unnecessary,
> since this value would have already been adjusted earlier when handling
> discontinuous chunks. Likes:
>
> ```
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -376,7 +376,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode
> *inode, int fd,
>                  *(void **)idx++ =3D chunk;
>                  lastch =3D chunk;
>          }
> -       erofs_update_minextblks(sbi, interval_start, pos, &minextblks);
>          inode->datalayout =3D EROFS_INODE_CHUNK_BASED;
>          free(chunkdata);
>          return erofs_blob_mergechunks(inode, chunkbits,
>
> ```
> This way can reduces the chunk index array's size. And what about your
> opinion?
>
> Thanks,
> Hongbo

Hi Hongbo,
I think the last call is necessary to handle the tail end which is not
handled in the for loop. But I understand that if the file is
contiguous then the last call can reduce minextblks.

Does the below patch address your concern to conditionally call the
last erofs_update_minextblks()?

Thanks,
Sandeep.

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index de9150f..47fe923 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -303,6 +303,7 @@ int erofs_blob_write_chunked_file(struct
erofs_inode *inode, int fd,
        lastch =3D NULL;
        minextblks =3D BLK_ROUND_UP(sbi, inode->i_size);
        interval_start =3D 0;
+       bool is_contiguous =3D true;

        for (pos =3D 0; pos < inode->i_size; pos +=3D len) {
 #ifdef SEEK_DATA
@@ -332,6 +333,7 @@ int erofs_blob_write_chunked_file(struct
erofs_inode *inode, int fd,
                                erofs_update_minextblks(sbi, interval_start=
,
                                                        pos, &minextblks);
                                interval_start =3D pos;
+                               is_contiguous =3D false;
                        }
                        do {
                                *(void **)idx++ =3D &erofs_holechunk;
@@ -365,7 +367,8 @@ int erofs_blob_write_chunked_file(struct
erofs_inode *inode, int fd,
                *(void **)idx++ =3D chunk;
                lastch =3D chunk;
        }
-       erofs_update_minextblks(sbi, interval_start, pos, &minextblks);
+       if (!is_contiguous)
+               erofs_update_minextblks(sbi, interval_start, pos, &minextbl=
ks);
        inode->datalayout =3D EROFS_INODE_CHUNK_BASED;
        free(chunkdata);
        return erofs_blob_mergechunks(inode, chunkbits,

