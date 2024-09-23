Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24116983A50
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 01:17:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XCJmh6lBMz2yT0
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Sep 2024 09:17:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727133442;
	cv=none; b=omy1blxpg6+8RXXn5388Fu3AksSw45UI4SRQTCTIv1eMVor/jTf8gLp6YRNEGG0u8n9cvuBUlryKdxjd5xRN75iTs1ll5iS9zL9Qvuz1Io8v9SpYXnwYQapNfWeL/8fvVugXqZpdmchv+p3YU+2ynDxXKBAD0+jLBWq3PKFG4O55TUzgS/6SMf4rGRWqioDHzyCWizaEcZxhBGCpY3jUHa7Z676NfQjnXClFcljh/b3Io0t9pG0JE2ikmsihbd2GHPDAYJnSS++3CVyUzE5Pkkzv9VuUiQcGXobi/UOVi4H4ia26xZAInuM+rkZkfv6n05pl3zI9wmgjAd7TyH21lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727133442; c=relaxed/relaxed;
	bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYt/hQ5t8FcQFR0SDtsGwVSY77DpsHs8P1+1vGiDHclQijGowbGyNumMS4QmO2Vf67sHtwo6GGNvxZ7Q7C5CXzVGUKJoT/y5znoZC8zcDKptN7m2e7QWFAI5zel2npsZgY4BYJzvwUUAtp8ymRTTttJrUeZvfOs2wwqx1jt2oRqmTzuMW/K7Z9R9lmDKfW8AJzk6esP+R8o7esnunJw21KePUmJm8rQ8ogzkl4dVJVcogeYsGxDrPT3R3kT8rnn6Vq4ENrzRpoFW2Z5VeDA6UHSSOpqsBlyUaXIlu1rHAF18mNBVWrLH/6ZWu8wn99UIh5m+1S2rUk4xdPAHrw70Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VmsxFpzy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VmsxFpzy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XCJmd4DFNz2x9W
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Sep 2024 09:17:20 +1000 (AEST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so6503490a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727133434; x=1727738234; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=VmsxFpzywEqUIJCqX9YRkoQxcOoQKfS9xFT60GdFkRXuIJEE2IQvX0xdvU49Wz6FAS
         3y35Qm8yQ/eyX5+vQx+E1CvlYjaXYR1ISRMbZ1cKhKgtkH2RDTzWhrq5B9wYLbO4g19U
         W6Wk0ZGMA4ZBBP1+nv0xkNoVyBtdwcUU5pOO/89iqg5NGwXueKf+5lozC2ZXt3bWuoiF
         vgtdVTaYItG1jMTsA/V2fzZdg7pL4ix4hMrH7Vn1XfCteOhxITsJi+e6mmdQTimgZzcS
         7cSZJb6mnJeaXh3cong/F67lSuT7GrPQSbR0kcWltyX17rQ9UUnfzJTdHUu/pwQ8kWZu
         RTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727133434; x=1727738234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngRtzW5JM4PktiK1i50Y+IhfPwDmKMxpAqupnEmiErk=;
        b=pwVn887MTCn2Xjmsx9RAjeYefaMurrpyQ12kApZNqdIxS/ZdPs9keGycGwQoHht1es
         UsvTwD7WK6ygAjCYPh4Bn/hzwa0vAK50muSQx7j/wdkj9ClvYVBpGLl5+XGAmjwA3MSb
         WebQKuVV/7W/s/4QT5WinrNVTuxhluXPQ9cFI1+AqvAr1E71FeYQtwoHk4Jny7K/o/vM
         ITWyuLv/IKrt+/k3Iox9MfDzqehPhpX8jWA5KUi8TqgdNuL9QADxQhLSFEzdiuxLOuxR
         2+ZlbV7UQWY0xNlGtZfQaYyY37J0+YC259gHYlkbC5Ry0wupNyU7mmqU7rPmaT36PCoZ
         66wg==
X-Forwarded-Encrypted: i=1; AJvYcCVPdWS+D/C3uVSNHsYsHvJAUMh944SPxK8cSSvEi7srG52kRRNIBNjg8lPVIthL68Omi/vamq2ligO/gw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMo+l6R1ghIzAaxfeJg7odHBnJpFpI7Zc174aqtZTnuUNjdVq3
	H1iMNkd9TY3lQMja42/+uhP0i5644fPFn39mqJujdjPlAVOsTIyxkgyyIWoJMAYOiSkfdWnqL25
	D1zbk41XSMsC/KQ2tUntGlx7td4s=
X-Google-Smtp-Source: AGHT+IH8LipBtLSxEtozQ2rg05n3Ixckwwsb8tD+R3wx/CmXcuSVcLfSG+Z/gs1ubLzXvUowuTAPkX6CdLZ8O6/puxQ=
X-Received: by 2002:a05:6402:3506:b0:5c5:c2a7:d53a with SMTP id
 4fb4d7f45d1cf-5c5c2a7d69amr3583016a12.12.1727133434103; Mon, 23 Sep 2024
 16:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-2-dhowells@redhat.com>
In-Reply-To: <20240923150756.902363-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 18:17:00 -0500
Message-ID: <CAH2r5mv75LkMnB4ZAWO+sxQwjMne1gKb5EGC3i7kc7h=L0emSA@mail.gmail.com>
Subject: Re: [PATCH 1/8] netfs: Fix mtime/ctime update for mmapped writes
To: David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

added to cifs-2.6.git for-next since it is important as it fixes a
regression affecting cifs.ko

On Mon, Sep 23, 2024 at 10:08=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
> ctime need to be written back on close, got taken over by netfs as
> NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
> set it.
>
> The flag gets set correctly on buffered writes, but doesn't get set by
> netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> generic/215.
>
> Fix this by setting the flag in netfs_page_mkwrite().
>
> Fixes: 73425800ac94 ("netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_i=
node")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409161629.98887b2-oliver.sang@i=
ntel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index d7eae597e54d..b3910dfcb56d 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -552,6 +552,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, s=
truct netfs_group *netfs_gr
>                 trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
>         netfs_set_group(folio, netfs_group);
>         file_update_time(file);
> +       set_bit(NETFS_ICTX_MODIFIED_ATTR, &ictx->flags);
>         if (ictx->ops->post_modify)
>                 ictx->ops->post_modify(inode);
>         ret =3D VM_FAULT_LOCKED;
>
>


--=20
Thanks,

Steve
