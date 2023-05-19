Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E680709E57
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 19:38:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNDb86RPXz3gh5
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 03:38:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n9S35mWf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n9S35mWf;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNDKy2wl5z3fps
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 03:27:02 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EC86060CFB;
	Fri, 19 May 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C2C433D2;
	Fri, 19 May 2023 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684517218;
	bh=3drYpyYKUnH1cb6kQ/uVQsoKFoAeU6vU9OI6/6PAfZk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=n9S35mWf0Pm1llwyRM/w2pbmtXfNp34VbrsNfXPxN520wya1N0C9fZhbaDkGXp6t1
	 ++4elSII5PbPazoPs1V13ArsNYNWNCG9iBVCR8Jg+0ORpWnLuUWnIvNyTthkwCh/Wp
	 mMkIJ/RKwTOi9mGU1PpxaVARUlGIQaKWBPHYsWJq7aOFuZoXPs/Xsal++FoCctM77B
	 T3WzBD4cszc8qG0Mpj1oUa2IW7kT7dBh48dusd/dRyZLrXwhjMXA990AA7/jN7Qacf
	 vg6p0Bhiq9oBCEdH0NSkyjZxonQ6UpawB1FL3Dh9IyGluDL25TXzfnenQB65Xtwag7
	 1bCFyT4ZTuATQ==
Message-ID: <9672a3006f0f8424c09e0f00dcb8ecaa1c42abb6.camel@kernel.org>
Subject: Re: [PATCH] cachefiles: Allow the cache to be non-root
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Date: Fri, 19 May 2023 13:26:56 -0400
In-Reply-To: <1853230.1684516880@warthog.procyon.org.uk>
References: <1853230.1684516880@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2023-05-19 at 18:21 +0100, David Howells wrote:
>    =20
> Set mode 0600 on files in the cache so that cachefilesd can run as an
> unprivileged user rather than leaving the files all with 0.  Directories
> are already set to 0700.
>=20
> Userspace then needs to set the uid and gid before issuing the "bind"
> command and the cache must've been chown'd to those IDs.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 82219a8f6084..66482c193e86 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -451,7 +451,8 @@ struct file *cachefiles_create_tmpfile(struct cachefi=
les_object *object)
> =20
>  	ret =3D cachefiles_inject_write_error();
>  	if (ret =3D=3D 0) {
> -		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
> +		file =3D vfs_tmpfile_open(&nop_mnt_idmap, &parentpath,
> +					S_IFREG | 0600,
>  					O_RDWR | O_LARGEFILE | O_DIRECT,
>  					cache->cache_cred);
>  		ret =3D PTR_ERR_OR_ZERO(file);
>=20

Seems safe enough, and if it helps allow this to run unprivileged then:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
