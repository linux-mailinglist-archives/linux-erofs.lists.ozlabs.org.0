Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62882669C0E
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 16:28:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ntlfw37DYz3cff
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 02:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M/cLbI4Q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M/cLbI4Q;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ntlfs3srKz3bbS
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 02:28:05 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C9425620D6;
	Fri, 13 Jan 2023 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F489C433D2;
	Fri, 13 Jan 2023 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673623683;
	bh=/WFO5kmEHVzUbgmBmc+dReM3alIskIwlJX9FItlyzA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M/cLbI4QV7jm1LK27vAyJ+HIrxp8zVXiaTGY5XZ6h7YqA+Dq21xp0ghv/4J4oldks
	 GPyo48+AdYHebZfyxDv3TWKirZtyRI3tEWvFkcOot31Y6/WRK/T2nk6DAILvGjQ3Pf
	 K4FDjWj6R/qpUBYzvksCxqSLxBqoxjsM289Yg5oOar6kTFHjR22UEOhNKfxslceCs6
	 /XN1Kewc5IhCSmv3hmkrV95/9IFK5dAvdDTM5JW70bRzQpgzu1sl0mkC45AzKq639F
	 Xwq9QeUhbDgsKRFBsbsmLiiPt/WGJ43VgytsD1HWY56EH4g8QiTh2ilN5pYXsLKwKO
	 Q3ELrohTZGb9Q==
Message-ID: <bc07b4d69f6c709988d2faca50717a402c1ed81e.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] fscache: Use clear_and_wake_up_bit() in
 fscache_create_volume_work()
From: Jeff Layton <jlayton@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
Date: Fri, 13 Jan 2023 10:28:01 -0500
In-Reply-To: <20230113115211.2895845-3-houtao@huaweicloud.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
	 <20230113115211.2895845-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, houtao1@huawei.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2023-01-13 at 19:52 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> fscache_create_volume_work() uses wake_up_bit() to wake up the processes
> which are waiting for the completion of volume creation. According to
> comments in wake_up_bit() and waitqueue_active(), an extra smp_mb() is
> needed to guarantee the memory order between FSCACHE_VOLUME_CREATING
> flag and waitqueue_active() before invoking wake_up_bit().
>=20
> Fixing it by using clear_and_wake_up_bit() to add the missing memory
> barrier.
>=20
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fscache/volume.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index 903af9d85f8b..cdf991bdd9de 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -280,8 +280,7 @@ static void fscache_create_volume_work(struct work_st=
ruct *work)
>  	fscache_end_cache_access(volume->cache,
>  				 fscache_access_acquire_volume_end);
> =20
> -	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
> -	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
> +	clear_and_wake_up_bit(FSCACHE_VOLUME_CREATING, &volume->flags);
>  	fscache_put_volume(volume, fscache_volume_put_create_work);
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
