Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CE669C08
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jan 2023 16:27:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NtlfJ0B5Kz3cfl
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Jan 2023 02:27:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KzgC60FP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KzgC60FP;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ntlf86P77z3c99
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Jan 2023 02:27:28 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8A37461FC3;
	Fri, 13 Jan 2023 15:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D676C433EF;
	Fri, 13 Jan 2023 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673623644;
	bh=3oW+bJL4a6uki2bL5hsD7AU5oGF1aSENnaNKozJNznQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KzgC60FP9gFQhETHYZBxpqbqkdH+Bd0fYRcifzQ0RJllad+tkDmjOj7mk4JjUzbX8
	 UFqau6HIZ+vqj1Yp59Dg5D7WGRBkZ/TIaD4OSWdOKt30s5zQ+kwl6dSXAMCYWMCeWH
	 +IiGfaIIghrWL/xeRwjWfU1n02e9c8TXIdcSK9zbb3injlS6bXTn40OVnUdHYfSsmy
	 jUPn+s3jt/8LxQXe6KVD1r47Kzvw8mU9i9b4xAN2ycNX9nf0pMARQ8QkY7a6oqzuc0
	 NRHOuJLNAWjs661BKT6OyVx8yrcMefoOvuj8d0toHiwzr4ZYaOxt6dlpBrmGFbagB2
	 B9CdfB5jUVDIQ==
Message-ID: <445ebed318067cd31f5df17d8f5a52963f49fc04.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] fscache: Use wait_on_bit() to wait for the
 freeing of relinquished volume
From: Jeff Layton <jlayton@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, linux-cachefs@redhat.com
Date: Fri, 13 Jan 2023 10:27:22 -0500
In-Reply-To: <20230113115211.2895845-2-houtao@huaweicloud.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
	 <20230113115211.2895845-2-houtao@huaweicloud.com>
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
> The freeing of relinquished volume will wake up the pending volume
> acquisition by using wake_up_bit(), however it is mismatched with
> wait_var_event() used in fscache_wait_on_volume_collision() and it will
> never wake up the waiter in the wait-queue because these two functions
> operate on different wait-queues.
>=20
> According to the implementation in fscache_wait_on_volume_collision(),
> if the wake-up of pending acquisition is delayed longer than 20 seconds
> (e.g., due to the delay of on-demand fd closing), the first
> wait_var_event_timeout() will timeout and the following wait_var_event()
> will hang forever as shown below:
>=20
>  FS-Cache: Potential volume collision new=3D00000024 old=3D00000022
>  ......
>  INFO: task mount:1148 blocked for more than 122 seconds.
>        Not tainted 6.1.0-rc6+ #1
>  task:mount           state:D stack:0     pid:1148  ppid:1
>  Call Trace:
>   <TASK>
>   __schedule+0x2f6/0xb80
>   schedule+0x67/0xe0
>   fscache_wait_on_volume_collision.cold+0x80/0x82
>   __fscache_acquire_volume+0x40d/0x4e0
>   erofs_fscache_register_volume+0x51/0xe0 [erofs]
>   erofs_fscache_register_fs+0x19c/0x240 [erofs]
>   erofs_fc_fill_super+0x746/0xaf0 [erofs]
>   vfs_get_super+0x7d/0x100
>   get_tree_nodev+0x16/0x20
>   erofs_fc_get_tree+0x20/0x30 [erofs]
>   vfs_get_tree+0x24/0xb0
>   path_mount+0x2fa/0xa90
>   do_mount+0x7c/0xa0
>   __x64_sys_mount+0x8b/0xe0
>   do_syscall_64+0x30/0x60
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>=20
> Considering that wake_up_bit() is more selective, so fix it by using
> wait_on_bit() instead of wait_var_event() to wait for the freeing of
> relinquished volume. In addition because waitqueue_active() is used in
> wake_up_bit() and clear_bit() doesn't imply any memory barrier, use
> clear_and_wake_up_bit() to add the missing memory barrier between
> cursor->flags and waitqueue_active().
>=20
> Fixes: 62ab63352350 ("fscache: Implement volume registration")
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fscache/volume.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index ab8ceddf9efa..903af9d85f8b 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -141,13 +141,14 @@ static bool fscache_is_acquire_pending(struct fscac=
he_volume *volume)
>  static void fscache_wait_on_volume_collision(struct fscache_volume *cand=
idate,
>  					     unsigned int collidee_debug_id)
>  {
> -	wait_var_event_timeout(&candidate->flags,
> -			       !fscache_is_acquire_pending(candidate), 20 * HZ);
> +	wait_on_bit_timeout(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
> +			    TASK_UNINTERRUPTIBLE, 20 * HZ);
>  	if (fscache_is_acquire_pending(candidate)) {
>  		pr_notice("Potential volume collision new=3D%08x old=3D%08x",
>  			  candidate->debug_id, collidee_debug_id);
>  		fscache_stat(&fscache_n_volumes_collision);
> -		wait_var_event(&candidate->flags, !fscache_is_acquire_pending(candidat=
e));
> +		wait_on_bit(&candidate->flags, FSCACHE_VOLUME_ACQUIRE_PENDING,
> +			    TASK_UNINTERRUPTIBLE);
>  	}
>  }
> =20
> @@ -347,8 +348,8 @@ static void fscache_wake_pending_volume(struct fscach=
e_volume *volume,
>  	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
>  		if (fscache_volume_same(cursor, volume)) {
>  			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
> -			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
> -			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
> +			clear_and_wake_up_bit(FSCACHE_VOLUME_ACQUIRE_PENDING,
> +					      &cursor->flags);
>  			return;
>  		}
>  	}

Reviewed-by: Jeff Layton <jlayton@kernel.org>
